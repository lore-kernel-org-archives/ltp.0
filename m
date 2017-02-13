From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Mon, 13 Feb 2017 11:38:04 +0800
Subject: [LTP] [PATCH v2] syscalls/signal06: fix test for regression
 with earlier version of gcc and kernel
In-Reply-To: <20170209161922.GA25369@rei>
References: <20161010131529.GA1684@rei>
 <1479284063-12968-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20170209161922.GA25369@rei>
Message-ID: <58A12A1C.3090808@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 02/10/2017 12:19 AM, Cyril Hrubis wrote:
> Hi!
>> 1. Currently, following code is incorrect on some releases with
>>    earlier version of gcc(tested on RHEL5.11GA):
>>
>> 	while (D == d && loop < LOOPS) {
>>
>>    Because the argument in function test(double d) is used via (%rsp),
>>    but here we actually need a xmm register to trigger the fpu bug.
>>    So use global value instead to make sure to take use of xmm.
>>
>> 2. Although this regression test is designed to trigger SIGSEGV
>>    intentionally, on some releases with old kernel(tested on RHEL5.11GA),
>>    this will still lead to segmentation fault that terminate the program
>>    and break the test even though compiling with -O2.  So slightly adjust
>>    the weight of the codes in child thread to depress SIGSEGV trigger's
>>    chance while increase LOOPS to ensure reproducible.
> 
> This needs to be worded a bit better, I had to read the email discussion
> to remember what we are trying to avoid here.
> 
> Something as:
> 
> 2. Although this regresssion test is designed to trigger SIGSEGV
>    intentionally in order to invoke signal handler, producing it too
>    fast can lead to a program termination on older kernels (found in
>    RHEL5.11GA). Hence we divide the frequency in half and increase
>    number of LOOPS at the same time as a compensation to make sure
>    that the bug is 100% reproducible.
> 
> OK to commit with this change to the patch description?

Sure, the description is much better now.
Thanks very much!

Best Regards,
Guangwen Feng


