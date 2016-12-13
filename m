From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Dec 2016 14:52:33 +0100
Subject: [LTP] [PATCH v3 1/4] syscalls/ipc: add newipc library for new
	API
In-Reply-To: <1481614745-27778-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20161212142847.GD21828@rei.lan>
 <1481614745-27778-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20161213135233.GB750@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- a/testcases/kernel/syscalls/ipc/Makefile
> +++ b/testcases/kernel/syscalls/ipc/Makefile
> @@ -1,19 +1,18 @@
>  #
> -#  Copyright (c) International Business Machines  Corp., 2001
> +# Copyright (c) International Business Machines  Corp., 2001
>  #
> -#  This program is free software;  you can redistribute it and/or modify
> -#  it under the terms of the GNU General Public License as published by
> -#  the Free Software Foundation; either version 2 of the License, or
> -#  (at your option) any later version.
> +# This program is free software;  you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
>  #
> -#  This program is distributed in the hope that it will be useful,
> -#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
> -#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> -#  the GNU General Public License for more details.
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +# the GNU General Public License for more details.
>  #
> -#  You should have received a copy of the GNU General Public License
> -#  along with this program;  if not, write to the Free Software
> -#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +# You should have received a copy of the GNU General Public License
> +# along with this program.
>  #
>  
>  top_srcdir		?= ../../../..
> @@ -21,20 +20,19 @@ top_srcdir		?= ../../../..
>  include $(top_srcdir)/include/mk/env_pre.mk
>  
>  LIBDIR			:= lib
> -FILTER_OUT_DIRS		:= $(LIBDIR)
> -LIB			:= $(LIBDIR)/libipc.a $(LIBDIR)/libmsgctl.a
> +NEWLIBDIR		:= libnewipc
> +LIB			:= $(LIBDIR)/libipc.a $(LIBDIR)/libmsgctl.a $(NEWLIBDIR)/libnewipc.a
>  
> -$(LIBDIR):
> -	mkdir -p "$@"
> -
> -$(LIB): $(LIBDIR)
> -	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
> +$(LIB): $(LIBDIR) $(NEWLIBDIR)
> +	$(MAKE) -C $(LIBDIR) -f "$(abs_srcdir)/$(LIBDIR)/Makefile" all
> +	$(MAKE) -C $(NEWLIBDIR) -f "$(abs_srcdir)/$(NEWLIBDIR)/Makefile" all
>  
>  MAKE_DEPS		:= $(LIB)
>  
>  trunk-clean:: | lib-clean
>  
> -lib-clean:: $(LIBDIR)
> -	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
> +lib-clean:: $(LIBDIR) $(NEWLIBDIR)
> +	$(MAKE) -C $(LIBDIR) -f "$(abs_srcdir)/$(LIBDIR)/Makefile" clean
> +	$(MAKE) -C $(NEWLIBDIR) -f "$(abs_srcdir)/$(NEWLIBDIR)/Makefile" clean

I've just found that this whole Makefile has been broken for ages and
that the old library was build only by the inclusion of the Makefile.inc
in the test directories, I wonder why this wasn't breaking parallel
build at all. The whole reason is that MAKE_DEPS is ignored when
MAKE_TARGETS is empty so the $(LIB) targets are not rebuild and removing
the $(LIBDIR) from FILTER_OUT_DIRS is not solution either since that
will break parallel build for sure.

I will do something about this. One solution may be to set the
MAKE_TARGETS to some phony target if it's empty. Let's see if I can
figure out something better.

-- 
Cyril Hrubis
chrubis@suse.cz
