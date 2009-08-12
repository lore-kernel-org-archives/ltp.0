Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MbKD0-0005ss-Sg
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 20:14:06 +0000
Received: from rv-out-0708.google.com ([209.85.198.247])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MbKCv-0006dz-D4
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 20:14:06 +0000
Received: by rv-out-0708.google.com with SMTP id b17so67139rvf.22
	for <ltp-list@lists.sourceforge.net>;
	Wed, 12 Aug 2009 13:13:55 -0700 (PDT)
Message-Id: <E831A4F6-658A-47BE-9778-D00D7D3E9741@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <4A82DC0A.3050502@canonical.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Date: Wed, 12 Aug 2009 13:14:32 -0700
References: <4A7AEE38.60101@canonical.com>
	<364299f40908061022m926d148o661e1c8a2eb58a5@mail.gmail.com>
	<4A82DC0A.3050502@canonical.com>
Subject: Re: [LTP] fix lib6 test building
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
To: Paul Larson <paul.larson@canonical.com>
Cc: ltp-list@lists.sourceforge.net

On Aug 12, 2009, at 8:13 AM, Paul Larson wrote:

> Garrett Cooper wrote:
>> On Thu, Aug 6, 2009 at 7:52 AM, Paul  
>> Larson<paul.larson@canonical.com> wrote:
>>> The lib6 tests seem to fail the first pass through building for me
>>> because ranlib does not seem to get set correctly at any point.   
>>> This
>>> seems to fix it up for me.
>>
>> Fixed on HEAD moments ago:
>>
>> gcooper@orangebox /scratch/ltp-dev2/ltp $ cvs diff
>> testcases/network/lib6/Makefile
>> Index: testcases/network/lib6/Makefile
>> ===================================================================
>> RCS file: /cvsroot/ltp/ltp/testcases/network/lib6/Makefile,v
>> retrieving revision 1.6
>> diff -r1.6 Makefile
>> 25a26,27
>>> RANLIB                ?= ranlib
> The patch you checked in does not correct the build failure.

     Error message please?
Thanks,
-Garrett

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
