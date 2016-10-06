From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 6 Oct 2016 05:09:30 -0400 (EDT)
Subject: [LTP] [PATCH] [RFC] readahead02: Fix on Btrfs
In-Reply-To: <20161006081752.GA9210@rei>
References: <20161006081752.GA9210@rei>
Message-ID: <966408417.764925.1475744970952.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Cc: "Jan Stancek" <jstancek@redhat.com>
> Sent: Thursday, 6 October, 2016 10:17:52 AM
> Subject: [PATCH] [RFC] readahead02: Fix on Btrfs
> 
> The Btrfs uses anonymous block devices for its subvolumes hence
> /sys/dev/block/$major:$minor/ is not created for these.
> 
> We have to use ioctl(BTRFS_IOC_FS_INFO, ...) to get fs UUID in order to
> map a path on Btrfs to a sysfs path that contains links to the devices.
> 
> TODO: What happens to readahead if there is more than one device backing
>       the Btrfs filesystem?
> 
> Also this is getting absurdly compliated, maybe we should rethink the
> test assertions so that we don't have to rely on reading the
> read_ahead_kb file, perhaps we can just try to guess the maximal size by
> calling the readahead in a loop with increasing size until it fails
> instead.

Syscall itself won't fail, it will silently make shorter read.
If this patch goes through, then reading read_ahead_kb becomes
useless:
  https://lkml.org/lkml/2016/7/25/308

Perhaps, we should stop focusing on max size. We could change it to start
with size of entire file, and for subsequent calls update file offset as
max(MIN_SANE_READAHEAD, cache_increase_since_last_call), where MIN_SANE_READAHEAD
would be some small arbitrary number. So there would be a guarantee
it can eventually finish and any smaller readahead than that number would
be considered a failure.

> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/syscalls/readahead/readahead02.c | 57
>  ++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/readahead/readahead02.c
> b/testcases/kernel/syscalls/readahead/readahead02.c
> index 2517a33..3c06596 100644
> --- a/testcases/kernel/syscalls/readahead/readahead02.c
> +++ b/testcases/kernel/syscalls/readahead/readahead02.c
> @@ -42,6 +42,7 @@
>  #include <stdint.h>
>  #include <unistd.h>
>  #include <fcntl.h>
> +#include <linux/btrfs.h>

This will be an issue on old distros/kernels.

Regards,
Jan
