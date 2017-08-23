From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 Aug 2017 12:21:42 +0200
Subject: [LTP] [RFC PATCH v8 07/11] lib/test_net.sh: Add function
 reset_ltp_netspace()
In-Reply-To: <1075a919-2403-4025-8817-e42a3f5c2113@oracle.com>
References: <20170818164437.13556-1-pvorel@suse.cz>
 <20170818164437.13556-8-pvorel@suse.cz>
 <245506e0-b0a6-3066-a35f-ad5e7509e4fc@oracle.com>
 <20170822201300.h6lpprx6rcezzlmp@dell5510>
 <1075a919-2403-4025-8817-e42a3f5c2113@oracle.com>
Message-ID: <20170823102142.6d3bnhmcw4x5csxy@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> >>     ip li del ltp_ns_veth2 2>/dev/null
> >> }
> >> init_ltp_netspace()
> >> {
> >>     ...
> >>     pid="$(echo $(readlink /var/run/netns/ltp_ns) | cut -f3 -d'/')"
> >>     export LTP_NETNS="${LTP_NETNS:-ns_exec $pid net,mnt}"
> >>     if ! ip li sh $LHOST_IFACES > /dev/null 2>&1; then
> >>         ROD ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2
> > Code duplicity :-(.

> Why? it is moved here from the upper if block.
OK :-).

Final version of reset_ltp_netspace() patch:

+++ b/testcases/lib/test_net.sh
@@ -26,13 +26,11 @@ init_ltp_netspace()
 	local pid=
 
 	if [ ! -f /var/run/netns/ltp_ns ]; then
-		ROD ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2
 		pid="$(ROD ns_create net,mnt)"
 		mkdir -p /var/run/netns
 		ROD ln -s /proc/$pid/ns/net /var/run/netns/ltp_ns
 		ROD ns_exec $pid net,mnt mount --make-rprivate /sys
 		ROD ns_exec $pid net,mnt mount -t sysfs none /sys
-		ROD ns_ifmove ltp_ns_veth1 $pid
 		ROD ns_exec $pid net,mnt ip li set lo up
 	fi
 
@@ -44,12 +42,30 @@ init_ltp_netspace()
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
+	[ -n "$TST_USE_NETNS" ] || return
+
+	# resetting netns when using custom netns is not supported
+	[ "$(tst_iface)" = "ltp_ns_veth2" ] || return
+
+	tst_resm TINFO "reset netns"
+	ip link delete ltp_ns_veth2 2> /dev/null
+	init_ltp_netspace
+}

> >>         ROD ns_ifmove ltp_ns_veth1 $pid
> >>     fi
> >>     ...
> >> }
> > It's working for me with this patch (turn over the condition in reset_ltp_netspace(), assuming
> > that custom netns would have different LHOST_IFACES, is that correct?):

> I'm not sure how to handle it correctly for rmmod test right now,
> may be we should TCONF on the check inside the test:

> $TST_USE_NETNS -a "$(tst_iface)" != "ltp_ns_veth2"

Right, tst_brkm TCONF added into setup of route4-rmmod test.


Kind regards,
Petr
