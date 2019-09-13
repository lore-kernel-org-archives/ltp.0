From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Sep 2019 22:53:28 +0200
Subject: [LTP] [PATCH] syscalls/acct02: Improve logging
Message-ID: <20190913205328.6049-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ unify verification function.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

added some debugging info.
Problem with s390 is caused by big endianess:
ac_version != 3 (131)

I suspect a bug in UNPACK(), but don't know how to fix it.

Failures on x86_64:
* various recent kernels 5.2.9 / 5.3, 4.20 on Debian, using v3:
acct02.c:222: INFO: Verifying using 'struct acct_v3'
acct02.c:174: INFO: == loop 1 ==
acct02.c:81: INFO: ac_comm != 'acct02_helper' ('acct02')
acct02.c:174: INFO: == loop 2 ==
acct02.c:81: INFO: ac_comm != 'acct02_helper' ('acct02')
acct02.c:132: INFO: ac_exitcode != 65280 (0)
acct02.c:140: INFO: ac_ppid != 18029 (18028)
acct02.c:174: INFO: == loop 3 ==
acct02.c:81: INFO: ac_comm != 'acct02_helper' ('acct02')
acct02.c:132: INFO: ac_exitcode != 65280 (0)
acct02.c:140: INFO: ac_ppid != 18029 (18028)
acct02.c:187: INFO: Number of accounting file entries tested: 2
acct02.c:191: FAIL: acct() wrote incorrect file contents!

* 3.10 on CentOS using v3:
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('')
acct02.c:88: INFO: ac_btime < 1568406976 (0)
acct02.c:133: INFO: ac_exitcode != 32768 (0)
acct02.c:141: INFO: ac_ppid != 19863 (0)
acct02.c:147: INFO: ac_version != 3 (0)
acct02.c:152: INFO: ac_pid < 1 (0)
acct02.c:188: INFO: Number of accounting file entries tested: 0
=> this looks to be completely wrong.

Other distros using various kernels (both old and recent) using struct
acct_v3 works well, so the bug might be some specific kernel
configuration.

I also tested recent (4.20.0-rc2) kernel with struct acct, working well.

Kind regards,
Petr

 testcases/kernel/syscalls/acct/acct02.c | 136 ++++++++++++++++--------
 1 file changed, 92 insertions(+), 44 deletions(-)

diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
index c2c20668e..e9b669868 100644
--- a/testcases/kernel/syscalls/acct/acct02.c
+++ b/testcases/kernel/syscalls/acct/acct02.c
@@ -34,6 +34,8 @@
 #define OUTPUT_FILE	"acct_file"
 
 #define UNPACK(x) ((x & 0x1fff) << (((x >> 13) & 0x7) * 3))
+#define ACCT_MEMBER(x) (v3 ? ((struct acct_v3 *)acc)->x : ((struct acct *)acc)->x)
+#define ACCT_MEMBER_V3(x) (((struct acct_v3 *)acc)->x)
 
 static int fd;
 static int v3;
@@ -68,50 +70,95 @@ static void run_command(void)
 	rc = tst_run_cmd(cmd, NULL, NULL, 1) << 8;
 }
 
-static int verify_acct(struct acct *acc)
+static int verify_acct(void *acc, int elap_time)
 {
-	int sys_time  = UNPACK(acc->ac_stime);
-	int user_time = UNPACK(acc->ac_utime);
-	int elap_time = UNPACK(acc->ac_etime);
-
-	if (strcmp(acc->ac_comm, COMMAND) ||
-		acc->ac_btime < start_time ||
-		acc->ac_btime - start_time > 1 ||
-		acc->ac_uid != getuid() ||
-		acc->ac_gid != getgid() ||
-		user_time/clock_ticks > 1 ||
-		sys_time/clock_ticks  > 1 ||
-		elap_time/clock_ticks >= 2 ||
-		acc->ac_exitcode != rc)
-		return 0;
-	return 1;
-}
+	int sys_time  = UNPACK(ACCT_MEMBER(ac_stime));
+	int user_time = UNPACK(ACCT_MEMBER(ac_stime));
+	int ret = 0, tmp;
+	float tmp2;
+
+	if (strcmp(ACCT_MEMBER(ac_comm), COMMAND)) {
+		tst_res(TINFO, "ac_comm != '%s' ('%s')", COMMAND,
+			ACCT_MEMBER(ac_comm));
+		ret = 1;
+	}
 
