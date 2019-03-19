From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Mar 2019 15:49:35 +0100
Subject: [LTP] Travis failures
In-Reply-To: <806790692.10036950.1552938781363.JavaMail.zimbra@redhat.com>
References: <20190318175549.GB3892@dell5510>
 <806790692.10036950.1552938781363.JavaMail.zimbra@redhat.com>
Message-ID: <20190319144935.GK6204@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > quite often I see in my travis builds liblitpnuma.a related failures [1] (one
> > random out-of-tree build), which gets fixed by restarting it. Any idea why?
> 
> Looks like when it gets built via ./libs it works, but if it's pulled
> as dependency first, it fails:

Which is bug itself, we have to build it via libs otherwise this will
break if more than one of these directories will pull it as dependency
at the same time.

> # make -C $(pwd)/../ltp-build/testcases/kernel/syscalls/set_mempolicy/ -f $(pwd)/testcases/kernel/syscalls/set_mempolicy/Makefile top_srcdir=$(pwd) top_builddir=$(pwd)/../ltp-build
> make: Entering directory `/root/ltp-build/testcases/kernel/syscalls/set_mempolicy'
> make -C "/root/ltp-build/libs/libltpnuma" -f "/root/ltp-build/libs/libltpnuma/Makefile" all
> make[1]: Entering directory `/root/ltp-build/libs/libltpnuma'
> make[1]: /root/ltp-build/libs/libltpnuma/Makefile: No such file or directory
> make[1]: *** No rule to make target `/root/ltp-build/libs/libltpnuma/Makefile'.  Stop.
> make[1]: Leaving directory `/root/ltp-build/libs/libltpnuma'
> make: *** [/root/ltp-build/libs/libltpnuma/libltpnuma.a] Error 2
> make: Leaving directory `/root/ltp-build/testcases/kernel/syscalls/set_mempolicy'
> 
> Maybe something like this to fix it?
> 
> diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
> index 131854e..55cf4da 100644
> --- a/include/mk/testcases.mk
> +++ b/include/mk/testcases.mk
> @@ -43,13 +43,13 @@ LDLIBS              += -lltp
> 
>  ifdef LTPLIBS
> 
> -LTPLIBS_DIRS = $(addprefix $(abs_top_builddir)/libs/lib, $(LTPLIBS))
> +LTPLIBS_DIRS = $(LTPLIBS)
>  LTPLIBS_FILES = $(addsuffix .a, $(addprefix $(abs_top_builddir)/libs/, $(foreach LIB,$(LTPLIBS),lib$(LIB)/lib$(LIB))))
> 
>  MAKE_DEPS += $(LTPLIBS_FILES)
> 
>  $(LTPLIBS_FILES): $(LTPLIBS_DIRS)
> -       $(MAKE) -C "$^" -f "$^/Makefile" all
> +       $(MAKE) -C "$(addprefix $(abs_top_builddir)/libs/lib, $^)" -f "$(addprefix $(abs_top_srcdir)/libs/lib, $^)/Makefile" all

Well we can use LTPLIBS directly here, and there is no need to use
addprefix if we are not applying the change to a set, so I guess that
following will work as well:

$(MAKE) -C "$(abs_top_builddir)/libs/lib)$^" -f "$(abs_top_srcdir)/libs/lib)$^/Makefile" all

Otherwise this is a good catch, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
