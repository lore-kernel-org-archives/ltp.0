From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 29 Mar 2017 11:37:54 +0200
Subject: [LTP] [RFC] [PATCH] lib32: Add support for linking 32bit
 programs on 64bit
In-Reply-To: <20170328154647.GK1045@rei>
References: <20170328100114.29730-1-chrubis@suse.cz>
 <20170328165536.741d14e5@linux-v3j5> <20170328153347.GJ1045@rei>
 <20170328154647.GK1045@rei>
Message-ID: <20170329113754.5cf917e5@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Metan,

On Tue, 28 Mar 2017 17:46:47 +0200
"Cyril Hrubis" <chrubis@suse.cz> wrote:
> 
> Try with this condition instead of the above ifeqs:
> 
> $(MAKE_TARGETS): LDFLAGS += -L$(top_builddir)/lib$(subst -m,,$(filter -m32,$(CFLAGS)))
> 
> It's a bit hairy but seems to work.
> 

It works (if added after MAKE_TARGETS is defined ofcourse) and also I
symlinked in the safe socket lib, so the test now compiles and runs fine, at
least on x86_64 SUSE.

I will try it on SLE-11 SP4 i586.

Thank you,
Richard.
