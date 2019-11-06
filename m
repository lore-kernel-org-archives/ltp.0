From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 6 Nov 2019 18:01:54 +0100
Subject: [LTP] Rename tst_test_* to tst_require_*
In-Reply-To: <20191106162605.GB7509@rei.lan>
References: <20191011090737.17997-1-lkml@jv-coder.de>
 <20191011100604.GA11441@dell5510>
 <1570799029.4238.15.camel@suse.de> <20191011131041.GA18363@rei>
 <20191011140015.GA27627@dell5510> <20191024122814.GC27782@rei.lan>
 <20191024124837.GA11934@dell5510> <20191106162605.GB7509@rei.lan>
Message-ID: <20191106170152.GA17047@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > > I would like to end the bikeshedding now and also get the tests fixed so
> > > here is the proposal. If anyone wants to send a patch that unifies the
> > > API on tst_needs_* please do so. If no one starts at least working on
> > > that in a week or two, let's merge this patchset. Does that sound
> > > reasonable to everyone?

> Gentle reminder, this timeouts tomorrow when I will apply the original
> patches, unless someone steps in.
OK, if nobody objects, tomorrow I'll modify Joerg's patchset to be
"Rename tst_test_* to tst_needs_*" and push it on his behalf.

I like *require* more, but it's better to have the same name for variables
and functions.

Kind regards,
Petr
