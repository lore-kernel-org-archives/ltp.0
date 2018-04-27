From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 27 Apr 2018 08:35:12 +0800
Subject: [LTP] [PATCH] commands: Remove all test cases
In-Reply-To: <20180426172713.GB14157@x230>
References: <20180426132418.19495-1-schlad@suse.de>
 <20180426132418.19495-2-schlad@suse.de>
 <b72b277b-e8e0-d69c-b918-bd48341c2a1d@oracle.com>
 <20180426172713.GB14157@x230>
Message-ID: <5AE27040.508@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/04/27 1:27, Petr Vorel wrote:
> Hi,
>
>> On 04/26/2018 04:24 PM, Sebastian Chlad wrote:
>>> Test cases testing commands are often outdated or not maintained.
>>> Those test cases also do not fit in with current LTP project status.
>>> Signed-off-by: Sebastian Chlad<schlad@suse.de>
> ...
>
>>> diff --git a/testcases/commands/keyctl/keyctl01.sh b/testcases/commands/keyctl/keyctl01.sh
>>> deleted file mode 100644
>>> index 3fda3893b..000000000
>>> --- a/testcases/commands/keyctl/keyctl01.sh
> ...
>>> -# This is a regression test about potential uninitialized variable,
>>> -# the test can crash the buggy kernel, and the bug has been fixed in:
>>> -#
>>> -#   commit 38327424b40bcebe2de92d07312c89360ac9229a
>>> -#   Author: Dan Carpenter<dan.carpenter@oracle.com>
>>> -#   Date:   Thu Jun 16 15:48:57 2016 +0100
>>> -#
>>> -#   KEYS: potential uninitialized variable
>>> -#
> ...
>
>>> --- a/testcases/commands/sysctl/sysctl01.sh
> ...
>>> -# Description:
>>> -# This is a regression test for invalid value of sysctl_sched_time_avg.
>>> -# System will hang if user set sysctl_sched_time_avg to 0 on buggy kernel.
>>> -#
>>> -# The kernel bug has been fixed in kernel:
>>> -# '5ccba44ba118("sched/sysctl: Check user input value of sysctl_sched_time_avg")'
>>> -
>> And those tests also don't fit?
>
> sysctl and keyctl are actually testing kernel bugs.
> Other kernel related (at least lsmod, mkfs, mkswap, unshare, ldd, gdb) + TPM tools
> (tpm-tools, ...) are probably valid.
Hi,

I want to leave unshare01 because it could test not only namespaces but also a RHEL specific bug:
https://bugzilla.redhat.com/show_bug.cgi?id=1463072

I attach the fix patch for your reference.

Thanks,
Xiao Yang

> I guess most of user space tools not related to kernel (cp, cron, df, ln, tar, unzip, wc,
> which) are questionable.
> du01 and ar01 are mentioned in git log to catch some bug, so we'd have to carefully check
> one by one if we want to remove them (and remove them in separate commits, but that's
> obvious).
>
> Kind regards,
> Petr
>



-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: 61136-fs-mntns-Remove-incorrect-put_mnt_ns.patch
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180427/4599a3cf/attachment.ksh>
