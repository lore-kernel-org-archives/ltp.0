From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 21 Dec 2016 17:27:48 +0100
Subject: [LTP] [PATCH] network: fix telnet test for running on single
 machine
In-Reply-To: <e6ef2253-fff1-2114-1def-d88cf82df809@oracle.com>
References: <20161219154433.19861-1-pvorel@suse.cz>
 <e6ef2253-fff1-2114-1def-d88cf82df809@oracle.com>
Message-ID: <20161221162748.suos5o54trzjrj2h@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> It seems there are several solutions:
> 1. we could do something similar to ssh/dns/http tests,
>    i.e. start the client side from remote host;
What means "remote host" in this context?

> 2. add $(tst_ipaddr rservice), and in case of netns, it will return
> 127.0.0.1/::1 addresses;
> 3. start those services inside ltp_ns;
No idea, what is the easiest solution. Maybe 2.?


Kind regards,
Petr
