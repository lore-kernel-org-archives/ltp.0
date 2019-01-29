From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Jan 2019 19:18:56 +0100
Subject: [LTP] [RFC PATCH 0/2] Rewrite route stress tests into C
In-Reply-To: <cd8be415-a4e0-06ac-997a-4195b396fa47@oracle.com>
References: <20190124161735.19609-1-pvorel@suse.cz>
 <cd8be415-a4e0-06ac-997a-4195b396fa47@oracle.com>
Message-ID: <20190129181856.GA17728@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

thanks for your comments.

> > Some issues:
> > * The test is only on lhost, no attempt to set iface on rhost and check
> > connection. The only check is done via error of libnl used. It's
> > questionable whether this way is good enough.

> True, it would be better to verify that the route is working and usable.

> At least, we could open a socket and send something using the route
> (ns-udpsender way)...
OK, I'll try at least this. And if it's not suitable enough, I'll have to get
back to shell (or I'd have to implement tst_rhost_run() in C).

> > If we want to have established connection, it'd be better to get back to
> > shell testing [1], just replace netstress to new tool (I'd prefer not
> > use ns-udpsender).> 
> > * rtnetlink is used via libnl, which is very lazy approach.
> > As subject of testing is route testing and not rtnetlink testing I
> > didn't reimplement rtnetlink socket communication from scratch, but I
> > guess I should. Also using link caching (used by functions from libnl-cli)
> > might not be a good idea (maybe using libmnl or only libnl-route would
> > be better if using library).

> And libmnl has an example:
> https://git.netfilter.org/libmnl/tree/examples/rtnl/rtnl-route-add.c
I noticed this as well, I'll use libmnl.

Kind regards,
Petr
