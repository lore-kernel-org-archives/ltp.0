From: Alessio Balsini <balsini@android.com>
Date: Thu, 24 Jun 2021 13:31:43 +0100
Subject: [LTP] [PATCH] getrlimit/getrlimit03: fix unavailable
 __NR_getrlimit for arm
In-Reply-To: <YNM6QGFYt/bpaPDS@yuki>
References: <20210623134041.366838-1-balsini@android.com>
 <YNM6QGFYt/bpaPDS@yuki>
Message-ID: <YNR7L2ftbwx6IUls@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On Wed, Jun 23, 2021 at 03:42:24PM +0200, Cyril Hrubis wrote:
> Hi!
> > __NR_getrlimit has been deprecated from arm EABI, and is only available
> > if the OABI_COMPAT config option is defined.
> > This causes failures with the current test as it assumes that
> > __NR_getrlimit exists if __NR_ugetrlimit is defined, while this
> > assumption does not hold anymore.
> > 
> > Catch this exception by testing if __NR_getrlimit is defined and the
> > target is arm.
> 
> I suppose that this a proper fix for:
> 
> https://github.com/linux-test-project/ltp/issues/819
> 

We spotted this failure on Android, but they are indeed the same issue!

> 
> I guess that this generates a few unused function warnings, can we fix
> all the places with #if SIGNED_GETRLIMIT in the source code please?
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

Here below the new patch that should fixed the unused functions warnings, as
well as the useless definition of rlimit_long if the signed version of
__NR_getrlimit does not exist.

Thanks,
Alessio

-- >8 --
Subject: [PATCH] getrlimit/getrlimit03: fix deprecated __NR_getrlimit for arm

__NR_getrlimit has been deprecated from arm EABI, and is only available
if the OABI_COMPAT config option is defined.
This may cause failures with the current test as it assumes that
__NR_getrlimit always exists if __NR_ugetrlimit is defined, but this
assumption does not hold anymore.

Catch this exception by testing if __NR_getrlimit is defined and the
target is arm.

Signed-off-by: Alessio Balsini <balsini@android.com>

---
 .../kernel/syscalls/getrlimit/getrlimit03.c   | 27 ++++++++++++++-----
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit03.c b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
index 319bc494a..8601b6caa 100644
--- a/testcases/kernel/syscalls/getrlimit/getrlimit03.c
+++ b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
@@ -36,13 +36,25 @@
  * the architecture predates the "new" handler.  For clarity, this test
  * will call them getrlimit_long and getlimit_ulong internally.
  */
-#define SIGNED_GETRLIMIT (__NR_ugetrlimit != __LTP__NR_INVALID_SYSCALL)
-#if SIGNED_GETRLIMIT
+#if __NR_ugetrlimit != __LTP__NR_INVALID_SYSCALL
+
+/**
+ * __NR_getrlimit has been deprecated from arm EABI and moved to OABI_COMPAT,
+ * so the syscall on arm may or may not be available, also if __NR_ugetrlimit
+ * exists.
+ */
+#if !defined(__arm__) || __NR_getrlimit != __LTP__NR_INVALID_SYSCALL
+#define SIGNED_GETRLIMIT
+#endif
+
 #define __NR_getrlimit_ulong           __NR_ugetrlimit
 #define __NR_getrlimit_ulong_str       "__NR_ugetrlimit"
+
 #else
+
 #define __NR_getrlimit_ulong           __NR_getrlimit
 #define __NR_getrlimit_ulong_str       "__NR_getrlimit"
+
 #endif

 #ifndef HAVE_STRUCT_RLIMIT64
@@ -74,12 +86,13 @@ static int getrlimit_ulong(int resource, struct rlimit_ulong *rlim)
        return syscall(__NR_getrlimit_ulong, resource, rlim);
 }

-#if SIGNED_GETRLIMIT
+const long RLIM_INFINITY_L = LONG_MAX;
+
+#ifdef SIGNED_GETRLIMIT
 struct rlimit_long {
        long rlim_cur;
        long rlim_max;
 };
-const long RLIM_INFINITY_L = LONG_MAX;

 static int getrlimit_long(int resource, struct rlimit_long *rlim)
 {
@@ -116,7 +129,7 @@ static int compare_u64_ulong(int resource, uint64_t val_u64,
        return 0;
 }

-#if SIGNED_GETRLIMIT
+#ifdef SIGNED_GETRLIMIT
 static int compare_u64_long(int resource, uint64_t val_u64, long val_l,
                            const char *kind)
 {
@@ -142,7 +155,7 @@ static void run(unsigned int resource)
        int ret_ul;
        int errno_ul;

-#if SIGNED_GETRLIMIT
+#ifdef SIGNED_GETRLIMIT
        struct rlimit_long rlim_l;
        int ret_l;
        int errno_l;
@@ -167,7 +180,7 @@ static void run(unsigned int resource)
        tst_res(TPASS, "__NR_prlimit64(%d) and %s(%d) gave consistent results",
                resource, __NR_getrlimit_ulong_str, resource);

-#if SIGNED_GETRLIMIT
+#ifdef SIGNED_GETRLIMIT
        errno = 0;
        ret_l = getrlimit_long(resource, &rlim_l);
        errno_l = errno;
--
2.32.0.288.g62a8d224e6-goog

