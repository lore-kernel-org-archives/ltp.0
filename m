From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 31 Jan 2017 11:14:06 -0500 (EST)
Subject: [LTP] [PATCH] [RFC] zram01: Fix on ppc64le
In-Reply-To: <1485870273-26990-1-git-send-email-chrubis@suse.cz>
References: <1485870273-26990-1-git-send-email-chrubis@suse.cz>
Message-ID: <845142934.836828.1485879246140.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Tuesday, 31 January, 2017 2:44:33 PM
> Subject: [LTP] [PATCH] [RFC] zram01: Fix on ppc64le
> 
> The minimal size for Btrfs filesystem on ppc64le is around 139MB, most
> likely because of larger page size, hence the test fails.
> 
> This commit adds tst_min_fs_size.sh library, that parses mkfs.btrfs
> output which includes minimal filesystem size in case of a failure.
> 
> The code also falls back to 150MB if the mkfs.btrfs output wasn't parsed
> correctly.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/device-drivers/zram/zram01.sh |  8 ++++--
>  testcases/lib/tst_min_fs_size.sh               | 35
>  ++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 2 deletions(-)
>  create mode 100644 testcases/lib/tst_min_fs_size.sh

This is ~4 years old comment from Zach Brown, when I hit an issue on ppc,
where I could alloc only 1/2 of the volume size:

"That small volume mkfs warning is issued for devices less than a gig.  It indicates that btrfs has gone in to a weird degenerate allocation scheme.  We'd only support volumes much larger than that, though I have no quick rule to say how large starts to be reasonable.  Multiple gig, certainly."

I'm running with 384M since then, so far successfully. If we don't allocate
too much data on it, we might be OK, but still I'd go with minimum default of 256M.

Regards,
Jan
