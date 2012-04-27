Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shyju.pv@huawei.com>) id 1SNfX3-0006jO-Kd
	for ltp-list@lists.sourceforge.net; Fri, 27 Apr 2012 07:23:57 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SNfX1-00014J-S6
	for ltp-list@lists.sourceforge.net; Fri, 27 Apr 2012 07:23:57 +0000
Received: from huawei.com (szxga05-in [172.24.2.49])
	by szxga05-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14
	(built Aug
	8 2006)) with ESMTP id <0M3400GCHN73QO@szxga05-in.huawei.com> for
	ltp-list@lists.sourceforge.net; Fri, 27 Apr 2012 15:23:27 +0800 (CST)
Received: from szxrg01-dlp.huawei.com ([172.24.2.119])
	by szxga05-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14
	(built Aug
	8 2006)) with ESMTP id <0M3400BSON6UG6@szxga05-in.huawei.com> for
	ltp-list@lists.sourceforge.net; Fri, 27 Apr 2012 15:23:27 +0800 (CST)
Date: Fri, 27 Apr 2012 12:53:18 +0530
From: Shyju PV <shyju.pv@huawei.com>
In-reply-to: <mailman.339101.1335467425.27891.ltp-list@lists.sourceforge.net>
Message-id: <67C56F0DB3A24924B4A9721F3AD50227@china.huawei.com>
MIME-version: 1.0
Subject: [LTP] Failure of get_robust_list01 test case in LTP for kernels
 3.4-c3 and 3.3.3
Reply-To: shyju.pv@huawei.com
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
Cc: 'Sanil kumar' <sanil.kumar@huawei.com>, 'Shubham Goyal' <shubgoya@in.ibm.com>, nagamani.mantha@huawei.com

Issue description:
------------------- 
Kernel Version : 3.4-rc3 
System call : get_robust_list 
LTP Testcase : get_robust_list01 
LTP Version : 20100401 
Platform : x86_64 ( ATCA Board ) 
Testcase Description : Verifies whether the get_robust_list() returns the 
proper errno for various failure cases 
Previous kernel version in which testcase passed : 3.2.9 

while Executing the syscall as given below 
if (seteuid(1) == -1) 
 tst_brkm(TBROK|TERRNO, cleanup, "seteuid(1) failed"); 
 TEST(retval = syscall(__NR_get_robust_list, 1,(struct robust_list_head
*)&head,&len_ptr)); 

The return value of the code is expected to be -1 but 0 is returned and 
hence the LTP test failed. 

A detailed analysis revealed below observations. 
The failure details? 
    The testcase tries to seteuid to a non-root user and tries to get the
futex 
list of init process. A failure(EPERM) is expected from the system call.
While 
in 3.2.9, the call behaved as per the expectation and failed,  in 3.4-rc3
the 
system call is successful causing the failure of the LTP test case. 

History of the problem: 
    The issue was first discussed in grsecurity forum 
(http://forums.grsecurity.net/viewtopic.php?t=2916&p=11579), quoting the
given 
LTP test. At that time test used to pass in vanilla kernel and used to fail
in 
grsecurity kernel. 
From the discussion: 
"It's correct that it (permission checking of grsecurity) doesn't match
exactly 
the vanilla permission check, but the vanilla check is broken in serious
ways." 
The thread died with the reporter saying that there are no real application 
which hits the scenario apart from the LTP test suite. 

    For vanilla 3.2.16, a patch was submitted (signed off by Kees Cook
<keescook@chromium.org>) 
making the permission check implementation of the system call same as that
of grsecurity 
(https://lkml.org/lkml/2012/3/19/717, title: futex: Do not leak robust list
to 
unprivileged process). Thomas Gleixner and Ingo Molnar was part of the 
discussion. It was decided to remove the system call in 2013 and was marked 
deprecated.  The patch 'changes the permission checks to be the same as
those 
used for similar info that comes out of /proc.' 

While initially the code was just checking for euid and uid check, 
the latest patch calls ptrace_may_access() bring in some extra checks as
well. 
Now, if the user has access to the /proc of the process, it has 
access to the futext list, else not. 

ptrace_may_access() which is the additional new check: 

    int dumpable = 0; 
    /* Don't let security modules deny introspection */ 
    if (task == current) 
        return 0; 
    rcu_read_lock(); 
    tcred = __task_cred(task); 
    if (cred->user->user_ns == tcred->user->user_ns && 
        (cred->uid == tcred->euid && 
         cred->uid == tcred->suid && 
         cred->uid == tcred->uid  && 
         cred->gid == tcred->egid && 
         cred->gid == tcred->sgid && 
         cred->gid == tcred->gid)) 
        goto ok; 
    if (ns_capable(tcred->user->user_ns, CAP_SYS_PTRACE)) 
        goto ok; 
    rcu_read_unlock(); 
    return -EPERM; 
ok: 
    rcu_read_unlock(); 
    smp_rmb(); 
    if (task->mm) 
        dumpable = get_dumpable(task->mm); 
    if (!dumpable && !task_ns_capable(task, CAP_SYS_PTRACE)) 
        return -EPERM; 

    return security_ptrace_access_check(task, mode); 
    
Looking at the history and the changes that is introduced by the patch,
shall we remove the test case 
from LTP which fails on the latest open source kernels.

Shyju 


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
