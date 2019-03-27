From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Mar 2019 15:48:26 +0100
Subject: [LTP] [PATCH v3] syscalls/sync_file_range: add partial file
 sync test-cases
In-Reply-To: <1551962651-22261-1-git-send-email-sumit.garg@linaro.org>
References: <1551962651-22261-1-git-send-email-sumit.garg@linaro.org>
Message-ID: <20190327144826.GA30619@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Sorry for the long delay.

This is altmost perfect, the only problem is that the third test fails
on vfat. As far as I can tell the reason is that vfat does not support
sparse files, hence seeking to the middle of file and writing there also
schedulles I/O to write zeros from the start of the file to the offset
we started writing to.

Following ugly patch solves the problem:

diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
index 334ea5e88..774524c2f 100644
--- a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
+++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
@@ -45,6 +45,12 @@ static void verify_sync_file_range(struct testcase *tc)
 
        fd = SAFE_OPEN(tc->fname, O_RDWR|O_CREAT, MODE);
 
+       if (!strcmp(tst_device->fs_type, "vfat")) {
+               tst_res(TINFO, "Pre-filling file");
+               tst_fill_fd(fd, 0, tc->write_off, 1);
+               fsync(fd);
+       }
+
        lseek(fd, tc->write_off, SEEK_SET);
 

So either we limit the tests so that the sync region does not overlap with the
possible hole at the start of the file and loose some test coverage.

Or we can add a function to the test library that would return true/false if
sparse files are supported for a given FS.

-- 
Cyril Hrubis
chrubis@suse.cz
