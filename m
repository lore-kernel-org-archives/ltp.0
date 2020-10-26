From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Oct 2020 08:01:48 +0100
Subject: [LTP] [PATCH] route{4,6}-rmmod: Filter out ":" and fix typos
In-Reply-To: <e0bdc892-6ade-f694-7c14-ca7ef7cb052f@oracle.com>
References: <1603361548-1534-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <e0bdc892-6ade-f694-7c14-ca7ef7cb052f@oracle.com>
Message-ID: <20201026070148.GC21306@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey, Feiyu,

> On 22.10.2020 13:12, Feiyu Zhu wrote:
> > Reported-by: Jin Cao <caoj.fnst@cn.fujitsu.com>
> > Signed-off-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
> > ---
> >  testcases/network/stress/route/route4-rmmod | 4 ++--
> >  testcases/network/stress/route/route6-rmmod | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)

> > diff --git a/testcases/network/stress/route/route4-rmmod b/testcases/network/stress/route/route4-rmmod
> > index 7aa1958..1ba255e 100644
> > --- a/testcases/network/stress/route/route4-rmmod
> > +++ b/testcases/network/stress/route/route4-rmmod
> > @@ -164,14 +164,14 @@ do_setup()
> >      lhost_module=`ethtool -i $lhost_ifname | grep driver | sed "s/driver:[[:blank:]]*//"`

> >      # Chack the other active interface uses the same driver
> > -    for ifname in `ifconfig | grep ^eth | awk '{ print $1}'`; do
> > +    for ifname in `ifconfig | grep ^eth | awk '{print $1}' | sed "s/://"`; do

> Thanks for fixing it, but it is not enough here. This command is wrong,
> not only does it use obsolete tool, but also assumes that interface
> names start with 'eth'. So it skips the check for active connections
> that already in use with the driver (it is going to remove) for all
> modern systems.
+1

> I think we should at least remove this test from the runtest file
> until the proper fix.
Good idea, I've sent a patch for this.
https://patchwork.ozlabs.org/project/ltp/patch/20201026070006.25298-1-pvorel@suse.cz/

> Also this test and route4{6}-redirect are
> really need to be rewritten with new test API, please have a look
> at route-change-*.sh.

Kind regards,
Petr

