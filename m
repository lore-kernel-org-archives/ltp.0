Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UsN1Y-00066r-NN
	for ltp-list@lists.sourceforge.net; Fri, 28 Jun 2013 00:58:52 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UsN1W-0000gE-GY
	for ltp-list@lists.sourceforge.net; Fri, 28 Jun 2013 00:58:52 +0000
Message-ID: <51CCDF3A.70001@cn.fujitsu.com>
Date: Fri, 28 Jun 2013 08:56:26 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1372304589-16585-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1529763918.536440.1372325997166.JavaMail.root@redhat.com>
In-Reply-To: <1529763918.536440.1372325997166.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] clock_settime03: don't test PROCESS_CPUTIME_ID
	and THREAD_CPUTIME_ID
Reply-To: gaowanlong@cn.fujitsu.com
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
Cc: LTP <ltp-list@lists.sourceforge.net>

On 06/27/2013 05:39 PM, Jan Stancek wrote:
> 
> 
> 
> 
> ----- Original Message -----
>> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
>> To: "LTP" <ltp-list@lists.sourceforge.net>
>> Cc: "Cyril Hrubis" <chrubis@suse.cz>, "Caspar Zhang" <caspar@casparzhang.com>, "Garrett Cooper" <yanegomi@gmail.com>,
>> "Mike Frysinger" <vapier@gentoo.org>, jstancek@redhat.com, "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
>> Sent: Thursday, 27 June, 2013 5:43:09 AM
>> Subject: [PATCH] clock_settime03: don't test PROCESS_CPUTIME_ID and THREAD_CPUTIME_ID
>>
>> PROCESS_CPUTIME_ID and THREAD_CPUTIME_ID are not supported before
>> kernel 2.6.12, and changed back since 2.6.38. And they are
>> thought improper supported on Linux, so we just remove them
>> from the test of clock_settime and remain them be untested.
> 
> Hi,
> 
> Isn't this test testing that these are not supported?
>   EINVAL The clk_id specified is not supported on this system.
> 
> Are these going to be removed completely?
> What is the risk if we keep them?

The problem is what Cyril said in this thread.

Thanks,
Wanlong Gao

> 
> Regards,
> Jan
> 
>>
>> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
>> ---
>>  testcases/kernel/timers/clock_settime/clock_settime03.c | 15 ---------------
>>  1 file changed, 15 deletions(-)
>>
>> diff --git a/testcases/kernel/timers/clock_settime/clock_settime03.c
>> b/testcases/kernel/timers/clock_settime/clock_settime03.c
>> index a949303..3693395 100644
>> --- a/testcases/kernel/timers/clock_settime/clock_settime03.c
>> +++ b/testcases/kernel/timers/clock_settime/clock_settime03.c
>> @@ -37,8 +37,6 @@ clockid_t clocks[] = {
>>  	CLOCK_REALTIME,
>>  	CLOCK_REALTIME,
>>  	CLOCK_REALTIME,
>> -	CLOCK_PROCESS_CPUTIME_ID,
>> -	CLOCK_THREAD_CPUTIME_ID
>>  };
>>  
>>  int testcases[] = {
>> @@ -49,8 +47,6 @@ int testcases[] = {
>>  	EINVAL,			/* Invalid timespec     */
>>  	EINVAL,			/* NSEC_PER_SEC + 1     */
>>  	EPERM,			/* non-root user        */
>> -	0,
>> -	0,
>>  };
>>  
>>  char *TCID = "clock_settime03";
>> @@ -70,17 +66,6 @@ int main(int ac, char **av)
>>  	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
>>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>>  
>> -	/* PROCESS_CPUTIME_ID & THREAD_CPUTIME_ID are not supported on
>> -	 * kernel versions lower than 2.6.12 and changed back in 2.6.38
>> -	 */
>> -	if ((tst_kvercmp(2, 6, 12)) < 0 || (tst_kvercmp(2, 6, 38)) >= 0) {
>> -		testcases[7] = EINVAL;
>> -		testcases[8] = EINVAL;
>> -	} else {
>> -		testcases[7] = EFAULT;
>> -		testcases[8] = EFAULT;
>> -	}
>> -
>>  	setup();
>>  
>>  	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> --
>> 1.8.3.1.448.gfb7dfaa
>>
>>
> 


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
