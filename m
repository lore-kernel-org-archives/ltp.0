From: Khem Raj <raj.khem@gmail.com>
Date: Fri,  8 Jan 2016 08:11:39 +0000
Subject: [LTP] [PATCH 19/31] tomoyo: Replace canonicalize_file_name() with
	realpath()
In-Reply-To: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
References: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452240711-51180-19-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

canonicalize_file_name() API is specific to glibc

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/security/tomoyo/tomoyo_filesystem_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/tomoyo/tomoyo_filesystem_test.c b/testcases/kernel/security/tomoyo/tomoyo_filesystem_test.c
index da4af0f..5c1a3ca 100644
--- a/testcases/kernel/security/tomoyo/tomoyo_filesystem_test.c
+++ b/testcases/kernel/security/tomoyo/tomoyo_filesystem_test.c
@@ -274,9 +274,9 @@ int main(int argc, char *argv[])
 	/* Test mount(). */
 	{
 		static char buf[4096];
-		char *dev_ram_path = canonicalize_file_name("/dev/ram0");
+		char *dev_ram_path = realpath("/dev/ram0", NULL);
 		if (!dev_ram_path)
-			dev_ram_path = canonicalize_file_name("/dev/ram");
+			dev_ram_path = realpath("/dev/ram", NULL);
 		if (!dev_ram_path) {
 			dev_ram_path = "/dev/ram0";
 			mknod(dev_ram_path, S_IFBLK, MKDEV(1, 0));
-- 
2.7.0

