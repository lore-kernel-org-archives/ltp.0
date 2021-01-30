From: Li Wang <liwang@redhat.com>
Date: Sat, 30 Jan 2021 13:37:47 +0800
Subject: [LTP] [PATCH v2 2/6] zram01.sh: Generate test setup variables
 in setup
In-Reply-To: <20210129194144.31299-3-pvorel@suse.cz>
References: <20210129194144.31299-1-pvorel@suse.cz>
 <20210129194144.31299-3-pvorel@suse.cz>
Message-ID: <CAEemH2ffReVSE_210nyRZVZHOwoMMy-F4Cye08RwPa5bh7PZ0w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Petr Vorel <pvorel@suse.cz> wrote:

> ...
>
> diff --git a/testcases/kernel/device-drivers/zram/zram01.sh
> b/testcases/kernel/device-drivers/zram/zram01.sh
> index a795ff89f..c5d4a3e51 100755
> --- a/testcases/kernel/device-drivers/zram/zram01.sh
> +++ b/testcases/kernel/device-drivers/zram/zram01.sh
> @@ -8,23 +8,25 @@
>
>  TST_CNT=7
>  TST_TESTFUNC="do_test"
> -TST_NEEDS_CMDS="awk bc dd"
> +TST_NEEDS_CMDS="awk bc dd grep"
>  . zram_lib.sh
> +TST_SETUP="setup"
>
> -# List of parameters for zram devices.
> -# For each number the test creates own zram device.
> -zram_max_streams="2 3 5 8"
> -
> -FS_SIZE="402653184"
> -FS_TYPE="btrfs"
> +get_btrfs_size()
>

What about renaming at_least_1G_mem() or check_space_for_btrfs()?


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210130/cf12bffe/attachment.htm>
