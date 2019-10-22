From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Oct 2019 16:07:57 +0200
Subject: [LTP] [PATCH v2 2/2] testcases/kernel: Add linux git and CVE tags
In-Reply-To: <20191022140757.29713-1-chrubis@suse.cz>
References: <20191022140757.29713-1-chrubis@suse.cz>
Message-ID: <20191022140757.29713-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Not all tests are annotated at the moment but the majority has been
finished for now.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/cve/cve-2014-0196.c                         | 5 +++++
 testcases/cve/cve-2015-3290.c                         | 5 +++++
 testcases/cve/cve-2016-10044.c                        | 5 +++++
 testcases/cve/cve-2016-7042.c                         | 5 +++++
 testcases/cve/cve-2016-7117.c                         | 5 +++++
 testcases/cve/cve-2017-16939.c                        | 5 +++++
 testcases/cve/cve-2017-17052.c                        | 5 +++++
 testcases/cve/cve-2017-17053.c                        | 5 +++++
 testcases/cve/cve-2017-2618.c                         | 5 +++++
 testcases/cve/cve-2017-2671.c                         | 5 +++++
 testcases/cve/meltdown.c                              | 6 +++++-
 testcases/cve/stack_clash.c                           | 4 ++++
 testcases/kernel/crypto/af_alg01.c                    | 5 +++++
 testcases/kernel/crypto/af_alg02.c                    | 5 +++++
 testcases/kernel/crypto/af_alg03.c                    | 4 ++++
 testcases/kernel/crypto/af_alg04.c                    | 4 ++++
 testcases/kernel/crypto/af_alg05.c                    | 8 +++++++-
 testcases/kernel/crypto/af_alg06.c                    | 4 ++++
 testcases/kernel/crypto/crypto_user01.c               | 6 ++++++
 testcases/kernel/crypto/crypto_user02.c               | 4 ++++
 testcases/kernel/crypto/pcrypt_aead01.c               | 5 +++++
 testcases/kernel/sound/snd_timer01.c                  | 6 ++++++
 testcases/kernel/syscalls/accept/accept02.c           | 5 +++++
 testcases/kernel/syscalls/acct/acct02.c               | 4 ++++
 testcases/kernel/syscalls/add_key/add_key02.c         | 5 +++++
 testcases/kernel/syscalls/bpf/bpf_prog02.c            | 4 ++++
 testcases/kernel/syscalls/bpf/bpf_prog03.c            | 5 +++++
 testcases/kernel/syscalls/futex/futex_cmp_requeue02.c | 5 +++++
 testcases/kernel/syscalls/keyctl/keyctl02.c           | 4 ++++
 testcases/kernel/syscalls/keyctl/keyctl04.c           | 5 +++++
 testcases/kernel/syscalls/keyctl/keyctl05.c           | 4 ++++
 testcases/kernel/syscalls/move_pages/move_pages12.c   | 6 ++++++
 testcases/kernel/syscalls/realpath/realpath01.c       | 4 ++++
 testcases/kernel/syscalls/request_key/request_key05.c | 4 ++++
 testcases/kernel/syscalls/sbrk/sbrk03.c               | 4 ++++
 testcases/kernel/syscalls/sendto/sendto02.c           | 4 ++++
 testcases/kernel/syscalls/setrlimit/setrlimit06.c     | 4 ++++
 37 files changed, 176 insertions(+), 2 deletions(-)

diff --git a/testcases/cve/cve-2014-0196.c b/testcases/cve/cve-2014-0196.c
index 6997fffe4..012cbb7cd 100644
--- a/testcases/cve/cve-2014-0196.c
+++ b/testcases/cve/cve-2014-0196.c
@@ -141,4 +141,9 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = run,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "4291086b1f08"},
+		{"CVE", "2014-0196"},
+		{}
+	}
 };
