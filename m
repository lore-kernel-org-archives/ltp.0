Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rameshyr@linux.vnet.ibm.com>) id 1UPSZa-0002na-Id
	for ltp-list@lists.sourceforge.net; Tue, 09 Apr 2013 07:02:30 +0000
Received: from e23smtp02.au.ibm.com ([202.81.31.144])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UPSZY-0004tt-EX
	for ltp-list@lists.sourceforge.net; Tue, 09 Apr 2013 07:02:30 +0000
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <rameshyr@linux.vnet.ibm.com>;
	Tue, 9 Apr 2013 16:54:52 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id BC59B357804E
	for <ltp-list@lists.sourceforge.net>;
	Tue,  9 Apr 2013 17:02:15 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	r396mI4p60751924
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Apr 2013 16:48:19 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	r3971ZBp006890
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Apr 2013 17:01:35 +1000
Message-ID: <5163BCCC.90909@linux.vnet.ibm.com>
Date: Tue, 09 Apr 2013 12:31:32 +0530
From: Ramesh <rameshyr@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <515EA506.8060305@linux.vnet.ibm.com>
	<51621625.6000507@cn.fujitsu.com>
In-Reply-To: <51621625.6000507@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] runltp: syscalls/mount0* and inotify03 tests are
 getting skipped from runltp's execution
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
To: gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net

On 04/08/2013 06:28 AM, Wanlong Gao wrote:
> On 04/05/2013 06:18 PM, Ramesh wrote:
>> Some of the tests which require a block device for their execution are
>> skipped
>> when runltp is run without any block device being specified on
>> commandline.Most
>> of such tests are from syscalls group and as a work around to make these
>> tests
>> run even when no block device is specified,I have made use of loopback
>> device
>> to create a block device with ext4 filesystem. So,runltp is modified to
>> create
>> a block device and set the values for DEVICE and DEVICE_FS_TYPE accordingly.
>
> I like this change, but seems that your email client wrapped the lines,
> please take care of this issue when you respin the patch.
>
> Thanks,
> Wanlong Gao
>
>>
>> Following are the skipped tests,
>> ----
>> inotify03 inotify03 -D DEVICE -T DEVICE_FS_TYPE
>> mount01 mount01 -D DEVICE -T DEVICE_FS_TYPE
>> mount02 mount02 -D DEVICE -T DEVICE_FS_TYPE
>> mount03 mount03 -D DEVICE -T DEVICE_FS_TYPE
>> mount04 mount04 -D DEVICE -T DEVICE_FS_TYPE
>> umount01 umount01 -D DEVICE -T DEVICE_FS_TYPE
>> umount02 umount02 -D DEVICE -T DEVICE_FS_TYPE
>> umount03 umount03 -D DEVICE -T DEVICE_FS_TYPE
>> ----
>>
>> Please review the patch and let me know if any more changes are needed.
>>
>>
>> Signed-off-by: Ramesh YR<rameshyr@linux.vnet.ibm.com>
>> ---
>>    runltp |   52 +++++++++++++++++++++++++++++++++++++++++++++++-----
>>    1 files changed, 47 insertions(+), 5 deletions(-)
>>
>> diff --git a/runltp b/runltp
>> index 04cc690..d7e3f0d 100755
>> --- a/runltp
>> +++ b/runltp
>> @@ -681,14 +681,22 @@ main()
>>
>>        if [ -n "$DEVICE" ]; then
>>            sed -i "s|DEVICE|$DEVICE|"  ${TMP}/alltests
>> +    RC=$?
>>        else
>> -        echo "remove test cases which require the block device."
>> -        echo "You can specify it with option -b"
>> -        sed -i "/DEVICE/d"  ${TMP}/alltests
>> +    create_block
>> +    if [ $? -eq 0 ]; then
>> +        sed -i "s|DEVICE|$DEVICE|"  ${TMP}/alltests
>> +        RC=$?
>> +    else
>> +        echo -e "no block device was specified on commandline.\n Block
>> device could not be created using loopback device"
>> +        echo -e "Tests which require block device are disabled.\n You
>> can specify it with option -b"
>> +        sed -i "/DEVICE/d"  ${TMP}/alltests
>> +        RC=$?
>> +    fi
>>        fi
>>
>> -    if [ $? -ne 0 ]; then
>> -            echo "FATAL: error during prcessing alltests file by sed"
>> +    if [ $RC -ne 0 ]; then
>> +            echo "FATAL: error during processing alltests file by sed"
>>                exit 1
>>        fi
>>
>> @@ -971,8 +979,42 @@ main()
>>        exit $VALUE
>>    }
>>
>> +create_block()
>> +{
>> +    #create a block device with ext4 filesystem.
>> +    dd if=/dev/zero of=${TMP}/test.img bs=1kB count=10240&>/dev/null
>> +    if [ $? -ne 0 ]; then
>> +        echo "Failed to create loopback device image,please check disk
>> space and re-run"
>> +        return 1
>> +    else
>> +        ##search for an unused loop dev
>> +        LOOP_DEV=$(losetup -f)
>> +        if [ $? -ne 0 ]; then
>> +            echo "no unused loop device is found"
>> +            return 1
>> +        else
>> +            ##attach the created file to loop dev.
>> +            losetup $LOOP_DEV ${TMP}/test.img&>/dev/null
>> +            if [ $? -ne 0 ]; then
>> +                echo "losetup failed to create block device"
>> +                return 1
>> +            else
>> +                mkfs.ext4 $LOOP_DEV&>/dev/null
>> +                [ $? -ne 0 ]&&  (echo "creating a ext4 block device
>> failed"&&  return 1)
>> +                #set the values in alltests which require block device.
>> +                DEVICE=$LOOP_DEV
>> +                DEVICE_FS_TYPE="ext4"
>> +                return 0
>> +            fi
>> +        fi
>> +    fi
>> +}
>> +
>> +
>>    cleanup()
>>    {
>> +    [ -e "${TEMP}/test.img" ]&&  rm -f ${TEMP}/test.img
>> +    [ "$LOOP_DEV" ]&&  losetup -d $LOOP_DEV
>>        rm -rf ${TMP}
>>    }
>>
>
Hi,

I have corrected few indentation flaws and I think this patch should be 
fine to commit.
Please let me know if you are still facing any issues in extracting this 
patch for commit.


Signed-off-by: Ramesh YR <rameshyr@linux.vnet.ibm.com>
---
  runltp |   51 ++++++++++++++++++++++++++++++++++++++++++++++-----
  1 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/runltp b/runltp
index 04cc690..5562b9c 100755
--- a/runltp
+++ b/runltp
@@ -681,14 +681,22 @@ main()

      if [ -n "$DEVICE" ]; then
          sed -i "s|DEVICE|$DEVICE|"  ${TMP}/alltests
+        RC=$?
      else
-        echo "remove test cases which require the block device."
-        echo "You can specify it with option -b"
-        sed -i "/DEVICE/d"  ${TMP}/alltests
+        create_block
+        if [ $? -eq 0 ]; then
+            sed -i "s|DEVICE|$DEVICE|"  ${TMP}/alltests
+            RC=$?
+        else
+            echo -e "no block device was specified on commandline.\n 
Block device could not be created using loopback device"
+            echo -e "Tests which require block device are disabled.\n 
You can specify it with option -b"
+            sed -i "/DEVICE/d"  ${TMP}/alltests
+            RC=$?
+        fi
      fi

-    if [ $? -ne 0 ]; then
-            echo "FATAL: error during prcessing alltests file by sed"
+    if [ $RC -ne 0 ]; then
+            echo "FATAL: error during processing alltests file by sed"
              exit 1
      fi

@@ -971,8 +979,41 @@ main()
      exit $VALUE
  }

