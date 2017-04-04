From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 4 Apr 2017 13:50:24 +0300
Subject: [LTP] [RFC PATCH v2 2/3] network: Add tool for setup IP
	variables
In-Reply-To: <20170403123118.4p2xuzwzq34s46rv@x230>
References: <20170403071428.11754-1-pvorel@suse.cz>
 <20170403071428.11754-3-pvorel@suse.cz>
 <7cdee769-8b90-a7d4-bb82-09cadce47f46@oracle.com>
 <20170403123118.4p2xuzwzq34s46rv@x230>
Message-ID: <ae28eabb-494f-ef35-d983-e0685f98deaa@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03.04.2017 15:31, Petr Vorel wrote:
> ...
>> Hmm, what are '0xff0d' and '0xaa10' prefixes? The first one seems to be a
>> multicast group address...
> These are really random values, an easy way to get valid but unused value. Do you want
> different approach?
Hi Petr,

No, we shouldn't do that, at least using such prefixes.  The much safer
approach is to
use the private address ranges.

For IPv6 it's a unique local address, i.e. fd00::/8 prefix. We could
stick with default
one and use another one (may be random) in case we got overlap with the
predefined address, e.g.: "fd00:f00" and "fdaa:f00" (the same approach
as yours).

And for IPv4, e.g. 10.x/10.(x + 128).

> ...
>> And why this limitation is needed?
> I did it just to simplify the implementation.  IMHO both IPv4 and IPv6 require two nodes
> on the same physical network have the same prefix so I didn't consider this as a real
> limitation.
>
> But of course, there could be different prefixes, the smaller would be used as IPV6_NETWORK variable is
> used for both hosts. Do you want me to change it this way?

May be I misunderstood the 'prefix' variable there. If, for example,
10.20.0.1/22 and 10.20.1.1/22 would result into 10.20 prefix, then it's
fine,
network variable is "10.20" and host variables are "0.1" and "1.1".

Thanks,
Alexey

