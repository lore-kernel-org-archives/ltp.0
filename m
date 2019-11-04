From: Enji Cooper (yaneurabeya) <yaneurabeya@gmail.com>
Date: Sun, 3 Nov 2019 22:52:21 -0800
Subject: [LTP] [RFC] Remove {config.h,config.mk,features.mk,}.default ?
In-Reply-To: <20191104062340.GA9263@dell5510>
References: <20191101073528.GA22452@dell5510>
 <332232ad-3b46-332d-c917-3175ff56868d@cn.fujitsu.com>
 <20191104062340.GA9263@dell5510>
Message-ID: <D2E9CFA1-F49E-4522-8EB3-77D5FAE93371@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> On Nov 3, 2019, at 22:23, Petr Vorel <pvorel@suse.cz> wrote:
> 
> Hi Xu,
> 
>> Yes. Reading LTP/INSTALL[1], these files are used when we don't use autoconf.
>> as below:
>> Using autoconf (preferred):
>> 	$ make autotools # This must be run from "$TOP_SRCDIR"!
>> 	$ test -d "$TOP_BUILDDIR" || mkdir -p "$TOP_BUILDDIR"
>> 	$ cd "$TOP_BUILDDIR" && "$TOP_SRCDIR/configure" \
>> 	  # [configure args go here, e.g. CC=$CC, LDFLAGS=$LDFLAGS, etc]
> 
>> Not using autoconf:
> 
>> 	$ test -d "$TOP_BUILDDIR" || mkdir -p "$TOP_BUILDDIR"
>> 	$ cp "$TOP_SRCDIR/include/config.h.default" \
>> 	     "$TOP_BUILDDIR/include/config.h"
>> 	$ cp "$TOP_SRCDIR/include/mk/config.mk.default" \
>> 	     "$TOP_BUILDDIR/include/mk/config.mk"
>> 	$ cp "$TOP_SRCDIR/include/mk/features.mk.default" \
>> 	     "$TOP_BUILDDIR/include/mk/features.mk"
> 
>> [1]https://github.com/linux-test-project/ltp/blob/master/INSTAL
> 
>> ps:IMO, I don't use these files. Now most distributions have auotconf and we can remove these files.
> Thanks for review, I'll send a patch to ML.

The reason for having a non-autoconf path is purely legacy now (like 6-10+ years ago). I vote for axing the support.
Thanks,
-Enji
