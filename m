From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Feb 2018 10:47:54 +0100
Subject: [LTP] [PATCH] commands/df01.sh: Add check for mkfs.${FS_TYPE}
 command
In-Reply-To: <1518596984-16336-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1518596984-16336-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180227094754.q6r54m7t4l6jvbdg@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> Since commit 521df0e, tst_rod can detect nonexistent command and report TBROK
> in tst_mkfs(), so we can check mkfs.${FS_TYPE} command before tst_mkfs().

> If mkfs.exfat command did not exist, running df01_exfat got the following errors:
> -----------------------------------------------------------------
> tst_device.c:230: INFO: Using test device LTP_DEV='/dev/loop0'
>  1 TINFO: Formatting /dev/loop0 with exfat extra opts=''
>  1 TBROK: mkfs.exfat /dev/loop0 failed
>  1 TINFO: The /dev/loop0 is not mounted, skipping umount
> -----------------------------------------------------------------

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  testcases/commands/df/df01.sh | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
> index 0552327..fbf1e2f 100755
> --- a/testcases/commands/df/df01.sh
> +++ b/testcases/commands/df/df01.sh
> @@ -49,6 +49,10 @@ parse_args()

>  setup()
>  {
> +	if [ -n "$FS_TYPE" ]; then
> +		tst_check_cmds mkfs.${FS_TYPE}
> +	fi
> +
>  	tst_mkfs ${FS_TYPE} ${TST_DEVICE}

>  	ROD_SILENT mkdir -p mntpoint

Pushed, thanks!


Kind regards,
Petr
