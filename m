Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UadDM-00084b-Tl
	for ltp-list@lists.sourceforge.net; Fri, 10 May 2013 02:37:44 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UadDJ-00056A-Ku
	for ltp-list@lists.sourceforge.net; Fri, 10 May 2013 02:37:44 +0000
Message-ID: <518C5CE3.9070702@cn.fujitsu.com>
Date: Fri, 10 May 2013 10:35:15 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <518B618F.80400@cn.fujitsu.com>
	<201305091222.52821.vapier@gentoo.org>
In-Reply-To: <201305091222.52821.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 1/2]semctl/semctl01.c: cleanup
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

On 05/10/2013 12:22 AM, Mike Frysinger wrote:
> On Thursday 09 May 2013 04:42:55 DAN LI wrote:
>> --- a/testcases/kernel/syscalls/ipc/semctl/semctl01.c
>> +++ b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
>>
>>  /*
>> @@ -24,32 +23,6 @@
>>   * DESCRIPTION
>>   *	semctl01 - test the 10 possible semctl() commands
>>   *
>> - * ALGORITHM
>> - *	create a semaphore set with read and alter permissions
>> - *	loop if that option was specified
>> - *	  loop through the test cases
>> - *	    do any setup required for the test case
>> - *	    make the semctl() call using the TEST() macro
>> - *	    check the return code
>> - *	      if failure, issue a FAIL message.
>> - *	    otherwise,
>> - *	      if doing functionality testing
>> - *		call the appropriate test function
>> - *	  	if correct,
>> - *			issue a PASS message
>> - *		otherwise
>> - *			issue a FAIL message
>> - *	call cleanup
> 
> i don't see high level DESCRIPTION/ALGORITHM as "useless".  why do you ?

In my opinion, "ALGORITHM" section of many ltp testcases follows one format:
------------------------------------------------
setup()
loop test frame
	loop all test cases
		TEST(call)
		if call failed
			log the errno
		else
			if functionality is ok
				case PASS
			else
				case FAIL
cleanup()
------------------------------------------------

So, i think this section is redundant and useless once someone has
learned the test frame.

> 
>>   * HISTORY
> 
> on the flip side, HISTORY is pretty useless.  that's what `git log` is for.

Agreed.

I'll send a V2 to fix it.

Thanks,
DAN LI
> -mike
> 



------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
