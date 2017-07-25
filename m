From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 25 Jul 2017 11:57:35 +0200
Subject: [LTP] [RFC PATCH v7 02/11] network/stress: Add library
 test_net_stress.sh
In-Reply-To: <fddf6fa1-3a12-5035-482f-08fe83fcb47e@oracle.com>
References: <20170721040407.868-1-pvorel@suse.cz>
 <20170721040407.868-3-pvorel@suse.cz>
 <fddf6fa1-3a12-5035-482f-08fe83fcb47e@oracle.com>
Message-ID: <20170725095735.nhde7e6nezqeo3nn@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > +export OCTET_3_IPV4_UNUSED=${OCTET_3_IPV4_UNUSED:-23} # x.x.N.x
> > +export OCTET_4_LHOST_IPV4_HOST_UNUSED=${OCTET_4_LHOST_IPV4_HOST_UNUSED:-2} # x.x.x.N
> > +export OCTET_4_RHOST_IPV4_HOST_UNUSED=${OCTET_4_RHOST_IPV4_HOST_UNUSED:-1} # x.x.x.N
> > +export LHOST_IPV4_HOST_UNUSED="${OCTET_3_IPV4_UNUSED}.${OCTET_4_LHOST_IPV4_HOST_UNUSED}"
> > +export RHOST_IPV4_HOST_UNUSED="${OCTET_3_IPV4_UNUSED}.${OCTET_4_RHOST_IPV4_HOST_UNUSED}"
> > +export LHOST_IPV4_UNUSED="${IPV4_NET16_UNUSED}.$LHOST_IPV4_HOST_UNUSED"
> > +export RHOST_IPV4_UNUSED="${IPV4_NET16_UNUSED}.$RHOST_IPV4_HOST_UNUSED"
> > +
> > +export OCTET_3_IPV6_UNUSED="${OCTET_3_IPV6_UNUSED:-:0}"
> > +export OCTET_4_LHOST_IPV6_HOST_UNUSED=${OCTET_4_LHOST_IPV6_HOST_UNUSED:-2}
> > +export OCTET_4_RHOST_IPV6_HOST_UNUSED=${OCTET_4_RHOST_IPV6_HOST_UNUSED:-1}
> > +export LHOST_IPV6_HOST_UNUSED="${OCTET_3_IPV6_UNUSED}:${OCTET_4_LHOST_IPV6_HOST_UNUSED}"
> > +export RHOST_IPV6_HOST_UNUSED="${OCTET_3_IPV6_UNUSED}:${OCTET_4_RHOST_IPV6_HOST_UNUSED}"
> > +export LHOST_IPV6_UNUSED="${IPV6_NET32_UNUSED}:$LHOST_IPV6_HOST_UNUSED"
> > +export RHOST_IPV6_UNUSED="${IPV6_NET32_UNUSED}:$RHOST_IPV6_HOST_UNUSED"

> Hmm, what is the purpose of adding these variables to the library?
> Why someone would need to redefine any of them?
I thought someone might appreciate ability to full control of IP
addresses, but you're right it's probably useless.
If you don't mind, I'll keep {L,R}HOST_IPV{4,6}_UNUSED variables as they are used in many scripts
(DRY approach) and delete the rest of variables.


> > +check_connectivity_interval()
> > +{
> > +	local cnt="$1"
> > +	local restore="${2:-false}"
> > +	local src_iface="${3:-$(tst_iface)}"
> > +	local dst_addr="${4:-$(tst_ipaddr rhost)}"
> > +
> > +	[ $CHECK_INTERVAL -eq 0 ] && return
> > +
> > +	[ $(($cnt % $CHECK_INTERVAL)) -ne 0 ] && return
> > +
> > +	[ "$restore" != "false" ] && restore_ipaddr
> > +
> > +	check_connectivity $src_iface $dst_addr $cnt
> > +	return $?
> > +}

> No need for 'return $?', the last command determines exit status for a
> function.
Right, thanks.

> > +make_background_tcp_traffic()
> > +{
> > +	local port=$(tst_get_unused_port ipv${ipver} stream)
> > +	local ip="${1:-$(tst_ipaddr)}"
> > +
> > +	ROD netstress -R 3 -g $port > /dev/null 2>&1 &
> > +	tst_rhost_run -s -b -c "netstress -l -H $ip -g $port"

> There is no point in adding 'ROD' and '-s' option for tst_rhost_run() if
> it's started in background.
Right, thanks.


Kind regards,
Petr
