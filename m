Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1N6Nwv-0007SC-HJ
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 12:29:53 +0000
Received: from e28smtp02.in.ibm.com ([59.145.155.2])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6Nwo-0000ue-Rz
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 12:29:53 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp02.in.ibm.com (8.14.3/8.13.1) with ESMTP id nA6CSevL007185
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Nov 2009 17:58:40 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA6CSePf2465860
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Nov 2009 17:58:40 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA6CSdLJ031016
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Nov 2009 23:28:40 +1100
Message-ID: <4AF41677.8030408@linux.vnet.ibm.com>
Date: Fri, 06 Nov 2009 17:58:39 +0530
From: gowrishankar <gomuthuk@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <4AF3D509.3060408@st.com>
In-Reply-To: <4AF3D509.3060408@st.com>
Subject: Re: [LTP] [PATCH] add iterations option in gtod_latency.
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
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: ltp-list@lists.sourceforge.net

Giuseppe CAVALLARO wrote:
> Regards,
> Peppe
> 

Can you please add freeing resources at the end of main.

         stats_container_free(&dat);
         stats_container_free(&hist);
         stats_quantiles_free(&quantiles);

Also, you could set MIN_ITERATION to 10000 instead of hard coding inside main.
Just a suggestion.

Thanks,
Gowri

> 
> ------------------------------------------------------------------------
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
