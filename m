From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 14 Jul 2016 18:03:33 +0300
Subject: [LTP] [PATCH] waitpid06: use the new API
In-Reply-To: <20160712135104.GC2651@rei.suse.cz>
References: <1467904136-5136-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160712135104.GC2651@rei.suse.cz>
Message-ID: <5787A9C5.4000702@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 07/12/2016 04:51 PM, Cyril Hrubis wrote:
> Hi!
>> I'd like to update those waitpid* test cases utilizing wait_for_parent()
>> to use the checkpoint interface. It requires converting them for the
>> new LTP API. This, in turn, drops UCLINUX support. However, since nobody
>> has replied to:
>>
>> http://lists.linux.it/pipermail/ltp/2016-May/001752.html
>>
>> it (dropping UCLINUX) seems to be acceptable. Right?
>
> I've even tried to subscribe to the uClinux-dev mailing list but it
> looks like nobody manages it anymore. So I guess that we may start
> dropping support for it.
>
>> -static void setup_sigint(void)
>> -{
>> -	if ((sig_t) signal(SIGINT, inthandlr) == SIG_ERR) {
>> -		tst_resm(TFAIL, "signal SIGINT failed. " "errno = %d", errno);
>> -		exit(-1);
>> +	pid = SAFE_FORK();
>> +	if (pid == 0) {
>> +		do_child_1();
>> +	} else {
>> +		SAFE_WAITPID(pid, &status, 0);
>> +		if (WEXITSTATUS(status) != 0)
>> +			tst_res(TFAIL, "Child returned bad status");
>> +		else
>> +			tst_res(TPASS, "Child returned good status");
>
> Hmm, I guess that there is no reason for this indirection anymore. We
> can just start MAXKIDS processes directly from the test() function.

 From the code:
                 if (kid_count == (MAXKIDS / 2))
                         group2 = setpgrp();

it seems that the author wanted to have the first 4 children be in one 
process group, and the other 4 children - in another. I don't know why 
he/she needed that though.

If we start MAXKIDS directly from the test() function they all will be 
in one process group - the process group of the process executing the 
test() function.

So I'd keep the current scheme.

>
> Otherwise it looks good.
>

Thanks for the review.

Having a fresh look at this, I found a few additional things:
  * I don't handle the situation when setpgrp() fails
  * group1 is not used, so is a candidate for removal
  * types for group2, fork_kid_pid, wait_kid_pid should be pid_t

I'll update the patch and send a new version tomorrow.
