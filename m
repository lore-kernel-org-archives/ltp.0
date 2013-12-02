Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VnWfM-000431-3J
	for ltp-list@lists.sourceforge.net; Mon, 02 Dec 2013 16:48:12 +0000
Date: Mon, 2 Dec 2013 17:47:39 +0100
From: chrubis@suse.cz
Message-ID: <20131202164739.GC13145@rei.suse.cz>
References: <528DF229.4090409@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <528DF229.4090409@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/3] runltp: add a big loop device
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Some tests, such as fs_ext4, need a big block device and
> the original DEVICE is some small, so create a BIG_DEVICE
> (default size 5GB).
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  runltp | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 63 insertions(+), 4 deletions(-)
> 
> diff --git a/runltp b/runltp
> index 63c625f..f491beb 100755
> --- a/runltp
> +++ b/runltp
> @@ -163,6 +163,9 @@ usage()
>      -b DEVICE       Some tests require an unmounted block device
>                      to run correctly.
>      -B DEVICE_FS_TYPE The file system of test block devices.
> +    -z BIG_DEVICE   Some tests require a big unmounted block device
> +                    to run correctly.
> +    -Z BIG_DEVICE_FS_TYPE The file system of the big device
>  
>  
>      example: ${0##*/} -c 2 -i 2 -m 2,4,10240,1 -D 2,10,10240,1 -p -q  -l /tmp/result-log.$$ -o /tmp/result-output.$$ -C /tmp/result-failed.$$ -d ${PWD}
> @@ -207,11 +210,12 @@ main()
>      local PAN_COMMAND=""
>      local DEFAULT_FILE_NAME_GENERATION_TIME=`date +"%Y_%b_%d-%Hh_%Mm_%Ss"`
>      local DEVICE_FS_TYPE="ext2"
> +    local BIG_DEVICE_FS_TYPE="ext2"
>      local scenfile=
>  
>      version_date=$(cat "$LTPROOT/Version")
>  
> -    while getopts a:c:C:d:D:f:F:ehi:K:g:l:m:M:Nno:pqr:s:S:t:T:w:x:b:B: arg
> +    while getopts a:c:C:d:D:f:F:ehi:K:g:l:m:M:Nno:pqr:s:S:t:T:w:x:b:B:z:Z: arg
>      do  case $arg in
>          a)  EMAIL_TO=$OPTARG
>              ALT_EMAIL_OUT=1;;
> @@ -424,6 +428,8 @@ main()
>              INSTANCES="-x $OPTARG";;
>          b) DEVICE=$OPTARG;;
>          B) DEVICE_FS_TYPE=$OPTARG;;
> +        z) BIG_DEVICE=$OPTARG;;
> +        Z) BIG_DEVICE_FS_TYPE=$OPTARG;;
>          \?) usage;;
>          esac
>      done
> @@ -678,19 +684,37 @@ main()
>      }
>  
>      if [ -n "$DEVICE" ]; then
> -        sed -i "s|DEVICE|$DEVICE|"  ${TMP}/alltests
> +        sed -i "s|\s+DEVICE\s+|$DEVICE|"  ${TMP}/alltests

Actually I've been thinking how can we get rid of the ugly sed lines and
what about we:

1. Export the devices as shell variables:

   export LTP_SMALL_DEV="$DEVICE"
   export LTP_BIG_DEV="$BIG_DEVICE"

2. Change the runtest files to use $LTP_SMALL_DEV and $LTP_BIG_DEV

We would still need to disable some testcases if devices are not
available, but we will get rid of this ulgy part.

>          RC=$?
>      else
>          create_block
>          if [ $? -eq 0 ]; then
> -            sed -i "s|DEVICE|$DEVICE|"  ${TMP}/alltests
> +            sed -i "s|\s+DEVICE\s+|$DEVICE|"  ${TMP}/alltests
>              RC=$?
>          else
>              echo "no block device was specified on commandline."
>              echo "Block device could not be created using loopback device"
>              echo "Tests which require block device are disabled."
>              echo "You can specify it with option -b"
> -            sed -i "/DEVICE/d"  ${TMP}/alltests
> +            sed -i "/\s+DEVICE\s+/d"  ${TMP}/alltests
> +            RC=$?
> +        fi
> +    fi
> +
> +    if [ -n "$BIG_DEVICE" ]; then
> +        sed -i "s|BIG_DEVICE|$BIG_DEVICE|"  ${TMP}/alltests
> +        RC=$?
> +    else
> +        create_big_block
> +        if [ $? -eq 0 ]; then
> +            sed -i "s|BIG_DEVICE|$BIG_DEVICE|"  ${TMP}/alltests
> +            RC=$?
> +        else
> +            echo "no big block device was specified on commandline."
> +            echo "BIG block device could not be created using loopback device"
> +            echo "Tests which require big block device are disabled."
> +            echo "You can specify it with option -z"
> +            sed -i "/BIG_DEVICE/d"  ${TMP}/alltests
>              RC=$?
>          fi
>      fi
> @@ -704,6 +728,10 @@ main()
>          sed -i "s|DEVICE_FS_TYPE|$DEVICE_FS_TYPE|"  ${TMP}/alltests
>      fi
>  
> +    if [ -n "$BIG_DEVICE" ]; then
> +        sed -i "s|BIG_DEVICE_FS_TYPE|$BIG_DEVICE_FS_TYPE|"  ${TMP}/alltests
> +    fi
> +
>      if [ $? -ne 0 ]; then
>          echo "FATAL: error during processing alltests file by sed"
>          exit 1
> @@ -979,10 +1007,41 @@ create_block()
>      fi
>  }
>  
> +create_big_block()
> +{
> +    # In most systems, the /tmp is relatively small
> +    # So create a big block device in LTPROOT
> +    BIG_DEVICE_DIR=${LTPROOT}/big_device$$

Using LTPROOT is wrong too. There are (embedded) systems that have the
LTPROOT mounted readonly or too small.

I guess that the only option here is to skip the testcases unless user
has specified device or directory to create it.

> +    mkdir -p $BIG_DEVICE_DIR
> +    dd if=/dev/zero of=${BIG_DEVICE_DIR}/test.img bs=1kB count=5120000 #5G
> +    if [ $? -ne 0 ]; then
> +        echo "Failed to create loopback device image, please check disk space and re-run"
> +        return 1
> +    else
> +        ##search for an unused loop dev
> +        LOOP_BIG_DEV=$(losetup -f)
> +        if [ $? -ne 0 ]; then
> +            echo "no unused loop device is found"
> +            return 1
> +        else
> +            ##attach the created file to loop dev.
> +            losetup $LOOP_BIG_DEV ${BIG_DEVICE_DIR}/test.img
> +            if [ $? -ne 0 ]; then
> +                echo "losetup failed to create block device"
> +                return 1
> +            fi
> +            BIG_DEVICE=$LOOP_BIG_DEV
> +            return 0
> +        fi
> +    fi
> +}
> +
>  cleanup()
>  {
>      [ "$LOOP_DEV" ] && losetup -d $LOOP_DEV
> +    [ "$LOOP_BIG_DEV" ] && losetup -d $LOOP_BIG_DEV
>      rm -rf ${TMP}
> +    rm -rf ${BIG_DEVICE_DIR}
>  }

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
