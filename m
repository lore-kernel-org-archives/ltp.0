From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 8 Feb 2021 17:04:50 +0100
Subject: [LTP] [PATCH 2/2] if-mtu-change.sh: Lower CHANGE_INTERVAL for
 netns
In-Reply-To: <c5322d13-c69d-aa4d-193c-7c047a405d9a@oracle.com>
References: <20210205142051.32055-1-pvorel@suse.cz>
 <20210205142051.32055-2-pvorel@suse.cz>
 <c5322d13-c69d-aa4d-193c-7c047a405d9a@oracle.com>
Message-ID: <YCFhIs/lyRGTh8IR@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> >  # The interval of the mtu change [second]
> >  CHANGE_INTERVAL=${CHANGE_INTERVAL:-5}
> > -
> >  TST_TIMEOUT=$(((CHANGE_INTERVAL + 30) * MTU_CHANGE_TIMES))

> > +if tst_net_use_netns; then
> > +	CHANGE_INTERVAL="100ms"

> Hi Petr,

> What about adding the option to change this value too for netns,
> for example like this:

> TST_TIMEOUT=1
> if tst_net_use_netns; then
>     CHANGE_INTERVAL=${CHANGE_INTERVAL:-100ms}
> else
>     CHANGE_INTERVAL=${CHANGE_INTERVAL:-5}
>     tst_is_int $CHANGE_INTERVAL && TST_TIMEOUT=$CHANGE_INTERVAL
> fi

> TST_TIMEOUT=$(((TST_TIMEOUT + 30) * MTU_CHANGE_TIMES))
That's indeed much better!

How about allow to overwrite CHANGE_INTERVAL even for netns?
i.e move tst_is_int $CHANGE_INTERVAL && TST_TIMEOUT=$CHANGE_INTERVAL
after the test (although it's unlikely anybody would use sec value for netns
and ms value for ssh):

# CHANGE_INTERVAL: The interval of the mtu change
TST_TIMEOUT=1
if tst_net_use_netns; then
    CHANGE_INTERVAL=${CHANGE_INTERVAL:-100ms}
else
    CHANGE_INTERVAL=${CHANGE_INTERVAL:-5}
fi
tst_is_int $CHANGE_INTERVAL && TST_TIMEOUT=$CHANGE_INTERVAL
TST_TIMEOUT=$(((TST_TIMEOUT + 30) * MTU_CHANGE_TIMES))

> > +	TST_TIMEOUT=$((30 * MTU_CHANGE_TIMES))
> > +fi
> > +
> >  # The array of the value which MTU is changed into sequentially
> >  # 552 - net.ipv4.route.min_pmtu
> >  CHANGE_VALUES="784 1142 552 1500 552 1500 552 748 552 1142 1500"
> > @@ -65,6 +69,7 @@ find_ipv4_max_packet_size()

> >  do_setup()
> >  {
> > +

> empty new line?
Thanks!

Kind regards,
Petr
