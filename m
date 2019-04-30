From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 30 Apr 2019 15:52:29 +0200
Subject: [LTP] [PATCH 2/2] Makefile: Fix target redefinition
In-Reply-To: <20190430133836.28400-2-chrubis@suse.cz>
References: <20190430133836.28400-1-chrubis@suse.cz>
 <20190430133836.28400-2-chrubis@suse.cz>
Message-ID: <20190430135229.GB7752@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> There is no need to add a rule for the libs directory because there is a
> generic rule for directory creation already. All we need to do is to
> make the libs-all target depend on the directory path, which we do
> already so that the directory is created before we attempt to execute
> make there.

> Fixes: 17a5b0fb63bf65eff433bdee3bf5f73826a50e0f

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Petr Vorel <pvorel@suse.cz>
> CC: Jan Stancek <jstancek@redhat.com>
> ---
Tested-by: Petr Vorel <pvorel@suse.cz>
The same as previous patch (testing both together).

Kind regards,
Petr

>  Makefile | 3 ---
>  1 file changed, 3 deletions(-)

> diff --git a/Makefile b/Makefile
> index c46d050ce..768ca4606 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -102,9 +102,6 @@ $(sort $(addprefix $(abs_top_builddir)/,$(BOOTSTRAP_TARGETS)) $(INSTALL_DIR) $(D
>  ## Pattern based subtarget rules.
>  lib-install: lib-all

> -$(abs_top_builddir)/libs:
> -	mkdir -m 00755 -p "$@"
> -
>  libs-all: $(abs_top_builddir)/libs

>  $(MAKE_TARGETS) include-all lib-all libs-all:
