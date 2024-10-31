<?php
require_once '../condb.php'; // เส้นทางไปยังไฟล์การเชื่อมต่อฐานข้อมูล

class Membership {
    private $conn; // ตัวแปรสำหรับเก็บการเชื่อมต่อฐานข้อมูล

    // คอนสตรัคเตอร์ที่ใช้สำหรับสร้างอินสแตนซ์ของคลาส Membership
    public function __construct($dbConnection) {
        $this->conn = $dbConnection; // เก็บการเชื่อมต่อฐานข้อมูล
    }

    // ฟังก์ชันสำหรับดึงตัวเลือกประเภทสมาชิกจากฐานข้อมูล
    public function getMembershipOptions() {
        $sql = "SELECT id, name, price, description FROM memberships"; // คำสั่ง SQL เพื่อเลือกข้อมูลสมาชิก
        $stmt = $this->conn->prepare($sql); // เตรียมคำสั่ง SQL
        $stmt->execute(); // รันคำสั่ง SQL
        return $stmt->fetchAll(PDO::FETCH_ASSOC); // คืนค่าข้อมูลสมาชิกทั้งหมดในรูปแบบ associative array
    }

    // ฟังก์ชันสำหรับลงทะเบียนสมาชิกใหม่
    public function registerMembership($userName, $membershipId) {
        // ตรวจสอบว่าผู้ใช้มีอยู่ในระบบหรือไม่
        $sql = "SELECT id FROM users WHERE user_name = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$userName]); // รันคำสั่ง SQL พร้อมกับชื่อผู้ใช้
        $userId = $stmt->fetchColumn(); // รับ ID ของผู้ใช้

        // ถ้าผู้ใช้ไม่อยู่ในระบบ ให้เพิ่มผู้ใช้
        if (!$userId) {
            $insertUserSql = "INSERT INTO users (user_name) VALUES (?)"; // คำสั่ง SQL เพื่อเพิ่มผู้ใช้ใหม่
            $insertStmt = $this->conn->prepare($insertUserSql); // เตรียมคำสั่ง SQL
            $insertStmt->execute([$userName]); // รันคำสั่ง SQL
            $userId = $this->conn->lastInsertId(); // รับ ID ของผู้ใช้ใหม่
        }

        // ลงทะเบียนสมาชิก
        $sql = "INSERT INTO user_memberships (user_id, membership_id) VALUES (?, ?)"; // คำสั่ง SQL เพื่อบันทึกข้อมูลสมาชิก
        $stmt = $this->conn->prepare($sql); // เตรียมคำสั่ง SQL
        return $stmt->execute([$userId, $membershipId]); // รันคำสั่ง SQL พร้อมกับ user_id และ membership_id
    }

    // ฟังก์ชันสำหรับดึงข้อมูลสมาชิกของผู้ใช้
    public function getUserMemberships($userId) {
        $sql = "SELECT m.name, m.price, m.description 
                FROM user_memberships um 
                JOIN memberships m ON um.membership_id = m.id 
                WHERE um.user_id = ?"; // คำสั่ง SQL เพื่อเลือกข้อมูลสมาชิกของผู้ใช้
        $stmt = $this->conn->prepare($sql); // เตรียมคำสั่ง SQL
        $stmt->execute([$userId]); // รันคำสั่ง SQL
        return $stmt->fetchAll(PDO::FETCH_ASSOC); // คืนค่าข้อมูลสมาชิกทั้งหมดในรูปแบบ associative array
    }
}

session_start(); // เริ่มเซสชัน

$membership = new Membership($conn); // สร้างอินสแตนซ์ของคลาส Membership
$options = $membership->getMembershipOptions(); // ดึงตัวเลือกประเภทสมาชิก

$message = ""; // ตัวแปรสำหรับเก็บข้อความแจ้งเตือน

