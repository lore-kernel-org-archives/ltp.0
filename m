From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 1 Jun 2021 12:03:56 +0200
Subject: [LTP] [PATCH 0/3] CI: Move from Travis to GitHub Actions
In-Reply-To: <CAASaF6zQt38sSkA7PDNZL53J7gbOXTCgC54Xbwb6qe=7-_wpWg@mail.gmail.com>
References: <20210531165052.8731-1-pvorel@suse.cz>
 <CAASaF6zQt38sSkA7PDNZL53J7gbOXTCgC54Xbwb6qe=7-_wpWg@mail.gmail.com>
Message-ID: <YLYGDIIvhKQB+2Ad@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> On Mon, May 31, 2021 at 6:51 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi,

> > Travis often false positive due "pull rate limit" issue [1],
> > thus I decided to finally switch to GitHub Actions.

> > Also using GitHub native CI allows more advanced features
> > (e.g. update wiki with doc/*.txt, nightly build docparser doc).

> > Whole thing is tested [2].

> > I rewritten build.sh, added -r step.
> > It's ugly, using commands in yaml would be more readable. But I'd prefer
> > 1) not writting shell in yaml 2) have build script for local use.

> > Please comment, test.


> We should update docs too, but series looks OK, ACK.

Hi Jan,

thanks! I was thinking about it but than forgot.
I'll fix it now.
I was a bit fast with merging.

Kind regards,
Petr
