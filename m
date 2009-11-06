Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1N6PPy-00008y-J4
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 14:03:58 +0000
Received: from e28smtp08.in.ibm.com ([59.145.155.8])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6PPr-0001da-Jf
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 14:03:58 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp08.in.ibm.com (8.14.3/8.13.1) with ESMTP id nA6DkmCF002722
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Nov 2009 19:16:48 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA6E3hOu2281694
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Nov 2009 19:33:43 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA6E3gcE030892
	for <ltp-list@lists.sourceforge.net>; Sat, 7 Nov 2009 01:03:42 +1100
Message-ID: <4AF42CBC.6000204@linux.vnet.ibm.com>
Date: Fri, 06 Nov 2009 19:33:40 +0530
From: gowrishankar <gomuthuk@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <4AF3D509.3060408@st.com> <4AF41677.8030408@linux.vnet.ibm.com>
	<4AF41D01.207@st.com>
In-Reply-To: <4AF41D01.207@st.com>
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

Giuseppe CAVALLARO wrote:
> gowrishankar wrote:
>> Giuseppe CAVALLARO wrote:
>>> Regards,
>>> Peppe
>>>
>> Can you please add freeing resources at the end of main.
>>
>>         stats_container_free(&dat);
>>         stats_container_free(&hist);
>>         stats_quantiles_free(&quantiles);
>>
>> Also, you could set MIN_ITERATION to 10000 instead of hard coding inside
>> main.
>> Just a suggestion.
> 
> patch reattached!
> Peppe
> 

Patch looks neat!

I just recollected now that I had sent more or less same patch
very long back, but maintainer missed it some how.

http://www.opensource-archive.org/showthread.php?t=82487

Subrata ?? :)

Thanks,
Gowri



>> Thanks,
>> Gowri
>>
>>> ------------------------------------------------------------------------
>>>
>>> ------------------------------------------------------------------------------
>>>
>>> Let Crystal Reports handle the reporting - Free Crystal Reports 2008
>>> 30-Day trial. Simplify your report design, integration and deployment
>>> - and focus on what you do best, core application coding. Discover
>>> what's new with
>>> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
>>>
>>>
>>> ------------------------------------------------------------------------
>>>
>>> _______________________________________________
>>> Ltp-list mailing list
>>> Ltp-list@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>
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
