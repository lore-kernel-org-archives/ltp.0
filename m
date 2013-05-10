Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UaijL-00010X-Bi
	for ltp-list@lists.sourceforge.net; Fri, 10 May 2013 08:31:07 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UaijJ-00087g-HH
	for ltp-list@lists.sourceforge.net; Fri, 10 May 2013 08:31:07 +0000
Message-ID: <518CB008.5080402@cn.fujitsu.com>
Date: Fri, 10 May 2013 16:30:00 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <518B618F.80400@cn.fujitsu.com> <518B6271.2030707@cn.fujitsu.com>
	<20130509133232.GC4255@rei.suse.cz>
	<201305091220.44861.vapier@gentoo.org>
In-Reply-To: <201305091220.44861.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 2/2]semctl/semctl01.c: Test features IPC_INFO,
 SEM_INFO and SEM_STAT
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On 05/10/2013 12:20 AM, Mike Frysinger wrote:
> On Thursday 09 May 2013 09:32:32 chrubis@suse.cz wrote:
>>> +#ifdef __linux__
>>> +int TST_TOTAL = 13;
>>> +#else
>>>  int TST_TOTAL = 10;
>>> +#endif
>>>  static int sem_id_1 = -1;
>>> @@ -57,8 +65,14 @@ static void func_sval(void);
>>>  static void func_rmid(void);
>>>  static void child_cnt(void);
>>>  static void child_pid(void);
>>> +#ifdef __linux__
>>> +static void func_iinfo(int);
>>> +static void func_sinfo(void);
>>> +static void func_sstat(int);
>>> +#endif
>>
>> Well the only part of the LTP that we promise that will build and run on
>> anything else than Linux is Open Posix Testsuite, so in my opinion these
>> ifdefs are not needed. Has anybody different opinion?
> 
> i agree -- drop the __linux__ check, especially under testcases/kernel/ ... 
> the "kernel" there is "linux".

So, you mean drop the "sgi" as well?

Thanks,
Wanlong Gao

> -mike
> 
> 
> 
> ------------------------------------------------------------------------------
> Learn Graph Databases - Download FREE O'Reilly Book
> "Graph Databases" is the definitive new guide to graph databases and 
> their applications. This 200-page book is written by three acclaimed 
> leaders in the field. The early access version is available now. 
> Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
> 
> 
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
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
