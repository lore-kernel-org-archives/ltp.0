From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 2 Mar 2020 15:32:44 +0530
Subject: [LTP] [PATCH] syscalls/openat2: New tests
In-Reply-To: <20200302093622.GA5288@rei.lan>
References: <b927e5f2cd36ec2dd57202b492563922b1a94e77.1582886993.git.viresh.kumar@linaro.org>
 <20200228132210.GC8324@rei>
 <20200302063714.claovt5uyi7gxf2o@vireshk-i7>
 <20200302084651.GA4736@rei.lan>
 <20200302090718.hmyxgbmrwltxiz56@vireshk-i7>
 <20200302093622.GA5288@rei.lan>
Message-ID: <20200302100244.6syqeskptbsnyf6t@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02-03-20, 10:36, Cyril Hrubis wrote:
> The code you had there in the first place was passing by accident
> because the were non-zero bytes on the stack after the structure, which
> is pretty bad, because if it started to fail randomly nobody would know
> why.

I know :)

What about this? This doesn't test the success case with pad = 0 though, as it
is a success case. Don't want to add a separate file for it. :)

diff --git a/testcases/kernel/syscalls/openat2/openat202.c b/testcases/kernel/syscalls/openat2/openat202.c
index 6889c89ab68d..c945d279dcdf 100644
--- a/testcases/kernel/syscalls/openat2/openat202.c
+++ b/testcases/kernel/syscalls/openat2/openat202.c
@@ -9,7 +9,10 @@
 
 #define TEST_FILE "test_file"
 
-static struct open_how *how;
+struct open_how_pad {
+       struct open_how how;
+       uint64_t pad;
+} *phow;
 
 static struct tcase {
        const char *name;
@@ -18,28 +21,31 @@ static struct tcase {
        uint64_t flags;
        uint64_t mode;
        uint64_t resolve;
+       uint64_t pad;
        size_t size;
        int exp_errno;
 } tcases[] = {
-       {"invalid-dfd", -1, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, 0, sizeof(struct open_how), EBADF},
-       {"invalid-pathname", AT_FDCWD, NULL, O_RDONLY | O_CREAT, S_IRUSR, 0, sizeof(struct open_how), EFAULT},
-       {"invalid-flags", AT_FDCWD, TEST_FILE, O_RDONLY, S_IWUSR, 0, sizeof(struct open_how), EINVAL},
-       {"invalid-mode", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, -1, 0, sizeof(struct open_how), EINVAL},
-       {"invalid-resolve", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, -1, sizeof(struct open_how), EINVAL},
-       {"invalid-size-0", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, 0, 0, EINVAL},
-       {"invalid-size-big", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, 0, 2 * sizeof(struct open_how), EFAULT},
-       {"invalid-size-small", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, 0, sizeof(struct open_how) - 1, EINVAL},
+       {"invalid-dfd", -1, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, 0, 0, sizeof(struct open_how), EBADF},
+       {"invalid-pathname", AT_FDCWD, NULL, O_RDONLY | O_CREAT, S_IRUSR, 0, 0, sizeof(struct open_how), EFAULT},
+       {"invalid-flags", AT_FDCWD, TEST_FILE, O_RDONLY, S_IWUSR, 0, 0, sizeof(struct open_how), EINVAL},
+       {"invalid-mode", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, -1, 0, 0, sizeof(struct open_how), EINVAL},
+       {"invalid-resolve", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, -1, 0, sizeof(struct open_how), EINVAL},
+       {"invalid-size-0", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, 0, 0, 0, EINVAL},
+       {"invalid-size-big-with-pad", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, 0, 1, sizeof(struct open_how_pad), E2BIG},
+       {"invalid-size-big", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, 0, 0, 2 * sizeof(struct open_how_pad), EFAULT},
+       {"invalid-size-small", AT_FDCWD, TEST_FILE, O_RDWR | O_CREAT, S_IRWXU, 0, 0, sizeof(struct open_how) - 1, EINVAL},
 };
 
 static void run(unsigned int n)
 {
        struct tcase *tc = &tcases[n];
 
-       how->flags = tc->flags;
-       how->mode = tc->mode;
-       how->resolve = tc->resolve;
+       phow->how.flags = tc->flags;
+       phow->how.mode = tc->mode;
+       phow->how.resolve = tc->resolve;
+       phow->pad = tc->pad;
 
-       TEST(openat2(tc->dfd, tc->pathname, how, tc->size));
+       TEST(openat2(tc->dfd, tc->pathname, &phow->how, tc->size));
 
        if (TST_RET >= 0) {
                SAFE_CLOSE(TST_RET);
@@ -63,7 +69,7 @@ static struct tst_test test = {
        .setup = openat2_supported_by_kernel,
        .needs_tmpdir = 1,
        .bufs = (struct tst_buffers []) {
-               {&how, .size = sizeof(*how)},
+               {&phow, .size = sizeof(*phow)},
                {},
        }
 };

-- 
viresh
