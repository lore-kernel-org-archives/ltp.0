From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Jul 2019 16:42:46 +0200
Subject: [LTP] [PATCH v2 1/2] m4: remove some useless m4
In-Reply-To: <20190729131619.GB27006@rei.lan>
References: <1b8b7f73-fd31-58d2-5162-3648fa9729a5@163.com>
 <1563789167-2328-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190729122621.GB5872@dell5510> <20190729131619.GB27006@rei.lan>
Message-ID: <20190729144227.GA8824@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > > Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> > Acked-by: Petr Vorel <pvorel@suse.cz>

> > Although I wonder whether mixing 4 changes (even related to autoconf)
> > in single commit is a good idea (makes it a bit hard to review).

> Yes please, at least the SPDX conversion has to be in a separate patch.
+1

BTW m4/ltp-signalfd.m4 would require cleanup as well.

Kind regards,
Petr
