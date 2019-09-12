From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Sep 2019 17:07:40 +0200
Subject: [LTP] [PATCH v4 0/7] net/route: rewrite route-change-{dst, gw,
 if} into new API
In-Reply-To: <ed511992-8853-b7ca-9a8a-84c98f26887d@oracle.com>
References: <20190903141610.28887-1-pvorel@suse.cz>
 <df197557-8f95-52d5-813e-a5abc73a1af6@oracle.com>
 <20190912134826.GB22246@dell5510>
 <ed511992-8853-b7ca-9a8a-84c98f26887d@oracle.com>
Message-ID: <20190912150740.GA1064@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > Another option is to have single option for adding both MAX and MIN:

> > -h MIN,MAX # for HOST_ID
> > -n MIN,MAX # for NET_ID

> > (e.g. -n5,255 -h1,255)

> It can be the best option,


> > But it looks to me a bit uncomfortable having to always to add both min and max.

> max "-n ,254" or min "-n 2"?
Great, thanks! How simple and elegant solution :).


> >> * if NS_TIMES is large, there are a lot of messages in a test output
> >>   (it seems NS_TIMES * 4), could we minimize the number of them?

> > I can add -q option to tst_add_ipaddr() which usage will make it NS_TIMES * 2. (1)
> > If it's still too much I'll drop "testing route over ..." (2)
> > Other option would be to print only even Nth iteration (I don't think it's a
> > good idea) or even has only single TPASS/TFAIL.

> > BTW don't we want end testing on first failure?

> Agree, why not.
OK, it'll be in v5.

I'd prefer to change EXPECT_{PASS,FAIL} to return exit value so we can detect
the failure, but that would expect tst_res to return exit code as well.
(not sure, if it's a radical change).

Kind regards,
Petr
