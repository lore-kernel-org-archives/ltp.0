From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 9 Dec 2019 08:42:06 +0100
Subject: [LTP] [PATCH] Remove duplicated ".needs_tmpdir=1" when using
 equivalent flags
In-Reply-To: <1575447166-7813-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1575447166-7813-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20191209074206.GA2373112@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> From ltp library code, when we have used these flags(".needs_device"
> ".mntpoint" ".resource_file" ".needs_checkpoints" ".format_device"
> "mount_device" ".all_filesystems"), we don't need to set ".needs_tmpdir=1".
> So remove it.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

LGTM (unless Cyril has some objections).

I propose following diff (fix formating, reword; I'll modify it before merge).

Kind regards,
Petr

diff --git doc/test-writing-guidelines.txt doc/test-writing-guidelines.txt
index 29b0e5db2..e8e766753 100644
--- doc/test-writing-guidelines.txt
+++ doc/test-writing-guidelines.txt
@@ -493,10 +493,10 @@ this needed.
 
 If '.needs_tmpdir' is set to '1' in the 'struct tst_test' unique test
 temporary is created and it's set as the test working directory. Tests *MUST
-NOT* create temporary files outside that directory. If we have used one of
-these flags(".needs_device" ".mntpoint" ".resource_file" ".needs_checkpoints"
-".format_device" "mount_device" ".all_filesystems"), we don't need to set
-'.needs_tmpdir' again because these flags also will create temporary directory.
+NOT* create temporary files outside that directory. The flag is not needed to
+be set when use these flags: '.all_filesystems', '.format_device', '.mntpoint',
+'.mount_device' '.needs_checkpoints', '.needs_device', '.resource_file'
+(these flags imply creating temporary directory).
 
 IMPORTANT: Close all file descriptors (that point to files in test temporary
            directory, even the unlinked ones) either in the 'test()' function
