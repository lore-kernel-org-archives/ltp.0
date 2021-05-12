From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 12 May 2021 17:31:57 +0200
Subject: [LTP] [PATCH] proc01: Add /proc/dirty/dirty_list to known_issues
In-Reply-To: <20210308033428.20924-1-zhaogongyi@huawei.com>
References: <20210308033428.20924-1-zhaogongyi@huawei.com>
Message-ID: <YJv07fCsOlCR0LZH@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zhao,

> When we open the file /proc/dirty/dirty_list directly, it will return -1 and
> set the errno to ENOMEM.

...
> +++ b/testcases/kernel/fs/proc/proc01.c
> @@ -85,6 +85,7 @@ static const struct mapping known_issues[] = {
>  	{"open", "/proc/sal/init/data", EBUSY},
>  	{"open", "/proc/sal/mca/data", EBUSY},
>  	{"open", "/proc/fs/nfsd/pool_stats", ENODEV},
> +	{"open", "/proc/dirty/dirty_list", ENOMEM},
Is /proc/dirty/dirty_list in mainline? We haven't found "dirty_list" string in
mainline git (there is dirty_list code, but not "dirty_list" string).

I'd prefer not to add vendor specific files, or at least to document them.

Kind regards,
Petr
