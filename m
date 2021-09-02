From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Thu, 2 Sep 2021 06:37:52 +0000
Subject: [LTP] [PATCH] syscalls/creat09: Add another linux tag
In-Reply-To: <1630564446-3393-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1630564446-3393-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <61307148.1050605@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> ---
>   testcases/kernel/syscalls/creat/creat09.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
> index 53ab202c1..9b88acd1a 100644
> --- a/testcases/kernel/syscalls/creat/creat09.c
> +++ b/testcases/kernel/syscalls/creat/creat09.c
> @@ -18,6 +18,16 @@
>    *  Date:   Tue Jul 3 17:10:19 2018 -0700
>    *
>    *  Fix up non-directory creation in SGID directories
> + *
> + * This fix is incomplete if file is on xfs filesystem.
> + *
> + * Fixed in:
> + *
> + *  commit 01ea173e103edd5ec41acec65b9261b87e123fc2
> + *  Author: Christoph Hellwig<hch@lst.de>
> + *  Date:   Fri Jan 22 16:48:18 2021 -0800
> + *
> + *  xfs: fix up non-directory creation in SGID directories
>    */
> 
>   #include<stdlib.h>
> @@ -112,6 +122,7 @@ static struct tst_test test = {
>   	.tags = (const struct tst_tag[]) {
>   		{"linux-git", "0fa3ecd87848"},
>   		{"CVE", "2018-13405"},
> +		{"linux-git", "01ea173e103e"}
Sorry, I miss comma here.
>   		{}
>   	},
>   };