diff --git a/testcases/cve/cve-2015-3290.c b/testcases/cve/cve-2015-3290.c
index fe630e4af..6c4fd57ac 100644
--- a/testcases/cve/cve-2015-3290.c
+++ b/testcases/cve/cve-2015-3290.c
@@ -469,6 +469,11 @@ static struct tst_test test = {
 	.setup = setup,
 	.timeout = TIMEOUT,
 	.test_all = run,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "9b6e6a8334d5"},
+		{"CVE", "2015-3290"},
+		{}
+	}
 };
 
 #else /* HAVE_PERF_EVENT_ATTR && (defined(__x86_64__) || defined(__i386__)) */
diff --git a/testcases/cve/cve-2016-10044.c b/testcases/cve/cve-2016-10044.c
index c2e79df31..7519676a1 100644
--- a/testcases/cve/cve-2016-10044.c
+++ b/testcases/cve/cve-2016-10044.c
@@ -62,4 +62,9 @@ static struct tst_test test = {
 	.test_all = run,
 	.cleanup = cleanup,
 	.min_kver = "2.6.8",
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "22f6b4d34fcf"},
+		{"CVE", "2016-10044"},
+		{}
+	}
 };
diff --git a/testcases/cve/cve-2016-7042.c b/testcases/cve/cve-2016-7042.c
index 35950adc7..4434265dd 100644
--- a/testcases/cve/cve-2016-7042.c
+++ b/testcases/cve/cve-2016-7042.c
@@ -71,4 +71,9 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = do_test,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "03dab869b7b2"},
+		{"CVE", "2016-7042"},
+		{}
+	}
 };
diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index 5d9f842aa..dca002924 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -150,4 +150,9 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.min_kver = "2.6.33",
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "a2e2725541fa"},
+		{"CVE", "2016-7117"},
+		{}
+	}
 };
diff --git a/testcases/cve/cve-2017-16939.c b/testcases/cve/cve-2017-16939.c
index 4ecc86337..9ab1eb2c3 100644
--- a/testcases/cve/cve-2017-16939.c
+++ b/testcases/cve/cve-2017-16939.c
@@ -77,4 +77,9 @@ static void run(void)
 static struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "1137b5e2529a"},
+		{"CVE", "2017-16939"},
+		{}
+	}
 };
diff --git a/testcases/cve/cve-2017-17052.c b/testcases/cve/cve-2017-17052.c
index 81123fce8..d89c62eb6 100644
--- a/testcases/cve/cve-2017-17052.c
+++ b/testcases/cve/cve-2017-17052.c
@@ -111,4 +111,9 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.setup = setup,
 	.test_all = run,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "2b7e8665b4ff"},
+		{"CVE", "2017-17052"},
+		{}
+	}
 };
diff --git a/testcases/cve/cve-2017-17053.c b/testcases/cve/cve-2017-17053.c
index 646ec11cc..08a08211d 100644
--- a/testcases/cve/cve-2017-17053.c
+++ b/testcases/cve/cve-2017-17053.c
@@ -154,6 +154,11 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = run,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "ccd5b3235180"},
+		{"CVE", "2017-17053"},
+		{}
+	}
 };
 
 #else
diff --git a/testcases/cve/cve-2017-2618.c b/testcases/cve/cve-2017-2618.c
index cf018d401..4ab3cfb8f 100644
--- a/testcases/cve/cve-2017-2618.c
+++ b/testcases/cve/cve-2017-2618.c
@@ -51,4 +51,9 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.setup = setup,
 	.test_all = do_test,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "0c461cb727d1"},
+		{"CVE", "2017-2618"},
+		{}
+	}
 };
diff --git a/testcases/cve/cve-2017-2671.c b/testcases/cve/cve-2017-2671.c
index b92c1d94b..e72795d15 100644
--- a/testcases/cve/cve-2017-2671.c
+++ b/testcases/cve/cve-2017-2671.c
@@ -109,4 +109,9 @@ static struct tst_test test = {
 	.test_all = run,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "43a6684519ab"},
+		{"CVE", "2017-2671"},
+		{}
+	}
 };
diff --git a/testcases/cve/meltdown.c b/testcases/cve/meltdown.c
index 863f1a9e4..db00e1811 100644
--- a/testcases/cve/meltdown.c
+++ b/testcases/cve/meltdown.c
@@ -377,7 +377,11 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
 	.cleanup = cleanup,
