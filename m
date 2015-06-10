Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Z2bBD-0006gH-Vb
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 08:16:11 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z2bBB-00066q-V9
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 08:16:11 +0000
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t5A8G3oT023526
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Jun 2015 08:16:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t5A8G3c8020259
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Jun 2015 08:16:03 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t5A8G3QK026133
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Jun 2015 08:16:03 GMT
Message-ID: <5577F240.8000101@oracle.com>
Date: Wed, 10 Jun 2015 11:16:00 +0300
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1433923871-10933-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1433923871-10933-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Content-Type: multipart/mixed; boundary="------------060401070400040508020802"
Subject: Re: [LTP] [PATCH] detach_device: Wait until the kernel frees the
 loop device
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

This is a multi-part message in MIME format.
--------------060401070400040508020802
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit



On 06/10/2015 11:11 AM, Stanislav Kholmanskikh wrote:
> On systems employing the "lazy loop device removal",
> kernel commit commit a1ecac3b0656a68259927c234e505804d33a7b83
> ("loop: Make explicit loop device destruction lazy"),
> ioctl(LOOP_CLR_FD) may return 0 when the loop device is in use,
> for example by udev.
>
> Therefore, there is a chance that a quick attach/detach may not
> give udev enough time to complete, like this:
>
> open("file.img", O_RDWR)           = 4
> ioctl(3, LOOP_SET_FD, 0x4)         = 0
> close(3)                           = 0
> close(4)                           = 0
> open("/dev/loop0", O_RDONLY)       = 3
> ioctl(3, LOOP_CLR_FD, 0)           = 0
> close(3)                           = 0
> open("/dev/loop0", O_RDWR)         = 3
> open("file.img", O_RDWR)           = 4
> ioctl(3, LOOP_SET_FD, 0x4)         = -1 EBUSY (Device or resource busy)
>
> So let's wait until the kernel frees the loop device, i.e.
> when ioctl(LOOP_CLR_FD) starts failing with ENXIO.
>
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>

I tested it the attached test case (plus you need to remove 'static' 
next to attach_device and detach_device).

Without the patch it fails with:

[root@kholmanskikh test]# ./loop_test
loop_test    1  TBROK  :  tst_device.c:144: ioctl(/dev/loop0, 
LOOP_SET_FD, file.img) failed: EBUSY
loop_test    2  TBROK  :  tst_device.c:144: Remaining cases broken


--------------060401070400040508020802
Content-Type: text/x-csrc;
 name="loop_test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="loop_test.c"

#include "test.h"
#include "safe_macros.h"

char *TCID = "loop_test";
int TST_TOTAL = 1;

void attach_device(void (*cleanup_fn)(void),
		   const char *dev, const char *file);
void detach_device(void (*cleanup_fn)(void), const char *dev);

int main(void)
{
	int i, fd;

	tst_tmpdir();

	fd = SAFE_OPEN(NULL, "file.img", O_RDWR | O_CREAT, 0644);
	SAFE_FTRUNCATE(NULL, fd, 1024 * 1024UL);

	SAFE_CLOSE(NULL, fd);

	for (i = 0; i < 1000; i++) {
		attach_device(NULL, "/dev/loop0", "file.img");
		detach_device(NULL, "/dev/loop0");
	}

	tst_rmdir();

	tst_resm(TPASS, "Finished");
	tst_exit();
}

--------------060401070400040508020802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--------------060401070400040508020802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------060401070400040508020802--

