From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Jul 2020 14:58:15 +0200
Subject: [LTP] [PATCH v3 2/2] syscalls/ioctl_loop05: Using
 LOOP_CONFIGURE to set direct io
In-Reply-To: <1595556357-29932-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200722125946.GA22573@yuki.lan>
 <1595556357-29932-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1595556357-29932-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200729125815.GD7152@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	/*
> +	 * When we call loop_configure ioctl successfully and detach it,
> +	 * the subquent loop_configure without non-zero lo_offset or
> +	 * sizelimit may trigger the blk_update_request I/O error.
> +	 * To avoid this, sleep 1s to ensure last blk_update_request has
> +	 * completed.
> +	 */
> +	sleep(1);

This sounds to me like a kernel bug. Have you tried asking kernel
developers if this is expected behavior before we attempt work around
the problem in tests?

-- 
Cyril Hrubis
chrubis@suse.cz
