From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Fri, 23 Apr 2021 12:54:33 +0800
Subject: [LTP] [PATCH] syscalls/name_to_handle_at: Clean memory after
 calling name_to_handle_at
Message-ID: <20210423045433.1885-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Need to cleanup memory after calling name_to_handle_at, otherwise the
test will fail when we run with option '-i', as follows:

./name_to_handle_at02 -i 2
tst_test.c:1313: TINFO: Timeout per run is 0h 05m 00s
name_to_handle_at02.c:74: TPASS: invalid-dfd: name_to_handle_at() failed
as expected: EBADF (9)
name_to_handle_at02.c:74: TPASS: not a directory: name_to_handle_at()
failed as expected: ENOTDIR (20)
name_to_handle_at02.c:74: TPASS: invalid-path: name_to_handle_at()
failed as expected: EFAULT (14)
name_to_handle_at02.c:74: TPASS: invalid-file-handle:
name_to_handle_at() failed as expected: EFAULT (14)
name_to_handle_at02.c:74: TPASS: zero-file-handle-size:
name_to_handle_at() failed as expected: EOVERFLOW (75)
name_to_handle_at02.c:74: TPASS: high-file-handle-size:
name_to_handle_at() failed as expected: EINVAL (22)
name_to_handle_at02.c:74: TPASS: invalid-mount_id: name_to_handle_at()
failed as expected: EFAULT (14)
name_to_handle_at02.c:74: TPASS: invalid-flags: name_to_handle_at()
failed as expected: EINVAL (22)
name_to_handle_at02.c:74: TPASS: empty-path: name_to_handle_at() failed
as expected: ENOENT (2)
name_to_handle_at02.c:74: TPASS: invalid-dfd: name_to_handle_at() failed
as expected: EBADF (9)
name_to_handle_at02.c:74: TPASS: not a directory: name_to_handle_at()
failed as expected: ENOTDIR (20)
name_to_handle_at02.c:74: TPASS: invalid-path: name_to_handle_at()
failed as expected: EFAULT (14)
name_to_handle_at02.c:74: TPASS: invalid-file-handle:
name_to_handle_at() failed as expected: EFAULT (14)
name_to_handle_at02.c:62: TFAIL: zero-file-handle-size:
name_to_handle_at() passed unexpectedly
name_to_handle_at02.c:74: TPASS: high-file-handle-size:
name_to_handle_at() failed as expected: EINVAL (22)
name_to_handle_at02.c:74: TPASS: invalid-mount_id: name_to_handle_at()
failed as expected: EFAULT (14)
name_to_handle_at02.c:74: TPASS: invalid-flags: name_to_handle_at()
failed as expected: EINVAL (22)
name_to_handle_at02.c:74: TPASS: empty-path: name_to_handle_at() failed
as expected: ENOENT (2)

Summary:
passed   17
failed   1
broken   0
skipped  0
warnings 0

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 .../kernel/syscalls/name_to_handle_at/name_to_handle_at02.c    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c
index d60c8a0c1..e3e77ef3f 100644
--- a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c
+++ b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c
@@ -54,6 +54,9 @@ static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];

+	/* Need to clean memory after calling name_to_handle_at. */
+	memset(&fh, 0, sizeof(fh));
+
 	TEST(name_to_handle_at(tc->dfd, *tc->pathname, *tc->fhp, *tc->mount_id,
 			       tc->flags));

--
2.17.1

