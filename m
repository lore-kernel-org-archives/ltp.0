Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1Mmvgu-0005fc-Nj
	for ltp-list@lists.sourceforge.net; Sun, 13 Sep 2009 20:28:56 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mmvgq-0003a6-QL
	for ltp-list@lists.sourceforge.net; Sun, 13 Sep 2009 20:28:56 +0000
Date: Sun, 13 Sep 2009 15:05:54 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090913200554.GA21695@us.ibm.com>
References: <1252847779.5357.31.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1252847779.5357.31.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [Testing 2.6.31] Don't raise all privs on setuid-root
	file	with fE set
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
Cc: Casey Schaufler <casey@schaufler-ca.com>, ltp-list <ltp-list@lists.sf.net>, James Morris <jmorris@namei.org>

Quoting Subrata Modak (subrata@linux.vnet.ibm.com):
> Hi Serge,
> 
> Is there any requirement to adjust LTP Filecaps tests against the
> backdrop of Filecaps changes in 2.6.31 kernel, documented here:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=b5f22a59c0356655a501190959db9f7f5dd07e3f,
> 
> Regards--
> Subrata

No, coexistence of suid-root and file capabilities are not currently
tested.

-serge

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
