Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kiran@linux.vnet.ibm.com>) id 1MWrRl-00087T-0t
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 12:42:53 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWrRe-0002y2-7c
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 12:42:52 +0000
From: Kiran <kiran@linux.vnet.ibm.com>
Date: Fri, 31 Jul 2009 18:12:25 +0530
Message-Id: <1249044145.5432.71.camel@kiran-laptop>
Mime-Version: 1.0
Subject: [LTP] [PATCH 0/3] libstats: Add new API
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
To: ltp-list <ltp-list@lists.sf.net>
Cc: gowrishankar.m@in.ibm.com

Hi,
 
 This set of 3 patches adds a new API stats_container_append to  
 libstats. This function adds new stats_record_t to the record list in
 stats_container_t. It also replaces the occurrences of data->size with
 data->index and modifies the test-cases to call the append function.
 
 Changelog
 ---------
  - Added index to stats_container_t struct
  - Added Append function to add new stats_record_t to records list of 
    stats_container_t
  - Replaced the occurrences of data->size by data->index in libstats.c
  - Modified the realtime testcases to include call to the append 
    function.
-- 

Thanks,
Kiran


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
