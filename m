From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Aug 2017 19:18:05 +0200
Subject: [LTP] [RFC PATCH v8 01/11] lib/test_net.sh: Add unused IP
 address helper functions
In-Reply-To: <90408ccf-db5b-40a3-dac1-150088c00ca7@oracle.com>
References: <20170818164437.13556-1-pvorel@suse.cz>
 <20170818164437.13556-2-pvorel@suse.cz>
 <90408ccf-db5b-40a3-dac1-150088c00ca7@oracle.com>
Message-ID: <20170822171805.r3i2pxj5pxnpauyd@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

again, thank you for your review!

> > +# Get IP address of unused network, specified by 3rd and 4th octet.
> > +# This is useful when 3rd and/or 4th octet are needed to be defined.
> > +# tst_ipaddr_un_ip [OCTET_3] [OCTET_4]

> 3rd and 4th octet are only meaningful for IPv4, what about 'net_id' and
> 'host_id' instead?
OK, no problem.

> > +# OCTET_3: Integer or hex value of 3rd octet; Default value is 0.
> > +# OCTET_4: Integer or hex value of 4th octet; Default value is 0.
> > +tst_ipaddr_un_ip()
> > +{
> > +	local octet_3="${1:-0}"
> > +	local octet_4="${2:-0}"
> > +	local max
> > +
> > +	[ "$TST_IPV6" ] && max=65535 || max=255
> > +
> > +	if [ "$TST_IPV6" ]; then
> > +		octet_3=$(printf %d $octet_3)
> > +		octet_4=$(printf %d $octet_4)
> > +	fi
> > +
> > +	[ $octet_3 -lt 0 ] && octet_3=0
> > +	[ $octet_4 -lt 0 ] && octet_4=1
> > +	[ $octet_3 -gt $max ] && octet_3=$max
> > +	[ $octet_4 -gt $max ] && octet_4=$max
> > +
> > +	if [ "$TST_IPV6" ]; then
> > +		[ $octet_3 -gt 0 ] && octet_3="$(printf %x $octet_3)" || octet_3=
> > +		[ $octet_4 -gt 0 -o "$octet_3" ] && octet_4="$(printf %x $octet_4)" || octet_4=
> > +		[ "$octet_3" -a "$octet_4" ] && octet_4=":$octet_4"
> > +		echo "${IPV6_NET32_UNUSED}::${octet_3}${octet_4}"

> '${octet_3}${octet_4}' - if max is 65K, it's 4 bytes, ':' missed?
Not sure if I get what you mean, I don't see missing ':'

$ TST_IPV6=6 tst_ipaddr_un_ip 65535
fd00:23::ffff:0

$ TST_IPV6=6 tst_ipaddr_un_ip 65535 65535
fd00:23::ffff:ffff

$ TST_IPV6=6 tst_ipaddr_un_ip 0 65535
fd00:23::ffff

But I'll use new version based on move one parameter before '::', as you suggested (see
bellow).


> I assume this is needed for getting subnets/routes, in most cases we would
> have 64-bit netmask that's why I would move one parameter before '::'

> echo "${IPV6_NET32_UNUSED}:${octet_3}::${octet_4}"
Right, changed:
if [ "$TST_IPV6" ]; then
	[ $host_id -gt 0 ] && host_id="$(printf %x $host_id)" || host_id=
	[ $net_id -gt 0 ] && net_id="$(printf %x $net_id)" || net_id=
	[ "$net_id" ] && net_id=":$net_id"
	echo "${IPV6_NET32_UNUSED}${net_id}::${host_id}"
else
	echo "${IPV4_NET16_UNUSED}.${net_id}.${host_id}"
fi
i.e. don't print ':0', when host_id == 0 and don't print '0' at the end when host_id == 0.
I give up optimizations when IPV6_NET32_UNUSED contain ':' at the end (it shouldn't contain
it anyway).


> Can we have getopts in a single function to prevent code duplication?

OK, rewritten into single function:
# Get IP address of unused network, specified by either by type and
# counter or by net and host.
# tst_ipaddr_un -cCOUNTER [TYPE]
# tst_ipaddr_un [NET_ID] [HOST_ID]
# TYPE: { lhost | rhost }; Default value is 'lhost'.
# COUNTER: Integer value for counting HOST_ID and NET_ID. Default is 1.
# NET_ID: Integer or hex value of net. For IPv4 is 3rd octet, for IPv6 is 3rd
# hextet. Default value is 0.
# HOST_ID: Integer or hex value of host. For IPv4 is 4th octet, for IPv6 is the
# last hextet. Default value is 0.
tst_ipaddr_un()
{
	local counter host_id net_id max_host_id max_net_id tmp type
	local OPTIND

	while getopts "c:" opt; do
		case $opt in
			c) counter="$OPTARG";;
		esac
	done
	shift $(($OPTIND - 1))

	[ "$TST_IPV6" ] && max_net_id=65535 || max_net_id=255

	if [ "$counter" ]; then
		[ $counter -lt 1 ] && counter=1
		type="${1:-lhost}"
		max_host_id=$((max_net_id - 1))
		tmp=$((counter * 2))
		[ "$type" = "rhost" ] && tmp=$((tmp - 1))

		host_id=$((tmp % max_host_id))
		net_id=$((tmp / max_host_id))

		if [ $host_id -eq 0 ]; then
			host_id=$max_host_id
			net_id=$((net_id - 1))
		fi
	else
		net_id="${1:-0}"
		host_id="${2:-0}"
		max_host_id=$max_net_id
		if [ "$TST_IPV6" ]; then
			net_id=$(printf %d $net_id)
			host_id=$(printf %d $host_id)
		fi
		[ $net_id -lt 0 ] && net_id=0
		[ $host_id -lt 0 ] && host_id=1
	fi

	[ $net_id -gt $max_net_id ] && net_id=$max_net_id
	[ $host_id -gt $max_host_id ] && host_id=$max_host_id

	if [ "$TST_IPV6" ]; then
		[ $host_id -gt 0 ] && host_id="$(printf %x $host_id)" || host_id=
		[ $net_id -gt 0 ] && net_id="$(printf %x $net_id)" || net_id=
		[ "$net_id" ] && net_id=":$net_id"
		echo "${IPV6_NET32_UNUSED}${net_id}::${host_id}"
	else
		echo "${IPV4_NET16_UNUSED}.${net_id}.${host_id}"
	fi
}

Any comments on it? (BTW I prefer in functions using OPTIND as local variable than
reseting it after use).

Kind regards,
Petr
