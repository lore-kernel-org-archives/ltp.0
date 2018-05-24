From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 24 May 2018 09:59:40 +0200
Subject: [LTP] [PATCH v2 ltp] Add .cache.mk and *.dwo into clean target
 and .gitignore
In-Reply-To: <20180522030331.28252-1-yixin.zhang@intel.com>
References: <20180522030331.28252-1-yixin.zhang@intel.com>
Message-ID: <20180524075940.prbtar2gylm6mnl4@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yixin,

> These files are generated during build, so and them into clean target
> and .gitignore

> Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
> ---
>  .gitignore             | 2 ++
>  include/mk/env_post.mk | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)

> diff --git a/.gitignore b/.gitignore
> index a7e65633f..b838efd59 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -8,6 +8,8 @@ core
>  .gdb_history
>  .gdbinit
>  lib*.a
> +.cache.mk
> +*.dwo

>  /aclocal.m4
>  autom4te.cache
> diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
> index 4c57fffe4..913bdf5d1 100644
> --- a/include/mk/env_post.mk
> +++ b/include/mk/env_post.mk
> @@ -54,7 +54,8 @@ MAKE_TARGETS			?= $(notdir $(patsubst %.c,%,$(wildcard $(abs_srcdir)/*.c)))

>  MAKE_TARGETS			:= $(filter-out $(FILTER_OUT_MAKE_TARGETS),$(MAKE_TARGETS))

> -CLEAN_TARGETS			+= $(MAKE_TARGETS) *.o *.pyc
> +# with only *.dwo, .[0-9]+.dwo can not be cleaned
> +CLEAN_TARGETS			+= $(MAKE_TARGETS) *.o *.pyc .cache.mk *.dwo .*.dwo

>  # Majority of the files end up in testcases/bin...
>  INSTALL_DIR			?= testcases/bin

Thanks, pushed!


Kind regards,
Petr
