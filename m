From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 Jan 2021 11:02:53 +0100
Subject: [LTP] [PATCH v2 1/1] syscalls/get_mempolicy01: Rewrite to new
 API
In-Reply-To: <CAEemH2dVgwHREFGrOe1tNUgZXZn5OAo5PJ-nne_yoj2nRHt=pw@mail.gmail.com>
References: <20210106181735.1588-1-pvorel@suse.cz>
 <CAEemH2dVgwHREFGrOe1tNUgZXZn5OAo5PJ-nne_yoj2nRHt=pw@mail.gmail.com>
Message-ID: <YA6XTdOpqlXg2ybX@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

...
> > +               struct bitmask *exp_mask = *(tc->exp_nodemask);
> > +
> > +               if (!numa_bitmask_equal(exp_mask, getnodemask)) {
> > +                       tst_res(TFAIL, "masks are not equal");
> > +                       tst_res_hexd(TINFO, exp_mask->maskp,
> > +                               exp_mask->size / 8, "expected:");
> > +                       tst_res_hexd(TINFO, getnodemask->maskp,
> > +                               getnodemask->size / 8, "returned:");
> > +               }


> These few lines have a code indent issue, otherwise looks good.

> Reviewed-by: Li Wang <liwang@redhat.com>

Thanks for your review, merged with fixed indent.

Kind regards,
Petr
