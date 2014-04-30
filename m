Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WfVNh-00074Z-Bm
	for ltp-list@lists.sourceforge.net; Wed, 30 Apr 2014 14:21:05 +0000
Date: Wed, 30 Apr 2014 16:20:09 +0200
From: chrubis@suse.cz
Message-ID: <20140430142009.GB21327@rei>
References: <4506ACC2AE90484D87F9A883BA36C21C54931E@LCHQEX03.lancope.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4506ACC2AE90484D87F9A883BA36C21C54931E@LCHQEX03.lancope.local>
Subject: Re: [LTP] Suggested patch to recvfrom / recvmsg tests
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
To: Joseph Beckenbach <jbeckenbach@lancope.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> A tweak to improve recvfrom01.c and recvmsg01.c --
> there's a loop in the child server process which walks all available fds and attempts to read those where the relevant fd_set bit is set.
> Sadly, when there's more file descriptors available than bits in the fd_set, this loop will happily walk off the end of the fd_set, clearing bits along the way.
> This leads to intermittent segfaults and thus false positives in these two tests.

What arch is this? On my system both getfdsetsize() and FD_SETSIZE are
set to 1024?

> =====
> diff --git a/testcases/kernel/syscalls/recvfrom/recvfrom01.c b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
> index b5ab4a0..5e68d98 100644
> --- a/testcases/kernel/syscalls/recvfrom/recvfrom01.c
> +++ b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
> @@ -319,7 +319,7 @@ void do_child()
>  			/* send something back */
>  			(void)write(newfd, "hoser\n", 6);
>  		}
> -		for (fd = 0; fd < nfds; ++fd)
> +		for (fd = 0; fd < nfds && fd < FD_SETSIZE; ++fd)
>  			if (fd != sfd && FD_ISSET(fd, &rfds)) {
>  				cc = read(fd, buf, sizeof(buf));
>  				if (cc == 0 || (cc < 0 && errno != EINTR)) {

What about we set nfds to sfd + 1 and for each child we accept we set
nfds to max(nfds, newfd+1)?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
