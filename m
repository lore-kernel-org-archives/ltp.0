Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1Wl86D-0006My-SL
	for ltp-list@lists.sourceforge.net; Fri, 16 May 2014 02:42:17 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wl86C-0004sj-1Q
	for ltp-list@lists.sourceforge.net; Fri, 16 May 2014 02:42:17 +0000
Message-ID: <53757A75.7000101@cn.fujitsu.com>
Date: Fri, 16 May 2014 10:39:49 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1399874987-24926-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<27774731.5088145.1400061957755.JavaMail.zimbra@redhat.com>
In-Reply-To: <27774731.5088145.1400061957755.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH 1/2] setpgid/setpgid01.c: cleanup
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi,

On 05/14/2014 06:05 PM, Jan Stancek wrote:
>
> ----- Original Message -----
>> From: "Xiaoguang Wang" <wangxg.fnst@cn.fujitsu.com>
>> To: ltp-list@lists.sourceforge.net
>> Sent: Monday, 12 May, 2014 8:09:46 AM
>> Subject: [LTP] [PATCH 1/2] setpgid/setpgid01.c: cleanup
>>
>> Delete some useless comments.
>> Do some code re-arrangement.
>> Some cleanup.
>>
>> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
>> ---
>>  testcases/kernel/syscalls/setpgid/setpgid01.c | 204
>>  +++++++-------------------
>>  1 file changed, 57 insertions(+), 147 deletions(-)
>>
>> -	/*
>> -	 * Make sure current process is NOT a session or pgrp leader
>> -	 */
>> +static void setpgid_test1(void)
>> +{
>> +	int ret;
>> +	pid_t pgid, pid;
>>  
>>  	pgid = getpgrp();
>>  	pid = getpid();
>>  
> Hi,
>
>> +	/*
>> +	 * Make sure current process is NOT a session or pgrp leader
>> +	 */
>>  	if (pgid == pid) {
> What if we dropped the condition above and always make a child?
> If we do that, then setpgid_test1() and setpgid_test2() are almost the same,
> with the difference of arguments you pass to setpgid(), so there's a chance
> to re-use some code.
>
> Thinking about it a bit more, is there any reason we need a child process?

For pid = 0 & pgid = 0 test, I think we should have tests in child process,
because in this case, according to setpgid()'s manpge, this will set
child process's PGID to its PID, we should verify this.

>
> If it is pgrp leader, we create a child, which inherits parent's PGID and then
> calls setpgid(0, pgid_of_parent)
> If it's not a pgrp leader, we call setpgid(pid, current_pgid).
>
> We always seem to call setpgid with same pgid as current PGID. Can that
> fail in any scenario? Does it matter if it's a pgrp leader or not?

Thanks for your explanation.
When I did this cleanup, I also did not know why to have this
setting, so I kept this setting. Now it seems it is useless, I
will send a new version, which would remove this 'pgid == pid' code, thanks.

Regards,
Xiaoguang Wang

>
> $ cat a.c
> int main()
> {
> 	printf("%d %d\n", getpid(), getpgrp());
> 	printf("%d\n", setpgid(getpid(), getpgrp()));
> 	return 0;
> }
>
> $ ./a.out 
> 22721 22721
> 0
>
> Am I missing something?
>
> Regards,
> Jan
>
>>  		if ((pid = FORK_OR_VFORK()) == -1) {
>> -			tst_brkm(TBROK, cleanup,
>> -				 "fork() in setup() failed - errno %d", errno);
>> +			tst_brkm(TBROK | TERRNO, cleanup, "fork()");
>>  		}
>>  
>> -		if (pid != 0) {	/* parent - sits and waits */
>> -			wait(&status);
>> -			exit(WEXITSTATUS(status));
>> -		} else {	/* child - continues with test */
>> +		if (pid != 0) {
>> +			ret = wait4child(pid);
>> +		} else {
>>  			pid = getpid();
>> +			TEST(setpgid(pid, pgid));
>> +			if (TEST_RETURN == -1 || getpgrp() != pgid)
>> +				exit(1);
>> +			else
>> +				exit(0);
>>  		}
>> +	} else {
>> +		TEST(setpgid(pid, pgid));
>> +		if (TEST_RETURN == -1 || getpgrp() != pgid)
>> +			ret = 1;
>> +		else
>> +			ret = 0;
>>  	}
>> +
>> +	if (ret == 0)
>> +		tst_resm(TPASS, "test setpgid(%d, %d) success", pid, pgid);
>> +	else
>> +		tst_resm(TFAIL, "test setpgid(%d, %d) fail", pid, pgid);
>>  }
>>  
>> -/***************************************************************
>> - * cleanup() - performs all ONE TIME cleanup for this test at
>> - *		completion or premature exit.
>> - ***************************************************************/
>> -void cleanup(void)
>> +static void setup(void)
>>  {
>> -	/*
>> -	 * print timing stats if that option was specified.
>> -	 * print errno log if that option was specified.
>> -	 */
>> -	TEST_CLEANUP;
>> +	tst_sig(FORK, DEF_HANDLER, cleanup);
>>  
>> +	TEST_PAUSE;
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	TEST_CLEANUP;
>>  }
>> --
>> 1.8.2.1
>>
>>
>> ------------------------------------------------------------------------------
>> "Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
>> Instantly run your Selenium tests across 300+ browser/OS combos.
>> Get unparalleled scalability from the best Selenium testing platform
>> available
>> Simple to use. Nothing to install. Get started now for free."
>> http://p.sf.net/sfu/SauceLabs
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>
> .
>


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
