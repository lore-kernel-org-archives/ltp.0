From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Mar 2017 14:59:08 +0100
Subject: [LTP] [PATCH 1/3] tst_test: Handle device mkfs/mount int the
 library
In-Reply-To: <530294916.8516424.1487676424944.JavaMail.zimbra@redhat.com>
References: <20170214152639.11603-1-chrubis@suse.cz>
 <530294916.8516424.1487676424944.JavaMail.zimbra@redhat.com>
Message-ID: <20170301135908.GD32207@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Series looks good to me.

Pushed with two more fcntl() tests.

> One issue I ran into is that
> quotactl01 fails on RHEL5.6/6.0, but that doesn't seem
> to be related to your patch:
> 
> # ./quotactl01 
> tst_device.c:120: INFO: Found free device '/dev/loop0'
> tst_mkfs.c:79: INFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
> mke2fs 1.41.12 (17-May-2010)
> tst_test.c:847: INFO: Timeout per run is 0h 05m 00s
> quotacheck: Mountpoint (or device) /tmp/quoyk2cuB/mntpoint not found or has no quota enabled.
> quotacheck: Cannot find filesystem to check or filesystem not mounted with quota option.
> quotactl01.c:179: FAIL: user quotafile didn't exist: ENOENT

Strange, that looks like the options are accepted but ignored for ext4
as well.

-- 
Cyril Hrubis
chrubis@suse.cz
