From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 Oct 2019 15:04:02 +0200
Subject: [LTP] [PATCH v5 0/8] net/route: rewrite route-change-{dst, gw,
 if} into new API
In-Reply-To: <f5b4a42f-fb20-e085-1250-c0e2b171c01f@oracle.com>
References: <20191011132433.24197-1-pvorel@suse.cz>
 <f5b4a42f-fb20-e085-1250-c0e2b171c01f@oracle.com>
Message-ID: <20191017130401.GA21484@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> On 11.10.2019 16:24, Petr Vorel wrote:
> > Hi,

> > changes v4->v5:
> > addressed these Alexey's requests:
> > * tst_ipadd_un() now handles both host_id and net_id, with
> > -h MIN,MAX, -n MIN,MAX
> > (instead of -b, -f, -n which handled only host_id)

> > * add -q to tst_add_ipaddr() (silence test output)

> > * introduce EXPECT_{FAIL,PASS}_BRK() to shell API and use it to stop
> > test on first error.

> The patches look great, thanks Petr!
Finally merged :).
Thanks a lot for many patient reviews and suggestions.
I'll send another version of C netlink based tests.

Kind regards,
Petr