-	.min_kver = "2.6.32"
+	.min_kver = "2.6.32",
+	.tags = (const struct tst_tag[]) {
+		{"CVE", "2017-5754"},
+		{}
+	}
 };
 
 #else /* #if defined(__x86_64__) || defined(__i386__) */
diff --git a/testcases/cve/stack_clash.c b/testcases/cve/stack_clash.c
index 3ea3ec491..ecbf5f6da 100644
--- a/testcases/cve/stack_clash.c
+++ b/testcases/cve/stack_clash.c
@@ -250,4 +250,8 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.setup = setup,
 	.test_all = stack_clash_test,
+	.tags = (const struct tst_tag[]) {
+		{"CVE", "2017-1000364"},
+		{}
+	}
 };
diff --git a/testcases/kernel/crypto/af_alg01.c b/testcases/kernel/crypto/af_alg01.c
index bb6e01738..d3e823e6c 100644
--- a/testcases/kernel/crypto/af_alg01.c
+++ b/testcases/kernel/crypto/af_alg01.c
@@ -76,4 +76,9 @@ static void do_test(unsigned int i)
 static struct tst_test test = {
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(hash_algs),
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "af3ff8045bbf"},
+		{"CVE", "2017-17806"},
+		{}
+	}
 };
diff --git a/testcases/kernel/crypto/af_alg02.c b/testcases/kernel/crypto/af_alg02.c
index 08087ecac..fab0010c9 100644
--- a/testcases/kernel/crypto/af_alg02.c
+++ b/testcases/kernel/crypto/af_alg02.c
@@ -59,4 +59,9 @@ static struct tst_test test = {
 	.test_all = run,
 	.timeout = 20,
 	.needs_checkpoints = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "ecaaab564978"},
+		{"CVE", "2017-17805"},
+		{}
+	}
 };
diff --git a/testcases/kernel/crypto/af_alg03.c b/testcases/kernel/crypto/af_alg03.c
index 240c52835..5f214e48b 100644
--- a/testcases/kernel/crypto/af_alg03.c
+++ b/testcases/kernel/crypto/af_alg03.c
@@ -28,4 +28,8 @@ static void run(void)
 
 static struct tst_test test = {
 	.test_all = run,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "e57121d08c38"},
+		{}
+	}
 };
diff --git a/testcases/kernel/crypto/af_alg04.c b/testcases/kernel/crypto/af_alg04.c
index 48239e020..df049048a 100644
--- a/testcases/kernel/crypto/af_alg04.c
+++ b/testcases/kernel/crypto/af_alg04.c
@@ -55,4 +55,8 @@ static void run(void)
 static struct tst_test test = {
 	.test_all = run,
 	.forks_child = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "bb2964810233"},
+		{}
+	}
 };
diff --git a/testcases/kernel/crypto/af_alg05.c b/testcases/kernel/crypto/af_alg05.c
index 964adffcc..df2b03546 100644
--- a/testcases/kernel/crypto/af_alg05.c
+++ b/testcases/kernel/crypto/af_alg05.c
@@ -11,7 +11,7 @@
  * boundary.  Based on the reproducer from the commit message.  Note that this
  * issue only reproduces on certain architectures, such as arm and arm64.
  *
- * On some older kernel without commit 160544075f2 ("crypto: scatterwalk - Hide
+ * On some older kernel without commit 160544075f2a ("crypto: scatterwalk - Hide
  * PageSlab call to optimise away flush_dcache_page") , it doesn't use
  * ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macro. It can crash on all architectures.
  * Without skcipher walk interface, it is also a regresstion test for commit
@@ -46,4 +46,10 @@ static void run(void)
 
 static struct tst_test test = {
 	.test_all = run,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "8088d3dd4d7c"},
+		{"linux-git", "160544075f2a"},
+		{"linux-git", "0868def3e410"},
+		{}
+	}
 };
