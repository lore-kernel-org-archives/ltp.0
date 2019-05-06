From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 6 May 2019 21:57:03 +0200
Subject: [LTP] [PATCH 1/1] net/broken_ip: Rewrite into new API
In-Reply-To: <25305d65-d8ab-f0fa-dd39-defc093d6823@oracle.com>
References: <20190427053929.7372-1-pvorel@suse.cz>
 <5cff91e0-c566-27c3-95dd-39dd4e2b6d0e@oracle.com>
 <20190502114459.GA32460@dell5510>
 <0c7a3010-d7d6-1d83-0548-148adb55b2cc@oracle.com>
 <20190506153220.GA21222@dell5510>
 <25305d65-d8ab-f0fa-dd39-defc093d6823@oracle.com>
Message-ID: <20190506195703.GA11266@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> >> OK. Perhaps we should rename them to indicate that they relate to ns-icmpv_sender,
> >> because the maximum icmp data size is 65535 - headers, not those values.
> > True. How about this:

> > export NS_ICMPV4_SENDER_DATA_MAXSIZE=1472
> > export NS_ICMPV6_SENDER_DATA_MAXSIZE=1452

> Agree.
Thanks, merged!

Kind regards,
Petr
