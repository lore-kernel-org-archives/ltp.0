From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 Jun 2021 08:42:33 +0200
Subject: [LTP] [PATCH v2] ssh-stress: Convert to new api
In-Reply-To: <fae3c38e-ae64-05ac-264b-f11cae8c1c55@jv-coder.de>
References: <20210614094338.125870-1-lkml@jv-coder.de>
 <a2ad7106-3e96-48a0-d195-80d7d09c8613@bell-sw.com>
 <fae3c38e-ae64-05ac-264b-f11cae8c1c55@jv-coder.de>
Message-ID: <YMmdWRGTB0MrtdxJ@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg, Alexey,

> Hi Alexey,

> > > +	# Kill all remaining ssh processes
> > > +	tst_rhost_run -c "ps auwx | \
> > > +		awk '\$0 ~ \"$RHOST_SSH_CONF\" && \$11 == \"ssh\" {print \$2}' | \
> > > +		xargs -r -t kill -- >/dev/null 2>&1"
> > >   }
> > What about using pkill -f instead of ps|awk|kill?
> I guess I did not use pkill for two reasons:
> 1. I wanted to be sure to really only kill ssh processes with
> $RHOST_SSH_CONF in their arguments
> 2. I did not want to use an extra tool, that is not necessarily available on
> all systems.

> The first one could be solved by using "pkill -f "^ssh .*$RHOST_SSH_CONF", I
> guess. This still leaves a problem with unescaped regexp meta characters in
> RHOST_SSH_CONF, but my awk solution has the same problem. But I think this
> is only theoretical, it is extremely unlikely, that any regexp meta
> character apart from "." is used in RHOST_SSH_CONF and the dot will unlikely
> produce false positives.
> The second point can be ignored. pkill is used in many locations throughout
> ltp already. It should probably be added as a runtime dependency.

+1. pkill as runtime dependency is probably better than xargs dependency.
BTW I thought in the past to write tst_kill command, either as a shell
implementation (which would look on pkill, killall and if none of them
it'd used ps and grep) or (better) just to implement it in C.


> > > -	tst_rhost_run -s -c "ssh-stress02-rmt.sh $TST_IPVER $(tst_ipaddr) \
> > > -		$rconfig $CONNECTION_TOTAL $NS_DURATION"
> > > +	tst_res TINFO "Verify the ssh connectivity over IPv4/IPv6 is not broken after creating many ssh sessions"
> >                                                             ^
> > The message may have indicated the exact IP version with $TST_IPVER
> Yeah right, that was just copy and pasted from the original test
> description.
+ nit: "Verify SSH connectivity ..."

Kind regards,
Petr
