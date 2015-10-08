From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 8 Oct 2015 09:34:21 +0800
Subject: [LTP] [PATCH v7 2/7] SAFE_MACROS: Add socket(), bind(), listen(),
 connect() and getsockname()
In-Reply-To: <20151007130741.GC2608@rei.suse.cz>
References: <1444214869-3597-1-git-send-email-zenglg.jy@cn.fujitsu.com>
 <1444214869-3597-2-git-send-email-zenglg.jy@cn.fujitsu.com>
 <20151007130741.GC2608@rei.suse.cz>
Message-ID: <1444268061.11021.4.camel@G08FNSTD140232>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Wed, 2015-10-07 at 15:07 +0200, Cyril Hrubis wrote:
> Hi!
> > +char *ltp_sock_addr(const struct sockaddr *sa, socklen_t salen);
> > +#define LTP_SOCK_ADDR(sa, salen)	ltp_sock_addr(sa, salen)
> 
> Why do we define the LTP_SOCK_ADDR() as a macro?
> 

Indeed, it is not necessary.

> As far as I can see it's does not add any value over calling the
> function.
> 
> Also we tend to prefix LTP internal funciton with tst_ rather than ltp_
> but that is minor.

OK, I got it.

Thanks for your review.

Best regards,
Zeng
> 


