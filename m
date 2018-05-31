From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 31 May 2018 07:55:51 +0200
Subject: [LTP] [RFC PATCH v5 2/5] tst_test.sh: Warn about using
 "private" variable or function
In-Reply-To: <9c849736-05c7-5725-f436-3c252988784a@oracle.com>
References: <20180525215725.7218-1-pvorel@suse.cz>
 <20180525215725.7218-3-pvorel@suse.cz>
 <9c849736-05c7-5725-f436-3c252988784a@oracle.com>
Message-ID: <20180531055551.GA3369@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

...
> > +		for _tst_i in $(grep _tst_ "$TST_TEST_PATH" | sed 's/.*_tst_//; s/[="} \t\/:`].*//'); do
> > +			tst_res TWARN "Private variable or function _tst_$_tst_i used!"

> Hi Petr,


> For example "do_virt_dev_tst_01()" function name in the test, it is
> also a private function name?
No, the goal was to separate library names (e.g. anything in tst_test.sh) from test
itself. I.e. we can use any name in test, just avoid using namespace _tst_ (or TST_ except
doing the setup itself.


Kind regards,
Petr
