From: Nicolas Joly <njoly@pasteur.fr>
Date: Mon, 25 Jul 2016 09:17:37 +0200
Subject: [LTP] [PATCH] Fix clock_nanosleep01 overall test status
Message-ID: <20160725071737.GA22484@issan.sis.pasteur.fr>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,

Please find a small patch that fix the clock_nanosleep01 overall test
status. It removes the TERRNO flag which will wrongly report the last
test error ...

before:

[...]
clock_nanosleep01    0  TINFO  :  (case04) START
clock_nanosleep01    1  TFAIL  :  clock_nanosleep01.c:294: clock_gettime failed: TEST_ERRNO=EINVAL(22): Invalid argument
clock_nanosleep01    0  TINFO  :  (case04) END => NG
clock_nanosleep01    0  TINFO  :  (case05) START
clock_nanosleep01    0  TINFO  :  remain time: 9 489917345
EXPECT: return value(ret)=4 errno=0 (Success)
RESULT: return value(ret)=4 errno=0 (Success)
clock_nanosleep01    0  TINFO  :  (case05) END => OK
clock_nanosleep01    2  TFAIL  :  clock_nanosleep01.c:394: clock_nanosleep failed: errno=SUCCESS(0): Success

after:

[...]
clock_nanosleep01    0  TINFO  :  (case04) START
clock_nanosleep01    1  TFAIL  :  clock_nanosleep01.c:294: clock_gettime failed: TEST_ERRNO=EINVAL(22): Invalid argument
clock_nanosleep01    0  TINFO  :  (case04) END => NG
clock_nanosleep01    0  TINFO  :  (case05) START
clock_nanosleep01    0  TINFO  :  remain time: 9 489936483
EXPECT: return value(ret)=4 errno=0 (Success)
RESULT: return value(ret)=4 errno=0 (Success)
clock_nanosleep01    0  TINFO  :  (case05) END => OK
clock_nanosleep01    2  TFAIL  :  clock_nanosleep01.c:394: clock_nanosleep failed

Thanks.

-- 
Nicolas Joly

Cluster & Computing Group
Biology IT Center
Institut Pasteur, Paris.
-------------- next part --------------
commit aec40955112ac88c62b5982418e612c1fb7a480d
Author: Nicolas Joly <njoly@pasteur.fr>
Date:   Mon Jul 25 09:09:28 2016 +0200

    clock_nanosleep/clock_nanosleep01: Fix overall result from tests.
    
    Remove TERRNO flag when printing overall test status. On failure, the
    value will wrongly output the status of the last test.
    
    Signed-off-by: Nicolas Joly <njoly@pasteur.fr>

diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
index 08c1fbd..9114d09 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
@@ -390,7 +390,7 @@ int main(int ac, char **av)
 				break;
 
 			default:
-				tst_brkm(TFAIL | TERRNO, cleanup,
+				tst_brkm(TFAIL, cleanup,
 					 "clock_nanosleep failed");
 				break;
 			}
