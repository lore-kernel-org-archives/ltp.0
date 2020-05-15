From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 May 2020 13:56:01 +0200
Subject: [LTP] [PATCH] pty04: Avoid receiving packets from all interfaces
In-Reply-To: <20200515103910.8703-1-rpalethorpe@suse.com>
References: <20200515103910.8703-1-rpalethorpe@suse.com>
Message-ID: <20200515115601.GA6412@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Raw sockets receive all packets from all interfaces as soon as they are
> created. They don't need to be bound to one or more interfaces like I thought.

> This creates the socket with a NULL packet type which appears to be unused in
> the Linux kernel and receives no packets. The protocol is then changed to
> ETH_P_ALL when binding to the netdevice we are interested in.

> I assume it is impossible for a packet to have zero for its packet type. Most
> likely using ETH_P_LOOP would have been OK too, but I suppose that is really
> used by some hardware.

> This also fixes various other problems that have been observed with this
> test. Such as memory allocation failures.
So we have lost a potential CVE reproducer :).

Thanks for the fix.

Kind regards,
Petr
