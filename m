From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 8 Jun 2017 15:09:38 +0200
Subject: [LTP] [RFC PATCH v6 08/11] lib/test_net.sh: reset_ltp_netspace()
In-Reply-To: <056a189d-c0d0-1dfa-f4a3-76917de949e7@oracle.com>
References: <20170603120022.13415-1-pvorel@suse.cz>
 <20170603120022.13415-9-pvorel@suse.cz>
 <056a189d-c0d0-1dfa-f4a3-76917de949e7@oracle.com>
Message-ID: <20170608130938.csrksavjbyjlrf7m@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Looks like it's not the right place for this function. Is it going to be
> used in tests somehow?

> What about adding it to network.sh with special option?

It's used in testcases/network/stress/route/route4-rmmod (patch [1]) so far, it probably be used
also in testcases/network/stress/route/route6-rmmod.

> > +# Force to reset netns.
> > +reset_ltp_netspace()
> > +{
> > +	[ -n "$TST_USE_NETNS" ] || return
> > +	ip net del ltp_ns

> With this patch
>   3fb501e net: use LTP ns_create/ns_exec

> rm -f /var/run/netns/ltp_ns
> pkill ns_create
It's more readable to use 'ip net del ltp_ns', but ns_create is already used in test_net.sh.
If it's ok for you, I'll keep it in test_net.sh, but use your code.

[1]: http://lists.linux.it/pipermail/ltp/2017-June/004717.html


Kind regards,
Petr
