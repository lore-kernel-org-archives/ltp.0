Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Q7SC6-0003hV-7x
	for ltp-list@lists.sourceforge.net; Wed, 06 Apr 2011 12:50:46 +0000
Date: Wed, 6 Apr 2011 15:14:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110406131428.GC6652@saboteur.suse.cz>
References: <26c7134d7a0855a4bd8a5f73e7dfc8088115f9d2.1301695094.git.aelder@sgi.com>
	<fd62b40430e6b1c99c8c1495fbc2d17ce2f959b0.1301695094.git.aelder@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fd62b40430e6b1c99c8c1495fbc2d17ce2f959b0.1301695094.git.aelder@sgi.com>
Subject: Re: [LTP] [PATCH 2/6] ltp: move type definitions up in "doio.c"
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
To: Alex Elder <aelder@sgi.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +struct syscall_info {
> +	char		*sy_name;
> +	int		sy_type;
> +	struct status	*(*sy_syscall)();
> +	int		(*sy_buffer)();
> +	char		*(*sy_format)();
> +	int		sy_flags;
> +	int		sy_bits;
> +};

Ideally these callbacks should have defined their parameters too.
Otherwise the compiler can't check if we passed somehow correct
parametetrs. Somethink like (*fn)(int, void*, char); should be enough.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
