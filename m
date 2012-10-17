Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chris@mips.com>) id 1TOZ68-0003yn-3Q
	for ltp-list@lists.sourceforge.net; Wed, 17 Oct 2012 19:16:08 +0000
Received: from dns1.mips.com ([12.201.5.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TOZ62-0005DK-Ct
	for ltp-list@lists.sourceforge.net; Wed, 17 Oct 2012 19:16:08 +0000
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id q9HJFu4S002647
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Oct 2012 12:15:56 -0700
Received: from exchdb01.mips.com (unknown [192.168.36.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mailgate1.mips.com (Postfix) with ESMTP id 2972B3645FF
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Oct 2012 12:15:52 -0700 (PDT)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MIMEBOUNDARY"
From: Chris Dearman <chris@mips.com>
Date: Wed, 17 Oct 2012 12:15:49 -0700
Message-ID: <20121017191549.24471.86119.stgit@localhost6.localdomain6>
Subject: [LTP] [PATCH] Add generated files to .gitignore
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--MIMEBOUNDARY
Content-Disposition: inline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Chris Dearman <chris@mips.com>
---
 .gitignore                                        |    2 ++
 testcases/commands/.gitignore                     |    5 +++++
 testcases/kernel/mem/.gitignore                   |    2 ++
 testcases/kernel/syscalls/.gitignore              |    8 ++++++++
 testcases/kernel/timers/leapsec/.gitignore        |    1 +
 testcases/misc/tcore_patch_test_suites/.gitignore |    1 +
 6 files changed, 19 insertions(+)
 create mode 100644 testcases/commands/.gitignore
 create mode 100644 testcases/kernel/timers/leapsec/.gitignore
 create mode 100644 testcases/misc/tcore_patch_test_suites/.gitignore

--MIMEBOUNDARY
Content-Disposition: attachment;
	filename="add-generated-files-to-gitigno.patch"
MIME-Version: 1.0
Content-Type: text/plain; name="add-generated-files-to-gitigno.patch";
	charset="utf-8"
Content-Transfer-Encoding: 7bit

diff --git a/.gitignore b/.gitignore
index c723901..c9f5637 100644
--- a/.gitignore
+++ b/.gitignore
@@ -48,3 +48,5 @@ patches/
 logfile.*
 
 /utils/benchmark/ebizzy-0.3/ebizzy
+/lib/tests/bytes_by_prefix_test
+/lib/tests/tst_tmpdir_test
diff --git a/testcases/commands/.gitignore b/testcases/commands/.gitignore
new file mode 100644
index 0000000..01918ea
--- /dev/null
+++ b/testcases/commands/.gitignore
@@ -0,0 +1,5 @@
+/ade/objdump/test_arch_debug
+/ade/objdump/test_arch_stripped
+/ade/size/test
+/cron/cron_dirs_check
+/eject/check_tray
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 5a3a8e9..e60e458 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -57,9 +57,11 @@
 /shmt/shmt08
 /shmt/shmt09
 /shmt/shmt10
+/swapping/swapping01
 /thp/thp01
 /thp/thp02
 /tunable/max_map_count
+/tunable/min_free_kbytes
 /tunable/overcommit_memory
 /vma/vma01
 /vma/vma02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 0d2c3d8..7df28c2 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -68,6 +68,10 @@
 /close/close01
 /close/close02
 /close/close08
+/cma/process_vm01
+/cma/process_vm_readv02
+/cma/process_vm_readv03
+/cma/process_vm_writev02
 /confstr/confstr01
 /connect/connect01
 /creat/creat01
@@ -342,6 +346,7 @@
 /inotify/inotify01
 /inotify/inotify02
 /inotify/inotify03
+/inotify/inotify04
 /inotify_init/inotify_init1_01
 /inotify_init/inotify_init1_02
 /io_cancel/io_cancel01
@@ -460,6 +465,7 @@
 /madvise/madvise01
 /madvise/madvise02
 /madvise/madvise03
+/madvise/madvise04
 /mallopt/mallopt01
 /mbind/mbind01
 /memcmp/memcmp01
@@ -623,6 +629,8 @@
 /read/read02
 /read/read03
 /read/read04
+/readahead/readahead01
+/readahead/readahead02
 /readdir/readdir01
 /readdir/readdir02
 /readlink/creat_slink
diff --git a/testcases/kernel/timers/leapsec/.gitignore b/testcases/kernel/timers/leapsec/.gitignore
new file mode 100644
index 0000000..58787e2
--- /dev/null
+++ b/testcases/kernel/timers/leapsec/.gitignore
@@ -0,0 +1 @@
+/leapsec_timer
diff --git a/testcases/misc/tcore_patch_test_suites/.gitignore b/testcases/misc/tcore_patch_test_suites/.gitignore
new file mode 100644
index 0000000..e47c402
--- /dev/null
+++ b/testcases/misc/tcore_patch_test_suites/.gitignore
@@ -0,0 +1 @@
+/tcore

--MIMEBOUNDARY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
--MIMEBOUNDARY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--MIMEBOUNDARY--

