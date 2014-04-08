Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WXaeO-0006Ix-6g
	for ltp-list@lists.sourceforge.net; Tue, 08 Apr 2014 18:21:36 +0000
Date: Tue, 8 Apr 2014 20:20:52 +0200
From: chrubis@suse.cz
Message-ID: <20140408182052.GA5854@rei>
References: <1395311334-22330-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395311334-22330-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3] testscripts/test_robind.sh: cleanup and make
 some fixes
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Remove useless comments and abandon the operation which creates
> a 500MB image-file. If user wants to run these tests, a big block
> device should be specified by running runltp with -z option.
> 
> And we split tests in testscripts/fs_ro_tests into separate testcases,
> keep one entry per test in runtest/fs_readonly
> 
> Using the interface provided by the shell library test.sh.
> 
> Delete fs_ro_tests, which is not used now.

I've fixed the script to be POSIX shell compatible (see diff below) and added a
followup patch to move the test_robind.sh script to
testcases/kernel/fs/fs_readonly because the runtest file does not work when
it's in  testscripts directory which is not in $PATH.

Pushed, thanks.

 . test.sh
 
-function usage()
+usage()
 {
        cat << EOF
        usage: $0 -c command [ext3,ext2,jfs,xfs,reiserfs,ramfs]
@@ -67,7 +67,7 @@ EOF
        exit 1
 }
 
-function umount_mntpoint
+umount_mntpoint()
 {
        if [ $dir3_ro_mount_flag -eq 1 ];then
                umount dir3-ro
@@ -97,26 +97,26 @@ function umount_mntpoint
        fi
 }
 
-function cleanup
+cleanup()
 {
        umount_mntpoint
        tst_rmdir
 }
-TST_CLEANUP=cleanup
 
 # parameters: file_systems (if any )
-function setup
+setup()
 {
        tst_require_root
 
-       tst_tmpdir
-
        if [ -z "$LTP_BIG_DEV" ];then
                tst_brkm TCONF "tests need a big block device(>=500MB)"
        else
                device=$LTP_BIG_DEV
        fi
 
+       tst_tmpdir
+       TST_CLEANUP=cleanup
+
        for dir in $DIRS
        do
                rm -rf $dir

 # Executes the tests for differnt FS's
 for fstype in $FSTYPES; do
        opts="-F"
-       if [ "$fstype" == "reiserfs" ]; then
+       if [ "$fstype" = "reiserfs" ]; then
                opts="-f --journal-size 513 -q"
-       elif [ "$fstype" == "jfs" ]; then
+       elif [ "$fstype" = "jfs" ]; then
                opts="-f"
-       elif [ "$fstype" == "xfs" ]; then
+       elif [ "$fstype" = "xfs" ]; then
                opts=""
        fi



-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
