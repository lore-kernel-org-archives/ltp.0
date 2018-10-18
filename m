From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Oct 2018 16:00:23 +0200
Subject: [LTP] [PATCH 1/1] net: Introduce $TST_PING
In-Reply-To: <40613a15-b157-df57-1ec9-1eccb0cc1f0d@oracle.com>
References: <20181008115849.30826-1-pvorel@suse.cz>
 <40613a15-b157-df57-1ec9-1eccb0cc1f0d@oracle.com>
Message-ID: <20181018140023.GB30125@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Hi Petr,

> >  [ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
> > +tst_net_fix_ping_cmd

> It is called twice, i.e. also in tst_net_parse_args(), though it should be
> enough to have it only here?
No. This is for hypothetical case when you manually set TST_IPV6=6 and use test
without getopts.


> For IPv4 tests we would eventually need tst_ping() with IPv6, so that TST_IPV6
> is empty, for example for some tunnels that are working for both protocols over
> IPv4, checking dst address to decide which command to use. I've not posted the
> patch yet, I guess I will do it after this one.
OK, make sense.

> So I think we shouldn't use TST_PING variable...  it could be the new variable
> for the ping6 only, or some general wrapper for the both commands?

> Or may be something like this:

> ping6()
> {
>     ping -6 $@
> }

> if which ping6 >/dev/null 2>&1; then
>     unset ping6
> fi
I have a respect to use function of the same name as binary in $PATH because
possible race conditions, but this should be safe.
Simple solution => I'll use it in v2.


> >  	# ping cmd use 56 as default message size
> >  	for size in ${msg_sizes:-"56"}; do
> > -		$cmd -I $src_iface -c $PING_MAX $dst_addr \
> > +		$TST_PING -I $src_iface -c $PING_MAX $dst_addr \
> >  			-s $size -i 0 > /dev/null 2>&1
> >  		ret=$?
> >  		if [ $ret -eq 0 ]; then
> > diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> > index e22e17aae..558057d9c 100755
> > --- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> > +++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> > @@ -45,7 +45,7 @@ do_setup()
> >  		;;
> >  	esac

> > -	tst_test_cmds $CMD ping$TST_IPV6
> > +	tst_test_cmds $CMD $TST_PING

> Are you sure it will work with the "ping -6" command as expected?
You're right, that'd be a bug. Another reason to use ping6 function.
TCONF: '-6' not found

Thanks for your review!


Kind regards,
Petr
