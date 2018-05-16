From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 May 2018 16:00:02 +0200
Subject: [LTP] [PATCH v2 1/1] ipneigh : Use new API
In-Reply-To: <dec4e6fc-4d4c-fa1d-34f6-e5dad515440c@suse.de>
References: <20180514114930.9350-1-asmorodskyi@suse.com>
 <20180516090947.nkoa6lhtu2rj4x52@dell5510>
 <dec4e6fc-4d4c-fa1d-34f6-e5dad515440c@suse.de>
Message-ID: <20180516140002.ubghlmuys7y42uif@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Anton,

...
> > Some change I'd like to have is to pass this script command (-c [ arp | ip ]) and run test
> > only once, i.e. TST_CNT=1 (then it does not need to be included).
> > Then in runtest files it'd be:

> > diff --git runtest/net.ipv6 runtest/net.ipv6
> > -ipneigh601 ipneigh01.sh -6
> > +ipneigh6_ip ipneigh01.sh -6 -c ip
> > diff --git runtest/net.tcp_cmds runtest/net.tcp_cmds
> > -ipneigh01 ipneigh01.sh
> > +ipneigh01_arp ipneigh01.sh -c arp
> > +ipneigh01_ip ipneigh01.sh -c ip

> > By this test is 1) cleaner 2) we get rid of TCONF for IPv6.

> ok , make sense .

> > > +			tst_res TCONF "'arp cmd doesn't support IPv6, skipping test-case"
                               ^ left quote, which was in previous version, please remove it.
> > You still do TCONF.
> Yes and it make perfect sense now because I am doing exit just after this
> message , so it is ok
OK, it make sense to check for it. But if you pass 1 command in the test, you can have it as:
tst_res TCONF "arp doesn't support IPv6"

Kind regards,
Petr
