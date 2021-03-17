From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 17 Mar 2021 11:56:06 +0100
Subject: [LTP] [PATCH] cleanup: Unify the annotation style and remove
 Redundant code
In-Reply-To: <YFHLCI7WPPQ/zW+X@pevik>
References: <20210317040323.26899-1-zhaogongyi@huawei.com>
 <YFHLCI7WPPQ/zW+X@pevik>
Message-ID: <YFHgRpFpN9V0Mpxf@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Gongyi,

> > Change 'Description' to 'DESCRIPTION' and change 'Algorithm' to
> > 'ALGORITHM' and remove Redundant tst_reap_children since tst_reap_children
> > has been called in the test skeleton.

> Actually the preferred form is Description (only first letter capitalized),
> see f5a269142 ("docparse: Unify Description and Algorithm titles").
> (Better would be to also update it in tests, which I haven't done).

> Thus I'd be for merging only removing tst_reap_children() (good catch).

Merged just part removing tst_reap_children().
Thanks!

Kind regards,
Petr
