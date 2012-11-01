Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TTllZ-0003Ts-SR
	for ltp-list@lists.sourceforge.net; Thu, 01 Nov 2012 03:48:25 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TTllY-0006XK-9S
	for ltp-list@lists.sourceforge.net; Thu, 01 Nov 2012 03:48:25 +0000
Message-ID: <5091EDBC.4030909@cn.fujitsu.com>
Date: Thu, 01 Nov 2012 11:34:20 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <D7504F77ECABB0449431598E06DDF6E9179A600C@szxeml526-mbx.china.huawei.com>
In-Reply-To: <D7504F77ECABB0449431598E06DDF6E9179A600C@szxeml526-mbx.china.huawei.com>
Subject: Re: [LTP] ioctl01 failed when checking the ioctl bad command return
 value.
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Linliangjie <linliangjie@huawei.com>
Cc: shyju pv <shyju.pv@huawei.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, "Maxiansheng (Max)" <max.maxiansheng@huawei.com>, Sanil kumar <sanil.kumar@huawei.com>

On 11/01/2012 10:10 AM, Linliangjie wrote:
> Issue description: 
> ------------------- 
> Kernel Version : 3.7-rc2
> System call : ioctl
> LTP Testcase : ioctl01
> LTP Version : 20120903 
> Platform : x86_64 ( HP 8200 PC ) 
> Testcase Description : Testcase to check the errnos set by the ioctl(2) system
> call.
> Previous kernel version in which testcase passed : 3.2.9
> 
> Executing log:
> -------------------------
> [root@linux-qf4g]-[/tmp/ltp/ltp/testcases/bin]
> (0)# ./ioctl01 -D /dev/tty
> ioctl01     1  TPASS  :  failed as expected: TEST_ERRNO=EBADF(9): Bad file
> descriptor
> ioctl01     2  TPASS  :  failed as expected: TEST_ERRNO=EFAULT(14): Bad address
> ioctl01     3  TFAIL  :  failed unexpectedly; expected 22 - Invalid argument:
> TEST_ERRNO=ENOTTY(25): Inappropriate ioctl for device
> ioctl01     4  TPASS  :  failed as expected: TEST_ERRNO=ENOTTY(25):
> Inappropriate ioctl for device
> ioctl01     5  TPASS  :  failed as expected: TEST_ERRNO=EFAULT(14): Bad address
> -------------------------
> The return value of the code is expected to be 22 but 24 is returned and 
> hence the LTP test failed. 
> 
>>From v3.2.9, kernel has changed the return value for bad command. 
> The patch commit no:07d106d0a33d6063d2061305903deb02489eba20

Yes, you are right, but you didn't find the real effective patch,
the real effective patch is 

commit bbb63c514a3464342967237a51a21ea8f61ab951
Author: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Date:   Mon Aug 27 15:23:12 2012 +0800

    drivers:tty:fix up ENOIOCTLCMD error handling
    
    At commit 07d106d0, Linus pointed out that ENOIOCTLCMD should be
    translated as ENOTTY to user mode.
    For example:
        fd = open("/dev/tty", O_RDWR);
        ioctl(fd, -1, &argp);
    
    then the errno should be ENOTTY but not EINVAL.
    
    Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
    Acked-by: Alan Cox <alan@linux.intel.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


It's a kernel change, so I will make a patch to fix this LTP test case.
Thank you very much for reporting this. ;)
And you *Huawei* guys are very welcome to the Open Source community. :-)


Regards,
Wanlong Gao


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
