From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 12 May 2020 09:49:13 +0530
Subject: [LTP] [PATCH V2 15/17] syscalls/semtimedop: Add support for
 semtimedop and its time64 version
In-Reply-To: <CAEemH2dps8ib=GQKd+GftKYFdefFM+9sgvJw8SWccSDcXTRHaQ@mail.gmail.com>
References: <cover.1588911607.git.viresh.kumar@linaro.org>
 <8a675726b6e553e740016390c774bce19efc5a12.1588911607.git.viresh.kumar@linaro.org>
 <CAEemH2cX=zyULO6qZBV5fBQv74dm2yuiUeRJ8SMe7OXYWJJ_sQ@mail.gmail.com>
 <20200511104306.x4sit6vy2a4bmcgc@vireshk-i7>
 <CAEemH2dps8ib=GQKd+GftKYFdefFM+9sgvJw8SWccSDcXTRHaQ@mail.gmail.com>
Message-ID: <20200512041913.6nd5ws6foc7bszp2@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11-05-20, 20:29, Li Wang wrote:
> This delta works(on x86_64) for me. But the s390x issue looks like the same
> as the futex TCONF in another email.

Ah, this should fix it then:

diff --git a/testcases/kernel/syscalls/ipc/semop/semop.h b/testcases/kernel/syscalls/ipc/semop/semop.h
index 7180f6e35185..584d12c68e0d 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop.h
+++ b/testcases/kernel/syscalls/ipc/semop/semop.h
@@ -44,4 +44,12 @@ static inline int call_semop(struct test_variants *tv, int semid,
 	return tv->semtimedop(semid, sops, nsops, tst_ts_get(timeout));
 }
 
+static inline void semop_supported_by_kernel(struct test_variants *tv)
+{
+       /* Check if the syscall is implemented on the platform */
+       TEST(call_semop(tv, 0, NULL, 0, NULL));
+       if (TST_RET == -1 && TST_ERR == ENOSYS)
+               tst_brk(TCONF, "Test not supported on kernel/platform");
+}
+
 #endif /* SEMOP_VAR__ */
diff --git a/testcases/kernel/syscalls/ipc/semop/semop01.c b/testcases/kernel/syscalls/ipc/semop/semop01.c
index cc8725bdbed3..7947183c837b 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop01.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop01.c
@@ -99,9 +99,11 @@ static void run(void)
 
 static void setup(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	int i;
 
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	semop_supported_by_kernel(tv);
 
 	get_arr.array = malloc(sizeof(unsigned short int) * PSEMS);
 	if (get_arr.array == NULL)
diff --git a/testcases/kernel/syscalls/ipc/semop/semop02.c b/testcases/kernel/syscalls/ipc/semop/semop02.c
index 5af1909480b5..4ffb9dd72c1c 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop02.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop02.c
@@ -47,13 +47,15 @@ static struct test_case_t {
 
 static void setup(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	char nobody_uid[] = "nobody";
 	struct passwd *ltpuser;
 	key_t semkey2;
 	struct seminfo ipc_buf;
 	union semun arr;
 
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	semop_supported_by_kernel(tv);
 
 	ltpuser = SAFE_GETPWNAM(nobody_uid);
 	SAFE_SETUID(ltpuser->pw_uid);
diff --git a/testcases/kernel/syscalls/ipc/semop/semop03.c b/testcases/kernel/syscalls/ipc/semop/semop03.c
index e877f989edaa..40a6b095c57d 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop03.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop03.c
@@ -88,7 +88,10 @@ static void run(unsigned int i)
 
 static void setup(void)
 {
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	semop_supported_by_kernel(tv);
 
 	/* get an IPC resource key */
 	semkey = GETIPCKEY();
diff --git a/testcases/kernel/syscalls/ipc/semop/semop04.c b/testcases/kernel/syscalls/ipc/semop/semop04.c
index 226a64603943..5e4bfeb625e2 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop04.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop04.c
@@ -94,7 +94,10 @@ static void run(unsigned int i)
 
 static void setup(void)
 {
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	semop_supported_by_kernel(tv);
 
 	val = 1;
 
diff --git a/testcases/kernel/syscalls/ipc/semop/semop05.c b/testcases/kernel/syscalls/ipc/semop/semop05.c
index 0e18f77ba1f5..770646bc564c 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop05.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop05.c
@@ -145,7 +145,10 @@ static void sighandler(int sig)
 
 static void setup(void)
 {
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	semop_supported_by_kernel(tv);
 
 	SAFE_SIGNAL(SIGHUP, sighandler);
 

-- 
viresh
