From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 4 Apr 2017 16:41:23 +0200
Subject: [LTP] [RFC PATCH v2 2/3] network: Add tool for setup IP
	variables
In-Reply-To: <ae28eabb-494f-ef35-d983-e0685f98deaa@oracle.com>
References: <20170403071428.11754-1-pvorel@suse.cz>
 <20170403071428.11754-3-pvorel@suse.cz>
 <7cdee769-8b90-a7d4-bb82-09cadce47f46@oracle.com>
 <20170403123118.4p2xuzwzq34s46rv@x230>
 <ae28eabb-494f-ef35-d983-e0685f98deaa@oracle.com>
Message-ID: <20170404144123.dhupzdybbnuersbg@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> No, we shouldn't do that, at least using such prefixes.  The much safer
> approach is to
> use the private address ranges.

> For IPv6 it's a unique local address, i.e. fd00::/8 prefix. We could
> stick with default
> one and use another one (may be random) in case we got overlap with the
> predefined address, e.g.: "fd00:f00" and "fdaa:f00" (the same approach
> as yours).
OK, I'll implement in v4:
fd00::/8 as IPv6 unused network with fd00:f00::/8 and fdaa:f00::/8 as an alternatives.

> And for IPv4, e.g. 10.x/10.(x + 128).
Right.

> May be I misunderstood the 'prefix' variable there. If, for example,
> 10.20.0.1/22 and 10.20.1.1/22 would result into 10.20 prefix, then it's
> fine,
> network variable is "10.20" and host variables are "0.1" and "1.1".
No, so far it really requires prefix to be (0, 32), divisible 8 (IPv4) resp. (0, 128)
divisible by 16.
I'll implement it as rounded up by 8 resp. 16 (e.g.: 10.20.1.1/22 => "prefix": 24,
fd00:f00::/5 => "prefix": 8)


Kind regards,
Petr
