From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 11 May 2020 16:38:49 +0530
Subject: [LTP] [PATCH V2 06/17] syscalls/futex: Add support for time64
 tests
In-Reply-To: <CAEemH2f8fQ58f_sJBkF4j2gnRORYm28g5Bzy21TF_M_wKuANUg@mail.gmail.com>
References: <cover.1588911607.git.viresh.kumar@linaro.org>
 <5432ab11234b37bf7f46db7c1a624a432c8aedf3.1588911607.git.viresh.kumar@linaro.org>
 <CAEemH2f8fQ58f_sJBkF4j2gnRORYm28g5Bzy21TF_M_wKuANUg@mail.gmail.com>
Message-ID: <20200511110849.jugfm7ett67uxfpb@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 09-05-20, 17:02, Li Wang wrote:
> This might not safe to use it directly if only check __NR_futex_time64 being
> defined. i.e Test it on the platform without achieving the system
> syscall(but
> define __NR_futex_time64), the test children exit with TCONF will cause
> kind of issues.

I will add this to the patch then, I am wondering if I need to add
this to all tests now ? Cyril ?

diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
index efde3410f564..537641766357 100644
--- a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
@@ -194,7 +194,11 @@ static void verify_futex_cmp_requeue(unsigned int n)
 
 static void setup(void)
 {
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
+
 	max_sleep_ms = tst_multiply_timeout(5000);
 
 	sd = SAFE_MMAP(NULL, sizeof(*sd), PROT_READ | PROT_WRITE,
diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
index e1af5ddab509..dd8fafb3ee38 100644
--- a/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
@@ -69,7 +69,11 @@ static void verify_futex_cmp_requeue(unsigned int n)
 
 static void setup(void)
 {
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
+
 	futexes = SAFE_MMAP(NULL, sizeof(futex_t) * 2, PROT_READ | PROT_WRITE,
 			    MAP_ANONYMOUS | MAP_SHARED, -1, 0);
 
diff --git a/testcases/kernel/syscalls/futex/futex_wait01.c b/testcases/kernel/syscalls/futex/futex_wait01.c
index 41b21a71f2c6..e884e696ef55 100644
--- a/testcases/kernel/syscalls/futex/futex_wait01.c
+++ b/testcases/kernel/syscalls/futex/futex_wait01.c
@@ -74,7 +74,10 @@ static void run(unsigned int n)
 
 static void setup(void)
 {
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/futex/futex_wait02.c b/testcases/kernel/syscalls/futex/futex_wait02.c
index 7b19115073dd..34b78357f6e6 100644
--- a/testcases/kernel/syscalls/futex/futex_wait02.c
+++ b/testcases/kernel/syscalls/futex/futex_wait02.c
@@ -74,7 +74,10 @@ static void run(void)
 
 static void setup(void)
 {
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
 
 	futex = SAFE_MMAP(NULL, sizeof(*futex), PROT_READ | PROT_WRITE,
 			  MAP_ANONYMOUS | MAP_SHARED, -1, 0);
diff --git a/testcases/kernel/syscalls/futex/futex_wait03.c b/testcases/kernel/syscalls/futex/futex_wait03.c
index 83601479adc0..e436b238a165 100644
--- a/testcases/kernel/syscalls/futex/futex_wait03.c
+++ b/testcases/kernel/syscalls/futex/futex_wait03.c
@@ -73,7 +73,10 @@ static void run(void)
 
 static void setup(void)
 {
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/futex/futex_wait04.c b/testcases/kernel/syscalls/futex/futex_wait04.c
index ba6988a20e98..8de3c90b08d3 100644
--- a/testcases/kernel/syscalls/futex/futex_wait04.c
+++ b/testcases/kernel/syscalls/futex/futex_wait04.c
@@ -53,7 +53,10 @@ static void run(void)
 
 static void setup(void)
 {
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/futex/futex_wait_bitset01.c b/testcases/kernel/syscalls/futex/futex_wait_bitset01.c
index 9f2f4025d4a4..a871af992572 100644
--- a/testcases/kernel/syscalls/futex/futex_wait_bitset01.c
+++ b/testcases/kernel/syscalls/futex/futex_wait_bitset01.c
@@ -102,7 +102,10 @@ static void run(unsigned int n)
 
 static void setup(void)
 {
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/futex/futex_wake01.c b/testcases/kernel/syscalls/futex/futex_wake01.c
index 21cf158daac7..2dbe8cc2f3aa 100644
--- a/testcases/kernel/syscalls/futex/futex_wake01.c
+++ b/testcases/kernel/syscalls/futex/futex_wake01.c
@@ -58,7 +58,10 @@ static void run(unsigned int n)
 
 static void setup(void)
 {
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/futex/futex_wake02.c b/testcases/kernel/syscalls/futex/futex_wake02.c
index cd535163a6e9..3491839872ac 100644
--- a/testcases/kernel/syscalls/futex/futex_wake02.c
+++ b/testcases/kernel/syscalls/futex/futex_wake02.c
@@ -147,7 +147,10 @@ static void run(void)
 
 static void setup(void)
 {
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/futex/futex_wake03.c b/testcases/kernel/syscalls/futex/futex_wake03.c
index b059cf6fa272..29e586c40132 100644
--- a/testcases/kernel/syscalls/futex/futex_wake03.c
+++ b/testcases/kernel/syscalls/futex/futex_wake03.c
@@ -103,7 +103,10 @@ static void run(void)
 
 static void setup(void)
 {
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
 
 	futex = SAFE_MMAP(NULL, sizeof(*futex), PROT_READ | PROT_WRITE,
 			  MAP_ANONYMOUS | MAP_SHARED, -1, 0);
diff --git a/testcases/kernel/syscalls/futex/futex_wake04.c b/testcases/kernel/syscalls/futex/futex_wake04.c
index 2f58efc1eb2a..edbb9c644c57 100644
--- a/testcases/kernel/syscalls/futex/futex_wake04.c
+++ b/testcases/kernel/syscalls/futex/futex_wake04.c
@@ -62,6 +62,7 @@ static void setup(void)
 	struct test_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
 
 	to.type = tv->tstype;
 	tst_ts_set_sec(&to, 30);
diff --git a/testcases/kernel/syscalls/futex/futextest.h b/testcases/kernel/syscalls/futex/futextest.h
index a9dcbbedd249..816f2f1f4689 100644
--- a/testcases/kernel/syscalls/futex/futextest.h
+++ b/testcases/kernel/syscalls/futex/futextest.h
@@ -88,6 +88,17 @@ enum futex_fn_type {
 	FUTEX_FN_FUTEX64,
 };
 
+static inline void futex_supported_by_kernel(enum futex_fn_type fntype)
+{
+	if (fntype != FUTEX_FN_FUTEX64)
+		return;
+
+	/* Check if the syscall is backported on an older kernel */
+	TEST(sys_futex_time64(NULL, 0, 0, NULL, NULL, 0));
+	if (TST_RET == -1 && TST_ERR == ENOSYS)
+		tst_brk(TCONF, "Test not supported on kernel");
+}
+
 /**
  * futex_syscall() - futex syscall wrapper
  * @fntype:	Futex function type

-- 
viresh
