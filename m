From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 May 2018 09:59:48 +0200
Subject: [LTP] [PATCH 1/4] tst_net.sh: Simplify ipver settings code
In-Reply-To: <2dad0d9c-ddfa-e6d2-2630-321d51545434@oracle.com>
References: <20180526111545.20521-1-pvorel@suse.cz>
 <2dad0d9c-ddfa-e6d2-2630-321d51545434@oracle.com>
Message-ID: <20180529075948.GA10361@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> On 05/26/2018 02:15 PM, Petr Vorel wrote:
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  testcases/lib/tst_net.sh | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)

> > diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> > index dc612a794..fd2eacf2f 100644
> > --- a/testcases/lib/tst_net.sh
> > +++ b/testcases/lib/tst_net.sh
> > @@ -29,11 +29,12 @@ TST_SETUP="tst_net_setup"

> >  # Blank for an IPV4 test; 6 for an IPV6 test.
> >  TST_IPV6=${TST_IPV6:-}
> > +ipver=${TST_IPV6:-4}

> Hi Petr,

> Perhaps, we need a prefix TST_.

> Shouldn't the same patch remove the setting of 'ipver' in the tests?
Thanks for comments, both makes sense. I wanted to do it after migrating everything to new
API, but probably better to do it before.

> Thanks,
> Alexey


Kind regards,
Petr
