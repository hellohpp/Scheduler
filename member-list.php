<?php
$title = "Member Lists";
include_once 'header.php';

?>
<section class="container">
    <div><?= !empty($message) ? $message : ""; ?></div>
    <article class="table-list">
        <table class="table table-bordered">
            <tr>
                <th>S.No</th>
                <th>Name</th>
                <th>Email</th>
                <th>Department</th>
                <th>Level</th>
                <th>Applied Time</th>
                <th>Status</th>

            </tr>
            <?php
            $lists = mysqli_query($link, "SELECT * FROM `tbl_jobs` ORDER BY `jobs_id` DESC");
            $number = mysqli_num_rows($lists);
            if ($number == 0) {
                echo "<tr><td colspan='7'>No Job  are Posted yet</td>";
            } else {
                for ($i = 1; $i <= $number; $i++) {
                    $list = mysqli_fetch_assoc($lists);
                    $jobs = mysqli_query($link, "SELECT `status` FROM `tbl_applied_jobs` WHERE `job_id`='" . $list['jobs_id'] . "'");
                    $job = mysqli_fetch_row($jobs);
                    ?>
                    <tr>
                        <form method="post">
                            <td><?= $i ?></td>
                            <td><?= $list['job_id'] ?>
                                <input type="hidden" name="jobs_id" value="<?= $list['jobs_id'] ?>"/><input
                                    type="hidden" name="user_id" value="<?= $_SESSION['USER_ID'] ?>"/>
                            </td>
                            <td><?= $list['title'] ?></td>
                            <td><?= $list['date'] ?></td>
                            <td><?= $list['place'] ?></td>
                            <td><?= $list['address'] ?></td>
                            <td>
                                <?php
                                if ($job[0] == '1') {
                                    echo "Accepted";
                                } elseif ($job[0] == '0') {
                                    echo "Pending";

                                } elseif ($job[0] == '-1') {
                                    echo "Rejected";
                                } else {
                                    ?>
                                    <button type="submit" name="submit">Apply</button>
                                <?php } ?>
                            </td>

                        </form>
                    </tr>
                <?php }
            } ?>
        </table>
    </article>
</section>
