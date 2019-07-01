From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 1 Jul 2019 14:27:45 +0800
Subject: [LTP] [PATCH] scenario_groups/default: run the kernel_misc test
 after the cve test
In-Reply-To: <20190628103900.10113-1-po-hsu.lin@canonical.com>
References: <20190628103900.10113-1-po-hsu.lin@canonical.com>
Message-ID: <5D19A7E1.10607@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Your patch just workarounds the issue for now, because it still happens 
if a new test designed to taint
kernel is added to the group before cve group in future.

Could we save the value of tainted before running block_dev and then 
restore it after running block_dev?

Best Regards,
Xiao Yang
On 2019/06/28 18:39, Po-Hsu Lin wrote:
> The block_dev test in kernel_misc will taint kernel with a warning flag,
> this is an expected behaviour.
>
> However, if you run the cve-2017-17053 after it, as the test is looking
> for a warning / died flag for a tainted kernel, it will cause false
> alarm with:
>    tst_taint.c:88: BROK: Kernel is already tainted: 14849
>
> The kernel_misc test was executed before the cve test in the default
> test plan. Move the kernel_misc test to the end of the list to
> workaround this issue.
>
> Signed-off-by: Po-Hsu Lin<po-hsu.lin@canonical.com>
> ---
>   scenario_groups/default | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scenario_groups/default b/scenario_groups/default
> index 1f3e5b27f..e5b34782c 100644
> --- a/scenario_groups/default
> +++ b/scenario_groups/default
> @@ -22,7 +22,6 @@ power_management_tests
>   hugetlb
>   commands
>   hyperthreading
> -kernel_misc
>   fs_ext4
>   can
>   cpuhotplug
> @@ -30,3 +29,4 @@ net.ipv6_lib
>   input
>   cve
>   crypto
> +kernel_misc



