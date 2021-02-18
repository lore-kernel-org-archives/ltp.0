From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Feb 2021 11:26:02 +0100
Subject: [LTP] [PATCH] lib/tst_mkfs: bugfix for lib/tst_mkfs.c
In-Reply-To: <20210218065758.230880-1-zhaogongyi@huawei.com>
References: <20210218065758.230880-1-zhaogongyi@huawei.com>
Message-ID: <YC5Aug2AJiokQjQH@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	if (!strcmp(fs_type, "tmpfs")) {
> +		tst_resm_(file, lineno, TINFO, "Need not fomat for TMPFS filesystem");

I've fixed typo and reworded this message a bit and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
