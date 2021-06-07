From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 7 Jun 2021 11:17:01 +0200
Subject: [LTP] [PATCH] runltp: Miscellaneous cleanups
In-Reply-To: <a75bc28f-121e-332f-197e-64e3bf15e748@uniontech.com>
References: <20210511092926.20509-1-caojin@uniontech.com>
 <YJpskTNEjIYNu2CT@yuki>
 <a75bc28f-121e-332f-197e-64e3bf15e748@uniontech.com>
Message-ID: <YL3kDQTPbYA1M+FJ@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cao jin, Cyril,

> On 5/11/21 7:37 PM, Cyril Hrubis wrote:
> > Hi!
> > The changes looks good to me but at the moment we are fairly late in the
> > release process so this will have to wait for about two weeks before it
> > could be applied.


> I am fine with that. Thanks, Cyril.
I added one more typo fix (seperate => separate) and merged.

FYI: runltp is very outdated we recommend to use runltp-ng [1].
It's not upstreamed yet, properly propagating timeout issue is the latest issue
we need to solve before upstreaming it into LTP and deprecating runltp.
We hope to make it in this release.

Kind regards,
Petr

[1] https://github.com/metan-ucw/runltp-ng/
[2] https://github.com/metan-ucw/runltp-ng/issues/31
