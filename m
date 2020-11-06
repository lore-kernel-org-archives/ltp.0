From: Li Wang <liwang@redhat.com>
Date: Fri, 6 Nov 2020 18:21:54 +0800
Subject: [LTP] [PATCH v4 2/2] lib/tst_kconfig: Make use of boolean
 expression eval
In-Reply-To: <20201103161052.13260-3-chrubis@suse.cz>
References: <20201103161052.13260-1-chrubis@suse.cz>
 <20201103161052.13260-3-chrubis@suse.cz>
Message-ID: <CAEemH2dUmmFx8cEhqMP6CLpRwszeBD=kMM4i3xpBKYSV+S2d8Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Nov 4, 2020 at 12:10 AM Cyril Hrubis <chrubis@suse.cz> wrote:

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
>

For series:
Reviewed-by: Li Wang <liwang@redhat.com>

> diff --git a/lib/newlib_tests/test_kconfig.c
> b/lib/newlib_tests/test_kconfig.c
> index d9c662fc5..1f659b95a 100644
> --- a/lib/newlib_tests/test_kconfig.c
> +++ b/lib/newlib_tests/test_kconfig.c
> @@ -14,6 +14,8 @@ static const char *kconfigs[] = {
>         "CONFIG_MMU",
>         "CONFIG_EXT4_FS=m",
>         "CONFIG_PGTABLE_LEVELS=4",
> +       "CONFIG_MMU & CONFIG_EXT4_FS=m",
> +       "CONFIG_EXT4_FS=m | CONFIG_MMU",
>         NULL
>  };
>


I tried with more complicated configurations for test parsing, most works
as expected but except the below one with parentheses ():

    "CONFIG_DEFAULT_HOSTNAME=\"(none)\"",

That's because the parentheses are the element of expression and used
to distinguish tokens, I?m not sure whether we can change it as a general
character to fix this problem, if no, we might need to comment on this in
the documentation.

--- a/lib/newlib_tests/test_kconfig.c
+++ b/lib/newlib_tests/test_kconfig.c
@@ -16,6 +16,11 @@ static const char *kconfigs[] = {
        "CONFIG_PGTABLE_LEVELS=4",
        "CONFIG_MMU & CONFIG_EXT4_FS=m",
        "CONFIG_EXT4_FS=m | CONFIG_MMU",
+       "CONFIG_DEFAULT_HOSTNAME=\"(none)\"",
+       "CONFIG_LOCALVERSION=\"\" | CONFIG_MODULE_SIG_HASH=\"sha256\"",
+       "CONFIG_OUTPUT_FORMAT=\"elf64-x86-64\"",
+       "CONFIG_ARCH_DEFCONFIG=\"arch/x86/configs/x86_64_defconfig\"",
+       "CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000",
        NULL
 };


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201106/f78e1a20/attachment.htm>
