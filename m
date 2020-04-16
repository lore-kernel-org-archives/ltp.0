From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 16 Apr 2020 16:19:09 +0200
Subject: [LTP] [PATCH v4 2/2] net/route: Add netlink based route change
 gw/dest tests
In-Reply-To: <b7673e46-60de-9039-5179-3d96c0b9a538@oracle.com>
References: <20200414152412.8278-1-pvorel@suse.cz>
 <20200414152412.8278-3-pvorel@suse.cz>
 <b7673e46-60de-9039-5179-3d96c0b9a538@oracle.com>
Message-ID: <20200416141909.GA16790@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > +++ b/runtest/net_stress.route
> > @@ -2,11 +2,15 @@
> >  route4-change-dst route-change-dst.sh
> >  route4-change-gw route-change-gw.sh
> >  route4-change-if route-change-if.sh
> > +route4-change-netlink-dst route-change-netlink-dst.sh
> > +route4-change-netlink-gw route-change-netlink-gw.sh -g
> >  route4-redirect route4-redirect
> >  route4-rmmod route4-rmmod

> >  route6-change-dst route-change-dst.sh -6
> >  route6-change-gw route-change-gw.sh -6
> >  route6-change-if route-change-if.sh -6
> > +route6-change-netlink-dst route-change-netlink-dst.sh
> > +route6-change-netlink-gw route-change-netlink-gw.sh -g

> "-6" option?
Thanks!
+ -g should not be there (first I thought I'd have a single script).

> > +++ b/testcases/network/stress/route/route-change-netlink.c
...
> > +#define IP_ADDR_DELIMITER '^'

> Why not to use more obvious delimiter, comma?
+1
BTW going to use IP_ADDR_DELIM (shorter name).

...
> > +struct ip_addr {
> > +	char ip[INET6_ADDRSTRLEN];

> What about adding 'struct addrinfo' here, and use it instead of ip
> string manipulation during the test?
Hm, probably good idea.
String manipulation is needed for creating destination (char dst[INET6_ADDRSTRLEN]).
But that should be done during setup as well => would it be better to have also
struct ip_addr *dst?

I separated number if IP from number of loops, so one can have really big loop
to stress system without requiring a lot of memory.

...
> > +int save_ip(struct ip_addr **list, char *item)
> > +{
> > +	int len = 0;
> > +
> > +	while ((item = strtok(item, CHR2STR(IP_ADDR_DELIMITER))) != NULL) {
> > +		save_ip_str(list, item);
> > +		item = NULL;
> > +		len++;
> > +	}
> > +
> > +	return len;
> > +}
> > +

> It would be better to pass a callback (save_ip_str or save_iface_str), these
> two functions are almost identical.
+1

...
> > +static void send_udp(char *local, char *remote)
> > +{
> > +	fd = SAFE_SOCKET(family, SOCK_DGRAM, IPPROTO_UDP);
> > +
> > +	struct addrinfo hints;
> > +	memset(&hints, 0, sizeof(struct addrinfo));
> > +	hints.ai_family = family;
> > +	hints.ai_socktype = SOCK_DGRAM;
> > +	hints.ai_flags = 0;
> > +	hints.ai_protocol = 0;
> > +	hints.ai_addr = INADDR_ANY;

> It seems this block can be moved to setup, socket() and hints.
+1

> > +
> > +	tst_setup_addrinfo(local, NULL, &hints, &lhost_addrinfo);

> lhost_addrinfo - is it used?
No, it's not, thanks. Yes, it does not make even sense, as code is for client.


Kind regards,
Petr
