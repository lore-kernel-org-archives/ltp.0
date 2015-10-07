From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 7 Oct 2015 15:07:41 +0200
Subject: [LTP] [PATCH v7 2/7] SAFE_MACROS: Add socket(), bind(), listen(),
 connect() and getsockname()
In-Reply-To: <1444214869-3597-2-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <1444214869-3597-1-git-send-email-zenglg.jy@cn.fujitsu.com>
 <1444214869-3597-2-git-send-email-zenglg.jy@cn.fujitsu.com>
Message-ID: <20151007130741.GC2608@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +char *ltp_sock_addr(const struct sockaddr *sa, socklen_t salen);
> +#define LTP_SOCK_ADDR(sa, salen)	ltp_sock_addr(sa, salen)

Why do we define the LTP_SOCK_ADDR() as a macro?

As far as I can see it's does not add any value over calling the
function.

Also we tend to prefix LTP internal funciton with tst_ rather than ltp_
but that is minor.

-- 
Cyril Hrubis
chrubis@suse.cz
