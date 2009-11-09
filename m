Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N7YCz-0005Aa-IK
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 17:39:17 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N7YCx-0004WZ-AT
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 17:39:17 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA9HZJ9r026345
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Nov 2009 12:35:19 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA9Hd9M3086194
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Nov 2009 12:39:09 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA9Hd9V1002846
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Nov 2009 12:39:09 -0500
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AF42CBC.6000204@linux.vnet.ibm.com>
References: <4AF3D509.3060408@st.com> <4AF41677.8030408@linux.vnet.ibm.com>
	<4AF41D01.207@st.com>  <4AF42CBC.6000204@linux.vnet.ibm.com>
Date: Mon, 09 Nov 2009 23:09:03 +0530
Message-Id: <1257788343.7677.63.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] add iterations option in gtod_latency.
Reply-To: subrata@linux.vnet.ibm.com
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
To: gowrishankar <gomuthuk@linux.vnet.ibm.com>, Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, 2009-11-06 at 19:33 +0530, gowrishankar wrote: 
> Giuseppe CAVALLARO wrote:
> > gowrishankar wrote:
> >> Giuseppe CAVALLARO wrote:
> >>> Regards,
> >>> Peppe
> >>>
> >> Can you please add freeing resources at the end of main.
> >>
> >>         stats_container_free(&dat);
> >>         stats_container_free(&hist);
> >>         stats_quantiles_free(&quantiles);
> >>
> >> Also, you could set MIN_ITERATION to 10000 instead of hard coding inside
> >> main.
> >> Just a suggestion.
> > 
> > patch reattached!

Thanks. But it fails to apply:

patching file testcases/realtime/func/gtod_latency/gtod_latency.c
Hunk #1 succeeded at 57 (offset 1 line).
Hunk #3 succeeded at 197 (offset 1 line).
Hunk #5 FAILED at 230.
Hunk #6 succeeded at 285 (offset 2 lines).
Hunk #8 succeeded at 303 with fuzz 2 (offset 2 lines).
Hunk #9 succeeded at 313 (offset 1 line).
Hunk #10 succeeded at 337 (offset 2 lines).

> > Peppe
> > 
> 
> Patch looks neat!
> 
> I just recollected now that I had sent more or less same patch
> very long back, but maintainer missed it some how.
> 
> http://www.opensource-archive.org/showthread.php?t=82487
> 
> Subrata ?? :)

I apolozise to have missed to see your patches. It is rare that i miss
any patches. But, i can see that some other patch changing the same file
was ack-ed by you. You could have reminded me during that time that it
does not include changes sent by you:

http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/realtime/func/gtod_latency/gtod_latency.c?view=log,

Revision 1.10 - (view) (download) (annotate) - [select for diffs] 
Mon Aug 3 10:37:50 2009 UTC (3 months ago) by subrata_modak 
Branch: MAIN 
Changes since 1.9: +4 -2 lines 
Diff to previous 1.9 
This set of 3 patches adds a new API stats_container_append to libstats. This function adds new stats_record_t to the record list in stats_container_t. It also replaces the occurrences of data->size with data->index and modifies the test-cases to call the append function. Changelog
---------
- Added index to stats_container_t struct
- Added Append function to add new stats_record_t to records list of stats_container_t
- Replaced the occurrences of data->size by data->index in libstats.c
- Modified the realtime testcases to include call to the append function.
[PATCH 3/3] libstats: Modify testcases to call the append function: This patch modifies the testcases to call the stats_container_append function.
Signed-off-by: Kiran Prakash <kiran@linux.vnet.ibm.com>,
Acked-by: Gowrishankar <gowrishankar.m@in.ibm.com>,
Acked-by: Darren Hart <dvhltc@us.ibm.com>,
Acked-by: Sripathi Kodi <sripathik@in.ibm.com>,

Regards--
Subrata

> 
> Thanks,
> Gowri
> 
> 
> 
> >> Thanks,
> >> Gowri
> >>
> >>> ------------------------------------------------------------------------
> >>>
> >>> ------------------------------------------------------------------------------
> >>>
> >>> Let Crystal Reports handle the reporting - Free Crystal Reports 2008
> >>> 30-Day trial. Simplify your report design, integration and deployment
> >>> - and focus on what you do best, core application coding. Discover
> >>> what's new with
> >>> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> >>>
> >>>
> >>> ------------------------------------------------------------------------
> >>>
> >>> _______________________________________________
> >>> Ltp-list mailing list
> >>> Ltp-list@lists.sourceforge.net
> >>> https://lists.sourceforge.net/lists/listinfo/ltp-list
> >>
> > 
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
