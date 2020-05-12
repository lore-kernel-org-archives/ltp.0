From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 May 2020 11:58:32 +0200
Subject: [LTP] [PATCH v2] syscalls/ioctl_loop05: Ensure do zero offset
 when using -i parameter
In-Reply-To: <1589260270-3636-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1589260270-3636-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200512095832.GA3037@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  	memset(&loopinfo, 0, sizeof(loopinfo));
> +	/*
> +	 * Setting loopdevice with zero loop_info struct, so we can avoid unknown
> +	 * error when using -i parameter.
> +	 */
> +	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo), TST_RETVAL_EQ0);

I've merged the patch without the comment, the commit message is
descriptive enough.

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
