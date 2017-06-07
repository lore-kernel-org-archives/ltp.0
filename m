From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 7 Jun 2017 18:27:56 +0200
Subject: [LTP] [RFC PATCH v6 06/11] network/stress: Add library
 test_stress_net.sh for general usage
In-Reply-To: <98827b85-b027-65ca-6ce5-5b149fb5a676@oracle.com>
References: <20170603120022.13415-1-pvorel@suse.cz>
 <20170603120022.13415-7-pvorel@suse.cz>
 <f1376e76-b9bf-8386-8a40-0a374fdf1697@oracle.com>
 <20170606134322.lkz6mmjxxmceeepb@dell5510>
 <98827b85-b027-65ca-6ce5-5b149fb5a676@oracle.com>
Message-ID: <20170607162756.3bqndanwlnq4h7gx@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > Wouldn't be worth to rewrite these test into C, using netlink/rtnetlink/libnfnetlink/libnl API?

> Interesting, may be that would stress more this Linux subsystem as there
> will be less latency when adding/removing interfaces, routes, etc.
> i.e. without starting a bunch of 'ip' commands in the shell.
Would you mind if I finish rewriting it as shell script and ip binary (incorporate your
comments and just removing ifconfig and route). As the most of work is done and it might
take me a while before I rewrite tests into CK


Kind regards,
Petr
