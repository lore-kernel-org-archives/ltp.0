Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NjT0y-00035O-O3
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 07:47:36 +0000
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NjT0w-0005hb-73
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 07:47:36 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id o1M7lHYw007590
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Feb 2010 18:47:17 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1M7fout1617998
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Feb 2010 18:41:51 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1M7lGxs016629
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Feb 2010 18:47:16 +1100
Message-ID: <4B823681.7010300@linux.vnet.ibm.com>
Date: Mon, 22 Feb 2010 13:17:13 +0530
From: Rishikesh <risrajak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060708050303050005010303"
Subject: [LTP] [ANNOUNCEMENT]: Intermediate release for FEB'10
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
To: LTP <ltp-list@lists.sourceforge.net>
Cc: risrajak@in.ibm.com, iranna.ankad@in.ibm.com, svishuku@in.ibm.com

This is a multi-part message in MIME format.
--------------060708050303050005010303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

Welcome to ltp community.

The February 2010 Intermediate release is out now. This build contains
many fixes. Changelog you can find as attached.

You can directly download from:
https://sourceforge.net/projects/ltp/files/LTP%20Source/ltp-20100228/ltp-intermediate-20100228.tgz/download

And for more details you can just have a look to ltp Home Page: 
http://ltp.sourceforge.net/

-- 
Thanks&  Regards
Rishi Kesh K Rajak
IBM LTC, Bangalore
LTP Maintainer
Please join IRC: #ltp @ freenode.net


--------------060708050303050005010303
Content-Type: text/plain;
 name="ChangeLog.new"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ChangeLog.new"


commit a6ff3058e577983a1052b333adfb3038a3c6f53e
Author: Garrett Cooper <yanegomi@gmail.com>
Date:   Sun Feb 21 19:23:10 2010 -0800

    Update the install-in-build-tree script.
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

commit c2c8d7f6d8d77f9755a919bf8fdd858ba4c9fbdb
Author: root <root@orangebox.(none)>
Date:   Sun Feb 21 18:12:18 2010 -0800

    Detecting potential fork errors in the test.
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

commit 0ebb1487d747f128c9f63c5ae0121d387ada87bc
Author: Garrett Cooper <yanegomi@gmail.com>
Date:   Sun Feb 21 08:14:18 2010 -0800

    Update README as per recent changes to build / test scripts.
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

