From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Aug 2017 22:13:00 +0200
Subject: [LTP] [RFC PATCH v8 07/11] lib/test_net.sh: Add function
 reset_ltp_netspace()
In-Reply-To: <245506e0-b0a6-3066-a35f-ad5e7509e4fc@oracle.com>
References: <20170818164437.13556-1-pvorel@suse.cz>
 <20170818164437.13556-8-pvorel@suse.cz>
 <245506e0-b0a6-3066-a35f-ad5e7509e4fc@oracle.com>
Message-ID: <20170822201300.h6lpprx6rcezzlmp@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > +# Force to reset netns.
> > +reset_ltp_netspace()
> > +{
> > +	[ -n "$TST_USE_NETNS" ] || return
> > +
> > +	tst_resm TINFO "reset netns"
> > +	ip link delete ltp_ns_veth2 2> /dev/null
> > +	rm -f /var/run/netns/ltp_ns
> > +	pkill ns_create

> Hmm, if there was custom netns you would break it anyway with this
> function and change to LTP one.

> I guess we should leave it unsupported for route rmmod test unless we
> figure out the right solution.

> Also, what if we reset only ltp veth pair, i.e.:

> reset_ltp_netspace()
> {
>     ...
>     [ "$(tst_iface)" != "ltp_ns_veth2" ] || return
Why this? I suppose it detects whether custom netns is used, but then I'd swap the
condition to:
	[ "$(tst_iface)" = "ltp_ns_veth2" ] || return

>     ip li del ltp_ns_veth2 2>/dev/null
> }

> init_ltp_netspace()
> {
>     ...

>     pid="$(echo $(readlink /var/run/netns/ltp_ns) | cut -f3 -d'/')"
>     export LTP_NETNS="${LTP_NETNS:-ns_exec $pid net,mnt}"

>     if ! ip li sh $LHOST_IFACES > /dev/null 2>&1; then
>         ROD ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2
Code duplicity :-(.
>         ROD ns_ifmove ltp_ns_veth1 $pid
>     fi
>     ...
> }

It's working for me with this patch (turn over the condition in reset_ltp_netspace(), assuming
that custom netns would have different LHOST_IFACES, is that correct?):

+++ b/testcases/lib/test_net.sh
@@ -44,12 +44,26 @@ init_ltp_netspace()
 	pid="$(echo $(readlink /var/run/netns/ltp_ns) | cut -f3 -d'/')"
 	export LTP_NETNS="${LTP_NETNS:-ns_exec $pid net,mnt}"
 
+	if ! ip li show $LHOST_IFACES > /dev/null 2>&1; then
+		ROD ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2
+		ROD ns_ifmove ltp_ns_veth1 $pid
+	fi
+
 	tst_restore_ipaddr
 	tst_restore_ipaddr rhost
 
 	tst_wait_ipv6_dad
 }
 
+# Force to reset netns.
+reset_ltp_netspace()
+{
+	[ "$(tst_iface)" = "ltp_ns_veth2" ] || return
+	tst_resm TINFO "reset netns"
+	ip link delete ltp_ns_veth2 2> /dev/null
+	init_ltp_netspace
+}
+
