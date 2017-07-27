From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 27 Jul 2017 11:03:31 +0200
Subject: [LTP] [RFC PATCH v7 11/11] network: Use tools to set up IPv4
 and IPv6 related variables
In-Reply-To: <2255e31f-0d8f-5aed-e288-6dde615d98a4@oracle.com>
References: <20170721040407.868-1-pvorel@suse.cz>
 <20170721040407.868-12-pvorel@suse.cz>
 <2255e31f-0d8f-5aed-e288-6dde615d98a4@oracle.com>
Message-ID: <20170727090331.olg3buhrhhs6h532@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > +# For full list of exported environment variables see:
> > +# tst_net_ip_prefix -h
> > +# tst_net_iface_prefix -h
> > +# tst_net_vars -h
> > +if [ -z "$TST_PARSE_VARIABLES" ]; then
> > +	tst_resm TINFO "Parsing IP and prefixes"
> > +	set -x

> It might be useful just for debugging, please remove it.
OK, I'll remove it, because you don't like it. But I have to admit, I think it's important
to see values of automatic setup.
If user reports a bug/problem we have ver_linux, which is suitable for most of the
scripts, but not for networking.  And printing values of automatic configuration doesn't
have to be by 'set -x', that was just a quick way how to achieve it.

> > +	eval "$(tst_net_ip_prefix $IPV4_LHOST)" || exit $?

> Not quite right, if you want to deal with the status of
> tst_net_ip_prefix, you have to set 'exit' on error inside $(...)

> eval "$(tst_net_ip_prefix $IPV4_LHOST || echo 'exit $?')"
Am I missing something? Are you sure, you're right? POSIX defines [1]:
EXIT STATUS
If there are no arguments, or only null arguments, eval shall return a zero exit status;
otherwise, it shall return the exit status of the command defined by the string of
concatenated arguments separated by <space> characters, or a non-zero exit status if the
concatenation could not be parsed as a command and the shell is interactive (and therefore
did not abort).

[1]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_19

And bash, dash and busybox shell all implement this behaviour correctly. So both ways
deals correctly with tst_net_ip_prefix exit status and I consider mine form a bit clearer.


> > +	if [ "$TST_USE_NETNS" != "yes" ]; then
> > +		tst_resm TINFO "Parsing prefixes and ifaces from rtnetlink"
> > +		set -x
> > +		eval "$(tst_net_iface_prefix $IPV4_LHOST)" || exit $?
> > +		eval "$(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV4_RHOST)" || exit $?
> > +		eval "$(tst_net_iface_prefix $IPV6_LHOST)" || exit $?
> > +		eval "$(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV6_RHOST)" || exit $?
> > +		set +x
> > +	fi

> Why netns is not working in the above case or it's an optimization?
Chicken or the egg problem. We need tst_rhost_run, but it requires LTP_NETNS being set =>
that requires init_ltp_netspace() call. But in init_ltp_netspace() we set remote IP. Does
it make sense to move tst_net_iface_prefix behind netns initialization and call 'tst_restore_ipaddr'
and 'tst_restore_ipaddr rhost' again?

...
> > diff --git a/testcases/network/stress/interface/if4-addr-change b/testcases/network/stress/interface/if4-addr-change
> > index 567f86643..a7469c252 100644
> > --- a/testcases/network/stress/interface/if4-addr-change
> > +++ b/testcases/network/stress/interface/if4-addr-change
> > @@ -48,12 +48,19 @@ while [ $cnt -lt $NS_TIMES ]; do

> >  	[ $num -eq $RHOST_IPV4_HOST ] && continue

> > -	# Change IPv4 address
> > -	lhost_ipv4addr="${IPV4_NETWORK}.${num}"
> > +	# check prefix and fix values for prefix != 24
> > +	add_to_net=
> > +	if [ $IPV4_LPREFIX -lt 8 -o $IPV4_LPREFIX -ge 32 ] ; then
> > +		tst_brkm TCONF "test must be with prefix >= 8 and prefix < 32 ($IPV4_LPREFIX)"
> > +	elif [ $IPV4_LPREFIX -lt 16 ]; then # N.x.x.num
> > +		add_to_net=".0.1"
> > +	elif [ $IPV4_LPREFIX -lt 24 ]; then # N.N.x.num
> > +		add_to_net=".1"
> > +	fi

> > -	ifconfig $(tst_iface) $lhost_ipv4addr netmask 255.255.255.0 \
> > -		broadcast 255.255.255.255 || \
> > -		tst_brkm TFAIL "Failed to change into ${lhost_ipv4addr}"
> > +	# Change IPv4 address
> > +	ROD ifconfig $(tst_iface) ${IPV4_LNETWORK}${add_to_net}.${num} netmask \
> > +		$IPV4_LNETMASK broadcast $IPV4_LBROADCAST


> Could you make a separate patch for this? It looks completely
> unrelated to the rest in this patch.
No, it is related: IPV4_NETWORK disappeared and was replaced by IPV4_LNETWORK and
IPV4_RNETWORK. If we split the commit into two, if4-addr-change will not work in the first
commit (and we break principle of atomic commits).
Of course, we can temporarily (for one commit) define IPV4_NETWORK locally in
if4-addr-change in the first commit in order not to break the script, but does it make
much sense?
I didn't mention in commit message that I'm updating all scripts which use old variables
(the ones which disappeared) with new ones. If you agree to keep it all in one commit, I
put the info in the message.

Thanks for your review, I really appreciate it!

Kind regards,
Petr
