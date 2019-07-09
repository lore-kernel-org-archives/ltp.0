From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Jul 2019 12:24:31 +0200
Subject: [LTP] [PATCH 1/1] syscalls/ioctl08: Require btrfs
In-Reply-To: <20190703154709.20863-1-pvorel@suse.cz>
References: <20190703154709.20863-1-pvorel@suse.cz>
Message-ID: <20190709102431.GB30251@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> WARNING: failed to open /dev/btrfs-control, skipping device
> registration: No such file or directory
> safe_macros.c:757: BROK: tst_test.c:752: mount(/dev/loop0, mnt_point,
> btrfs, 0, (nil)) failed: ENODEV
> 
> Cc: Christian Amann <camann@suse.com>
> Reported-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Amir,
> 
> thanks a lot for a report and sorry for longer time to reply (vacation).
> Could you please test it? (I don't have any VM with kernel >= 4.5 && !btrfs).

Looks good to me.

Amir have you had a chance to test this patch?

-- 
Cyril Hrubis
chrubis@suse.cz
