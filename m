From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 1 May 2019 17:34:14 +0200
Subject: [LTP] [PATCH 1/2] net/traceroute: Rewrite into new API
In-Reply-To: <5131c8d6-8092-5cba-f599-402e7e0dee98@oracle.com>
References: <20190429072800.23067-1-pvorel@suse.cz>
 <5131c8d6-8092-5cba-f599-402e7e0dee98@oracle.com>
Message-ID: <20190501153414.GB19942@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> On 29.04.2019 10:27, Petr Vorel wrote:
> > Add info about traceroute from iputils not being supported

> >  testcases/network/traceroute/traceroute01.sh | 63 ++++++++------------

> > -TST_TOTAL=6
> > -TCID="traceroute01"
> > -TST_CLEANUP="cleanup"
> > -
> > -TST_USE_LEGACY_API=1
> > +TST_CNT=2
> > +TST_NEEDS_CMDS="traceroute"
> > +TST_SETUP="setup"
> > +TST_TESTFUNC="test"

> TST_NEEDS_TMPDIR=1?
Thanks, yes it's needed (redirects to files).


Kind regards,
Petr
