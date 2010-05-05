Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O9o8F-0000v7-HA
	for ltp-list@lists.sourceforge.net; Wed, 05 May 2010 23:35:59 +0000
Received: from mail-iw0-f181.google.com ([209.85.223.181])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O9o8E-0000tP-TR
	for ltp-list@lists.sourceforge.net; Wed, 05 May 2010 23:35:59 +0000
MIME-Version: 1.0
In-Reply-To: <k2w364299f41005051634gd61e7f17n7ef4c8d9bbc8e86c@mail.gmail.com>
References: <1273050496.26977.19.camel@lishuang-desktop>
	<i2y42aa607e1005051100pa03938c4m7e585461ab1207c4@mail.gmail.com>
	<k2w364299f41005051634gd61e7f17n7ef4c8d9bbc8e86c@mail.gmail.com>
Date: Wed, 5 May 2010 16:35:53 -0700
Message-ID: <p2n364299f41005051635td8f793d4xbb477df131802c90@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: Henry Yei <hyei@mvista.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Wed, May 5, 2010 at 4:34 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Wed, May 5, 2010 at 11:00 AM, Henry Yei <hyei@mvista.com> wrote:
>> On Wed, May 5, 2010 at 2:08 AM, Henry xu <feng.xu@windriver.com> wrote:
>>> Hi,all
>>> I test sysctl03 in x86 and ppc platform and product the same fails as
>>> below.
>>>
>>>
>>> root@z530:/opt/ltp-full/testcases/bin> ./sysctl03
>>> sysctl03 =A0 =A01 =A0TFAIL =A0: =A0Expected EPERM (1), got 13: Permissi=
on denied
>>> sysctl03 =A0 =A02 =A0TFAIL =A0: =A0Expected EPERM, got 13
>>>
>>> The case expects to return EPERM,however return EACCES.
>>>
>>> My kernel version is 2.6.34 .I think it could be caused =A0by high vers=
ion
>>> kernel .Since in the past kernel of 2.6.27,there is not the fail.And I
>>> find the same issue of the case on the internet.It gives a patch,but I
>>> find =A0the patch is not merged in the newest ltp version .
>>>
>>> I want to know whether the isuue is known or not.
>>>
>>> thanks!
>>>
>>
>> FYI: Your pass on the 2.6.27 kernel may be because default kernel
>> config did not have the option CONFIG_SYSCTL_SYSCALL=3Dy, and the tests
>> returned a TCONF. This is a known issue. I've been waiting for the
>> sysctl interface to be removed from the kernel for years, but it is
>> still around.
>
> =A0 =A0They're going to blow away the sysctl(3) interface in a few

*(3) -> (2)

> versions, so I wouldn't even bother monkeying around with these tests.
> I'd just mark it as a known issue and continue on.

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
