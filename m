From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 22 Jun 2018 13:21:21 +0200
Subject: [LTP] [PATCH 6/6] net/{stress,
 virt}: Migrate tests using virt_lib.sh and ipsec_lib.sh
In-Reply-To: <1c6ef1f5-eb0f-f691-e172-4bb88137745e@oracle.com>
References: <20180618173707.30351-1-pvorel@suse.cz>
 <20180618173707.30351-7-pvorel@suse.cz>
 <1c6ef1f5-eb0f-f691-e172-4bb88137745e@oracle.com>
Message-ID: <20180622112121.wxlqdjuybjspctvv@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Hi Petr,

> Thanks for the patches, good work! Some comments below.
Thanks for your review! Agree on everything, but the last one is problematic.


> > --- a/testcases/network/virt/vlan02.sh
> > +++ b/testcases/network/virt/vlan02.sh

> > -TCID=vlan02
> > -TST_TOTAL=1
> > -
> >  virt_type="vlan"

> > +TST_TESTFUNC=do_test

> Shouldn't it be virt_add_delete_test with TST_TEST_DATA?
no, virt_add_delete_test uses $@ and it's used by virt_test_02.
As TST_TEST_DATA uses format: $1 for test number and $2 data itself we'd have to
pass fake param $1 when call it, which would be very ugly.

Now I'm thinking (too late), whether would be better swap params passed by TST_TEST_DATA
(i.e. $1 for data itself and $2 for test number). But as normal testing with
TST_CNT uses $1 for test number, I wanted be consistent.

Sometimes I regret that we don't have also TST_TESTFUNC_PARAMS, which would be
passed to TST_TESTFUNC just once. But we already have several ways how to start
functions...

> >  . virt_lib.sh

> > -virt_add_delete_test "id 4094"
> > +do_test()
> > +{
> > +	virt_add_delete_test "id 4094"
> > +}

> > -tst_exit
> > +tst_run

I've fixed some other minor issues. I'll give it a bit of testing and send v2.


Kind regards,
Petr
