From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 Jun 2018 19:42:32 +0200
Subject: [LTP] [PATCH 3/3] net/icmp: Unify log info messages
In-Reply-To: <ba39e350-a6df-68fe-31a6-31141d689df6@oracle.com>
References: <20180614131558.18707-1-pvorel@suse.cz>
 <20180614131558.18707-3-pvorel@suse.cz>
 <ba39e350-a6df-68fe-31a6-31141d689df6@oracle.com>
Message-ID: <20180618174232.ty6g6gm74rgnoq6b@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Hi Petr,

> > -# Test description
> > -tst_resm TINFO "Sending ICMP messages with the following conditions"
> > -tst_resm TINFO "- Version of IP is IPv${TST_IPV6:-4}"
> > -tst_resm TINFO "- Size of packets are ( $IPSEC_SIZE_ARRAY )"
> > +tst_resm TINFO "Sending ICMP messages">  
> >  if [ -n "$IPSEC_MODE" -a -n "$IPSEC_PROTO" ]; then
> >  	case $IPSEC_PROTO in

> Probably better to fix the similar issue here with printing IPsec
> protocol/mode type too, i.e. remove the above if block and print the
> message in ipsec_lib.sh/tst_ipsec() instead, so it would be the same
> as in tst_ipsec_setup_vti() now:

>     tst_resm TINFO "Test vti$TST_IPV6 + IPsec[$IPSEC_PROTO/$IPSEC_MODE]"

I replaced test with
https://patchwork.ozlabs.org/patch/931107/
(part of big patchset Migrate tests using virt_lib.sh and ipsec_lib.sh to new API
https://patchwork.ozlabs.org/project/ltp/list/?series=50725)

i.e in tst_ipsec_setup()
 {
 	# Configure SAD/SPD
 	if [ -n "$IPSEC_MODE" -a -n "$IPSEC_PROTO" ]; then
+		tst_resm TINFO "IPsec[$IPSEC_PROTO/$IPSEC_MODE]"
 		tst_ipsec lhost $(tst_ipaddr) $(tst_ipaddr rhost)
 		tst_ipsec rhost $(tst_ipaddr rhost) $(tst_ipaddr)

1) IMHO it does not make sense print info about it when no IPsec is done
2) Removed "vti$TST_IPV6" as tst_ipsec_setup is not used for VTI.

> > diff --git a/testcases/network/stress/icmp/icmp-uni-vti.sh b/testcases/network/stress/icmp/icmp-uni-vti.sh
> > index 7fa211d7f..ea8b5c828 100755
> > --- a/testcases/network/stress/icmp/icmp-uni-vti.sh
> > +++ b/testcases/network/stress/icmp/icmp-uni-vti.sh
> > @@ -26,7 +26,7 @@ do_test()
> >  {
> >  	PING_MAX="$IPSEC_REQUESTS"

> > -	tst_resm TINFO "Sending ICMP messages..."
> > +	tst_resm TINFO "Sending ICMP messages"
> >  	tst_ping $tst_vti $ip_rmt_tun $IPSEC_SIZE_ARRAY
> >  }


> The rest looks fine to me.
Thanks, I pushed the second two.

> Thanks,
> Alexey


Kind regards,
Petr
