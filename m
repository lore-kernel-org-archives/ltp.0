From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Nov 2017 19:59:11 +0100
Subject: [LTP] [RFC PATCH 4/4] travis: Install all dependencies (headers
 and libraries)
In-Reply-To: <20171129154806.GE15160@rei>
References: <20171128232130.4843-1-pvorel@suse.cz>
 <20171128232130.4843-5-pvorel@suse.cz> <20171129154806.GE15160@rei>
Message-ID: <20171129185911.GB3573@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> >  before_install:
> > +    - sudo apt install -f -y
> > +      libacl1-dev
...

> This runs before each compilation, right?
Yes.

> Can we have one build just with the basic C devel packages as well, since that have
> found most bugs in stubs and fallback code so far.
Sure. I just need to add this code into separate shell script and add more variables
into matrix.

Kind regards,
Petr