commit 0a383ab2d22d7ba20128429592ec31be055a5aa9
Author: Garrett Cooper <yanegomi@gmail.com>
Date:   Sun Feb 21 08:11:52 2010 -0800

    1. Fix a bug in the git pull method (wasn't setting srcdir).
    2. Set safe_rm when ltp is pulled so we can opt out of using srcdir
    with install-in-build-tree s.t. we can _truly_ test
    install-in-build-tree.
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

commit e520c3189f54b690d057ccdae29167d33771584c
Author: Garrett Cooper <yanegomi@gmail.com>
Date:   Sun Feb 21 08:10:03 2010 -0800

    Switch all of these Makefiles over to MAKE_DEPS instead of ad hoc
    trunk-all // incorrectly specified all: | type dependencies.
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

commit 225c2e31425d5f4b8f67bc69c309fe70dfe8fcf1
Author: Garrett Cooper <yanegomi@gmail.com>
Date:   Sat Feb 20 22:51:42 2010 -0800

    Add the library to MAKE_DEPS so it gets built prior to the other goals
    in this directory.
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

commit 02f8fe875ea4f13caf3452b9a60f4b4db49e45df
Author: root <root@orangebox.(none)>
Date:   Fri Feb 19 09:42:56 2010 -0800

    Hi,
    
    Scripts under LTPROOT/testscripts/ need to access ltp-pan from some
    other loaction now. Moreover there are scripts to run MATH and SYSCALL
    tests which are not required as they can be directly run through
    ./runltp -f <math/runltp>
    This patch fixes them. Probably the scripts need to be looked on
    more to fix such anomalies.
    
    Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>

commit 031c65bd3f6172d5cc80df0b577c025a139b3577
Author: root <root@orangebox.(none)>
Date:   Fri Feb 19 09:38:36 2010 -0800

    Hi,
    
    I have tried to execute the 'io_floppy' test in  LTP Version:  LTP-20100131.1
    
    maxin@maxin-laptop:/opt/ltp$ ./runltp -f io_floppy
    
    This test failed since the 'stress_floppy' script was not installed properly.
    Please find the below given log:
    -----------------------------------------------------------
    ....
    Running tests.......
    <<<test_start>>>
    tag=stress_floppy stime=1266516562
    cmdline="export TCdat=$LTPROOT/testcases/kernel/io/stress_floppy; stress_floppy"
    contacts=""
    analysis=exit
    <<<test_output>>>
    sh: stress_floppy: not found
    incrementing stop
    <<<execution_status>>>
    initiation_status="ok"
    duration=0 termination_type=exited termination_id=127 corefile=no
    cutime=0 cstime=0
    <<<test_end>>>
    INFO: ltp-pan reported some tests FAIL
    LTP Version: LTP-20100131.1
    
          ###############################################################"
    
               Done executing testcases."
               LTP Version:  LTP-20100131.1
          ###############################################################"
    -----------------------------------------------------------
    
    Attached patch(stress_floppy_Makefile.patch) fixes Makefile and the
    'stress_floppy' script gets installed properly.
    
    -----------------------------------------------------------
    Running tests.......
    <<<test_start>>>
    tag=stress_floppy stime=1266518427
    cmdline="export TCdat=$LTPROOT/testcases/kernel/io/stress_floppy; stress_floppy"
    contacts=""
    analysis=exit
    <<<test_output>>>
    incrementing stop
    Testing format...
    /dev/fd0: No such file or directory
    Format failed!
    <<<execution_status>>>
    initiation_status="ok"
    duration=0 termination_type=exited termination_id=1 corefile=no
    cutime=0 cstime=0
    <<<test_end>>>
    INFO: ltp-pan reported some tests FAIL
    LTP Version: LTP-20100131.1
    -----------------------------------------------------------
    
    Well, after applying this patch, the 'io_floppy' test fails successfully :)
    (Expected failure as I don't have a floppy drive)
    
    Signed-off-by: Maxin B. John <maxin.john@gmail.com>

commit ad99f1087d63aae7563534c0b6f66461671050cb
Author: root <root@orangebox.(none)>
Date:   Fri Feb 19 01:24:05 2010 -0800

    Work on the previous buffer overflow problem a bit more; ftest0[38]
    still fail from time to time, oddly enough even though I can't exactly
    pinpoint the root cause.
    
    Clean some of the format strings up though while I'm here...
    
    Signed-off-by: root <root@orangebox.(none)>

commit d639eef7e81a3c8768b13b471647deee41c8ff48
Author: Garrett Cooper <yanegomi@gmail.com>
Date:   Thu Feb 18 23:47:44 2010 -0800

    Fix a typo; improve some sentence wording.
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

commit 2aa40f7e10518977881b933cc93b8f50847cf3cf
Author: Garrett Cooper <yanegomi@gmail.com>
Date:   Thu Feb 18 23:43:02 2010 -0800

    Avoid sudo blocking for tty input indefinitely; this issue will need to
    be `properly' fixed by not having a password for the sudo'er's acct.
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

commit e03cee01ad68f7b8449a6eb091f7f739c3013e21
Author: Garrett Cooper <yanegomi@gmail.com>
Date:   Thu Feb 18 22:23:31 2010 -0800

    Fix a cosmetic bug where Version wasn't being generated for
    install-in-build-tree scenarios.
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

commit 3fceccbde835affc869f91cbc60c7a91fa0add0b
Author: Garrett Cooper <yanegomi@gmail.com>
Date:   Thu Feb 18 21:43:51 2010 -0800

    Merge the remote changes, again?? git's really complicated...
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

commit 1ca6b265f9af0ffdbeee03411c38489899723fc1
Author: Garrett Cooper <yanegomi@gmail.com>
Date:   Thu Feb 18 21:43:07 2010 -0800

    Merge the remote changes (!)
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

commit 4c2f39a8aaf619086a73efc1819be4dd5a0c2822
Merge: 103b262 77ed5b4
Author: Garrett Cooper <yanegomi@gmail.com>
Date:   Thu Feb 18 21:41:48 2010 -0800

    Merge branch 'master' of ssh://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev

commit 103b26251758c4582af5ebf6a9b8774832be643a
Author: Garrett Cooper <yanegomi@gmail.com>
Date:   Thu Feb 18 21:27:53 2010 -0800

    Clean up the TODO.
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

commit 09cbd9c271a3a74ccf7bd3401f6bb528c3c7d119
Author: Garrett Cooper <yanegomi@gmail.com>
Date:   Thu Feb 18 21:24:03 2010 -0800

    1. Correct compile time warnings by defining the timeout to 0 sec, 0
    nsec, instead of NULL.
    2. Make sure that the syscall errno applies to the entire test, not just
    the portion that Jiri noted the error with.
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

commit a2a0763133d7d8d2464b2018b6bf287a03847592
Author: gcooper <gcooper@orangebox.(none)>
Date:   Thu Feb 18 21:11:40 2010 -0800

    Update the build_functions script to add clean sanity support, git pull
    support, and also do some minor refactoring in terms of how some
    variables are set as well as when they're set.
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

commit 53786432b7db7d066563c42e0d87df755dbbf321
Author: gcooper <gcooper@orangebox.(none)>
Date:   Wed Feb 17 09:32:01 2010 -0800

    acl_test01 today...
    1. Should use $TMP.
    2. Should use tst_resm today.
    3. Should exit 0 on setup failure.
    4. Doesn't cleanup in the event of a test failure.
    5. Has a hardcoded loopback device instead of looking for the next
    available one via losetup -f.
    6. Other stylistic nits:
        a. [ $? != 0 ] -> [ $? -ne 0 ]
        b. Incorrect whitespace conventions / indentation issues.
        c. Etc...
    
    This test will need to be enhanced [still] to support non-ext2 //
    -ext3 filesystems (my kernel only supports ext4 fs's for instance...).
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

commit 77ed5b4eb6a65b90b38defd8aa981e8e9f04b5d9
Merge: 77312d8 98f3812
Author: Rishikesh K Rajak <rishikesh@rishikesh.in.ibm.com>
Date:   Wed Feb 17 18:57:58 2010 +0530

    Merge branch 'test'

commit 98f38120c682e64818e0a13abe62ffab94910e8d
Author: Rishikesh K Rajak <rishikesh@rishikesh.in.ibm.com>
Date:   Wed Feb 17 18:57:23 2010 +0530

     I've seen failures reporting "return value=0, errno=EACCESS" in the
    mq_notify01 test. This is because the syscall actually succeeded (as
    expected by the test), but, as it is implemented by a library
    function, some of the (more) syscalls it invoked failed. The POSIX
    specification of errno says it should only be read when the call in
    question failed - therefore, this patch hardcodes errno 0 when return
    value is 0.
    
     Also, this patch removes a useless TEST macro usage in a place the
    TEST_RETURN nor TEST_ERRNO variables are never checked.
    
    Regards
        Jiri Palecek
    
    Signed-off-by: Jiri Palecek <jpalecek@web.de>

commit 77312d8f35ad3c516636bce1401c78ac09e08a5f
Author: Rishikesh K Rajak <rishikesh@rishikesh.in.ibm.com>
Date:   Wed Feb 17 18:45:56 2010 +0530

    In the previous mailx version, the command "echo "d" | mail -u root" will
    output like the following.
    -----------------------------
    Mail version 8.1 6/6/93.  Type ? for help.
    "/var/mail/root": 1 message 1 new
    >N  1 MAILER-DAEMON@localh  Mon Jan 25 09:11  63/2367  "Returned mail: see tr"
    -----------------------------
    
    Buy in Heirloom Mail, the command will output.
    -----------------------------
    Heirloom Mail version 12.4 7/29/08.  Type ? for help.
    "/var/mail/root": 1 message 1 new
    >N  1 Mail Delivery Subsys  Mon Jan 25 14:16  67/2195  "Returned mail: see tr"
    -----------------------------
    
    "MAILER-DAEMON@localh" is been changed to "Mail Delivery Subsys".
    We should make mail_tests.sh to supporting Heirloom Mail.
    
    Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>

commit d4eb64c5715c44479ce90abd9292019dfe8377e3
Author: Rishikesh K Rajak <rishikesh@rishikesh.in.ibm.com>
Date:   Mon Feb 15 19:30:34 2010 +0530

    Deleted the scratch dir for testing

commit 6feffd8c46093216f795597c7d12739504583f64
Author: Rishikesh K Rajak <rishikesh@rishikesh.in.ibm.com>
Date:   Mon Feb 15 19:20:14 2010 +0530

    Testing with different branch and merging with main

commit e0984c4239b07eb6d83b2445d3d77b53576a5889
Author: Rishikesh K Rajak <rishikesh@rishikesh.in.ibm.com>
Date:   Mon Feb 15 19:17:35 2010 +0530

    Testing with different branch

commit dd04033034f9e550029178f9d85c95f411ef1009
Author: gcooper <gcooper@orangebox.(none)>
Date:   Sun Feb 14 23:16:22 2010 -0800

    Correct at least one of these lousy diagnostic messages for not finding
    nobody in /etc/passwd...
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

commit 8686ad72fbe76a7de8fe8e93ef68a71fff8a049d
Author: gcooper <gcooper@orangebox.(none)>
Date:   Sun Feb 14 23:12:10 2010 -0800

    Correctly consolidate tst_exit() calls in cleanup() as noted by
    Mitani-san.
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

commit 4086783fafe6afd70a6d647ae8bf5ded0548be79
Author: Rishikesh K Rajak <rishikesh@rishikesh.in.ibm.com>
Date:   Mon Feb 15 12:08:23 2010 +0530

    Added one TODO for conversion of CVS to GIT

commit f4f57997f7809f1c85a1d124ba277e7f3a510d08
Author: Rishikesh K Rajak <rishikesh@rishikesh.in.ibm.com>
Date:   Sun Feb 14 22:41:20 2010 +0530

    Testing for push to ltp.sf.net

commit 186613249384740cfd5c8346c1b6659613c6a2a6
Author: yaberauneya <yaberauneya>
Date:   Fri Feb 12 09:15:37 2010 +0000

    *** empty log message ***

commit dfac29ccbb03db3e4ee3fa5674cbbbf0104b08aa
Author: yaberauneya <yaberauneya>
Date:   Fri Feb 12 09:02:50 2010 +0000

    Remove test file.

commit 2279bf46ad12b3e75c512e9f146bc60a49220444
Author: yaberauneya <yaberauneya>
Date:   Fri Feb 12 09:02:34 2010 +0000

    Test.

commit 98379aa37cbc3dd8ac41ee6628b5033743f47165
Author: yaberauneya <yaberauneya>
Date:   Wed Feb 10 23:24:45 2010 +0000

    1. Simplify smoke test further by only checking to see whether or not the syscall works as opposed to checking the kernel version because people can backport support as seen fit and shouldn't be hindered by a stupid kernel version check...
    2. Correct compile because I originally checked in the change on a box without a proper toolchain and thus couldn't build before now.
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

commit eea384d34e99680de3ba09f6fe6916ecc1d960b0
Author: yaberauneya <yaberauneya>
Date:   Wed Feb 10 23:12:53 2010 +0000

    Not everyone has unshare capability... thanks for the reminder Mitani-san...
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

commit 903f68fcdcf31ee426190ac72adb9eaa293baaeb
Author: yaberauneya <yaberauneya>
Date:   Wed Feb 10 23:04:09 2010 +0000

    Fixed typo found by Mitani-san.
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

commit a962b7f8f0fae7b34edcc1b7619944e1137cd057
Author: yaberauneya <yaberauneya>
Date:   Wed Feb 10 01:28:25 2010 +0000

    Adding runtest entries for rt_sigaction0[23], as noted by Mitani-san, and forgotten by your's truly...
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

commit 7a0b567320b80b2cb361c9481549508ea772d73f
Author: yaberauneya <yaberauneya>
Date:   Tue Feb 9 14:49:02 2010 +0000

    An error occured on my i386 box.
    (OS: Fedora8, Kernel: 2.6.33-rc6, libcap: libcap-2.16)
    -------------
    exec_without_inh    1  TFAIL  :  Failed to drop CAP_SYS_ADMIN from bounding set.
    exec_without_inh    0  TINFO  :  (ret=-1, errno 38)
    -------------
    If the macro HAVE_DECL_CAP_BSET_DROP is 0, this error will occurs.
    But the program should to be broken when f != CAP_SET, like the similar code
    "if (ret || f != CAP_SET) {" in exec_with_inh.c.
    
    The TBROK message will be outputted if my patch merged.
    -------------
    exec_without_inh    1  TBROK  :  Failed to add CAP_SYS_ADMIN to pI
    -------------
    
    Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
    ---

commit 4f16ee0005cce6fc23727e39e1762c1e1f5a1285
Author: yaberauneya <yaberauneya>
Date:   Tue Feb 9 14:45:29 2010 +0000

    1. Remove mqns check app check. It no longer exists in the repo and thus gates these tests unnecessarily from being run..
    2. Compile the netns check app.
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>


--------------060708050303050005010303
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--------------060708050303050005010303
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------060708050303050005010303--

