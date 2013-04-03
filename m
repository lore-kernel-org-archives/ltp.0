Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UNM97-0006sh-86
	for ltp-list@lists.sourceforge.net; Wed, 03 Apr 2013 11:46:29 +0000
Date: Wed, 3 Apr 2013 13:47:14 +0200
From: chrubis@suse.cz
Message-ID: <20130403114714.GB2002@rei>
References: <5151E122.3090203@linux.vnet.ibm.com>
	<20130326194718.GA11865@rei.suse.cz>
	<51529266.2080906@linux.vnet.ibm.com>
	<20130327102829.GB11865@rei.suse.cz>
	<515C133C.6030803@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <515C133C.6030803@linux.vnet.ibm.com>
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
> I would like to share a work around which I have tried to make the tests 
> to run
> by default when -b and -B arguments are not specified.Please share your 
> thoughts
> on this and also let me know if there is any disadvantage in using a 
> loop device
> as I have made use of it in my changes. Also, suggest me an alternate 
> way to use
> this work around if the changes in runltp is not a better idea.


The runltp script is considered a hack rather than proper solution but
we don't have replacement yet, so we have to live with it as it is now.

The patch looks realtively good. Comments bellow.

> Here is the work around that I tried,
> 
> +++ runltp    2013-04-02 16:42:47.836836402 +0530
> @@ -681,17 +681,43 @@ main()
> 
>       if [ -n "$DEVICE" ]; then
>           sed -i "s|DEVICE|$DEVICE|"  ${TMP}/alltests
> +         RC=$?
>       else
> -        echo "remove test cases which require the block device."
> -        echo "You can specify it with option -b"
> -        sed -i "/DEVICE/d"  ${TMP}/alltests
> +         #create a block device with ext4 filesystem.
> +        dd if=/dev/zero of=${TMP}/test.img bs=1 count=10MB &>/dev/null

If I'm not mistaken the bs=1 would make the whole process way too slow.

Also I'm not sure if 10MB is enough for ext4.

> +        if [ $? -ne 0 ]; then
> +            echo "Please check for disk space and re-run"
> +            exit 1
> +        else
> +            ##search for an unused loop dev
> +            LOOP_DEV=$(losetup -f)
> +            if [ $? -ne 0 ]; then
> +                echo "no unused loop device is found"
> +                exit 1

There may be embeded systems without the loopback driver in kernel and
we should work on these too. So rather than aborting here, we should
disable the testcases in question.

> +            else
> +                ##attach the created file to loop dev.
> +                losetup $LOOP_DEV ${TMP}/test.img &>/dev/null
> +                if [ $? -ne 0 ]; then
> +                     echo "losetup failed to create block device"
> +                     exit 1
> +                else
> +                    ##format the block dev with ext4 filesystem.
> +                    mkfs.ext4 $LOOP_DEV &>/dev/null
> +                    #set the values in alltests which require block device.
> +                     DEVICE=$LOOP_DEV
> +                     DEVICE_FS_TYPE="ext4"
> +                    sed -i "s|DEVICE|$DEVICE|"  ${TMP}/alltests
> +                     RC=$?
> +                fi
> +            fi
> +          fi
>       fi
> 
> -    if [ $? -ne 0 ]; then
> +    if [ $RC -ne 0 ]; then
>               echo "FATAL: error during prcessing alltests file by sed"
>               exit 1
>       fi
> -
> +
>       if [ -n "$DEVICE" ]; then
>           mnt_pnt=`mktemp -d "${TMP}/mnt_pnt.XXXXXX"`
>           if [ -n "$DEVICE_FS_TYPE" ]; then
> @@ -973,6 +999,8 @@ main()
> 
>   cleanup()
>   {
> +    [ -e "${TMP}/test.img" ] && rm -f ${TMP}/test.img
> +    [ "$LOOP_DEV" ] && losetup -d $LOOP_DEV
>       rm -rf ${TMP}
>   }

Also please send a signed patch in unified diff format next time (git
can create these for your).

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
