From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 Nov 2015 14:22:06 +0100
Subject: [LTP] [PATCH v3] commands/mkfs: Added new testcase to test
 mkfs(8) command.
In-Reply-To: <1446624763-3242-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <5638A0B2.1060600@cn.fujitsu.com>
 <1446624763-3242-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20151104132206.GD17823@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +mkfs_verify_size()
> +{
> +	mkfs_mount
> +	local blocknum=`df -B 1k mntpoint | tail -n1 | awk '{print $2}'`
> +	mkfs_umount
> +
> +	if [ $blocknum -gt "$2" ]; then
> +		return 1
> +	fi
> +
> +	# Size argument in mkfs.ntfs denotes number-of-sectors which is 512bytes,
> +	# 1k-block size should be devided by this argument for ntfs verification.
> +	if [ "$1" = "ntfs" ]; then
> +		local rate=1024/512
> +		if [ $blocknum -lt "$(($2/rate*9/10))" ]; then
> +			return 1
> +		fi
> +	else
> +		if [ $blocknum -lt "$(($2*9/10))" ]; then
> +			return 1
> +		fi
> +	fi

I've added explicit return 0 here, since otherwise the retul value would
be set by the last executed command (which would be the either umount
or mount above...).


And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
