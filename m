Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1O5PbP-0003CN-2L
	for ltp-list@lists.sourceforge.net; Fri, 23 Apr 2010 20:35:55 +0000
Date: Fri, 23 Apr 2010 22:43:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100423204312.GA26503@saboteur.suse.cz>
References: <20100402185908.GA478@saboteur.suse.cz>
	<g2x364299f41004021212z6e85833ybccad62e6780ec26@mail.gmail.com>
	<20100419184131.GA20776@saboteur.suse.cz>
	<20100423125351.GA24523@saboteur.suse.cz>
	<n2s364299f41004231253offfe856amfa09260ba50cf18b@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <n2s364299f41004231253offfe856amfa09260ba50cf18b@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix fs_perms tests
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

Hi!
> 
> 2. MAX_PATH should be PATHNAME_MAX.
>

Hmm, could not find PATHNAME_MAX in my /usr/include/ and it seems that posix
says that this should be determined by fpathconf(). IMHO it is reasonable to
assume that path to sh is shorter than 1023 bytes as it is defined now.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
