From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 03 Aug 2021 08:04:59 +0100
Subject: [LTP] [PATCH] setsockopt03: Add Git and CVE tags
In-Reply-To: <20210803070116.30767-1-rpalethorpe@suse.com>
References: <20210803070116.30767-1-rpalethorpe@suse.com>
Message-ID: <87fsvrm2jo.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Sorry please ignore this, wrong patch!

Richard Palethorpe <rpalethorpe@suse.com> writes:

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  testcases/kernel/syscalls/setsockopt/setsockopt03.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt03.c b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
> index 14fdf400b..3d49628d6 100644
> --- a/testcases/kernel/syscalls/setsockopt/setsockopt03.c
> +++ b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
> @@ -114,4 +114,8 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.test_all = run,
>  	.needs_root = 1,
> +	.tags = (const struct tst_tag[]){
> +		{"linux-git", "ce683e5f9d04"},
> +		{"CVE", "CVE-2016-4997"},
> +	}
>  };


-- 
Thank you,
Richard.
