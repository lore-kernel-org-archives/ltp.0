Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1O9iz3-0004Ut-2I
	for ltp-list@lists.sourceforge.net; Wed, 05 May 2010 18:06:09 +0000
Received: from mail-vw0-f46.google.com ([209.85.212.46])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O9iz1-0003ir-TS
	for ltp-list@lists.sourceforge.net; Wed, 05 May 2010 18:06:09 +0000
MIME-Version: 1.0
In-Reply-To: <1273050496.26977.19.camel@lishuang-desktop>
References: <1273050496.26977.19.camel@lishuang-desktop>
From: Henry Yei <hyei@mvista.com>
Date: Wed, 5 May 2010 11:00:12 -0700
Message-ID: <i2y42aa607e1005051100pa03938c4m7e585461ab1207c4@mail.gmail.com>
Subject: Re: [LTP] ltp sysctl03 testcase failed in version of 20100228
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Henry xu <feng.xu@windriver.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Wed, May 5, 2010 at 2:08 AM, Henry xu <feng.xu@windriver.com> wrote:
> Hi,all
> I test sysctl03 in x86 and ppc platform and product the same fails as
> below.
>
>
> root@z530:/opt/ltp-full/testcases/bin> ./sysctl03
> sysctl03 =A0 =A01 =A0TFAIL =A0: =A0Expected EPERM (1), got 13: Permission=
 denied
> sysctl03 =A0 =A02 =A0TFAIL =A0: =A0Expected EPERM, got 13
>
> The case expects to return EPERM,however return EACCES.
>
> My kernel version is 2.6.34 .I think it could be caused =A0by high version
> kernel .Since in the past kernel of 2.6.27,there is not the fail.And I
> find the same issue of the case on the internet.It gives a patch,but I
> find =A0the patch is not merged in the newest ltp version .
>
> I want to know whether the isuue is known or not.
>
> thanks!
>

FYI: Your pass on the 2.6.27 kernel may be because default kernel
config did not have the option CONFIG_SYSCTL_SYSCALL=3Dy, and the tests
returned a TCONF. This is a known issue. I've been waiting for the
sysctl interface to be removed from the kernel for years, but it is
still around.

Henry Yei <hyei@mvista.com>

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
