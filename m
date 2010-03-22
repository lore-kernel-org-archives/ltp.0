Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Ntcif-0006jO-P8
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 08:10:41 +0000
Received: from mail-yw0-f192.google.com ([209.85.211.192])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ntcie-0001jy-6S
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 08:10:40 +0000
MIME-Version: 1.0
In-Reply-To: <20100322063936.GA20606@linux.vnet.ibm.com>
References: <1268975755.12801.44.camel@lishuang-desktop>
	<20100322063936.GA20606@linux.vnet.ibm.com>
Date: Mon, 22 Mar 2010 01:10:34 -0700
Message-ID: <364299f41003220110n6d1c0df7jbbc1c78450375980@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] When I execute ppoll01 testcase in mips board,
	the testcase 	failed.
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
To: Henry xu <feng.xu@windriver.com>, takahiro.yasui.mp@hitachi.com, yumiko.sugita.yf@hitachi.com, sa-fuji@sdl.hitachi.co.jp, ltp-list <ltp-list@lists.sf.net>

On Sun, Mar 21, 2010 at 11:39 PM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> On Fri, Mar 19, 2010 at 01:15:55PM +0800, Henry xu wrote:
>> Hi,all
>>
>> summary:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> When I execute ppoll01 testcase in mips board,the testcase failed.
>
> Again can you send us the strace of this ?
>
> @All, Let us know if anyone also facing the same problem, i am not having=
 any
> mips box but may be someone can help here to Henry.
>
> -Rishi
>>
>> Environment
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> linux version:2.6.27.45
>> hardware platform:mips
>>
>>
>>
>> symptom Details
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> root@localhost:/opt/mytest> ./ppoll01
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case00) START
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0EXPECT: revents=3D0x0005
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0RESULT: revents=3D0x0005
>> EXPECT: return value(ret)=3D(N >=3D 0) errno=3D0 (Success)
>> RESULT: return value(ret)=3D =A0 =A0 =A0 1 errno=3D0 (Success)
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case00) END =3D> OK
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case01) START
>> EXPECT: return value(ret)=3D0 errno=3D0 (Success)
>> RESULT: return value(ret)=3D-1 errno=3D4 (Interrupted system call)
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case01) END =3D> NG
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case02) START
>> ^CEXPECT: return value(ret)=3D0 errno=3D0 (Success)
>> RESULT: return value(ret)=3D-1 errno=3D4 (Interrupted system call)
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case02) END =3D> NG
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case03) START
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0EXPECT: revents=3D0x0020
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0RESULT: revents=3D0x0020
>> EXPECT: return value(ret)=3D(N >=3D 0) errno=3D0 (Success)
>> RESULT: return value(ret)=3D =A0 =A0 =A0 1 errno=3D0 (Success)
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case03) END =3D> OK
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case04) START
>> EXPECT: return value(ret)=3D-1 errno=3D4 (Interrupted system call)
>> RESULT: return value(ret)=3D-1 errno=3D4 (Interrupted system call)
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case04) END =3D> OK
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case05) START
>> EXPECT: return value(ret)=3D-1 errno=3D4 (Interrupted system call)
>> RESULT: return value(ret)=3D-1 errno=3D4 (Interrupted system call)
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case05) END =3D> OK
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case06) START
>> EXPECT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
>> RESULT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case06) END =3D> OK
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case07) START
>> EXPECT: return value(ret)=3D-1 errno=3D14 (Bad address)
>> RESULT: return value(ret)=3D-1 errno=3D14 (Bad address)
>> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case07) END =3D> OK
>> ppoll01 =A0 =A0 1 =A0TFAIL =A0: =A0ppoll01 failed: TEST_ERRNO=3DEFAULT(1=
4): Bad
>> address
>> NGppoll01 =A0 =A0 0 =A0TWARN =A0: =A0tst_rmdir(): rmobj(/tmp/ppoKT1uvV) =
failed:
>> unlink(/tmp/ppoKT1uvV/.nfs00000000005bcdac00000035) failed; errno=3D16:
>> Device or resource busy

    I was seeing similar back when I had access to Cavium mips
hardware and worked in my prior group. Neither case is true anymore so
I can't verify this issue.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
