Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Paven-0008J0-2O
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 19:37:57 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pavem-0004TA-C3
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 19:37:57 +0000
Received: by iyj18 with SMTP id 18so15364384iyj.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 Jan 2011 11:37:51 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1082)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <20B25B11-E8BD-45A7-AAD5-209D62BC6274@gmail.com>
Date: Thu, 6 Jan 2011 11:37:39 -0800
Message-Id: <1DAD8CD4-AB20-485F-95BD-E879867C242A@gmail.com>
References: <4D259E4A.2050704@cn.fujitsu.com>
	<AANLkTinX9M3EsBxSDsVy56iKqskSWKQE4vMhXy0kcxNG@mail.gmail.com>
	<20B25B11-E8BD-45A7-AAD5-209D62BC6274@gmail.com>
Subject: Re: [LTP] [PATCH 00/13]Fix a few syntax error
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

On Jan 6, 2011, at 11:35 AM, Garrett Cooper wrote:

> On Jan 6, 2011, at 10:26 AM, Mike Frysinger wrote:
> 
>> On Thu, Jan 6, 2011 at 5:49 AM, tangchen wrote:
>>> There are several small bugs making LTP unable to be built, most of
>>> which are syntax errors.
>>> 
>>> 1. Add missing parameters for tst_brkm() in
>>> testcases/kernel/syscalls/fchmod/fchmod03.c
>>> 2. Add missing parameters for tst_brkm() in
>>> testcases/kernel/syscalls/flock/flock04.c
>>> 3. Add missing ";" in testcases/kernel/syscalls/getpagesize/getpagesize01.c
>>> 4. Correct the parameters' names for parse_opts() in
>>> testcases/kernel/syscalls/lchown/lchown02.c
>>> 5. Add some preprocessor variables in /testcases/kernel/mem/ksm/ksm01.c
>>> bacause KSM is not supported on RHEL5
>>> 6. Add missing operators for parse_opts() in
>>> testcases/kernel/syscalls/msync/msync04.c
>>> 7. Fix an wrong using of macro WTERMSIG in
>>> testcases/kernel/syscalls/pipe/pipe04.c
>>> 8. Fix the wrong variable name of wtstatus in
>>> testcases/kernel/syscalls/pipe/pipe09.c
>>> 9. Add a missing ")" in testcases/kernel/syscalls/pread/pread03.c
>>> 10. Remove a redundant "{" in
>>> testcases/kernel/syscalls/sched_getparam/sched_getparam02.c
>>> 11. Fix the wrong using of perror() in
>>> testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
>>> 12. Add a missing variable TST_TOTAL in
>>> testcases/kernel/syscalls/socketpair/socketpair02.c
>>> 13. Add missing parameters for tst_brkm() in
>>> testcases/kernel/syscalls/statfs/statfs03.c
>> 
>> this is weird ... how did all these *compile errors* manage to get
>> *committed* ??
> 
> A really bad merge (I posted a reply to it a while ago in the archives).

Well, that and I also turned on -Werror to catch warnings-related errors.
-Garrett


------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