-static int verify_acct_v3(struct acct_v3 *acc)
-{
-	int sys_time  = UNPACK(acc->ac_stime);
-	int user_time = UNPACK(acc->ac_utime);
-	int elap_time = acc->ac_etime;
-
-	if (strcmp(acc->ac_comm, COMMAND) ||
-		acc->ac_btime < start_time ||
-		acc->ac_btime - start_time > 1 ||
-		acc->ac_uid != getuid() ||
-		acc->ac_gid != getgid() ||
-		acc->ac_ppid != (uint32_t)getpid() ||
-		user_time/clock_ticks > 1 ||
-		sys_time/clock_ticks  > 1 ||
-		elap_time/clock_ticks >= 2 ||
-		acc->ac_exitcode != rc ||
-		acc->ac_version != 3 ||
-		acc->ac_pid < 1)
-		return 0;
-	return 1;
+	if (ACCT_MEMBER(ac_btime) < start_time) {
+		tst_res(TINFO, "ac_btime < %d (%d)", start_time,
+			ACCT_MEMBER(ac_btime));
+		ret = 1;
+	}
+
+	tmp = ACCT_MEMBER(ac_btime) - start_time;
+	if (tmp > 1) {
+		tst_res(TINFO, "ac_btime - %d > 1 (%d)", start_time, tmp);
+		ret = 1;
+	}
+
+	if (ACCT_MEMBER(ac_uid) != getuid()) {
+		tst_res(TINFO, "ac_uid != %d (%d)", getuid(),
+			ACCT_MEMBER(ac_uid));
+		ret = 1;
+	}
+
+	if (ACCT_MEMBER(ac_gid) != getgid()) {
+		tst_res(TINFO, "ac_gid != %d (%d)", getgid(),
+			ACCT_MEMBER(ac_gid));
+		ret = 1;
+	}
+
+	tmp2 = user_time/clock_ticks;
+	if (tmp2 > 1) {
+		tst_res(TINFO, "user_time/clock_ticks > 1 (%d/%d: %.2f)",
+			user_time, clock_ticks, tmp2);
+		ret = 1;
+	}
+
+	tmp2 = sys_time/clock_ticks;
+	if (tmp2 > 1) {
+		tst_res(TINFO, "sys_time/clock_ticks > 1 (%d/%d: %.2f)",
+			sys_time, clock_ticks, tmp2);
+		ret = 1;
+	}
+
+	tmp2 = elap_time/clock_ticks;
+	if (tmp2 >= 2) {
+		tst_res(TINFO, "elap_time/clock_ticks >= 2 (%d/%d: %.2f)",
+			elap_time, clock_ticks, tmp2);
+		ret = 1;
+	}
+
+	if (ACCT_MEMBER(ac_exitcode) != rc) {
+		tst_res(TINFO, "ac_exitcode != %d (%d)", rc,
+			ACCT_MEMBER(ac_exitcode));
+		ret = 1;
+	}
+	if (!v3)
+		return ret;
+
+	if (ACCT_MEMBER_V3(ac_ppid) != (uint32_t)getpid()) {
+		tst_res(TINFO, "ac_ppid != %d (%d)", (uint32_t)getpid(),
+			ACCT_MEMBER_V3(ac_ppid));
+		ret = 1;
+	}
+
+	if (ACCT_MEMBER_V3(ac_version) != 3) {
+		tst_res(TINFO, "ac_version != 3 (%d)",
+			ACCT_MEMBER_V3(ac_version));
+		ret = 1;
+	}
+
+	if (ACCT_MEMBER_V3(ac_pid) < 1) {
+		tst_res(TINFO, "ac_pid < 1 (%d)", ACCT_MEMBER_V3(ac_pid));
+		ret = 1;
+	}
+	return ret;
 }
 
 static void run(void)
 {
-	int read_bytes, ret, entry_count;
+	int read_bytes, ret;
+	int entry_count = 0, i = 0;
 
 	fd = SAFE_OPEN(OUTPUT_FILE, O_RDWR | O_CREAT, 0644);
 
@@ -123,26 +170,27 @@ static void run(void)
 	run_command();
 	acct(NULL);
 
-	entry_count = 0;
 	do {
+		tst_res(TINFO, "== loop %d ==", ++i);
+
 		read_bytes = SAFE_READ(0, fd, &acct_struct, acct_size);
 
 		if (v3)
-			ret = verify_acct_v3(&acct_struct.v3);
+			ret = verify_acct(&acct_struct.v3, acct_struct.v3.ac_etime);
 		else
-			ret = verify_acct(&acct_struct.v0);
+			ret = verify_acct(&acct_struct.v0, UNPACK(acct_struct.v0.ac_etime));
 
 		if (read_bytes)
 			entry_count++;
-	} while (read_bytes == acct_size && !ret);
+	} while (read_bytes == acct_size && ret);
 
 	tst_res(TINFO, "Number of accounting file entries tested: %d",
 			entry_count);
 
 	if (ret)
-		tst_res(TPASS, "acct() wrote correct file contents!");
-	else
 		tst_res(TFAIL, "acct() wrote incorrect file contents!");
+	else
+		tst_res(TPASS, "acct() wrote correct file contents!");
 
 	SAFE_CLOSE(fd);
 }
-- 
2.22.1

