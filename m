From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 2 May 2019 13:44:59 +0200
Subject: [LTP] [PATCH 1/1] net/broken_ip: Rewrite into new API
In-Reply-To: <5cff91e0-c566-27c3-95dd-39dd4e2b6d0e@oracle.com>
References: <20190427053929.7372-1-pvorel@suse.cz>
 <5cff91e0-c566-27c3-95dd-39dd4e2b6d0e@oracle.com>
Message-ID: <20190502114459.GA32460@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Acked-by: Alexey Kodanev <alexey.kodanev@oracle.com>
...
> > +export ICMPV4_DATA_MAXSIZE=1472
> > +export ICMPV6_DATA_MAXSIZE=1452

> Since these variables are in the library, may be it would be better to tune
> them depending on an MTU of the tests interfaces?
Good idea. 1472 and 1452 are based on MTU = 1500 (IPv4: 1500 - 20 bytes for IPv4 header
- 8 bytes for ICMP header; IPv6: 1500 - 40 bytes for IPv6 header - 8 bytes for ICMP header),
which looks to me as the default for netns NICs and ethernet and wifi NICs,
but we should avoid failures when different MTU used.
I propose merging this version and add MTU detection support later.

I guess we don't need to check -s values passed to tst_icmp() (I guess nobody
set MTU < 1000, although it's not forbidden for IPv4). But I'd add this check
also into ns-icmpv[46]_sender.c.

+ off course other cleanup like merging ns-icmpv[46]_sender.c into single code would be nice,
but first I want to finish route rewriting.

> Also we can send more with fragmentation, but I guess ns-icmpv doesn't
> have proper support...
Do you mean to send packet big enough to have fragmentation on lhost?
+ setsockopt IP_PMTUDISC_DONT?

Kind regards,
Petr
