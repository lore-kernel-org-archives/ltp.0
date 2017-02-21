From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 21 Feb 2017 06:27:04 -0500 (EST)
Subject: [LTP] [PATCH 1/3] tst_test: Handle device mkfs/mount int the
 library
In-Reply-To: <20170214152639.11603-1-chrubis@suse.cz>
References: <20170214152639.11603-1-chrubis@suse.cz>
Message-ID: <530294916.8516424.1487676424944.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Tuesday, 14 February, 2017 4:26:37 PM
> Subject: [LTP] [PATCH 1/3] tst_test: Handle device mkfs/mount int the library
> 
> This commit adds functionality to format and then mount the test device
> to the test library which:
> 
> * Saves a few setup steps in most of the testcases that use test device
> 
> * The device is umounted in the test library process now -> it will be
>   umounted even if the test process has segfaulted.
> 
> + docs
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Series looks good to me. One issue I ran into is that
quotactl01 fails on RHEL5.6/6.0, but that doesn't seem
to be related to your patch:

# ./quotactl01 
tst_device.c:120: INFO: Found free device '/dev/loop0'
tst_mkfs.c:79: INFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
mke2fs 1.41.12 (17-May-2010)
tst_test.c:847: INFO: Timeout per run is 0h 05m 00s
quotacheck: Mountpoint (or device) /tmp/quoyk2cuB/mntpoint not found or has no quota enabled.
quotacheck: Cannot find filesystem to check or filesystem not mounted with quota option.
quotactl01.c:179: FAIL: user quotafile didn't exist: ENOENT

RHEL6.0 man-page says:
ext2
       grpquota|noquota|quota|usrquota
              These options are accepted but ignored.
ext4
       quota, noquota, grpquota, usrquota and
       [no]bh are backwardly compatible with ext3 or ext2.

Regards,
Jan
