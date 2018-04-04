From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 4 Apr 2018 11:45:56 +0200
Subject: [LTP] [PATCH] sctp/sctp_big_chunk.c: Fix compiler error
In-Reply-To: <1522831939-31257-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1522831939-31257-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180404094556.2eahiw2z4sz3y3r5@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Xiao,

> On old distros(e.g. RHEL5), Compilation failed because of redefinitions
> from linux/sctp.h(including linux/in.h) and netinet/in.h, as below:
> ----------------------------------------------------------------------
> In file included from /usr/include/linux/sctp.h:54,
>                  from ../../../include/lapi/sctp.h:22,
>                  from sctp_big_chunk.c:35:
> /usr/include/linux/in.h:26: error: redeclaration of enumerator ‘IPPROTO_IP’
> /usr/include/netinet/in.h:33: error: previous definition of ‘IPPROTO_IP’ was here
> ...
> ----------------------------------------------------------------------

> 1) There was a existed netinet/sctp.h based on lksctp-tools-devel package
>    in LTP, so we used netinet/sctp.h to fix it as the sctp tests did.
> 2) We removed lapi/sctp.h and duplicated SOL_SCTP in lapi/socket.h.

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---

Thank you for the fix. I'd prefer to remove our utils/sctp/include/netinet/sctp.h (I don't
think it's a good idea to copy headers into source code) and fix include/lapi/sctp.h
header trying first include <netinet/sctp.h> (with autotools check) and then
<linux/sctp.h> if the previous is not available, as Alexey suggested [1].

What do you think, Alexey?


Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2018-March/007517.html
