From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Mar 2019 17:25:20 +0100
Subject: [LTP] [PATCH] libs: fix sporadic out-of-tree build failures
 related to libs
In-Reply-To: <3fedf790971b876b20533ee3d6b5dff27b54fae3.1553076284.git.jstancek@redhat.com>
References: <3fedf790971b876b20533ee3d6b5dff27b54fae3.1553076284.git.jstancek@redhat.com>
Message-ID: <20190320162519.GA13644@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Reported-by: Petr Vorel <pvorel@suse.cz>
> Cc: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  include/mk/testcases.mk | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
> index 131854ec7346..4cbb37640687 100644
> --- a/include/mk/testcases.mk
> +++ b/include/mk/testcases.mk
> @@ -43,17 +43,19 @@ LDLIBS		+= -lltp
>  
>  ifdef LTPLIBS
>  
> -LTPLIBS_DIRS = $(addprefix $(abs_top_builddir)/libs/lib, $(LTPLIBS))
> +LTPLIBS_DIRS = $(addprefix libs/lib, $(LTPLIBS))
>  LTPLIBS_FILES = $(addsuffix .a, $(addprefix $(abs_top_builddir)/libs/, $(foreach LIB,$(LTPLIBS),lib$(LIB)/lib$(LIB))))
>  
>  MAKE_DEPS += $(LTPLIBS_FILES)
>  
>  $(LTPLIBS_FILES): $(LTPLIBS_DIRS)
> -	$(MAKE) -C "$^" -f "$^/Makefile" all
> +	$(MAKE) -C "$(abs_top_builddir)/$^" -f "$(abs_top_srcdir)/$^/Makefile" all
>  
>  LDFLAGS += $(addprefix -L$(top_builddir)/libs/lib, $(LTPLIBS))
>  
> +$(LTPLIBS_DIRS): %:
> +	mkdir -p "$(abs_top_builddir)/$@"

The problem here is that unless the paths in LTPLIBS_DIRS match existing
files the mkdir -p is executed every time LTPLIBS is defined in
Makefile. I guess that we can put the absolute paths back to the
LTPLIBS_DIRS variable and use $(subst ..) to replace the builddir with
srcdir but I wonder if there is a better solution.

-- 
Cyril Hrubis
chrubis@suse.cz
