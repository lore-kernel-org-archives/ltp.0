From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 6 Jun 2018 17:27:29 +0200
Subject: [LTP] [PATCH 0/7] TST_IPVER
In-Reply-To: <2b765425-664a-d4f6-3547-c2a63cd9b96e@oracle.com>
References: <20180601114956.17265-1-pvorel@suse.cz>
 <2b765425-664a-d4f6-3547-c2a63cd9b96e@oracle.com>
Message-ID: <20180606152729.lbuwg3mtyppdiint@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > Petr Vorel (7):
> >   tst_net.sh: Simplify ipver settings code
> >   tst_net.sh: Rename ipver to TST_IPVER
> >   net/dns: Replace $ipver by $TST_IPVER from tst_net.sh
> >   net/ftp: Replace $ipver by $TST_IPVER from tst_net.sh
> >   net/http: Replace $ipver by $TST_IPVER from tst_net.sh
> >   net/ssh: Replace $ipver by $TST_IPVER from tst_net.sh
> >   net/virt: Replace $ipver by $TST_IPVER from tst_net.sh


> The patch-set look good, acked.
Thanks for your review.

> BTW, I would rather split such patches on these logical changes:
> * introduce new TST_IPVER library variable
> * remove $ipver setups and replace the usage with $TST_IPVER.

Sure, much better, than 7 commits.
Changed to your suggestion and pushed with your ack.


Kind regards,
Petr
