Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZMzF3-0005Qo-CQ
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2015 14:00:25 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZMzF2-0004xu-8b
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2015 14:00:25 +0000
Date: Wed, 5 Aug 2015 16:00:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150805140001.GA821@rei.suse.de>
References: <55A680FC.2010807@oracle.com>
	<1437024647-2066-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1437024647-2066-1-git-send-email-zenglg.jy@cn.fujitsu.com>
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
> +int safe_bind(const char *file, const int lineno, void (cleanup_fn)(void),
> +	      int socket, const struct sockaddr *address,
> +	      socklen_t address_len)
> +{
> +	int err, ret, i;
> +
> +	for (i = 0; i < 30; i++) {
> +		ret = bind(socket, address, address_len);
> +		err = errno;
> +
> +		if (!ret)
> +			return 0;
> +
> +		if (err != EADDRINUSE) {
> +			tst_brkm(TBROK | TERRNO, cleanup_fn,
> +				 "%s:%d: bind(%d, %p, %d) failed", file, lineno,
> +				 socket, address, address_len);

I think that it would be a bit nicer if we created a helper to translate
the socket structure to it's string representation (and use it whenever
we deal with struct sockaddr passed from user). We would have to switch
on sa_family and then print either ip address or path (for unix
sockets), etc. But that would get us bind(8, '127.0.0.1:1024', ...)
failed instead of the raw pointer to the structure which is kind of
useless.

> +		}
> +
> +		tst_resm(TINFO, "bind('%p') failed with %s, try %2i...",
> +			 address, tst_strerrno(err), i+1);

                         Hmm, why do we do tst_strerno(err) here when
			 the only value for errno can be EADDRINUSE
			 (since we exit with tst_brkm() otherwise)
			 Why not just hardcode EADDRINUSE to the
			 message?

> +		if (i == 0 && err == EADDRINUSE)
> +			tst_resm(TINFO, "The given address is already in use.");

                         This message is not really useful because we
			 allready printed that bind failed with
			 EADDRINUSE with the tst_resm above.

> +		usleep(1000000);

                We can use sleep(1) instead now.

> +	}
> +
> +	tst_brkm(TBROK | TERRNO, cleanup_fn,
> +		 "%s:%d: Failed to bind(%d, %p, %d) after 30 retries",
> +		 file, lineno, socket, address, address_len);
> +}
> +
> +int safe_listen(const char *file, const int lineno, void (cleanup_fn)(void),
> +		int socket, int backlog)
> +{
> +	int rval;
> +
> +	rval = listen(socket, backlog);
> +
> +	if (rval < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup_fn,
> +			 "%s:%d: listen(%d, %d) failed", file, lineno, socket,
> +			 backlog);
> +	}
> +
> +	return rval;
> +}
> +
> +int safe_connect(const char *file, const int lineno, void (cleanup_fn)(void),
> +		 int sockfd, const struct sockaddr *addr, socklen_t addrlen)
> +{
> +	int rval;
> +
> +	rval = connect(sockfd, addr, addrlen);
> +
> +	if (rval < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup_fn,
> +			 "%s:%d: connect(%d, %p, %d) failed", file, lineno,
> +			 sockfd, addr, addrlen);
> +	}
> +
> +	return rval;
> +}
> +
> +int safe_getsockname(const char *file, const int lineno,
> +		     void (cleanup_fn)(void), int sockfd, struct sockaddr *addr,
> +		     socklen_t *addrlen)
> +{
> +	int rval;
> +
> +	rval = getsockname(sockfd, addr, addrlen);
> +
> +	if (rval < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup_fn,
> +			 "%s:%d: getsockname(%d, %p, %p) failed", file, lineno,
> +			 sockfd, addr, addrlen);
> +	}
> +
> +	return rval;
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
