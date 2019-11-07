From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 7 Nov 2019 12:09:19 +0100
Subject: [LTP] Rename tst_test_* to tst_require_*
In-Reply-To: <20191106170152.GA17047@dell5510>
References: <20191011090737.17997-1-lkml@jv-coder.de>
 <20191011100604.GA11441@dell5510>
 <1570799029.4238.15.camel@suse.de> <20191011131041.GA18363@rei>
 <20191011140015.GA27627@dell5510> <20191024122814.GC27782@rei.lan>
 <20191024124837.GA11934@dell5510> <20191106162605.GB7509@rei.lan>
 <20191106170152.GA17047@dell5510>
Message-ID: <20191107110919.GA439@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > Gentle reminder, this timeouts tomorrow when I will apply the original
> > patches, unless someone steps in.
> OK, if nobody objects, tomorrow I'll modify Joerg's patchset to be
> "Rename tst_test_* to tst_needs_*" and push it on his behalf.

> I like *require* more, but it's better to have the same name for variables
> and functions.
Actually thinking about it twice, I'm going to apply the original patch.
*require* is really more descriptive.

Kind regards,
Petr
