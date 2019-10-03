From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Oct 2019 13:44:28 +0200
Subject: [LTP] [RFC PATCH 2/2] doc: Add user-guide.txt
In-Reply-To: <20190930115852.21672-3-pvorel@suse.cz>
References: <20190930115852.21672-1-pvorel@suse.cz>
 <20190930115852.21672-3-pvorel@suse.cz>
Message-ID: <20191003114428.GC1858@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> atm it's just a stub, containing only Library environment variables
> section and Colorized output (moved from colorized-output.txt).
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  README.md                |  4 +++-
>  doc/colorized-output.txt | 10 ----------
>  doc/user-guide.txt       | 29 +++++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 11 deletions(-)
>  delete mode 100644 doc/colorized-output.txt
>  create mode 100644 doc/user-guide.txt
> 
> diff --git a/README.md b/README.md
> index b406a4a44..b0a024fcc 100644
> --- a/README.md
> +++ b/README.md
> @@ -155,7 +155,7 @@ $ testcases/bin/ioctl01 -h
>  Many require certain environment variables to be set
>  
>  ```
> -$ LTPROOT=/opt/ltp PATH="$PATH:$LTPROOT/testcases/bin" testcases/bin/wc01.sh
> +$ LTPROOT=/opt/ltp PATH="$PATH:$LTPROOT/bin:$LTPROOT/testcases/bin" testcases/bin/wc01.sh
>  ```

This looks like an unrelated change at best and should probably be part
of a separate patch.

Also the only thing that seems to be installed in $LTPROOT/bin/ that
could be potentially used by tests is the ffsb tool, that we are going
to get rid anyways. So I would have avoided including it in the example
anyways.

>  Most commonly, the path variable needs to be set and also `LTPROOT`, but there
> @@ -165,6 +165,8 @@ Note that all shell scripts need the `PATH` to be set. However this is not
>  limited to shell scripts, many C based tests need environment variables as
>  well.
>  
> +For more info see `doc/user-guide.txt`.
> +
>  Developers corner
>  =================
>  
> diff --git a/doc/colorized-output.txt b/doc/colorized-output.txt
> deleted file mode 100644
> index c1859ccfb..000000000
> --- a/doc/colorized-output.txt
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -Colorized output
> -================
> -
> -1. Usage
> ---------
> -By default LTP colorizes it's output unless using pipe or redirect to file.
> -
> -It's possible to force behaviour with LTP_COLORIZE_OUTPUT environment variable:
> -y or 1: always colorize
> -n or 0: never colorize
> diff --git a/doc/user-guide.txt b/doc/user-guide.txt
> new file mode 100644
> index 000000000..5d9208bff
> --- /dev/null
> +++ b/doc/user-guide.txt
> @@ -0,0 +1,29 @@
> +LTP User Guidelines
> +===================
> +
> +For compiling and installing and running the tests see `README.md`.
> +For running LTP network tests see `testcases/network/README.md`.
> +
> +1. Library environment variables
> +--------------------------------
> +
> +|==============================================================================
> +| 'KCONFIG_PATH'        | The path to the kernel config file, (if not set, it tries
> +                          the usual paths '/boot/config-RELEASE' or '/proc/config.gz').
> +| 'LTPROOT'             | Prefix for installed LTP, the default is '/opt/ltp'.
> +| 'LTP_COLORIZE_OUTPUT' | Force colorized output behaviour. 'y' or '1': always colorize
> +                          'n' or '0': never colorize.
> +| 'LTP_TIMEOUT_MUL'     | Multiply timeout, must be number >= 1 (> 1 is useful for
> +                          slow machines to avoid unexpected timeout).
> +                          Variable is also used in shell tests.
> +| 'PATH'                | It's required to addjust path:
> +                          `PATH="$PATH:$LTPROOT/bin:$LTPROOT/testcases/bin"`
> +| 'TMPDIR'              | Base directory for template directory, which is required by C tests
> +                          `tst_test->needs_tmpdir=1` (or others) or shell 'TST_NEEDS_TMPDIR=1').
> +|==============================================================================
> +
> +2. Colorized output
> +-------------------
> +
> +By default LTP colorizes it's output unless using pipe or redirect to file.
> +It's possible to force behaviour with 'LTP_COLORIZE_OUTPUT' environment variable.
> -- 
> 2.23.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
