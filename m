From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 3 Mar 2017 10:45:57 +0100
Subject: [LTP] [PATCH v2] min_free_kbytes: Check panic_on_oom in advance
In-Reply-To: <1488504025-2007-1-git-send-email-the_hoang0709@yahoo.com>
References: <1488504025-2007-1-git-send-email-the_hoang0709@yahoo.com>
Message-ID: <20170303094557.GB17012@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Hoang Nguyen <the_hoang0709@yahoo.com>
> ---
>  testcases/kernel/mem/tunable/min_free_kbytes.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
> index cb00f40..1f6fc8f 100644
> --- a/testcases/kernel/mem/tunable/min_free_kbytes.c
> +++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
> @@ -239,6 +239,11 @@ static void sighandler(int signo LTP_ATTRIBUTE_UNUSED)
>  void setup(void)
>  {
>  	tst_require_root();
> +    if (get_sys_tune("panic_on_oom")) {
> +        tst_brkm(TCONF, NULL,
> +            "panic_on_oom is set, disable it to run these testcases");
> +    }

Now the indentation is wrong, please make sure to use tabs. FYI you can
use checkpatch.pl from kernel git repo to check patches before sending
them for review.

-- 
Cyril Hrubis
chrubis@suse.cz
