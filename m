From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 29 Apr 2019 16:33:36 +0200
Subject: [LTP] LTP Release
In-Reply-To: <20190429131331.GB6265@rei>
References: <20190418111812.GB3073@rei.lan> <20190426131258.GA18760@rei>
 <20190429102009.GC6952@dell5510> <20190429131331.GB6265@rei>
Message-ID: <20190429143336.GD6265@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
> index 131854ec7..6d1b2d4ef 100644
> --- a/include/mk/testcases.mk
> +++ b/include/mk/testcases.mk
> @@ -49,7 +49,7 @@ LTPLIBS_FILES = $(addsuffix .a, $(addprefix $(abs_top_builddir)/libs/, $(foreach
>  MAKE_DEPS += $(LTPLIBS_FILES)
>  
>  $(LTPLIBS_FILES): $(LTPLIBS_DIRS)
> -       $(MAKE) -C "$^" -f "$^/Makefile" all
> +       $(MAKE) -C "$^" -f "$(subst $(abs_top_buildir),$(abs_to_srcdir),$^)/Makefile" all
>  
>  LDFLAGS += $(addprefix -L$(top_builddir)/libs/lib, $(LTPLIBS))
> 
> I will have a look at the top level Makefile as well to see what has to
> be done there.

And I guess I found the problem.

When I tried to fix the out-of-tree build by adding a rule to create the libs
directory I overlooked that there are all rules already in place and all that
had to be added was the dependency of libs-all on the builddir libs path. After
I added the rule that created the directory the libs-all targed was fulfilled
by a redefined target that only created the directory and haven't build the
libs directory before the rest of the source tree at all. We even got target
redefinition warnings because of that.

Peter can you please test with this change:

diff --git a/Makefile b/Makefile
index c46d050ce..768ca4606 100644
--- a/Makefile
+++ b/Makefile
@@ -102,9 +102,6 @@ $(sort $(addprefix $(abs_top_builddir)/,$(BOOTSTRAP_TARGETS)) $(INSTALL_DIR) $(D
 ## Pattern based subtarget rules.
 lib-install: lib-all
 
-$(abs_top_builddir)/libs:
-       mkdir -m 00755 -p "$@"
-
 libs-all: $(abs_top_builddir)/libs
 
 $(MAKE_TARGETS) include-all lib-all libs-all:



-- 
Cyril Hrubis
chrubis@suse.cz
