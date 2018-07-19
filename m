From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Jul 2018 14:27:37 +0200
Subject: [LTP] [PATCH v2 1/2] lib: Factor out is_supported() && Add
 tst_supported_fs for shell
In-Reply-To: <1531985470-25203-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180718124638.GD7117@rei>
 <1531985470-25203-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180719122737.GA19082@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	printf("Usage: tst_supported_fs [fs_type]\n");
> +	printf("   If a specified fs_type is supported, return 1\n");
> +	printf("   If a specified fs_type isn't supported, return 0\n");

Also this is a bit confusing since in shell 0 == true, hence it would be
a bit better to return !tst_fs_is_supported(argv[1]);

-- 
Cyril Hrubis
chrubis@suse.cz
