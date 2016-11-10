From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 10 Nov 2016 09:22:58 +0100
Subject: [LTP] [PATCH 2/3] doc: replace ltp.cvs.sourceforge.net links by path
In-Reply-To: <20161110082259.32348-1-pvorel@suse.cz>
References: <20161110082259.32348-1-pvorel@suse.cz>
Message-ID: <20161110082259.32348-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ remove outdated links and minor cleanup.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runalltests.sh                   | 17 ++++++++---------
 testcases/kernel/fs/fs_bind/TODO |  2 --
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/runalltests.sh b/runalltests.sh
index 20086b6..6e48c38 100755
--- a/runalltests.sh
+++ b/runalltests.sh
@@ -70,24 +70,22 @@ export LIBATTR_INSTALLED=0
 
 ## Set this to 1 if you wish to execute the stress_cd tests
 ## Make sure you have FLOPPY inserted, be warned that you
-## will loose all data on it after the tests,
+## will loose all data on it after the tests.
 export RUN_STRESS_FLOPPY=0
 
 ## Set this to 1 if you wish to execute the stress_floppy tests
-## Make sure you have CD inserted in your CD-ROM drive,
+## Make sure you have CD inserted in your CD-ROM drive.
 export RUN_STRESS_CD=0
 
-##Set this to 1 if you wish to run the CPUHOTPLUG tests
+## Set this to 1 if you wish to run the CPUHOTPLUG tests
 export RUN_CPU_HOTPLUG=0
 
 ##Set this to 1 if you wish to run the LTP-NETWORK tests. Please refer to:
-## http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/network/LTP-Network-test_README.pdf
-## for more information on how to run the tests.
+## testcases/network/README.md for more information on how to run the tests.
 export RUN_LTP_NETWORK_TESTS=0
 
-##Set this to 1 if you wish to run the LTP-NETWORK-STRESS tests. Please refer to:
-## http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/network/LTP-Network-test_README.pdf
-## and http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/network/stress/README
+## Set this to 1 if you wish to run the LTP-NETWORK-STRESS tests. Please refer to:
+## testcases/network/README.md and testcases/network/stress/README
 ## for more information on how to run the NETWORK-STRESS tests.
 export RUN_LTP_NETWORK_STRESS_TESTS=0
 
@@ -113,7 +111,8 @@ export NFS_SERVER_DISK_PARTITION1=yyy
 export NFS_SERVER_FS_TYPE1=zzz
 
 
-## Set this to 1 if you wish to run the FS tests on READ ONLY File Systems. Refer to http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testscripts/Readme_ROBind for more info
+## Set this to 1 if you wish to run the FS tests on READ ONLY File Systems.
+## Refer to testscripts/Readme_ROBind for more info.
 export RUN_RO_ONLY_FS_TESTS=0
 export READ_ONLY_DIRECTORY1=xxxx
 
diff --git a/testcases/kernel/fs/fs_bind/TODO b/testcases/kernel/fs/fs_bind/TODO
index 567a33a..1730148 100644
--- a/testcases/kernel/fs/fs_bind/TODO
+++ b/testcases/kernel/fs/fs_bind/TODO
@@ -1,5 +1,3 @@
-Reuse http://ltp.cvs.sourceforge.net/*checkout*/ltp/ltp/testcases/kernel/containers/check_for_unshare.c to test for unshare (used in nsclone.c) ??
-
 Consider replacing long invocations
 	(replace "$FS_BIND_ROOT/bin/makedir") with something shorter).
 
-- 
2.10.2

