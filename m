From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 28 Mar 2016 13:35:36 +0300
Subject: [LTP] [PATCH] delete_module: export license information
In-Reply-To: <56F550F8.3000609@free.fr>
References: <56F550F8.3000609@free.fr>
Message-ID: <56F908F8.7070902@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 03/25/2016 05:53 PM, Mason wrote:
> Export license information to avoid kernel taint.
>
> 	dummy_del_mod: module license 'unspecified' taints kernel.
> 	Disabling lock debugging due to kernel taint

Please add "Signed-off-by: ..." line to the patch.

Thanks,
Alexey

> ---
>   testcases/kernel/module/delete_module/dummy_del_mod.c     | 1 +
>   testcases/kernel/module/delete_module/dummy_del_mod_dep.c | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/testcases/kernel/module/delete_module/dummy_del_mod.c b/testcases/kernel/module/delete_module/dummy_del_mod.c
> index dfda0e333f46..10932d0aa959 100644
> --- a/testcases/kernel/module/delete_module/dummy_del_mod.c
> +++ b/testcases/kernel/module/delete_module/dummy_del_mod.c
> @@ -61,3 +61,4 @@ static void __exit dummy_exit(void)
>   module_init(dummy_init);
>   module_exit(dummy_exit);
>   EXPORT_SYMBOL(dummy_func_test);
> +MODULE_LICENSE("GPL");
> diff --git a/testcases/kernel/module/delete_module/dummy_del_mod_dep.c b/testcases/kernel/module/delete_module/dummy_del_mod_dep.c
> index a15b2ea5d7c0..c9f60e3cde9e 100644
> --- a/testcases/kernel/module/delete_module/dummy_del_mod_dep.c
> +++ b/testcases/kernel/module/delete_module/dummy_del_mod_dep.c
> @@ -53,3 +53,4 @@ static void __exit dummy_exit(void)
>   
>   module_init(dummy_init);
>   module_exit(dummy_exit);
> +MODULE_LICENSE("GPL");