diff --git a/testcases/kernel/crypto/af_alg06.c b/testcases/kernel/crypto/af_alg06.c
index 586d91b1d..6acdf8532 100644
--- a/testcases/kernel/crypto/af_alg06.c
+++ b/testcases/kernel/crypto/af_alg06.c
@@ -48,4 +48,8 @@ static void run(void)
 
 static struct tst_test test = {
 	.test_all = run,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "8f9c46934848"},
+		{}
+	}
 };
diff --git a/testcases/kernel/crypto/crypto_user01.c b/testcases/kernel/crypto/crypto_user01.c
index 163d7a2dd..47bf9f0d2 100644
--- a/testcases/kernel/crypto/crypto_user01.c
+++ b/testcases/kernel/crypto/crypto_user01.c
@@ -192,4 +192,10 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
 	.cleanup = cleanup,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "f43f39958beb"},
+		{"CVE", "2013-2547"},
+		{"CVE", "2018-19854"},
+		{}
+	}
 };
diff --git a/testcases/kernel/crypto/crypto_user02.c b/testcases/kernel/crypto/crypto_user02.c
index 6090b5a4e..384e344f2 100644
--- a/testcases/kernel/crypto/crypto_user02.c
+++ b/testcases/kernel/crypto/crypto_user02.c
@@ -105,4 +105,8 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_root = 1,
 	.forks_child = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "21d4120ec6f5"},
+		{}
+	}
 };
diff --git a/testcases/kernel/crypto/pcrypt_aead01.c b/testcases/kernel/crypto/pcrypt_aead01.c
index 3dc8c58c2..0609af9f6 100644
--- a/testcases/kernel/crypto/pcrypt_aead01.c
+++ b/testcases/kernel/crypto/pcrypt_aead01.c
@@ -75,4 +75,9 @@ static struct tst_test test = {
 	.test_all = run,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "d76c68109f37"},
+		{"CVE", "2017-5754"},
+		{}
+	}
 };
diff --git a/testcases/kernel/sound/snd_timer01.c b/testcases/kernel/sound/snd_timer01.c
index f62696659..e339ec862 100644
--- a/testcases/kernel/sound/snd_timer01.c
+++ b/testcases/kernel/sound/snd_timer01.c
@@ -140,4 +140,10 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "d11662f4f798"},
+		{"linux-git", "ba3021b2c79b"},
+		{"CVE", "2017-1000380"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/accept/accept02.c b/testcases/kernel/syscalls/accept/accept02.c
index 1a0f625c9..37ab8b64f 100644
--- a/testcases/kernel/syscalls/accept/accept02.c
+++ b/testcases/kernel/syscalls/accept/accept02.c
@@ -142,4 +142,9 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_checkpoints = 1,
+	.tags = (const struct tst_tag[]) {
+		{"CVE", "2017-8890"},
+		{"linux-git", "657831ff"},
+		{},
+	}
 };
diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
index 4d95aafec..890568b08 100644
--- a/testcases/kernel/syscalls/acct/acct02.c
+++ b/testcases/kernel/syscalls/acct/acct02.c
@@ -263,4 +263,8 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
 	.needs_root = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "4d9570158b626"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/add_key/add_key02.c b/testcases/kernel/syscalls/add_key/add_key02.c
