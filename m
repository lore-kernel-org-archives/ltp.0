From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 10 Feb 2021 14:08:56 +0100
Subject: [LTP] [PATCH 1/4] net/multicast: Create mcast_setup_normal()
In-Reply-To: <5f9aecc2-096b-6b24-bdfa-f9d361fcbac7@oracle.com>
References: <20210205151015.7465-1-pvorel@suse.cz> <YB7qefsNWbCJXUEu@pevik>
 <5f9aecc2-096b-6b24-bdfa-f9d361fcbac7@oracle.com>
Message-ID: <YCPa6EI4zyGzDEz1@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > +++ testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh
> > @@ -12,13 +12,13 @@ TST_NEEDS_ROOT=1
> >  TST_SETUP="mcast_setup_normal"
> >  . mcast-lib.sh

> > -MCAST_LCMD="ns-mcast_receiver"
> > -MCAST_RCMD="ns-udpsender"
> > -
> >  do_test()
> >  {
> >  	tst_res TINFO "joining $MCASTNUM_NORMAL IPv${TST_IPVER} multicast groups on separate sockets, then receiving a large number of UDP packets at each socket in $NS_DURATION seconds"

> > +	MCAST_LCMD="ns-mcast_receiver"
> > +	MCAST_RCMD="ns-udpsender"
> > +

> Hi Petr,

> Perhaps it would be better to move this to another wrapper
> in the lib along with mcast_setup_normal()?

Good idea, thanks!

> mcast_setup_normal_udp()
> {
>         mcast_setup_normal
> 	MCAST_LCMD="ns-mcast_receiver"
> 	MCAST_RCMD="ns-udpsender"
> }

Kind regards,
Petr
