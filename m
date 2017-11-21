From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 21 Nov 2017 12:51:35 +0100
Subject: [LTP] [RFC PATCH 3/4] lapi: Add lapi/in.h with definition moved
 from netstress.c
In-Reply-To: <20171109160528.ceuxteessmjfbiy7@dell5510>
References: <20171109113947.24609-1-pvorel@suse.cz>
 <20171109113947.24609-4-pvorel@suse.cz>
 <20171109151837.GC30136@rei>
 <20171109160528.ceuxteessmjfbiy7@dell5510>
Message-ID: <20171121115135.f5zjyrzxgid5y2cu@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > Maybe we should rename this file to netinet_in.h or create netinet
> > directory in lapi. Including just lapi/in.h is a bit confusing.
> Is it because in.h is also in bits/ directory (not only in linux and some glibc directory)?
> /usr/include/bits/in.h
> /usr/include/netinet/in.h
> /usr/include/linux/in.h

> As the same we have with lapi/tcp.h (in both kernel and glibc)...
> /usr/include/netinet/tcp.h
> /usr/include/linux/tcp.h

> And I'm for directory.
Actually I'd be for just plain "in.h" as other fileas in lapi/ directory don't prefix
anything, aren't in any special directory.
But if you really don't like that, I'll put it into netinet_in.h.


Kind regards,
Petr
