From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 Nov 2015 12:51:14 +0100
Subject: [LTP] [PATCH 1/2] preadv/preadv01.c: add new testcase
In-Reply-To: <ED6C2EA93386DC4AA15AFF52D89BAB228D0C90@G08CNEXMBPEKD02.g08.fujitsu.local>
References: <1446591451-11075-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20151103143031.GD5795@rei>
 <ED6C2EA93386DC4AA15AFF52D89BAB228D0C90@G08CNEXMBPEKD02.g08.fujitsu.local>
Message-ID: <20151104115113.GA17823@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Hi!
> Thank you for reply!

Can you pretty please set you email cliend to prefix quoted text in the
reply?

https://en.wikipedia.org/wiki/Posting_style#Quoted_line_prefix

> > +# FIXME (garrcoop): more messy format strings.
> > +CPPFLAGS		+= -Wno-error
> 
> This workaround should be needed at all.
> 
> > +%_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64
> > +
> > +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> 
> ...
> 
> Do you mean that this workaround can be removed ? I will remove it.

LTP is not build with -Werror hence there is absolutely no need to add
-Wno-error to CPPFLAGS.

-- 
Cyril Hrubis
chrubis@suse.cz
