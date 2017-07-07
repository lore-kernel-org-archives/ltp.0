From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 7 Jul 2017 15:13:44 +0200
Subject: [LTP] [PATCH 3/3] commands/keyctl01: Enable this test for RHEL6
In-Reply-To: <1494483656-15971-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1494483656-15971-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1494483656-15971-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170707131344.GD28534@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/commands/keyctl/keyctl01.sh b/testcases/commands/keyctl/keyctl01.sh
> index 8ea2b25..40183b0 100644
> --- a/testcases/commands/keyctl/keyctl01.sh
> +++ b/testcases/commands/keyctl/keyctl01.sh
> @@ -37,8 +37,9 @@ TST_NEEDS_CMDS="keyctl"
>  
>  setup()
>  {
> -	if tst_kvcmp -le 2.6.33; then
> -		tst_brk TCONF "Kernel newer than 2.6.33 is needed"
> +	if tst_kvcmp -le '2.6.33 RHEL6:2.6.32-254'; then
> +		tst_brk TCONF \
> +			"Kernel newer than 2.6.33 or 2.6.32-254.el6 is needed"

I would be a bit happier if we could check if keyctl operations we need
for the test are supported (if that is reasonably easy to do) insetad of
listing minimal kernel versions per distribution.

-- 
Cyril Hrubis
chrubis@suse.cz
