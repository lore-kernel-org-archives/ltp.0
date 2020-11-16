From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 16 Nov 2020 19:48:25 +0100
Subject: [LTP] [PATCH] net/host: update to new api
In-Reply-To: <20201116184143.GA171432@pevik>
References: <20201116101840.15433-1-kory.maincent@bootlin.com>
 <20201116184143.GA171432@pevik>
Message-ID: <20201116184825.GB171432@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Kory, Alexey,

> Hi Kory,

> thanks for your patch.
> ...
> >  do_test()
> >  {

> > -    tst_resm TINFO "test basic functionality of the \`$TC' command."
> > +    tst_res TINFO "test basic functionality of the host command."

> > -    while [ $TST_COUNT -lt $NUMLOOPS ]; do
> > +    while [ $TST_COUNT -le $NUMLOOPS ]; do
> IMHO there is no need to have loop like this.
> If required, we'd just add -iN parameter to it in the runtest file (where N is
> <1,max int), but IMHO it's enough to test host only once.

> >          if rhost_addr=$(host $RHOST); then
> > -            rhost_addr=$(echo "$rhost_addr" | awk -F, '{print $NF}') >/dev/null 2>&1
> > -            if ! host $rhost_addr >/dev/null 2>&1; then
> > -                end_testcase "reverse lookup with host failed"
> > -            fi
> > -
> > +            rhost_addr=$(echo "$rhost_addr" | awk '{print $NF}') >/dev/null 2>&1
> > +            EXPECT_PASS host $rhost_addr \>/dev/null 2>&1
> We need to redirect also second > and &:
> EXPECT_PASS host $rhost_addr \>/dev/null 2\>\&1

BTW 2>&1 does not make sense in this context (it's a redirection of error
message of EXPECT_PASS function, which would be to stdout.
I also noticed this part of traceroute01.sh is also wrong:
EXPECT_PASS traceroute $ip $bytes -n -m 2 $opts \>out.log 2>&1

It should be:
EXPECT_PASS traceroute $ip $bytes -n -m 2 $opts \>out.log 2\>\&1

But IMHO it'd be better in both cases to keep stderr not redirected
(don't hide problems). Therefore, unless you're against it, I'll remove
redirection from traceroute01.sh.

Kind regards,
Petr
