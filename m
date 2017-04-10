From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 10 Apr 2017 15:09:49 +0200
Subject: [LTP] [RFC PATCH v4 2/3] network: Add tool for setup IP
	variables
In-Reply-To: <ca79cf52-c655-17d6-9a53-34e6a4a0f2fb@oracle.com>
References: <20170405204418.3240-1-pvorel@suse.cz>
 <20170405204418.3240-3-pvorel@suse.cz>
 <ca79cf52-c655-17d6-9a53-34e6a4a0f2fb@oracle.com>
Message-ID: <20170410130948.chpqkbmuu6gtzb45@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> On 04/05/2017 11:44 PM, Petr Vorel wrote:
> > ...
> > +static int get_ipv4_info(struct in_addr *lIp, struct in_addr *rIp, int prefix)
> > +{
> > +	vars.ipv4_network = get_ipv4_network(lIp->s_addr, prefix,
> > +		FLAG_GET_NETWORK);
> > +	if (strcmp(vars.ipv4_network, get_ipv4_network(rIp->s_addr, prefix,
> > +			FLAG_GET_NETWORK))) {
> > +		fprintf(stderr, "Please use the same network for both IP addresses\n");
> > +		return -1;

> Thinking more about this, we shouldn't put such restrictions on
> network configuration as well. There could be more complex setup
> involving routers, NAT, etc.
Well, if we want to keep IPV{4,6}_NETWORK and
IPV{4,6}_NET_REV variables (see my reply today [1]), we'd have to somehow solve scenarios
with completely different addresses which have nothing in common (e.g. 10.2.0.1/22
10.2.1.1/22 => IPV4_NETWORK=10.2 - that's ok, but 10.2.0.1/24 and 192.168.1.2/24 will lead
to empty IPV4_NETWORK).
I'd try to avoid using {L,R}HOST_IPV{4,6}_NETWORK.

[1] http://lists.linux.it/pipermail/ltp/2017-April/004268.html


Kind regards,
Petr

