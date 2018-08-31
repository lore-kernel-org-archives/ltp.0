From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 31 Aug 2018 14:37:03 +0200
Subject: [LTP] [RFC PATCH 2/2] make: Add test target
In-Reply-To: <20180821140547.2509-3-pvorel@suse.cz>
References: <20180821140547.2509-1-pvorel@suse.cz>
 <20180821140547.2509-3-pvorel@suse.cz>
Message-ID: <20180831123703.GA3015@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> ----- Original Message -----
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  Makefile           |  3 +++
> >  lib/tests/Makefile |  3 +++
> >  lib/tests/test.sh  | 32 ++++++++++++++++++++++++++++++++
> >  3 files changed, 38 insertions(+)
> >  create mode 100755 lib/tests/test.sh
> > +
> > +for i in $@; do
> > +    echo "=== Testing '$i' ==="
> > +    case $i in
> > +        tst_checkpoint_wake_timeout|tst_record_childstatus)
> > +        if [ "$i" = "tst_record_childstatus" ]; then
> > +            echo "NOTE: expecting fail the test"
> > +            ./$i || [ $? -eq 1 ]
> > +        fi

> I'd prefer we fix the tests and make them return 0 if everything goes as expected.
Agree. But I took different folder. As Cyril pointed out, tests in lib/tests/
are for legacy API. I'm going to test new ones from lib/newlib_tests/.

As Christian works on #312 "Unit testing the shell library" [1], I'd like if
both shell and C tests had the same approach of testing.

I wonder whether to keep these tests in lib/tests/. At least some of them aren't
meant to be for unit testing (due expecting failing), nobody runs them, ...

[1] https://github.com/linux-test-project/ltp/issues/312

> Regards,
> Jan
