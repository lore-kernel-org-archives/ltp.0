From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jan 2021 10:39:41 +0100
Subject: [LTP] [PATCH 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01
 invoked oom-killer
In-Reply-To: <1611570288-23040-1-git-send-email-liuxp11@chinatelecom.cn>
References: <1611570288-23040-1-git-send-email-liuxp11@chinatelecom.cn>
Message-ID: <YBE03REJywKIlM0X@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> MemTotal:       198101744 kB
> MemFree:        189303148 kB
> MemAvailable:   188566732 kB

This sounds really strange, usually MemFree is smaller than MemAvailable
since MemFree does not include page cache.

Is this freshly booted system?

Can you send the whole meminfo here please?

-- 
Cyril Hrubis
chrubis@suse.cz
