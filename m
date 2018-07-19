From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Jul 2018 14:27:57 +0200
Subject: [LTP] [PATCH v2 2/2] zram/zram_lib.sh: Apply tst_supported_fs
	for shell
In-Reply-To: <1531985470-25203-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180718124638.GD7117@rei>
 <1531985470-25203-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1531985470-25203-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180719122757.GB16703@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  		# if requested fs not supported default it to ext2
> -		which mkfs.$fs > /dev/null 2>&1 || fs=ext2
> +		tst_supported_fs $fs > /dev/null 2>&1
> +		[ $? -eq 0 ] && fs=ext2

Should just:

	tst_supported_fs $fs || fs=ext2

suffice here?

(assuming that tst_supported_fs returns 0 on success)

-- 
Cyril Hrubis
chrubis@suse.cz
