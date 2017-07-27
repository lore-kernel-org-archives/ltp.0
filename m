From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 27 Jul 2017 11:14:21 +0200
Subject: [LTP] [PATCH v2] Add msync04: verify msync() writes back to file
In-Reply-To: <1500907621-2544-1-git-send-email-vkabatov@redhat.com>
References: <1500907621-2544-1-git-send-email-vkabatov@redhat.com>
Message-ID: <20170727091421.GA26998@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
index 741bcfe20..6ad5b7d12 100644
--- a/testcases/kernel/syscalls/msync/msync04.c
+++ b/testcases/kernel/syscalls/msync/msync04.c
@@ -61,7 +61,7 @@ static void test_msync(void)
 
        pagesize = (off_t)SAFE_SYSCONF(_SC_PAGESIZE);
        test_fd = SAFE_OPEN("msync04/testfile", O_CREAT | O_TRUNC | O_RDWR);
-       SAFE_WRITE(0, test_fd, STRING_TO_WRITE, strlen(STRING_TO_WRITE));
+       SAFE_WRITE(0, test_fd, STRING_TO_WRITE, sizeof(STRING_TO_WRITE) - 1);

The sizeof() - 1 == strlen() for string constants but sizeof() is inherently
O(1) rather than O(n). I guess that modern enough compiler will probably
replace the strlen with sizeof() when optimizing, but that is not a reason to
write suboptimal code...

        mmaped_area = SAFE_MMAP(NULL, pagesize, PROT_READ | PROT_WRITE,
                        MAP_SHARED, test_fd, 0);
        SAFE_CLOSE(test_fd);
@@ -85,11 +85,14 @@ static void test_msync(void)
 
 clean:
        SAFE_MUNMAP(mmaped_area, pagesize);
+       mmaped_area = NULL;
 }

 static void cleanup(void)
 {
-       SAFE_MUNMAP(mmaped_area, pagesize);
+       if (mmaped_area)
+               SAFE_MUNMAP(mmaped_area, pagesize);
+
        if (test_fd > 0)
                SAFE_CLOSE(test_fd);

I've changed the cleanup to unmap the pointer only if it was mapped.
While unlikely the memory pointer could be teoreticaly reused then we
will unmap memory mapped possibly by libc or test library in the
cleanup.

 }
@@ -99,7 +102,6 @@ static struct tst_test test = {
+       .setup = setup,
        .cleanup = cleanup,
        .needs_tmpdir = 1,
        .needs_root = 1,
-       .format_device = 1,
        .mntpoint = "msync04",
        .mount_device = 1,
        .min_kver = "2.6.25",

The mount_device implies format_device as well, so no need to specify
both either.


And finally I've moved the pagesize initialization to a setup function,
as we do not need to call it repeately in a case of repeated test runs
(see the test -i and -I options).

-- 
Cyril Hrubis
chrubis@suse.cz
