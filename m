From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 4 Nov 2019 13:40:44 +0800
Subject: [LTP] [RFC] Remove {config.h,config.mk,features.mk,}.default ?
In-Reply-To: <20191101073528.GA22452@dell5510>
References: <20191101073528.GA22452@dell5510>
Message-ID: <332232ad-3b46-332d-c917-3175ff56868d@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


on 2019/11/01 15:35, Petr Vorel wrote:

> Hi,
>
> I wonder if anybody uses include/config.h.default, include/mk/config.mk.default,
> include/mk/features.mk.default. Is it their purpose for people who, for some
> reason can't run ./configure? (I wonder who'd need it) Can we just drop them?

Hi Petr

Yes. Reading LTP/INSTALL[1], these files are used when we don't use autoconf.
as below:
Using autoconf (preferred):
	$ make autotools # This must be run from "$TOP_SRCDIR"!
	$ test -d "$TOP_BUILDDIR" || mkdir -p "$TOP_BUILDDIR"
	$ cd "$TOP_BUILDDIR" && "$TOP_SRCDIR/configure" \
	  # [configure args go here, e.g. CC=$CC, LDFLAGS=$LDFLAGS, etc]

Not using autoconf:

	$ test -d "$TOP_BUILDDIR" || mkdir -p "$TOP_BUILDDIR"
	$ cp "$TOP_SRCDIR/include/config.h.default" \
	     "$TOP_BUILDDIR/include/config.h"
	$ cp "$TOP_SRCDIR/include/mk/config.mk.default" \
	     "$TOP_BUILDDIR/include/mk/config.mk"
	$ cp "$TOP_SRCDIR/include/mk/features.mk.default" \
	     "$TOP_BUILDDIR/include/mk/features.mk"

[1]https://github.com/linux-test-project/ltp/blob/master/INSTAL

ps:IMO, I don't use these files. Now most distributions have auotconf and we can remove these files.

Thanks
Yang Xu

>
> include/config.h.default is out of sync with include/config.h.in;
> include/mk/config.mk.default and include/mk/features.mk.default are synced.
>
> Kind regards,
> Petr
>


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191104/fa15eda5/attachment.htm>
