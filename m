From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 9 Aug 2019 18:02:54 +0200
Subject: [LTP] [PATCH v3 4/5] network/route: Rewrite route-change-gw
 into new API
In-Reply-To: <4a9a229c-b00a-5427-0760-9312df90e5af@oracle.com>
References: <20190725111027.18716-1-pvorel@suse.cz>
 <20190725111027.18716-5-pvorel@suse.cz>
 <89188a02-2213-bea7-5273-d0077de5878e@oracle.com>
 <20190806195502.GA11768@dell5510>
 <4a9a229c-b00a-5427-0760-9312df90e5af@oracle.com>
Message-ID: <20190809160254.GA342@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> >>> +	local gw="$(tst_ipaddr_un 1 $(($1 + 1)))"

> >> We should keep $(($1 + 1)) within the valid range except already added IP address
> >> ($lhost), i.e. for IPv4 the range is 2..254 for host id:

> >>     local gw="$(tst_ipaddr_un 1 $(($1 % 253 + 2)))"

> >> Either we could limit the value here or in the tst_ipaddr_un(). Looks like
> >> route-change-if needs a similar fix for net id?
> > Good point (sorry to keep octet/hextet overflow related errors).
> > Although it'd be simpler to fix it in the code, I'd prefer to have this support
> > in tst_ipaddr_un(). Diff below adds -l MIN_HOST_ID (I'll post it as a part of v3),
> > do we want to lower also max host id?

> It can only be "max host id" option since we already have this variable in the
> function, and in the test setup, we could assign "lhost" variable with the max
> value:

>   lhost="$(tst_ipaddr_un 1 $max_host_id)"

I'll have to implement min value as well, because we have for non-counter mode
(e.g tst_ipaddr_un $net_id $host_id) 0 as well, so it will break for invalid
gateway 10.23.1.0. I wanted to avoid -c mode for these route tests.

I guess <0-254> for max host ID for this mode was good idea, but IMHO it should
be: <0-255> (to allow both network address and broadcast address), and allow to
have minimize both min and max. So for case of valid address it'd would be:
tst_ipaddr_un -l 1 -m 254 $net_id $host_id

Other could be to have range for this mode default suitable for hosts (<1..254>)
as we have it for -c mode. Getting network would be:

tst_ipaddr_un -n $net_id # instead of tst_ipaddr_un $net_id 0

Getting broadcast would be:

tst_ipaddr_un -b $net_id # currently not possible at all with tst_ipaddr_un

This second proposal looks more usable to me, although -b and -n aren't obvious
(long getopts would be better, but I think it's better to avoid them).

+ I'd still keep proposed -m max_host_id, so we could use tst_ipaddr_un $net_id 254
for route and tst_ipaddr_un -m 253 $net_id $1 for hosts.

Kind regards,
Petr