// ตรวจสอบเมื่อผู้ใช้ส่งฟอร์ม
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $userName = $_POST['user_name']; // รับชื่อผู้ใช้จากฟอร์ม
    $membershipId = $_POST['membership_id']; // รับประเภทสมาชิกจากฟอร์ม
    
    // ลงทะเบียนสมาชิก
    if ($membership->registerMembership($userName, $membershipId)) {
        $message = "<div class='alert alert-success'>ลงทะเบียนสมาชิกสำเร็จ!</div>"; // แสดงข้อความสำเร็จ
        
        // เก็บ user_id ในเซสชัน
        $sql = "SELECT id FROM users WHERE user_name = ?"; // คำสั่ง SQL เพื่อเลือก ID ของผู้ใช้
        $stmt = $conn->prepare($sql);
        $stmt->execute([$userName]); // รันคำสั่ง SQL
        $_SESSION['user_id'] = $stmt->fetchColumn(); // เก็บ ID ของผู้ใช้ในเซสชัน
    } else {
        $message = "<div class='alert alert-danger'>การลงทะเบียนสมาชิกล้มเหลว!</div>"; // แสดงข้อความล้มเหลว
    }
}

// ดึงข้อมูลสมาชิกของผู้ใช้
$userMemberships = isset($_SESSION['user_id']) ? $membership->getUserMemberships($_SESSION['user_id']) : []; // หากมี user_id ให้ดึงข้อมูลสมาชิก

?>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>เลือกประเภทการเป็นสมาชิก</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> <!-- ลิงค์ไปยัง CSS ของ Bootstrap -->
    <style>
        body {
            background-color: #f8f9fa; /* กำหนดสีพื้นหลังของหน้า */
        }
        .membership-card {
            background-color: #fff; /* กำหนดสีพื้นหลังของการ์ดสมาชิก */
            border-radius: 10px; /* กำหนดมุมมน */
            padding: 20px; /* กำหนดช่องว่างภายใน */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* กำหนดเงาให้กับการ์ด */
        }
    </style>
</head>
<body>

<div class="container mt-5"> <!-- สร้างกล่อง Container -->
    <div class="row justify-content-center"> <!-- จัดเรียงเนื้อหาให้อยู่ตรงกลาง -->
        <div class="col-md-6 membership-card"> <!-- การ์ดสมาชิก -->
            <h1>เลือกประเภทการเป็นสมาชิกฟิตเนต</h1> <!-- หัวข้อ -->
            <?php if (isset($message)) echo $message; ?> <!-- แสดงข้อความแจ้งเตือน -->
            <form action="" method="POST"> <!-- ฟอร์มสำหรับลงทะเบียนสมาชิก -->
                <div class="form-group">
                    <label for="user_name">ชื่อของคุณ:</label>
                    <input type="text" name="user_name" id="user_name" class="form-control" required> <!-- ช่องกรอกชื่อผู้ใช้ -->
                </div>
                <div class="form-group">
                    <label for="membership_id">ประเภทสมาชิก:</label>
                    <select name="membership_id" id="membership_id" class="form-control" required> <!-- เมนูเลื่อนสำหรับเลือกประเภทสมาชิก -->
                        <option value="">-- กรุณาเลือกประเภทสมาชิก --</option>
                        <?php foreach ($options as $option): ?> <!-- วนลูปแสดงตัวเลือกสมาชิก -->
                            <option value="<?php echo $option['id']; ?>">
                                <?php echo htmlspecialchars($option['name']) . ' - ' . htmlspecialchars($option['price']) . ' บาท'; ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">ลงทะเบียน</button> <!-- ปุ่มลงทะเบียน -->
            </form>
        </div>
    </div>

    <!-- แสดงผลสมาชิกด้านล่าง -->
    <div class="row justify-content-center mt-5">
        <div class="col-md-8 membership-card">
            <h2>ข้อมูลสมาชิกของคุณ</h2> <!-- หัวข้อแสดงข้อมูลสมาชิก -->
            <?php if (!empty($userMemberships)): ?> <!-- ตรวจสอบว่ามีข้อมูลสมาชิก -->
                <table class="table table-bordered"> <!-- ตารางแสดงข้อมูลสมาชิก -->
                    <thead>
                        <tr>
                            <th>ชื่อประเภทสมาชิก</th>
                            <th>ราคา</th>
                            <th>รายละเอียด</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($userMemberships as $membership): ?> <!-- วนลูปแสดงข้อมูลสมาชิก -->
                            <tr>
                                <td><?php echo htmlspecialchars($membership['name']); ?></td>
                                <td><?php echo htmlspecialchars($membership['price']) . ' บาท'; ?></td>
                                <td><?php echo htmlspecialchars($membership['description']); ?></td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            <?php else: ?>
                <p>คุณยังไม่ได้ลงทะเบียนสมาชิกใดๆ</p> <!-- ข้อความเมื่อไม่มีข้อมูลสมาชิก -->
            <?php endif; ?>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min
