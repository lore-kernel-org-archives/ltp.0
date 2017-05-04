From: Helge Deller <deller@gmx.de>
Date: Thu, 4 May 2017 20:23:46 +0200
Subject: [LTP] [PATCH] Fix getcwd03 testcase by zeroing target buffer for
	readlink()
Message-ID: <20170504182346.GA4959@ls3530.fritz.box>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

According to the man(2) page of readlink(), a null byte is not appended to the
target buffer. So applications need to make sure that the target buffer is
zero-initialized, otherwise random bytes at the end of the returned string may
exist. 

This patch zero-initializes the on-stack char array "link" and thus fixes the
testcase failure of getcwd03 on the hppa/parisc architecture (and maybe others).

Signed-off-by: Helge Deller <deller@gmx.de>

--
 testcases/kernel/syscalls/getcwd/getcwd03.c |    1 +
 1 file changed, 1 insertion(+)


diff --git a/testcases/kernel/syscalls/getcwd/getcwd03.c b/testcases/kernel/syscalls/getcwd/getcwd03.c
index 4f8f872cf..ec1cacea9 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd03.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd03.c
@@ -74,6 +74,7 @@ static void verify_getcwd(void)
 	}
 
 	SAFE_CHDIR("..");
+	memset(link, 0, sizeof(link));
 	SAFE_READLINK(dir_link, link, sizeof(link));
 
 	if (strcmp(link, SAFE_BASENAME(res1))) {
