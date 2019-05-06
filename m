From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 6 May 2019 17:32:20 +0200
Subject: [LTP] [PATCH 1/1] net/broken_ip: Rewrite into new API
In-Reply-To: <0c7a3010-d7d6-1d83-0548-148adb55b2cc@oracle.com>
References: <20190427053929.7372-1-pvorel@suse.cz>
 <5cff91e0-c566-27c3-95dd-39dd4e2b6d0e@oracle.com>
 <20190502114459.GA32460@dell5510>
 <0c7a3010-d7d6-1d83-0548-148adb55b2cc@oracle.com>
Message-ID: <20190506153220.GA21222@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> >> Acked-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> > ...
> >>> +export ICMPV4_DATA_MAXSIZE=1472
> >>> +export ICMPV6_DATA_MAXSIZE=1452

> >> Since these variables are in the library, may be it would be better to tune
> >> them depending on an MTU of the tests interfaces?
> > Good idea. 1472 and 1452 are based on MTU = 1500 (IPv4: 1500 - 20 bytes for IPv4 header
> > - 8 bytes for ICMP header; IPv6: 1500 - 40 bytes for IPv6 header - 8 bytes for ICMP header),
> > which looks to me as the default for netns NICs and ethernet and wifi NICs,
> > but we should avoid failures when different MTU used.
> > I propose merging this version and add MTU detection support later.


> OK. Perhaps we should rename them to indicate that they relate to ns-icmpv_sender,
> because the maximum icmp data size is 65535 - headers, not those values.
True. How about this:

export NS_ICMPV4_SENDER_DATA_MAXSIZE=1472
export NS_ICMPV6_SENDER_DATA_MAXSIZE=1452

Kind regards,
Petr
