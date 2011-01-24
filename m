Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PhK6Q-0000Xx-Qn
	for ltp-list@lists.sourceforge.net; Mon, 24 Jan 2011 10:56:54 +0000
Received: from mail-ww0-f41.google.com ([74.125.82.41])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PhK6P-0000ZN-KC
	for ltp-list@lists.sourceforge.net; Mon, 24 Jan 2011 10:56:54 +0000
Received: by wwi18 with SMTP id 18so3104515wwi.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 24 Jan 2011 02:56:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D3D4D36.1030002@cn.fujitsu.com>
References: <000001cb96a5$12026c30$36074490$@co.jp>
	<4D3D4D36.1030002@cn.fujitsu.com>
Date: Mon, 24 Jan 2011 02:56:47 -0800
Message-ID: <AANLkTinUjNU4z9GBqv=Mvf2vZF-0VTNzFDa89K_X3P7B@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix "sched_getparam/6-1" and
 "sched_getscheduler/7-1" tests
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, =?Big5?B?t+2ueSCwt6Wr?= <toza@ryobi.co.jp>, Mitani <mitani@ryobi.co.jp>

On Mon, Jan 24, 2011 at 1:58 AM, Bian Naimeng <biannm@cn.fujitsu.com> wrote:
>
>
> Mitani wrote:
>> Hi,
>>
>>
>> Following POSIX testsets failed:
>> ------------
>> conformance/interfaces/sched_getparam/6-1: execution: FAILED: Output:
>> Testing with user 'bin' (euid: 1)(uid: 1)
>> The function sched_getparam has successed.
>> ------------
>>
>> ------------
>> conformance/interfaces/sched_getscheduler/7-1: execution: FAILED: Output:
>> Testing with user 'bin' (uid: 1)
>> The function sched_getscheduler has successed.
>> ------------
>>
>> The environments are as follows:
>> =A0 - RHEL4.8 --- (x86, x86_64, ia64)
>> =A0 - kernel =A0--- kernel-2.6.9-89.EL
>> =A0 - glibc =A0 --- glibc-2.3.4-2.43
>>
>> =A0 - RHEL5.5 --- (x86, x86_64, ia64)
>> =A0 - kernel =A0--- kernel-2.6.18-194.el5
>> =A0 - glibc =A0 --- glibc-2.5-49
>>
>>
>> They are permission tests.
>>
>> The comment of "sched_getparam/6-1" testset source is as follows:
>> ------------
>> =A0 * On Linux, e.g, the kernel makes no check on user permission to cal=
l this
>> =A0 * API. So basically we don't know on what condition a system should =
return
>> =A0 * EPERM. It is implementation defined.
>> ------------
>>
>
> Hi Garrett,
>
> =A0I think it's better to report UNRESOLVED, whatever the os is.

    It's not implementation defined according to 2008.1, and it's flat
out a requirement failure (not UNRESOLVED):

The sched_getparam() function shall fail if:

[EPERM]
    The requesting process does not have permission to obtain the
scheduling parameters of the specified process.

`shall' -> `must' in POSIX terms.

    The test is incorrect because it fails to setgid the group to the
non-root user's group.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires =

February 28th, so secure your free ArcSight Logger TODAY! =

http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
