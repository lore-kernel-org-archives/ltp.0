Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZNJnT-00069T-UK
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2015 11:57:19 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZNJnP-0008MX-Hm
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2015 11:57:19 +0000
Date: Thu, 6 Aug 2015 13:56:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150806115652.GA12066@rei.suse.de>
References: <55A680FC.2010807@oracle.com>
	<1437024647-2066-1-git-send-email-zenglg.jy@cn.fujitsu.com>
	<20150805140001.GA821@rei.suse.de> <55C236CB.8060508@oracle.com>
	<1438858276.11271.20.camel@G08FNSTD140232>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1438858276.11271.20.camel@G08FNSTD140232>
Subject: Re: [LTP] [PATCH v5 01/11] SAFE_MACROS: Add socket(), bind(),
 listen(), connect() and getsockname()
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > >> +int safe_bind(const char *file, const int lineno, void (cleanup_fn)(void),
> > >> +	      int socket, const struct sockaddr *address,
> > >> +	      socklen_t address_len)
> > >> +{
> > >> +	int err, ret, i;
> > >> +
> > >> +	for (i = 0; i < 30; i++) {
> > 30 sec still may not be enough, I would set it to 2 minutes.
> 
> To be honest, I am not sure how long we should wait.
> 2 minutes is OK for me.

That depends on how long can TCP connection stay in the TIME_WAIT state,
googling around suggests that it's 1 minute for Linux. So IMHO anything
greater than 1 minute should do. So 2 minutes looks like good choice to
me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
