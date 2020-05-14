From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 May 2020 18:52:22 +0200
Subject: [LTP] [PATCH v2 1/1] rpc: TCONF when tests aren't compiled +
 remove kill warning
In-Reply-To: <238e6613-dc03-5d7f-bb0b-baccfbe773f6@163.com>
References: <20200512201416.8299-1-pvorel@suse.cz>
 <20200514144729.GA19276@dell5510>
 <238e6613-dc03-5d7f-bb0b-baccfbe773f6@163.com>
Message-ID: <20200514165222.GA2342816@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> On 5/14/20 10:47 PM, Petr Vorel wrote:
> > Hi,

> > > with this implementation (suggested by Alexey), we get TCONF twice. It's
> > > a bit strange, but I'll keep it, because I like that required binary is
> > > printed:
> > > rpc_test 1 TCONF: 'tirpc_rpcb_getaddr' not found
> > > rpc_test 1 TCONF: LTP compiled without TI-RPC support?
> > Please any comment for 2x TCONF. It's a bit strange, but just a tiny detail.
> > I'd like to have this fix in the release.

> Hi Petr,

Hi Yang,

> Why don't you use tst_cmd_available? like this:

> for i in $CLIENT $SERVER; do

> ??? tst_cmd_available $i || tst_brk TCONF "$i not found.? LTP compiled
> without TI-RPC support?"
Thanks for a review.
Yep, I suggested similar solution in v1
https://patchwork.ozlabs.org/project/ltp/patch/20200512152701.23625-1-pvorel@suse.cz/

I like solution from v2 (suggested by Alexey) as more elegant, just 2xTCONF is a
bit confusing. But I'm hesitating too much about such a tiny detail :).

Kind regards,
Petr
