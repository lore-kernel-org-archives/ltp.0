From: zhaogongyi <zhaogongyi@huawei.com>
Date: Wed, 17 Mar 2021 10:04:48 +0000
Subject: [LTP] [PATCH] cleanup: Unify the annotation style and remove
 Redundant code
Message-ID: <F3D3F6AC3820BB4C9FCA340DB5C32CB403892885@dggeml511-mbs.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

I have resubmit the patch as your review.

Thanks!

Best Regards,
Gongyi

> 
> HI Gongyi,
> 
> > Change 'Description' to 'DESCRIPTION' and change 'Algorithm' to
> > 'ALGORITHM' and remove Redundant tst_reap_children since
> > tst_reap_children has been called in the test skeleton.
> 
> Actually the preferred form is Description (only first letter capitalized), see
> f5a269142 ("docparse: Unify Description and Algorithm titles").
> (Better would be to also update it in tests, which I haven't done).
> 
> Thus I'd be for merging only removing tst_reap_children() (good catch).
> 
> Kind regards,
> Petr
