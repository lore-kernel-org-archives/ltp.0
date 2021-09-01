From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Wed, 1 Sep 2021 17:14:07 +0200
Subject: [LTP] [PATCH v4 1/3] lib: add tst_get_free_pids helper program
In-Reply-To: <20210901145127.92315-1-krzysztof.kozlowski@canonical.com>
References: <20210901145127.92315-1-krzysztof.kozlowski@canonical.com>
Message-ID: <096999da-3b87-8c2b-4640-e36e8809e8c5@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 01/09/2021 16:51, Krzysztof Kozlowski wrote:
> Add a tst_get_free_pids helper program so shell code can get limit of
> tasks/PIDs in the system without duplicating that code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  testcases/lib/.gitignore          |  1 +
>  testcases/lib/Makefile            |  2 +-
>  testcases/lib/tst_get_free_pids.c | 19 +++++++++++++++++++
>  3 files changed, 21 insertions(+), 1 deletion(-)
>  create mode 100644 testcases/lib/tst_get_free_pids.c
> 
> diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
> index a2e9f1ef0c08..5a0e8cba2ee7 100644
> --- a/testcases/lib/.gitignore
> +++ b/testcases/lib/.gitignore
> @@ -2,6 +2,7 @@
>  /tst_checkpoint
>  /tst_device
>  /tst_getconf
> +/tst_get_free_pids
>  /tst_get_median
>  /tst_get_unused_port
>  /tst_kvcmp
> diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
> index 38813e640ab1..179b474795d3 100644
> --- a/testcases/lib/Makefile
> +++ b/testcases/lib/Makefile
> @@ -11,6 +11,6 @@ INSTALL_TARGETS		:= *.sh
>  MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
>  			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars\
>  			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
> -			   tst_get_median tst_hexdump
> +			   tst_get_median tst_hexdump tst_get_free_pids
>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/lib/tst_get_free_pids.c b/testcases/lib/tst_get_free_pids.c
> new file mode 100644
> index 000000000000..276ce994b67a
> --- /dev/null
> +++ b/testcases/lib/tst_get_free_pids.c
> @@ -0,0 +1,19 @@
> +

It's missing SPDX. I'll send a v5.


Best regards,
Krzysztof
