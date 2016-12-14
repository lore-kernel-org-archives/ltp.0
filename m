From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Dec 2016 09:23:15 +0100
Subject: [LTP] [PATCH v3 1/4] syscalls/ipc: add newipc library for new
	API
In-Reply-To: <20161213135233.GB750@rei.lan>
References: <20161212142847.GD21828@rei.lan>
 <1481614745-27778-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20161213135233.GB750@rei.lan>
Message-ID: <20161214082315.GA16198@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I've just found that this whole Makefile has been broken for ages and
> that the old library was build only by the inclusion of the Makefile.inc
> in the test directories, I wonder why this wasn't breaking parallel
> build at all. The whole reason is that MAKE_DEPS is ignored when
> MAKE_TARGETS is empty so the $(LIB) targets are not rebuild and removing
> the $(LIBDIR) from FILTER_OUT_DIRS is not solution either since that
> will break parallel build for sure.
> 
> I will do something about this. One solution may be to set the
> MAKE_TARGETS to some phony target if it's empty. Let's see if I can
> figure out something better.

And, after a bit of research, I've realized, that without introducing
larger changes in the build system the only reasonable way how to build
a library is by using the Makefile.inc in all test subdirectories that
use it. That works since the make in subdirectories is executed in a
shell loop, which means that we will never end up building the same
library at the same time from several subdirectories.

So the correct way how to fix this issue is to add the libnewipc to the
FILTER_OUT_DIRS and create Makefile2.inc similar to Makefile.inc. I will
change the first patch to do exactly that and push the patchset.

-- 
Cyril Hrubis
chrubis@suse.cz
