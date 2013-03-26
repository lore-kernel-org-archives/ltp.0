Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UKZpM-0003o0-R2
	for ltp-list@lists.sourceforge.net; Tue, 26 Mar 2013 19:46:36 +0000
Date: Tue, 26 Mar 2013 20:47:18 +0100
From: chrubis@suse.cz
Message-ID: <20130326194718.GA11865@rei.suse.cz>
References: <5151E122.3090203@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5151E122.3090203@linux.vnet.ibm.com>
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
> I tried to run syscalls test with ./runltp -f syscalls, it's found that 
> the below tests
> are getting skipped from the run,
> -----------
> inotify03 inotify03 -D DEVICE -T DEVICE_FS_TYPE
> mount01 mount01 -D DEVICE -T DEVICE_FS_TYPE
> mount02 mount02 -D DEVICE -T DEVICE_FS_TYPE
> mount03 mount03 -D DEVICE -T DEVICE_FS_TYPE
> mount04 mount04 -D DEVICE -T DEVICE_FS_TYPE
> umount01 umount01 -D DEVICE -T DEVICE_FS_TYPE
> umount02 umount02 -D DEVICE -T DEVICE_FS_TYPE
> umount03 umount03 -D DEVICE -T DEVICE_FS_TYPE
> -----------
> 
> I didn't get the value of DEVICE & DEVICE_FS_TYPE in any of conf files 
> and also, as
> the tests expect a block device, I executed the tests by specifying a 
> block device
> (-D /dev/sda1 -T ext4), tests passed.
> 
> Also,as the DEVICE & DEVICE_FS_TYPE need to be explicitly specifed to 
> all the tests,
> these tests should be commented out in ltp/runtest/syscalls which is 
> used by runltp.
> 
> Any comments on this issue are appreciated.

The runtest files are processed before they are executed. See -b DEVICE and
-B DEVICE_FS_TYPE runltp parameters.

The current runltp script is more of the hack than solution. I've send a
RFC email with a description of planned successor to the LTP mailing
list not that long ago (but I haven't started writing the code yet).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Own the Future-Intel&reg; Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest.
Compete for recognition, cash, and the chance to get your game 
on Steam. $5K grand prize plus 10 genre and skill prizes. 
Submit your demo by 6/6/13. http://p.sf.net/sfu/intel_levelupd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
