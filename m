From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 24 Jan 2018 14:10:43 +0100
Subject: [LTP] [PATCH 1/1] network/stress: Update README
In-Reply-To: <20180124111834.GB14773@rei.lan>
References: <20170920092918.19960-1-pvorel@suse.cz>
 <20180124111834.GB14773@rei.lan>
Message-ID: <20180124131043.dbufum2zn6ekrkzc@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,
> > networkstress.sh was merged into network.sh and then deleted in
> > fddb4f3c7 ("network: remove outdated network runtests and scripts")

> > Also same of network stress tests use test_net.sh instead of using
> > deprecated LTP_RSH.

> > This fixes #203.

> Looks good, acked.
Thanks a lot for your review!

> > Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> > ---
> > I hate 'ltp-yyyymmdd/' path prefix, but I ignored it now.

> I do not like it either about we changed that to ltp-* or ltp-foo?
I'd propose to use simple relative path, e.g. INSTALL. Most of the projects use it (at
least for files like README or INSTALL in root of source tree.

Or, if we really need absolute path, lets use $LTPROOT, e.g. $LTPROOT/INSTALL.

Kind regards,
Petr
