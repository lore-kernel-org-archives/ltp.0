From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 25 May 2018 14:10:34 +0200
Subject: [LTP] [RFC PATCH v4 4/4] tst_test.sh: Add TST_TEST_DATA and
 TST_TEST_DATA_IFS
In-Reply-To: <20180525094204.GA1314@rei>
References: <20180524152129.1067-1-pvorel@suse.cz>
 <20180524152129.1067-4-pvorel@suse.cz> <20180525094204.GA1314@rei>
Message-ID: <20180525121034.fs2v7c34punzvcbx@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

thanks for review, I'll fix bugs.

> > +_tst_run_tests()
> > +{
> > +	local data="$1"
> > +	local i

> Shouldn't we prefix these two variables with _tst_ prefix as well?
IMHO no, as _tst_run_test and _tst_run_tests is private and these variables are local.
I thought we need to change tst_run as it's run by the tests and all variables which are.

> > +_tst_run_test()
> > +{
> > +	local res=$(_tst_resstr)
> > +	local fnc="$1"
> > +	shift

> And here as well, the _tst_ prefix?
Dtto.


Kind regards,
Petr
