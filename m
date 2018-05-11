From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 May 2018 17:49:34 +0200
Subject: [LTP] [PATCH ltp] runtest/scsi_debug.part1: remove invalid line
 in scenario file
In-Reply-To: <20180505015952.14640-1-yixin.zhang@intel.com>
References: <20180505015952.14640-1-yixin.zhang@intel.com>
Message-ID: <20180511154934.65rb7r4dzge53nfy@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yixin,
> Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
> ---
>  runtest/scsi_debug.part1 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/runtest/scsi_debug.part1 b/runtest/scsi_debug.part1
> index 5538516a3..acc427131 100644
> --- a/runtest/scsi_debug.part1
> +++ b/runtest/scsi_debug.part1
> @@ -1,5 +1,5 @@
>  #DESCRIPTION:scsi_debug filesystem tests
> -echo "----- Checking the Reiserfs -----"
> +
>  # Check the Reiserfs filesystem
>  gf201 growfiles -W gf201 -d /test/growfiles/reiser -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 glseek20 glseek20.2
>  gf202 growfiles -W gf202 -d /test/growfiles/reiser -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_

Thanks for patch, applied.
I just deleted 2 empty lines.

I dared to merge this during git freeze, as it's very simple fix.

Kind regards,
Petr