+create_block()
+{
+    #create a block device with ext4 filesystem.
+    dd if=/dev/zero of=${TMP}/test.img bs=1kB count=10240 &>/dev/null
+    if [ $? -ne 0 ]; then
+        echo "Failed to create loopback device image,please check disk 
space and re-run"
+        return 1
+    else
+        ##search for an unused loop dev
+        LOOP_DEV=$(losetup -f)
+        if [ $? -ne 0 ]; then
+            echo "no unused loop device is found"
+            return 1
+        else
+            ##attach the created file to loop dev.
+            losetup $LOOP_DEV ${TMP}/test.img &>/dev/null
+            if [ $? -ne 0 ]; then
+                echo "losetup failed to create block device"
+                return 1
+            else
+                mkfs.ext4 $LOOP_DEV &>/dev/null
+                [ $? -ne 0 ] && (echo "creating a ext4 block device 
failed" && return 1)
+                #set the values in alltests which require block device.
+                DEVICE=$LOOP_DEV
+                DEVICE_FS_TYPE="ext4"
+                return 0
+            fi
+        fi
+    fi
+}
+
  cleanup()
  {
+    [ "$LOOP_DEV" ] && losetup -d $LOOP_DEV
+    [ -e "${TEMP}/test.img" ] && rm -f ${TEMP}/test.img
      rm -rf ${TMP}
  }

-- 

Regards,
Ramesh







------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
