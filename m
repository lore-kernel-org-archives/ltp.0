Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <avagin@gmail.com>) id 1NAlBe-0002UQ-0W
	for ltp-list@lists.sourceforge.net; Wed, 18 Nov 2009 14:07:10 +0000
Received: from mailhub.sw.ru ([195.214.232.25] helo=relay.sw.ru)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NAlBV-0005HI-Oj
	for ltp-list@lists.sourceforge.net; Wed, 18 Nov 2009 14:07:09 +0000
Message-ID: <4B03F177.1090103@gmail.com>
Date: Wed, 18 Nov 2009 16:07:03 +0300
From: Andrew Vagin <avagin@gmail.com>
MIME-Version: 1.0
References: <1258098740-22455-1-git-send-email-avagin@gmail.com>
	<200911131017.02467.vapier@gentoo.org>
In-Reply-To: <200911131017.02467.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] clock_settime03: improve message about fail
Reply-To: avagin@gmail.com
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On 11/13/2009 06:17 PM, Mike Frysinger wrote:
> On Friday 13 November 2009 02:52:20 Andrew Vagin wrote:
>    
>> ---
>>   .../kernel/timers/clock_settime/clock_settime03.c  |    5 +++--
>>   1 files changed, 3 insertions(+), 2 deletions(-)
>>
>> --- a/testcases/kernel/timers/clock_settime/clock_settime03.c
>> +++ b/testcases/kernel/timers/clock_settime/clock_settime03.c
>> @@ -195,10 +195,11 @@ main(int ac, char **av)
>>   			} else {
>>   				tst_resm(TFAIL, "clock_settime(2) failed to"
>>   						" produce expected error; %d"
>> -						" , errno : %s and got %ld",
>> +						" , errno : %s and "
>> +						"got %ld errno %d",
>>   						testcase[i].exp_errno,
>>   						testcase[i].exp_errval,
>> -						TEST_RETURN);
>> +						TEST_RETURN, TEST_ERRNO);
>>      
> please convert it to TFAIL|TTERRNO instead
>    
I don't understand. pls describe in detail
> -mike
>    


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
