Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PGWSP-0004VT-34
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 12:40:49 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id C149D5FC9F
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Nov 2010 13:40:41 +0100 (CET)
Date: Thu, 11 Nov 2010 13:52:02 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101111125202.GB26340@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
Subject: [LTP] [PATCH] fix TMP versus TMPDIR in runtest files
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


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
There are a few places in runtest files that use $TMP instead of
$TMPDIR. Attached patch fixes that.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--PNTmBPCT7hxwcZjr
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="runtest_files.patch"

diff --git a/runtest/fs b/runtest/fs
index e6741a0..c47be1f 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -39,7 +39,7 @@ rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:$TMPDIR/rwte
 #iogen01 iogen -i 120s -s read,write 500b:doio.f1.$$ 1000b:doio.f2.$$ | doio -akv -n 2
 iogen01 export LTPROOT; rwtest -N iogen01 -i 120s -s read,write -Da -Dv -n 2 500b:$TMPDIR/doio.f1.$$ 1000b:$TMPDIR/doio.f2.$$
 
-fs_inod01 fs_inod $TMP 10 10 10
+fs_inod01 fs_inod $TMPDIR 10 10 10
 linker01 linktest.sh 1000 1000
 openfile01 openfile -f10 -t10
 inode01 inode01
diff --git a/runtest/ltplite b/runtest/ltplite
index 93285e5..516ba7c 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -104,14 +104,14 @@ chmod01A symlink01 -T chmod01
 chmod02 chmod02
 chmod03 chmod03
 chmod04 chmod04
-chmod05 cp -p $LTPROOT/testcases/bin/change_owner $TMP;chmod05 
-chmod06 cp -p $LTPROOT/testcases/bin/change_owner $TMP;chmod06
+chmod05 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;chmod05 
+chmod06 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;chmod06
 chmod07 chmod07
 
 chown01 chown01
 chown02 chown02
 chown03 export change_owner=$LTPROOT/testcases/bin/change_owner;chown03
-chown04 cp -p $LTPROOT/testcases/bin/change_owner $TMP;chown04
+chown04 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;chown04
 chown05 chown05
 
 chroot01 chroot01
@@ -182,13 +182,13 @@ fchmod01 fchmod01
 fchmod02 fchmod02
 fchmod03 fchmod03
 fchmod04 fchmod04
-fchmod05 cp -p $LTPROOT/testcases/bin/change_owner $TMP;fchmod05 
-fchmod06 cp -p $LTPROOT/testcases/bin/change_owner $TMP;fchmod06
+fchmod05 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;fchmod05 
+fchmod06 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;fchmod06
 fchmod07 fchmod07
 
 fchown01 fchown01
 fchown02 fchown02
-fchown03 cp -p $LTPROOT/testcases/bin/change_owner $TMP;fchown03
+fchown03 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;fchown03
 fchown04 export change_owner=$LTPROOT/testcases/bin/change_owner;fchown04
 fchown05 fchown05
 
@@ -605,7 +605,7 @@ readlink01A symlink01 -T readlink01
 readlink01 readlink01
 readlink02 readlink02
 readlink03 readlink03
-readlink04 cp -f $LTPROOT/testcases/bin/creat_slink $TMP; readlink04
+readlink04 cp -f $LTPROOT/testcases/bin/creat_slink $TMPDIR; readlink04
 
 readv01 readv01
 readv02 readv02
diff --git a/runtest/stress.part1 b/runtest/stress.part1
index 4225052..6d69abb 100644
--- a/runtest/stress.part1
+++ b/runtest/stress.part1
@@ -155,7 +155,7 @@ rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/tmp/rwtest0
 #iogen01 iogen -i 120s -s read,write 500b:doio.f1.$$ 1000b:doio.f2.$$ | doio -akv -n 2
 iogen01 export LTPROOT; rwtest -N iogen01 -i 120s -s read,write -Da -Dv -n 2 500b:doio.f1.$$ 1000b:doio.f2.$$
 
-fs_inod01 fs_inod $TMP 10 10 1
+fs_inod01 fs_inod $TMPDIR 10 10 1
 linker01 linktest.sh 1000 1000
 openfile01 openfile -f10 -t10
 inode01 inode01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 2e9564f..c2903f5 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -46,14 +46,14 @@ chmod01A symlink01 -T chmod01
 chmod02 chmod02
 chmod03 chmod03
 chmod04 chmod04
-chmod05 cp -p $LTPROOT/testcases/bin/change_owner $TMP;chmod05 
-chmod06 cp -p $LTPROOT/testcases/bin/change_owner $TMP;chmod06
+chmod05 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;chmod05 
+chmod06 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;chmod06
 chmod07 chmod07
 
 chown01 chown01
 chown02 chown02
 chown03 export change_owner=$LTPROOT/testcases/bin/change_owner;chown03
-chown04 cp -p $LTPROOT/testcases/bin/change_owner $TMP;chown04
+chown04 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;chown04
 chown05 chown05
 
 chroot01 chroot01
@@ -123,13 +123,13 @@ fchmod01 fchmod01
 fchmod02 fchmod02
 fchmod03 fchmod03
 fchmod04 fchmod04
-fchmod05 cp -p $LTPROOT/testcases/bin/change_owner $TMP;fchmod05 
-fchmod06 cp -p $LTPROOT/testcases/bin/change_owner $TMP;fchmod06
+fchmod05 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;fchmod05 
+fchmod06 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;fchmod06
 fchmod07 fchmod07
 
 fchown01 fchown01
 fchown02 fchown02
-fchown03 cp -p $LTPROOT/testcases/bin/change_owner $TMP;fchown03
+fchown03 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;fchown03
 fchown04 export change_owner=$LTPROOT/testcases/bin/change_owner;fchown04
 fchown05 fchown05
 
@@ -515,7 +515,7 @@ readlink01A symlink01 -T readlink01
 readlink01 readlink01
 readlink02 readlink02
 readlink03 readlink03
-readlink04 cp -f $LTPROOT/testcases/bin/creat_slink $TMP; readlink04
+readlink04 cp -f $LTPROOT/testcases/bin/creat_slink $TMPDIR; readlink04
 
 readv01 readv01
 readv02 readv02
diff --git a/runtest/syscalls b/runtest/syscalls
index 0ed2468..b2bf144 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -754,7 +754,7 @@ readlink01A symlink01 -T readlink01
 readlink01 readlink01
 readlink02 readlink02
 readlink03 readlink03
-readlink04 cp -f $LTPROOT/testcases/bin/creat_slink $TMP; readlink04
+readlink04 cp -f $LTPROOT/testcases/bin/creat_slink $TMPDIR; readlink04
 
 #readlinkat test cases
 readlinkat01 readlinkat01

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--PNTmBPCT7hxwcZjr--

