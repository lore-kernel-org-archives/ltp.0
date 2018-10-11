From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Oct 2018 00:10:14 +0200
Subject: [LTP] [PATCH 0/5] Fixes for DHCP tests
In-Reply-To: <20181003153756.3825-1-pvorel@suse.cz>
References: <20181003153756.3825-1-pvorel@suse.cz>
Message-ID: <20181011221014.GA25242@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > Petr Vorel (5):
> >   net/dhcp: Add support for wicked
> >   net/dhcp: Disable DNS for dnsmasq
> >   net/dhcp: Print client and server versions
> >   net/dhcp: Pass lease file location to dhcpd via -lf
> >   net/dhcp: TBROK when dnsmasq does not start

> The patch-set looks good, acked. Thanks Petr!
Thanks for your review, pushed with your ack.
I also added one more patch-set for DHCP ("DHCP tests and AppArmor improvements")


Kind regards,
Petr
