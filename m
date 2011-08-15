Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lgliang@taco.beaverton.ibm.com>) id 1Qt2hf-0008BL-RV
	for ltp-list@lists.sourceforge.net; Mon, 15 Aug 2011 19:20:03 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qt2hf-0004qs-2s
	for ltp-list@lists.sourceforge.net; Mon, 15 Aug 2011 19:20:03 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p7FIYAOe016925
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Aug 2011 14:34:10 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7FIv9gj170770
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Aug 2011 14:57:09 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p7FCug4d017184
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Aug 2011 06:56:42 -0600
From: Lucy Liang <lgliang@linux.vnet.ibm.com>
Date: Mon, 15 Aug 2011 11:56:28 -0700
Message-Id: <1313434593-7942-2-git-send-email-lgliang@linux.vnet.ibm.com>
In-Reply-To: <1313434593-7942-1-git-send-email-lgliang@linux.vnet.ibm.com>
References: <1313434593-7942-1-git-send-email-lgliang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.4.1"
Subject: [LTP] [PATCH 2/7 ver2 w/attachment] Updated pounder's configuration
	files
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

This is a multi-part message in MIME format.
--------------1.7.4.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Updated libpounder.sh file to reflect changes in the new pounder
version. Added a config file containing user-modifiable environment
variables along with detailed descriptions of what each does.

Signed-off-by: Lucy Liang <lgliang@linux.vnet.ibm.com>
---
 tools/pounder21/config        |   42 +++++++++++++++++++++++++++++++++++++++++
 tools/pounder21/libpounder.sh |    5 +--
 2 files changed, 44 insertions(+), 3 deletions(-)
 create mode 100644 tools/pounder21/config


--------------1.7.4.1
Content-Type: text/x-patch;
	name="0002-Updated-pounder-s-configuration-files.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0002-Updated-pounder-s-configuration-files.patch"

diff --git a/tools/pounder21/config b/tools/pounder21/config
new file mode 100644
index 0000000..69c15dc
--- /dev/null
+++ b/tools/pounder21/config
@@ -0,0 +1,42 @@
+#Set the following variables as needed
+
+export DURATION=0			#Time in seconds for pounder to run. Setting this variable
+					#to 0 will not put an upper bound on pounder run time.
+
+export MAX_FAILURES=5			#Maximum number of test failures allowed for each subtest
+					#before aborting. Setting this variable to 0 will not put
+					#an upper bound on any subtest failures.
+
+export NFS_LOGGING=0			#1 to enable NFS logging of pounder output, pounder will
+					#log output to remote directory on NFS server  specified
+					#by $NFS_LOGDIR and  $NFS_LOGSERVER (see below), which
+					#will be mounted on $POUNDER_LOGLOCAL (see libpounder.sh).
+					#0 to disable this feature, all output for pounder runs
+					#will be stored locally directly in $POUNDER_LOGLOCAL instead.
+
+export NFS_LOGSERVER=0			#IP address of the NFS server to use for logging pounder results.
+					#NFS_LOGGING should be enabled to use this feature.
+
+export NFS_LOGDIR=/path/to/log		#path to the log directory on $NFS_LOGSERVER; If $NFS_LOGGING
+					#is enabled, pounder will attempt to mount $NFS_LOGSERVER:$NFS_LOGDIR/
+					#on $POUNDER_LOGLOCAL (see libpounder.sh).
+
+export POUNDER_CACHE=0  		#address of the cache to use for fetching outside packages,
+                        		#The cache is a user-created web-accessible directory
+                        		#containing cached tarballs/scripts/etc. used for
+                        		#the various tests you intend to build. This is optional
+                        		#but useful for saving download time.
+
+#These variables below are used by specific subtests contained in the provided default test scheduler,
+#but they can be incorporated into user-defined subtests as well.
+
+export DO_X_TESTS=0			#0 disables X system testing, 1 enables X system testing.
+					#Used by the xterm_stress subtest.
+
+export NFS_SERVER=0			#IP address of the NFS server to use for nfs and ping_nfs
+					#subtests. Setting this variable to 0 disables nfs testing.
+
+export NTP_SERVER=pool.ntp.org		#Or use another NTP server of your choice.
+					#Used by the time_drift subtest.
+
+#Feel free to add more variables as you see fit.
diff --git a/tools/pounder21/libpounder.sh b/tools/pounder21/libpounder.sh
index 72a0dd6..5444239 100644
--- a/tools/pounder21/libpounder.sh
+++ b/tools/pounder21/libpounder.sh
@@ -25,13 +25,12 @@ export TESTS=`/bin/ls test_scripts/`
 export BUILDS=`/bin/ls build_scripts/`
 export POUNDER_HOME=`pwd`
 export POUNDER_PIDFILE="$POUNDER_HOME/pounder.pid"
-export POUNDER_LOGLOCAL="$POUNDER_HOME/log/"
+export POUNDER_LOGLOCAL="$POUNDER_HOME/log"
 export POUNDER_LOGDIR="$POUNDER_LOGLOCAL/$DATE/"
 export POUNDER_TMPDIR="$POUNDER_HOME/tmp/"
 export POUNDER_OPTDIR="$POUNDER_HOME/opt/"
 export POUNDER_SRCDIR="$POUNDER_HOME/src/"
-export POUNDER_CFGDIR="$POUNDER_HOME/config/"
-export POUNDER_VERSION=`head -1 "$POUNDER_HOME/README" | awk -F " " '{print $6}' | sed -e 's/\.//g'`
+export POUNDER_VERSION=`head -1 "$POUNDER_HOME/README" | awk -F " " '{print $3}' | sed -e 's/\.//g'`
 export NR_CPUS=`getconf _NPROCESSORS_ONLN`
 export NFS_LOGLOCAL="`echo "$HOSTNAME" | sed -e 's/\..*//g'`/`uname -r`-`uname -m`"
 

--------------1.7.4.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev

--------------1.7.4.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.4.1--



