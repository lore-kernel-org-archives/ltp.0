Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapierfilter@gmail.com>) id 1PaxQ0-0000q5-SS
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 21:30:48 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PaxPz-0001Xx-Q6
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 21:30:48 +0000
Received: by fxm17 with SMTP id 17so15604747fxm.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 Jan 2011 13:30:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20B25B11-E8BD-45A7-AAD5-209D62BC6274@gmail.com>
References: <4D259E4A.2050704@cn.fujitsu.com>
	<AANLkTinX9M3EsBxSDsVy56iKqskSWKQE4vMhXy0kcxNG@mail.gmail.com>
	<20B25B11-E8BD-45A7-AAD5-209D62BC6274@gmail.com>
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 6 Jan 2011 16:30:21 -0500
Message-ID: <AANLkTi=L8Vai5_=fn0psJeovura_Y=VjdN28ufiqBiiA@mail.gmail.com>
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
Cc: ltp-list@lists.sourceforge.net

On Thu, Jan 6, 2011 at 2:35 PM, Garrett Cooper wrote:
> A really bad merge (I posted a reply to it a while ago in the archives).

is there a way for us to manage the git hooks ?  we could have them
reject trivial merge commits (ones that should be fast forwards), and
commits with merge cruft in it ...
-mike

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
