From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Oct 2017 16:41:30 +0200
Subject: [LTP] [PATCH v3 16/16] doc: Update device flags in
	test-writing-guidelines
In-Reply-To: <20171011144130.29728-1-chrubis@suse.cz>
References: <20171011144130.29728-1-chrubis@suse.cz>
Message-ID: <20171011144130.29728-16-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/test-writing-guidelines.txt | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 15d418954..133cb9372 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -914,12 +914,27 @@ then.
 If '.format_device' flag is set the device is formatted with a filesystem as
 well. You can use '.dev_fs_type' to override the default filesystem type if
 needed and pass additional options to mkfs via '.dev_fs_opts' and
-'.dev_extra_opt' pointers.
+'.dev_extra_opt' pointers. Note that '.format_device' implies '.needs_device'
+there is no need to set both.
 
 If '.mount_device' is set, the device is mounted at '.mntpoint' which is used
 to pass a directory name that will be created and used as mount destination.
 You can pass additional flags and data to the mount command via '.mnt_flags'
-and '.mnt_data' pointers.
+and '.mnt_data' pointers. Note that '.mount_device' implies '.needs_device'
+and '.format_device' so there is no need to set the later two.
+
+If '.needs_rofs' is set, read-only filesystem is mounted at '.mntpoint' this
+one is supposed to be used for 'EROFS' tests.
+
+If '.all_filesystems' is set the test function is executed for all supported
+filesystems. Supported filesystems are detected based on existence of the
+'mkfs.$fs' helper and on kernel support to mount it. For each supported
+filesystem the 'tst_device.fs_type' is set to the currently tested fs type, if
+'.format_device' is set the device is formatted as well, if '.mount_device' is
+set it's mounted at '.mntpoint'. Also the test timeout is reset for each
+execution of the test fuction. This flag is expected to be used for filesystem
+related syscalls that are at least partly implemented in the filesystem
+specific code e.g. fallocate().
 
 [source,c]
 -------------------------------------------------------------------------------
-- 
2.13.5

