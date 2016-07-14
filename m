From: nousi <bnousilal@gmail.com>
Date: Thu, 14 Jul 2016 19:09:45 +0530
Subject: [LTP] Fwd: chmod06 is failing
In-Reply-To: <CAJ5vXcQiXyc8dJkeh0K77HCmaFe5Ts-Yw+WHuK28b3iLhbKBkA@mail.gmail.com>
References: <CAJ5vXcQiXyc8dJkeh0K77HCmaFe5Ts-Yw+WHuK28b3iLhbKBkA@mail.gmail.com>
Message-ID: <CAJ5vXcRKx-Qhh5fZyUHVXx96ejiOSbrN2eKSgM=i28Rp4=Abew@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi All,

please help me analyzing the below issue.

root@nousi:/opt/ltp# ./testcases/bin/chmod06
chmod06     0  TINFO  :  No free devices found
chmod06     1  TCONF  :  chmod06.c:194: Failed to obtain block device
chmod06     2  TCONF  :  chmod06.c:194: Remaining cases not appropriate for
configuration
chmod06     3  TBROK  :  chmod06.c:230: chmod(testdir_1) failed:
errno=ENOENT(2): No such file or directory
root@nousi:/opt/ltp#
root@nousi:/opt/ltp#
root@nousi:/opt/ltp# mknod /dev/loop-control b 7 10
root@nousi:/opt/ltp#
root@nousi:/opt/ltp#
root@nousi:/opt/ltp# ./testcases/bin/chmod06
chmod06     1  TBROK  :  tst_device.c:89: Failed to open /dev/loop-control:
errno=ENXIO(6): No such device or address
chmod06     0  TINFO  :  No free devices found
chmod06     2  TCONF  :  chmod06.c:194: Failed to obtain block device
chmod06     3  TCONF  :  chmod06.c:194: Remaining cases not appropriate for
configuration
chmod06     4  TBROK  :  chmod06.c:230: chmod(testdir_1) failed:
errno=ENOENT(2): No such file or directory
root@nousi:/opt/ltp#

-- 


*Thanks & Regards,B.Nousilal,*



-- 


*Thanks & Regards,B.Nousilal,*
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160714/704a2ef6/attachment.html>
