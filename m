Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TqNFI-0003lp-OC
	for ltp-list@lists.sourceforge.net; Wed, 02 Jan 2013 12:16:32 +0000
Date: Wed, 2 Jan 2013 13:16:35 +0100
From: chrubis@suse.cz
Message-ID: <20130102121635.GD12457@rei>
References: <50D15482.4080601@symbio.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50D15482.4080601@symbio.com>
Subject: Re: [LTP] ltplite.sh and tmpdir permissions
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
To: Olli Vertanen <olli.vertanen@symbio.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> A bit confusion feature: runltp adjusts tmpdir permissions to 777, but 
> for some reasons this has been dropped from runltplite.sh. Thus for me, 
> some tests fail when run from ltplite.sh, but succeed when run from runltp.
> 
> Bug or feature or something else?

I would call it a bug. Have you identified a commit that removed such
line, or was it broken since runltplite.sh creation?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Master Java SE, Java EE, Eclipse, Spring, Hibernate, JavaScript, jQuery
and much more. Keep your Java skills current with LearnJavaNow -
200+ hours of step-by-step video tutorials by Java experts.
SALE $49.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122612 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
