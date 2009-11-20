Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NBSKK-0008LB-Te
	for ltp-list@lists.sourceforge.net; Fri, 20 Nov 2009 12:11:00 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NBSKF-0004yN-Eo
	for ltp-list@lists.sourceforge.net; Fri, 20 Nov 2009 12:11:00 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAKC9ddc018662
	for <ltp-list@lists.sourceforge.net>; Fri, 20 Nov 2009 05:09:39 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAKCAi8G163968
	for <ltp-list@lists.sourceforge.net>; Fri, 20 Nov 2009 05:10:45 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nAK53dcQ007171
	for <ltp-list@lists.sourceforge.net>; Thu, 19 Nov 2009 22:03:40 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4B068507.4010303@st.com>
References: <4AF3D509.3060408@st.com> <4AF41677.8030408@linux.vnet.ibm.com>
	<4AF41D01.207@st.com> <4AF42CBC.6000204@linux.vnet.ibm.com>
	<1257788343.7677.63.camel@subratamodak.linux.ibm.com>
	<4B01682C.8040708@st.com>  <4B06495F.2060600@st.com>
	<1258712924.4986.5.camel@subratamodak.linux.ibm.com>
	<4B068507.4010303@st.com>
Date: Fri, 20 Nov 2009 17:40:30 +0530
Message-Id: <1258719031.4986.15.camel@subratamodak.linux.ibm.com>
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
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, 2009-11-20 at 13:01 +0100, Giuseppe CAVALLARO wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi Subrata,
> 
> this is the patch reworked to be applied against the ltp cvs.

Great. Thanks. Added.

Regards--
Subrata

> 
> Regards
> Peppe
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAksGhQcACgkQ2Xo3j31MSSINMACfdqZU48hhlPJETmqJkAKppYdo
> HawAoLc0yJ8JB2iQ4JU+ffNXmSaZW+9z
> =s7E+
> -----END PGP SIGNATURE-----


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
