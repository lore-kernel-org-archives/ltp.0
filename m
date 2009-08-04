Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MYLzm-0006FJ-MT
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 15:32:10 +0000
Received: from mail-fx0-f211.google.com ([209.85.220.211])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MYLzg-0005Ul-HF
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 15:32:10 +0000
Received: by fxm7 with SMTP id 7so3367533fxm.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 04 Aug 2009 08:31:57 -0700 (PDT)
Message-ID: <4A785468.6020803@petalogix.com>
Date: Tue, 04 Aug 2009 17:31:52 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <4A76D6DD.4020401@petalogix.com>	
	<20090803151449.GA29794@us.ibm.com>
	<1249387690.15587.34.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1249387690.15587.34.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] clone01 -c 10 on x86
Reply-To: michal.simek@petalogix.com
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
To: subrata@linux.vnet.ibm.com
Cc: LTP <ltp-list@lists.sourceforge.net>

Subrata Modak wrote:
> On Mon, 2009-08-03 at 10:14 -0500, Serge E. Hallyn wrote: 
>   
>> Quoting Michal Simek (michal.simek@petalogix.com):
>>     
>>> Hi All,
>>>
>>> can you please to run clone01 syscall test on any x86 machine? I am
>>> getting fault there when I run it 10 times for example.
>>> The same problem I have on Microblaze.
>>>
>>>  ./clone01  -c 10
>>> clone01     1  TPASS  :  clone() returned 22738
>>> clone01     1  TPASS  :  clone() returned 22740
>>> clone01     1  TPASS  :  clone() returned 22742
>>> clone01     1  TPASS  :  clone() returned 22748
>>> clone01     1  TPASS  :  clone() returned 22750
>>> clone01     1  TPASS  :  clone() returned 22752
>>> clone01     1  TPASS  :  clone() returned 22754
>>> clone01     1  TFAIL  :  clone() returned 134919589, errno = 22755
>>> [monstr@monstr clone]$ clone01     1  TPASS  :  clone() returned 22744
>>> clone01     1  TPASS  :  clone() returned 22746
>>>
>>> Thanks,
>>> Michal
>>>       
>> All right I don't have the patiente to wade through the parse_opts
>> and usc_lib crap, but this is not a clone failure.  What appears to
>> be happening is setup() at the top of clone01.c is calling
>> lib/parse_opts.c:usc_global_setup_hook(), with STD_COPIES set to the
>> count option you passed in.  That forks of 10 copies of the test.
>> I don't know what happens with the actual loop then, but the reason
>> you get the error for the last clone test is that one of those
>> forked copies of clone01 (*not* one of the cloned children) exits,
>> and wait() catches that one.  That is why wait() returned 22744,
>> which isn't any of the cloned children.
>>
>> So one stupid way of fixing this without dealing with the convoluted
>> setup junk would be to change the waitpid chunk of the code like so:
>>     
>
> Yes, it fixes the issue.
>   
Yes, but as Serge wrote above his patch just cover different fault not
solve it.

Regards,
Michal
> Regards--
> Subrata
>
>   
>> --- /usr/src/ltp-intermediate-20090721/testcases/kernel/syscalls/clone/clone01.c	2009-03-23 09:35:39.000000000 -0400
>> +++ /usr/src/ltp-intermediate-20090721.patched/testcases/kernel/syscalls/clone/clone01.c	2009-08-03 11:11:25.000000000 -0400
>> @@ -130,6 +132,7 @@ int main(int ac, char **av)
>>  		     (do_child, child_stack + CHILD_STACK_SIZE, SIGCHLD, NULL));
>>  #endif
>>
>> +again:
>>  		if ((child_pid = wait(&status)) == -1) {
>>  			tst_brkm(TBROK, cleanup, "wait() failed; error no ="
>>  				 " %d, %s", errno, strerror(errno));
>> @@ -138,11 +141,11 @@ int main(int ac, char **av)
>>  		/* check return code */
>>  		if (TEST_RETURN == child_pid) {
>>  			tst_resm(TPASS, "clone() returned %d", TEST_RETURN);
>> -		} else {
>> -			tst_resm(TFAIL, "clone() returned %d, errno = %d ",
>> -				 "wait() returned %d", TEST_RETURN, TEST_ERRNO,
>> +		} else if (TEST_RETURN == -1) {
>> +			tst_resm(TFAIL, "clone() returned %d, errno = %d wait() returned %d\n", TEST_RETURN, TEST_ERRNO,
>>  				 child_pid);
>> -		}
>> +		} else
>> +			goto again;
>>
>>  	}			/* End for TEST_LOOPING */
>>
>>
>> -serge
>>
>> ------------------------------------------------------------------------------
>> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
>> trial. Simplify your report design, integration and deployment - and focus on 
>> what you do best, core application coding. Discover what's new with 
>> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>     
>
>   


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
