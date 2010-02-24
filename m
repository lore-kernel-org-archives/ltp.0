Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rdunlap@xenotime.net>) id 1NkNJi-0006JX-N9
	for ltp-list@lists.sourceforge.net; Wed, 24 Feb 2010 19:54:42 +0000
Received: from xenotime.net ([72.52.64.118])
	by sfi-mx-2.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NkNJh-0005ow-Bs
	for ltp-list@lists.sourceforge.net; Wed, 24 Feb 2010 19:54:42 +0000
Received: from chimera.site ([71.245.98.113]) by xenotime.net for
	<ltp-list@lists.sourceforge.net>; Wed, 24 Feb 2010 11:54:15 -0800
Date: Wed, 24 Feb 2010 11:54:15 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
Message-Id: <20100224115415.77cffc1e.rdunlap@xenotime.net>
Mime-Version: 1.0
Subject: [LTP] [patch] clean up docs and scripts
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

From: Randy Dunlap <randy.dunlap@oracle.com>

Clean up some typos.
Update LTP maintainer name/email address.
Replace runalltests.sh with runltp in a few places.
Don't use quotation marks in here-documents in shell script.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 INSTALL               |   10 +++++-----
 README                |    2 +-
 doc/ltp-run-files.txt |    4 ++--
 runltp                |    8 ++++----
 4 files changed, 12 insertions(+), 12 deletions(-)

--- ltp-full-20100131.1.orig/doc/ltp-run-files.txt
+++ ltp-full-20100131.1/doc/ltp-run-files.txt
@@ -1,5 +1,5 @@
 List of scripts or executables that need to be run for complete LTP execution. 
-The tests listed are NOT executed with the runalltest.sh script
+The tests listed are NOT executed with the runalltests.sh script
 
 runalltests.sh
  - syscalls  (except epoll, see below)
@@ -23,7 +23,7 @@ To test filesystem with LVM 
 w/o LVM
 - ltpfsnolvm.sh
 
-Deveice Mapper tests
+Device Mapper tests
  - ltpdmmapper.sh
 
 Network tests
--- ltp-full-20100131.1.orig/INSTALL
+++ ltp-full-20100131.1/INSTALL
@@ -97,7 +97,7 @@ objects, generated files) outside of the
 reside. This is typically used when cross-compiling for multiple targets.
 
 NOTE: This is by and large correctly implemented, but there are several corner
-case, where this isn't implemented properly. Please see TODO for a list of items
+cases, where this isn't implemented properly. Please see TODO for a list of items
 which need fixing in the LTP tree.
 
 	$ mkdir "$OUT_OF_BUILD_TREE_DIR"
@@ -129,12 +129,12 @@ Quick Start
 4> make all
 5> make install
 6> cd /opt/ltp
-7> ./runalltests.sh
+7> ./runltp
 
 *NOTE:
 - LTP assumes the existence of the nobody, bin, and daemon users and their
 groups.  If these IDs do not exist, certain tests will fail. The users and
-groups IDs should be the same, i.e. if user "nobody" is 99, then it's group
+groups IDs should be the same, i.e. if user "nobody" is 99, then its group
 should also be "99". The names of the groups are irrelevant.
 - The installation directory is /opt/ltp by default. Please see "Using autoconf" above and specify the appropriate path via --prefix. DESTDIR= is also honored for install and will install into $DESTDIR/$prefix, if you want to install into a chroot or a rootfs for instance.
 
@@ -159,11 +159,11 @@ contributions are welcome.
    requirements above before doing so.
 
 4. You can run all of the tests sequentially using the example test script
-   runalltests.sh.  The script is provided to get you started.
+   runltp.  The script is provided to get you started.
    See ltp-pan(1) for more information on the test driver we have provided.
    It is simple, but it can do a lot of stuff.
 
-   NOTE: The diskio and network tests will NOT be run by the runalltests.sh
+   NOTE: The diskio and network tests will NOT be run by the runltp
    script. They are separate from the other tests because of the additional
    required setup overhead.
 
--- ltp-full-20100131.1.orig/README
+++ ltp-full-20100131.1/README
@@ -1,5 +1,5 @@
 Linux Test Project
-(Maintained by: Subrata Modak<subrata@linux.vnet.ibm.com>)
+(Maintained by: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>)
 
 The latest image is always available at http://ltp.sf.net
 
--- ltp-full-20100131.1.orig/runltp
+++ ltp-full-20100131.1/runltp
@@ -403,7 +403,7 @@ main()
             WARNING: The use of -x can cause unpredictable failures, as a
                      result of concurrently running multiple tests designed
                      to be ran exclusively.
-                     Pausing for 10 seconds..."
+                     Pausing for 10 seconds...
 	EOF
             sleep 10 
             INSTANCES="-x $OPTARG";;
@@ -935,11 +935,11 @@ main()
     {
     cat <<-EOF >&1
         
-       ###############################################################"
+       ###############################################################
         
-            Done executing testcases."
+            Done executing testcases.
             LTP Version:  $version_date
-       ###############################################################"
+       ###############################################################
        
 	EOF
     }

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
