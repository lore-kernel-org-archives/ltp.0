From: Nicolas Joly <njoly@pasteur.fr>
Date: Sun, 17 Jul 2016 12:11:40 +0200
Subject: [LTP] [PATCH] Make read03 test report PASS upon success
Message-ID: <20160717101140.GA24495@issan.sis.pasteur.fr>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,

Please find a small patch that make read03 testcase report PASS
instead of INFO upon success.

before:

njoly@raya [syscalls/read]> ./read03
read03      0  TINFO  :  read() succeded in setting errno to EAGAIN

after:

njoly@raya [syscalls/read]> ./read03
read03      1  TPASS  :  read() succeded in setting errno to EAGAIN

Thanks.

-- 
Nicolas Joly

Cluster & Computing Group
Biology IT Center
Institut Pasteur, Paris.
-------------- next part --------------
commit 48afdb548f57f4afcfdc15373fc742cb23176a46
Author: Nicolas Joly <njoly@pasteur.fr>
Date:   Sun Jul 17 11:53:28 2016 +0200

    syscalls/read03: Make test use TPASS not TINFO upon success.
    
    Signed-off-by: Nicolas Joly <njoly@pasteur.fr>

diff --git a/testcases/kernel/syscalls/read/read03.c b/testcases/kernel/syscalls/read/read03.c
index e8b3bbd..28554f5 100644
--- a/testcases/kernel/syscalls/read/read03.c
+++ b/testcases/kernel/syscalls/read/read03.c
@@ -90,7 +90,7 @@ int main(int ac, char **av)
 			tst_resm(TFAIL, "read set bad errno, expected "
 				 "EAGAIN, got %d", TEST_ERRNO);
 		} else {
-			tst_resm(TINFO, "read() succeded in setting errno to "
+			tst_resm(TPASS, "read() succeded in setting errno to "
 				 "EAGAIN");
 		}
 	}