index 4a5cf054a..159234f67 100644
--- a/testcases/kernel/syscalls/add_key/add_key02.c
+++ b/testcases/kernel/syscalls/add_key/add_key02.c
@@ -83,4 +83,9 @@ static void verify_add_key(unsigned int i)
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_add_key,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "5649645d725c"},
+		{"CVE", "2017-15274"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog02.c b/testcases/kernel/syscalls/bpf/bpf_prog02.c
index 62e02bc9f..acff1884a 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog02.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog02.c
@@ -181,5 +181,9 @@ static struct tst_test test = {
 		{&attr, .size = sizeof(*attr)},
 		{&msg, .size = sizeof(MSG)},
 		{},
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "3612af783cf5"},
+		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog03.c b/testcases/kernel/syscalls/bpf/bpf_prog03.c
index 47088a250..d79815961 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog03.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog03.c
@@ -187,5 +187,10 @@ static struct tst_test test = {
 		{&attr, .size = sizeof(*attr)},
 		{&msg, .size = sizeof(MSG)},
 		{},
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "95a762e2c8c9"},
+		{"CVE", "2017-16995"},
+		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
index 3ea19428c..228d8cff6 100644
--- a/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
@@ -73,4 +73,9 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test = verify_futex_cmp_requeue,
 	.tcnt = ARRAY_SIZE(tcases),
+	.tags = (const struct tst_tag[]) {
+		{"CVE", "2018-6927"},
+		{"linux-git", "fbe0e839d1e2"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/keyctl/keyctl02.c b/testcases/kernel/syscalls/keyctl/keyctl02.c
index b034275d2..f4ee03f33 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl02.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl02.c
@@ -136,4 +136,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = do_test,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "b4a1b4f5047e"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/keyctl/keyctl04.c b/testcases/kernel/syscalls/keyctl/keyctl04.c
index d30d25b04..1fed23ca6 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl04.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl04.c
@@ -43,4 +43,9 @@ static void do_test(void)
 
 static struct tst_test test = {
 	.test_all = do_test,
+	.tags = (const struct tst_tag[]) {
+		{"CVE", "2017-7472"},
+		{"linux-git", "c9f838d104fe"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/keyctl/keyctl05.c b/testcases/kernel/syscalls/keyctl/keyctl05.c
index 653b838f5..c592eb49e 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl05.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl05.c
@@ -207,4 +207,8 @@ static struct tst_test test = {
 	.tcnt = 3,
 	.test = do_test,
 	.forks_child = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "63a0b0509e70"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index c2927fb86..c906acbe3 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -330,6 +330,12 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(tcases),
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "e66f17ff7177"},
+		{"linux-git", "c9d398fa2378"},
+		{"linux-git", "4643d67e8cb0"},
+		{}
+	}
 };
 
 #else
diff --git a/testcases/kernel/syscalls/realpath/realpath01.c b/testcases/kernel/syscalls/realpath/realpath01.c
index fc2af2a1c..c0381e9cb 100644
--- a/testcases/kernel/syscalls/realpath/realpath01.c
+++ b/testcases/kernel/syscalls/realpath/realpath01.c
@@ -41,4 +41,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
+	.tags = (const struct tst_tag[]) {
+		{"CVE", "2018-1000001"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/request_key/request_key05.c b/testcases/kernel/syscalls/request_key/request_key05.c
index 129cc0507..a17d1d058 100644
--- a/testcases/kernel/syscalls/request_key/request_key05.c
+++ b/testcases/kernel/syscalls/request_key/request_key05.c
@@ -31,4 +31,8 @@ static void run(void)
 
 static struct tst_test test = {
 	.test_all = run,
+	.tags = (const struct tst_tag[]) {
+		{"CVE", "2017-6951"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/sbrk/sbrk03.c b/testcases/kernel/syscalls/sbrk/sbrk03.c
index 761a01c9d..80d2020ff 100644
--- a/testcases/kernel/syscalls/sbrk/sbrk03.c
+++ b/testcases/kernel/syscalls/sbrk/sbrk03.c
@@ -66,4 +66,8 @@ static void sbrk_test(void)
 
 static struct tst_test test = {
 	.test_all = sbrk_test,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "473a06572fcd"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/sendto/sendto02.c b/testcases/kernel/syscalls/sendto/sendto02.c
index 5c9f00125..743101733 100644
--- a/testcases/kernel/syscalls/sendto/sendto02.c
+++ b/testcases/kernel/syscalls/sendto/sendto02.c
@@ -77,4 +77,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_sendto,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "6e51fe757259"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit06.c b/testcases/kernel/syscalls/setrlimit/setrlimit06.c
index 87e6b0e32..726b26841 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit06.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit06.c
@@ -114,4 +114,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.forks_child = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "c3bca5d450b62"},
+		{}
+	}
 };
-- 
2.21.0

