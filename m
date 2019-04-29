From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Apr 2019 12:20:09 +0200
Subject: [LTP] LTP Release
In-Reply-To: <20190426131258.GA18760@rei>
References: <20190418111812.GB3073@rei.lan>
 <20190426131258.GA18760@rei>
Message-ID: <20190429102009.GC6952@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > So as usually please go ahead and point out anything that should go in
> > before the release.

> Only Peter replied so far, so I suppose that we are ready to freeze git
> starting next week and start the pre-release testing.

> Or is there anything that has to be considered to be included before we
> do that?
I guess it'd be great to fix sporadic out-of-tree build failures related to
libs. Jan's patch [1] does not fixed it. I have no idea how to fix it.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/1059002/
