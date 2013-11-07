Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VeMUg-00011a-Cq
	for ltp-list@lists.sourceforge.net; Thu, 07 Nov 2013 10:07:18 +0000
Date: Thu, 7 Nov 2013 11:06:51 +0100
From: chrubis@suse.cz
Message-ID: <20131107100651.GA27699@rei>
References: <1382969894-9814-1-git-send-email-alexey.kodanev@oracle.com>
	<20131106150508.GB29329@rei> <527B5E5B.9040709@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <527B5E5B.9040709@oracle.com>
Subject: Re: [LTP] [PATCH] network: tcp_fastopen: add TCP Fast Open test
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
To: alexey.kodanev@oracle.com
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> >> +
> >> +/* test options */
> >> +static char *narg, *Narg, *qarg, *barg, *Barg,
> >> +	*rarg, *Rarg, *aarg, *Targ;
> >> +static int nflag, Nflag, qflag, bflag, Bflag, dflag,
> >> +	rflag, Rflag, aflag, Hflag, Tflag, gflag;
> > There is no reason to use these flags. The option pointers are set to
> > NULL (global variables). So that you can use:
> >
> > 	if (arg) {
> > 		...
> > 	}
> >
> > In the check_opt() functions.
> OK
> >> +	{"o", &tcp_api, NULL},
> > This should be rather named as use_fastopen beacuse as it is, the name
> > is misleading (I was wondering if there were some changes in the TCP
> > userspace API for a while).
> There are changes in user-space TCP API: we don't use normal TCP system 
> calls: connect(), send(), write(). Instead making use of sendmsg(), 
> sendto() which are normally used in UDP. Some additional flags were 
> introduced.

Still I think it would be better to use 'fastopen' string in the opt
name.

> >> +int sock_recv_poll(int *fd, char *buf, const int *buf_size, int *offset)
> >> +{
> >> +	struct pollfd pfd;
> >> +	pfd.fd = *fd;
> >> +	pfd.events = POLLIN;
> >> +	int len = -1;
> >> +	while (1) {
> >> +		errno = 0;
> >> +		int ret = poll(&pfd, 1, wait_timeout / 1000);
> >> +		if (ret == -1) {
> >> +			if (errno == EINTR)
> >> +				continue;
> >> +			tst_resm(TFAIL | TERRNO, "poll failed at %s:%d",
> >> +				__FILE__, __LINE__);
> >> +			break;
> >> +		}
> >> +		if (ret == 0) {
> >> +			tst_resm(TFAIL, "msg timeout, sock '%d'", *fd);
> >> +			break;
> >> +		}
> >> +
> >> +		if (ret != 1 || !(pfd.revents & POLLIN))
> >> +			break;
> >> +
> >> +		errno = 0;
> >> +		len = recv(*fd, buf + *offset,
> >> +			*buf_size - *offset, MSG_DONTWAIT);
> >> +
> >> +		if (len == -1 && (errno == EINTR ||
> >> +			errno == EWOULDBLOCK || errno == EAGAIN))
> >> +			continue;
> >> +		else
> >> +			break;
> >> +	}
> >> +
> >> +	if (len == 0)
> >> +		tst_resm(TINFO, "sock was closed '%d'", *fd);
> >> +
> >> +	return len;
> >> +}
> > Now this one seems wrong. Both client and server creates new thread for
> > each connection, which means that this creates bussy loop (which will
> > eventually degrade performance). Why don't you use blocking read() so
> > that each thread waits in read() syscall util data are ready?
> It's not busy loop here, poll() will block. The purpose of the while(1) 
> is to go once more if the poll call was interrupted. I think I need to 
> remove EWOULDBLOCK and EGAIN errors checking as poll doesn't have their. 
> I didn't use read with block because I wanted some sort of block wait 
> timeout, which poll has.

Ah my bad, I see it now.

> > Can we default to localhost, would that work?
> It will work, but we won't see some significant performance results.

Ok.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
