From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 4 Apr 2018 15:15:32 +0200
Subject: [LTP] [RFC PATCH v3 2/5] tst_test.sh: Introduce
	TST_NO_DEFAULT_RUN
In-Reply-To: <20180404130806.GG32109@rei>
References: <20180403154717.22491-1-pvorel@suse.cz>
 <20180403154717.22491-3-pvorel@suse.cz>
 <20180404130806.GG32109@rei>
Message-ID: <20180404131532.GA11423@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > -if [ -z "$LTPROOT" ]; then
> > -	export LTPROOT="$PWD"
> > -	export TST_DATAROOT="$LTPROOT/datafiles"
> > -else
> > -	export TST_DATAROOT="$LTPROOT/testcases/data/$TST_ID"
> > -fi
> > +	if [ -z "$LTPROOT" ]; then
> > +		export LTPROOT="$PWD"
> > +		export TST_DATAROOT="$LTPROOT/datafiles"
> > +	else
> > +		export TST_DATAROOT="$LTPROOT/testcases/data/$TST_ID"
> > +	fi

> I guess that we may want to initialize the TST_ID, LTPROOT and
> TST_DATAROOT regardless, otherwise this looks pretty much
> straighforward and okay.
Thanks for feedback, Cyril!
I'll change it in v4.


Kind regards,
Petr
