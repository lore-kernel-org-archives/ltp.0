From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 9 Nov 2017 17:05:28 +0100
Subject: [LTP] [RFC PATCH 3/4] lapi: Add lapi/in.h with definition moved
 from netstress.c
In-Reply-To: <20171109151837.GC30136@rei>
References: <20171109113947.24609-1-pvorel@suse.cz>
 <20171109113947.24609-4-pvorel@suse.cz>
 <20171109151837.GC30136@rei>
Message-ID: <20171109160528.ceuxteessmjfbiy7@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Maybe we should rename this file to netinet_in.h or create netinet
> directory in lapi. Including just lapi/in.h is a bit confusing.
Is it because in.h is also in bits/ directory (not only in linux and some glibc directory)?
/usr/include/bits/in.h
/usr/include/netinet/in.h
/usr/include/linux/in.h

As the same we have with lapi/tcp.h (in both kernel and glibc)...
/usr/include/netinet/tcp.h
/usr/include/linux/tcp.h

And I'm for directory.

Kind regards,
Petr
