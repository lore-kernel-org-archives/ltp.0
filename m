From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Feb 2016 15:35:25 +0100
Subject: [LTP] [PATCH] commands/mkswap01: Update wait_for_file function
In-Reply-To: <1454082985-3549-1-git-send-email-shuang.qiu@oracle.com>
References: <1454082985-3549-1-git-send-email-shuang.qiu@oracle.com>
Message-ID: <20160202143525.GC19199@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> In commit a76b72ad31fa7bb22a09f323dadd5db7c00c7f56,it depends on the files 
> under /dev/disk/by-* in wait_for_file function.But sometimes udev does not 
> refresh automatically during runtime and the symbolic links will not appear.

Isn't that udev bug?

> Update the function to use blkid instead.

Does actually the swapon in the verify function work? Since as far as I
can tell it actually opens the symlink in question in order to get the
swap device.

Have you tried stracing it in case that the code waiting for the device
timeouted?

-- 
Cyril Hrubis
chrubis@suse.cz
