From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 4 Apr 2018 11:57:28 +0200
Subject: [LTP] [PATCH] sctp/sctp_big_chunk.c: Fix compiler error
In-Reply-To: <1522831939-31257-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1522831939-31257-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180404095728.u7ovuhxknd3x2yir@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

> On old distros(e.g. RHEL5), Compilation failed because of redefinitions
> from linux/sctp.h(including linux/in.h) and netinet/in.h, as below:
> ----------------------------------------------------------------------
> In file included from /usr/include/linux/sctp.h:54,
>                  from ../../../include/lapi/sctp.h:22,
>                  from sctp_big_chunk.c:35:
> /usr/include/linux/in.h:26: error: redeclaration of enumerator ‘IPPROTO_IP’
> /usr/include/netinet/in.h:33: error: previous definition of ‘IPPROTO_IP’ was here
And obviously we need to find a way, how to check these old distros. IMHO it's not
feasible with travis, it'd be great to add another CI (docker based) to test these
distros.


Kind regards,
Petr
