From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 14 Jun 2021 15:57:48 +0200
Subject: [LTP] [PATCH] ssh-stress: Convert to new api
In-Reply-To: <5db0624b-a6ce-2c02-d1d4-52034c85b2f1@jv-coder.de>
References: <20210610101917.1251564-1-lkml@jv-coder.de>
 <YMcB3Wcu0J9C3Z/Q@pevik>
 <5db0624b-a6ce-2c02-d1d4-52034c85b2f1@jv-coder.de>
Message-ID: <YMdgXPeTNHMtna/M@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> Hi,

> I will send a v2 with the changes commented here.
Thanks!

> On 6/14/2021 9:14 AM, Petr Vorel wrote:
> > Hi Joerg,

> > [ Cc Alexey ]
> > > From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> > > Apart from pure conversion:
> > >   - Use "StrictModes no" in ssh config, to get rid of
> > >     access permission problems; All part of the path of the
> > >     authorized_keys file must not be writeable by anyone but the owner.
> > >     This allows writing the file to the default temp directory
> > >   - Moved all rhost scripts into ssh-stress.sh
> > +1

> > Nice work, LGTM, few small notes (could be fixed before merge).
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > Out of curiosity, did you test this on Two Host Configuration [2] (i.e. ssh)?
> > Or just netns?
> No, but should have...
> I found two major problems with the test (will send a v2). But apart from
> that, either I was not able to find the documentation or it is not clear
> enough to me, how to run the two host setup.
> I found network/README.md, but it only mentions to set RHOST, but for my
> setup (with ips different from the default ones, IPV{4,6}_{L,R}HOST is also
Yes we should be more verbose at Two Host Configuration [1] as there is nothing
more. At least to mention IPV{4,6}_{L,R}HOST.

> required) and ltp must already be in the PATH on rhost, which was not
> possible for my rhost setup, where the filesystem is read-only and I had to
> hack setting the path into tst_rhost_run. It is not totally clear, that ltp
What exactly was your problem? Having to modify PATH on shell config on read
only system? I'll send a proposal to set PATH in tst_test.sh.

> > > -	check_icmpv${TST_IPVER}_connectivity $(tst_iface) $(tst_ipaddr rhost) || \
> > > -		tst_brkm TBROK "Failed to ping to $(tst_ipaddr rhost)"
> > > +	check_icmpv${TST_IPVER}_connectivity $(tst_iface) $(tst_ipaddr rhost) \
> > > +		|| tst_brk TBROK "Failed to ping $(tst_ipaddr rhost)"
> > Anything from testcases/network/stress/ns-tools/ is deprecated,
> > including check_icmpv{4,6}_connectivity. But this can be safely removed.
> > Although I don't see any connectivity check in tst_net.sh, it should be handled
> > there. IMHO it's needed at least for for two host based configuration, but it does not harm to test also netns based setup, thus somewhere after init_ltp_netspace.
> There is tst_ping in tst_net.sh. Without arguments, it just tests
> connectivity to rhost.
> Nevertheless, this is kind of useless in setup here. Other network tests do
> not check availability before execution, so I just dropped it for v2.
> +1 on adding it to tst_net.sh initialization
Yes, we should do it as a separate effort.

...

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/network/README.md#two-host-configuration
