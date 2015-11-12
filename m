From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Nov 2015 13:58:44 +0100
Subject: [LTP] [PATCH] commands/mkfs/mkfs01.sh: fix mkfs testcase
In-Reply-To: <BLU436-SMTP141D57E2A2AE833B9844076CF280@phx.gbl>
References: <BLU436-SMTP141D57E2A2AE833B9844076CF280@phx.gbl>
Message-ID: <20151112125843.GA19653@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/commands/mkfs/mkfs01.sh 
> b/testcases/commands/mkfs/mkfs01.sh
> index 5b62df4..31e3e15 100755
> --- a/testcases/commands/mkfs/mkfs01.sh
> +++ b/testcases/commands/mkfs/mkfs01.sh
> @@ -93,7 +93,7 @@ mkfs_verify_type()
>   		blkid $2 -t TYPE="ext2" >/dev/null
>   	else
>   		if [ "$1" = "msdos" ]; then
> -			blkid $2 -t SEC_TYPE="$1" >/dev/null
> +			blkid $2 -t TYPE="vfat" >/dev/null

Hmm I can see the SEC_TYPE set to msdos for both mkfs.msdos and
mkfs.vfat.

But indeed both mkfs.vfat and mkfs.msdos are symlinks to mkfs.fat and
seems to produce the same result.

I would have applied the patch but it does not apply (looks like
whitespaces were mangled somehow). Can you please make sure that your
email client is set up in a way that does not mangle patches and then
resend the patch?

-- 
Cyril Hrubis
chrubis@suse.cz
