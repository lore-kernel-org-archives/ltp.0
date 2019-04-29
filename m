From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Apr 2019 22:45:27 +0200
Subject: [LTP] LTP Release
In-Reply-To: <20190429131331.GB6265@rei>
References: <20190418111812.GB3073@rei.lan> <20190426131258.GA18760@rei>
 <20190429102009.GC6952@dell5510> <20190429131331.GB6265@rei>
Message-ID: <20190429204527.GA30772@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> There are two things to fix. One that the patch from Jan attempted is
> wrong path in the rule in the testcases.mk and the second one is that
> the libraries are not build from the top level Makefile first before
> everything else.

> For the first problem fixing the path to the library Makefile should fix
> the problem, something as (beware untested) this should fix it:

> diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
> index 131854ec7..6d1b2d4ef 100644
> --- a/include/mk/testcases.mk
> +++ b/include/mk/testcases.mk
> @@ -49,7 +49,7 @@ LTPLIBS_FILES = $(addsuffix .a, $(addprefix $(abs_top_builddir)/libs/, $(foreach
>  MAKE_DEPS += $(LTPLIBS_FILES)

>  $(LTPLIBS_FILES): $(LTPLIBS_DIRS)
> -       $(MAKE) -C "$^" -f "$^/Makefile" all
> +       $(MAKE) -C "$^" -f "$(subst $(abs_top_buildir),$(abs_to_srcdir),$^)/Makefile" all

>  LDFLAGS += $(addprefix -L$(top_builddir)/libs/lib, $(LTPLIBS))

> I will have a look at the top level Makefile as well to see what has to
> be done there.
Tested-by: Petr Vorel <pvorel@suse.cz>

This one looks ok. Also testing with machine with 32 cores, ok as well (but it's
hard to trigger this bug even current master).

Kind regards,
Petr

[1] https://travis-ci.org/pevik/ltp/builds/526016709
