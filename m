From: Li Wang <liwang@redhat.com>
Date: Mon, 2 Nov 2020 18:17:55 +0800
Subject: [LTP] [PATCH v2 2/2] lib/tst_kconfig: Make use of boolean
 expression eval
In-Reply-To: <20201027110446.20416-3-chrubis@suse.cz>
References: <20201027110446.20416-1-chrubis@suse.cz>
 <20201027110446.20416-3-chrubis@suse.cz>
Message-ID: <CAEemH2cOcAuoPcks4FPaTaS-THtjPvy+=uB3oGsnTSNp_umpMg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Oct 27, 2020 at 7:04 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Now each string in the kconfig[] array in tst_test structure is an
> boolean expression which is evaluated. All expressions has to be true in
> order for the test to continue.
>
> This also makes the parser for the kernel config a bit more robust as it
> was pointed out that there may have been cases where it could be mislead
> by hand edited config files.
>
> + Update the docs.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Pengfei Xu <pengfei.xu@intel.com>
> ---
>
> v2:
>    - squashed the two patches since we are doing more extensive changes
>    - made the parser a bit more robust
>    - renamed a few fucntions and identifiers to make the code easier to
>      understand
>    - sprinkled the code with consts
>
>  doc/test-writing-guidelines.txt |  21 +-
>  include/tst_kconfig.h           |  34 +--
>  lib/newlib_tests/config06       |   1 +
>  lib/newlib_tests/test_kconfig.c |   1 +
>  lib/tst_kconfig.c               | 362 +++++++++++++++++++++-----------
>  5 files changed, 270 insertions(+), 149 deletions(-)
>  create mode 100644 lib/newlib_tests/config06
>
> diff --git a/doc/test-writing-guidelines.txt
> b/doc/test-writing-guidelines.txt
> index 1a51ef7c7..3c2ab7166 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -1643,21 +1643,26 @@ on the system, disabled syscalls can be detected
> by checking for 'ENOSYS'
>  errno etc.
>
>  However in rare cases core kernel features couldn't be detected based on
> the
> -kernel userspace API and we have to resort to kernel .config parsing.
> +kernel userspace API and we have to resort to parse the kernel .config.
>
> -For this cases the test should set the 'NULL' terminated
> '.needs_kconfigs' array
> -of kernel config options required for the test. The config option can be
> -specified either as plain "CONFIG_FOO" in which case it's sufficient for
> the
> -test continue if it's set to any value (typically =y or =m). Or with a
> value
> -as "CONFIG_FOO=bar" in which case the value has to match as well. The
> test is
> -aborted with 'TCONF' if any of the required options were not set.
> +For this cases the test should set the 'NULL' terminated '.needs_kconfigs'
> +array of boolean expressions with constraints on the kconfig variables.
> The
> +boolean expression consits of variables, two binary operations '&' and
> '|',
> +negation '!' and correct sequence of parentesis '()'. Variables are
> expected
> +to be in a form of "CONFIG_FOO[=bar]".
> +
> +The test will continue to run if all expressions are evaluated to 'True'.
> +Missing variable is mapped to 'False' as well as variable with different
> than
> +specified value, e.g. 'CONFIG_FOO=bar' will evaluate to 'False' if the
> value
> +is anything else but 'bar'. If config variable is specified as plain
> +'CONFIG_FOO' it's evaluated to true it's set to any value (typically =y
> or =m).
>
>  [source,c]
>
>  -------------------------------------------------------------------------------
>  #include "tst_test.h"
>
>  static const char *kconfigs[] = {
> -       "CONFIG_X86_INTEL_UMIP",
> +       "CONFIG_X86_INTEL_UMIP | CONFIG_X86_UMIP",
>         NULL
>  };
>
> diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
> index 2d2cfd782..1bb21fea8 100644
> --- a/include/tst_kconfig.h
> +++ b/include/tst_kconfig.h
> @@ -6,27 +6,27 @@
>  #ifndef TST_KCONFIG_H__
>  #define TST_KCONFIG_H__
>
> -struct tst_kconfig_res {
> -       char match;
> -       char *value;
> +struct tst_kconfig_var {
> +       char id[64];
> +       unsigned int id_len;
> +       char choice;
> +       char *val;
>  };
>
>  /**
> - * Reads a kernel config and parses it for values defined in kconfigs
> array.
> + *
> + * Reads a kernel config, parses it and writes results into an array of
> + * tst_kconfig_var structures.
>   *
>   * The path to the kernel config should be autodetected in most of the
> cases as
>   * the code looks for know locations. It can be explicitely set/overrided
> with
>   * the KCONFIG_PATH environment variable as well.
>   *
> - * The kcofings array is expected to contain strings in a format
> "CONFIG_FOO"
> - * or "CONFIG_FOO=bar". The result array has to be suitably sized to fit
> the
> - * results.
> - *
> - * @param kconfigs array of config strings to look for
> - * @param results array to store results to
> - * @param cnt size of the arrays
> + * The caller has to initialize the tst_kconfig_var structure. The id has
> to be
> + * filled with config variable name such as 'CONFIG_FOO', the id_len
> should
> + * hold the id string length and the choice and val has to be zeroed.
>   *
> - * The match in the tst_kconfig_res structure is set as follows:
> + * After a call to this function each choice be set as follows:
>   *
>   *  'm' - config option set to m
>   *  'y' - config option set to y
> @@ -34,11 +34,13 @@ struct tst_kconfig_res {
>   *  'n' - config option is not set
>   *   0  - config option not found
>   *
> - * In the case that match is set to 'v' the value points to a newly
> allocated
> - * string that holds the value.
> + * In the case that match is set to 'v' the val pointer points to a newly
> + * allocated string that holds the value.
> + *
> + * @param vars An array of caller initalized tst_kconfig_var structures.
> + * @param vars_len Length of the vars array.
>   */
> -void tst_kconfig_read(const char *const kconfigs[],
> -                     struct tst_kconfig_res results[], size_t cnt);
> +void tst_kconfig_read(struct tst_kconfig_var vars[], size_t vars_len);
>
>  /**
>   * Checks if required kernel configuration options are set in the kernel
> diff --git a/lib/newlib_tests/config06 b/lib/newlib_tests/config06
> new file mode 100644
> index 000000000..b7db25411
> --- /dev/null
> +++ b/lib/newlib_tests/config06
> @@ -0,0 +1 @@
> +# Empty
> diff --git a/lib/newlib_tests/test_kconfig.c
> b/lib/newlib_tests/test_kconfig.c
> index d9c662fc5..183d55611 100644
> --- a/lib/newlib_tests/test_kconfig.c
> +++ b/lib/newlib_tests/test_kconfig.c
> @@ -14,6 +14,7 @@ static const char *kconfigs[] = {
>         "CONFIG_MMU",
>         "CONFIG_EXT4_FS=m",
>         "CONFIG_PGTABLE_LEVELS=4",
> +       "CONFIG_MMU & CONFIG_EXT4_FS=m",
>

The patchset looks awesome.

But a tiny issue was found from my test, the tst_kconfig_check() would be
failed to parse expression if reverse the sequence of the above string.

i.e.
-       "CONFIG_MMU & CONFIG_EXT4_FS=m",
+       "CONFIG_EXT4_FS=m & CONFIG_MMU",
(Core dumped here)

But trying with =Num, it gets different errors:

"CONFIG_MMU & CONFIG_PGTABLE_LEVELS=4",
(works well)

"CONFIG_PGTABLE_LEVELS=4 & CONFIG_MMU",
(print Expression not satisfied!)

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201102/dbf396b6/attachment-0001.htm>
