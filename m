From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Apr 2019 23:07:08 +0200
Subject: [LTP] LTP Release
In-Reply-To: <20190429143336.GD6265@rei>
References: <20190418111812.GB3073@rei.lan> <20190426131258.GA18760@rei>
 <20190429102009.GC6952@dell5510> <20190429131331.GB6265@rei>
 <20190429143336.GD6265@rei>
Message-ID: <20190429210708.GB30772@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > I will have a look at the top level Makefile as well to see what has to
> > be done there.

> And I guess I found the problem.

> When I tried to fix the out-of-tree build by adding a rule to create the libs
> directory I overlooked that there are all rules already in place and all that
> had to be added was the dependency of libs-all on the builddir libs path. After
> I added the rule that created the directory the libs-all targed was fulfilled
> by a redefined target that only created the directory and haven't build the
> libs directory before the rest of the source tree at all. We even got target
> redefinition warnings because of that.

> Peter can you please test with this change:

Sure! While this one is ok [1], and also with previous patch [2].
But when tested on real HW with 32 cores (with merged both commits), where it
took me 6 iterations to trigger this error :( (5 iterations was needed to
trigger error on the current master).

Kind regards,
Petr
[1] https://travis-ci.org/pevik/ltp/builds/526011623
[2] https://travis-ci.org/pevik/ltp/builds/526017203

> diff --git a/Makefile b/Makefile
> index c46d050ce..768ca4606 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -102,9 +102,6 @@ $(sort $(addprefix $(abs_top_builddir)/,$(BOOTSTRAP_TARGETS)) $(INSTALL_DIR) $(D
>  ## Pattern based subtarget rules.
>  lib-install: lib-all

> -$(abs_top_builddir)/libs:
> -       mkdir -m 00755 -p "$@"
> -
>  libs-all: $(abs_top_builddir)/libs

>  $(MAKE_TARGETS) include-all lib-all libs-all:
