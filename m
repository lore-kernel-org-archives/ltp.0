Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UNioK-0008F7-9e
	for ltp-list@lists.sourceforge.net; Thu, 04 Apr 2013 11:58:32 +0000
Date: Thu, 4 Apr 2013 13:59:18 +0200
From: chrubis@suse.cz
Message-ID: <20130404115918.GA7321@rei.suse.cz>
References: <5151E122.3090203@linux.vnet.ibm.com>
	<20130326194718.GA11865@rei.suse.cz>
	<51529266.2080906@linux.vnet.ibm.com>
	<20130327102829.GB11865@rei.suse.cz>
	<515C133C.6030803@linux.vnet.ibm.com> <20130403114714.GB2002@rei>
	<515C5D28.3050604@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <515C5D28.3050604@linux.vnet.ibm.com>
Subject: Re: [LTP] syscalls/mount0* and inotify03 tests are getting skipped
 from runltp
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
To: Ramesh <rameshyr@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
>   ltp-full-20130109/runltp |   48 
> ++++++++++++++++++++++++++++++++++++++++++---
>   1 files changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/ltp-full-20130109/runltp b/ltp-full-20130109/runltp
> index 04cc690..f0f0c95 100755
> --- a/ltp-full-20130109/runltp
> +++ b/ltp-full-20130109/runltp
> @@ -681,13 +681,20 @@ main()
> 
>       if [ -n "$DEVICE" ]; then
>           sed -i "s|DEVICE|$DEVICE|"  ${TMP}/alltests
> +    RC=$?
>       else
> -        echo "remove test cases which require the block device."
> -        echo "You can specify it with option -b"
> -        sed -i "/DEVICE/d"  ${TMP}/alltests
> +    create_block
> +    if [ $? -eq 0 ]; then
> +        sed -i "s|DEVICE|$DEVICE|"  ${TMP}/alltests
> +        RC=$?
> +    else
> +        echo "remove test cases which require the block device."
> +        echo "You can specify it with option -b"
> +        sed -i "/DEVICE/d"  ${TMP}/alltests

We should update the message here a little to let the user know that

1) no device was speficied on command line

2) the loopback device could not be created

3) tests that needs the device are disabled

> +        RC=$?
>       fi
> 
> -    if [ $? -ne 0 ]; then
> +    if [ $RC -ne 0 ]; then
>               echo "FATAL: error during prcessing alltests file by sed"
                                           ^
              Could you please also fix this typo

>               exit 1
>       fi
> @@ -971,8 +978,41 @@ main()
>       exit $VALUE
>   }
> 
> +create_block()
> +{
> +    #create a block device with ext4 filesystem.
> +    dd if=/dev/zero of=${TMP}/test.img bs=10 count=10MB &>/dev/null

Still not right, this will create roughly 100MB file (the count and
the block size get multiplied). The correct one for 10MB would be:

dd if=/dev/zero of=${TMP}/test.img bs=1kB count=10240

(the 1kB blocks are about the optimal size for write and we request
 10240 of them)

> +    if [ $? -ne 0 ]; then
> +        echo "Please check for disk space and re-run"

Please be more verbose here about what has gone wrong. Something like:

"Failed to create loopback device image, plese check disk space and
re-run."

> +        return 1
> +    else
> +        ##search for an unused loop dev
> +        LOOP_DEV=$(losetup -f)
> +        if [ $? -ne 0 ]; then
> +            echo "no unused loop device is found"
> +            return 1
> +        else
> +            ##attach the created file to loop dev.
> +            losetup $LOOP_DEV ${TMP}/test.img &>/dev/null
> +            if [ $? -ne 0 ]; then
> +                echo "losetup failed to create block device"
> +                return 1
> +            else
> +                ##format the block dev with ext3 filesystem.
> +                mkfs.ext4 $LOOP_DEV &>/dev/null

The comment here disagrees with the actual code, i.e. ext3 vs ext4.

I would just remove it as it's pretty clear what the line does without
it.

And you should check the return value from the mkfs just in case.

> +                #set the values in alltests which require block device.
> +                DEVICE=$LOOP_DEV
> +                DEVICE_FS_TYPE="ext4"
> +                return 0
> +            fi
> +        fi
> +    fi
> +}
> +
>   cleanup()
>   {
> +    [ -e "${TEMP}/test.img" ] && rm -f ${TEMP}/test.img
> +    [ "$LOOP_DEV" ] && losetup -d $LOOP_DEV
>       rm -rf ${TMP}
>   }

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
