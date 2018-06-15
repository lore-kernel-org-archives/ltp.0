From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 Jun 2018 16:47:17 +0200
Subject: [LTP] [PATCH 2/2] Make use of SAFE_GETGRNAM()
In-Reply-To: <1521184376-3649-2-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1521184376-3649-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1521184376-3649-2-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20180615144717.gzd3goeaz6yktoq5@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jinhui,

> Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/chmod/chmod05.c       |  4 +---
>  testcases/kernel/syscalls/chmod/chmod07.c       |  3 +--
>  testcases/kernel/syscalls/creat/creat08.c       | 16 +++++-----------
>  testcases/kernel/syscalls/fchmod/fchmod02.c     |  4 +---
>  testcases/kernel/syscalls/fchmod/fchmod05.c     |  5 +----
>  testcases/kernel/syscalls/open/open10.c         | 14 ++++----------
>  testcases/kernel/syscalls/setregid/setregid02.c |  5 +----
>  testcases/kernel/syscalls/setregid/setregid03.c |  5 +----
>  testcases/kernel/syscalls/setregid/setregid04.c |  6 ++----
>  9 files changed, 17 insertions(+), 45 deletions(-)

I took only change in fchmod02 and adjusted it into new API.

Thanks for both patches!

Kind regards,
Petr

diff --git testcases/kernel/syscalls/fchmod/fchmod02.c testcases/kernel/syscalls/fchmod/fchmod02.c
index c41fd39e3..a855f9567 100644
--- testcases/kernel/syscalls/fchmod/fchmod02.c
+++ testcases/kernel/syscalls/fchmod/fchmod02.c
@@ -54,9 +54,7 @@ static void setup(void)
 	struct group *ltpgroup;
 
 	ltpuser = SAFE_GETPWNAM(LTPUSER);
-	ltpgroup = getgrnam(LTPGRP);
-	if (ltpgroup == NULL)
-		tst_brk(TBROK, "%s not in /etc/group", LTPGRP);
+	ltpgroup = SAFE_GETGRNAM(LTPGRP);
 
 	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
 	SAFE_CHOWN(TESTFILE, ltpuser->pw_uid, ltpgroup->gr_gid);
