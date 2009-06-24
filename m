Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MJOw7-000483-PD
	for ltp-list@lists.sourceforge.net; Wed, 24 Jun 2009 09:38:35 +0000
Received: from rv-out-0708.google.com ([209.85.198.247])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MJOvy-0003iq-77
	for ltp-list@lists.sourceforge.net; Wed, 24 Jun 2009 09:38:35 +0000
Received: by rv-out-0708.google.com with SMTP id l33so82625rvb.22
	for <ltp-list@lists.sourceforge.net>;
	Wed, 24 Jun 2009 02:38:24 -0700 (PDT)
Message-Id: <A850D9FA-3282-440E-8B85-4A5BC5B4B067@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Mime-Version: 1.0 (iPhone Mail 7A341)
Date: Wed, 24 Jun 2009 02:38:12 -0700
Subject: [LTP] Goals and milestones
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi Subrata,
     After being away from FOSS for a while I'm going to jump back in  
a bit to get some work done in my personal time that aligns itself  
with deliverables at Cisco. Here's the breakdown in terms of priorities:
1. Ltp crosscompile makefile push completion - need this to resolve  
several issues with the current hacked make system and expedite  
upgrades on our end. Hard goal: before July snapshot is released  
(several items are dependent on a functioning upgrade). I will commit  
in small, discrete patches to get the work done quicker, but I'll need  
a makefile reviewer.
2. Catepault work. This aligns itself with 1., but isn't directly tied  
into 1.'s deliverable. Maybe October.
3. tst_res -> testreport replacement. Needs to take place somewhere  
around 2.'s deliverable because we need a more license neutral and  
equivalent, if not cleaner, means of doing test reporting to improve  
whitebox testing inhouse. I'd say before Thanksgiving.
4. Upstart whitebox tests - I originally suggested this thinking that  
there would be one Upstart release train, but Scott's maintaining  
several, so I think it may be a better idea to omit these tests and  
focus instead on exporting the graybox tests I'm working on inhouse at  
Cisco as they are more portable and have more overall value. I'm  
thinking maybe January or february of next year.

Hope that better describes where I'm at and what goals i'm trying to  
accomplish.

Thanks,
-Garrett 

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
