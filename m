Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rohit.170309@gmail.com>) id 1MgaWb-00012q-Bd
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 08:40:05 +0000
Received: from mail-pz0-f199.google.com ([209.85.222.199])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MgaWS-00023x-SM
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 08:40:05 +0000
MIME-Version: 1.0
In-Reply-To: <d51f89b0908202214l795ceb5bp5530fa4666f7ba87@mail.gmail.com>
References: <d51f89b0908130131u5742ff3epf58617e3f4ab38a3@mail.gmail.com>
	<4A850550.7080109@cn.fujitsu.com>
	<d51f89b0908140134g18b7b34cr9858edad1242373a@mail.gmail.com>
	<4A861EA2.6070701@cn.fujitsu.com>
	<d51f89b0908202214l795ceb5bp5530fa4666f7ba87@mail.gmail.com>
Date: Thu, 27 Aug 2009 14:09:50 +0530
Message-ID: <d51f89b0908270139j541bc03dtc0ece34af392f501@mail.gmail.com>
From: rohit verma <rohit.170309@gmail.com>
Subject: Re: [LTP] utimes01 test case issue
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
To: subrata@linux.vnet.ibm.com, Wei Yongjun <yjwei@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sf.net>

Hi Wang Yong/Subrata,

Kindly confirm whether the patch which i send you on 21st Aug is working fi=
ne.


Thank you,


On Fri, Aug 21, 2009 at 10:44 AM, rohit verma<rohit.170309@gmail.com> wrote:
> Hi Wang Yong,
>
> I have changed the expected error for root user in case02 as following.
>
> From tcase[2].err =3D EACCES to tcase[2].err =3D EPERM (For root user) .
>
> Pls check the attached patch for the same.
>
>
> On Sat, Aug 15, 2009 at 8:04 AM, Wei Yongjun<yjwei@cn.fujitsu.com> wrote:
>> rohit verma wrote:
>>> Hi Wang Yong,
>>>
>>> I am getting following =A0O/P for case02 :
>>>
>>> As root user:
>>>
>>> utimes01 =A0 =A00 =A0TINFO =A0: =A0(case02) START
>>> EXPECT: return value(ret)=3D-1 errno=3D13 (Permission denied)
>>> RESULT: return value(ret)=3D-1 errno=3D1 (Operation not permitted)
>>> utimes01 =A0 =A00 =A0TINFO =A0: =A0(case02) END =3D> NG
>>>
>>> As non-root user:
>>> utimes01 =A0 =A00 =A0TINFO =A0: =A0(case02) START
>>> seteuid failed.
>>> utimes01 =A0 =A00 =A0TINFO =A0: =A0(case02) END =3D> OK
>>>
>>> Are you getting the same?
>>>
>>>
>>>
>>
>> yes, the same result.
>>
>>>
>>> On Fri, Aug 14, 2009 at 12:03 PM, Wei Yongjun<yjwei@cn.fujitsu.com> wro=
te:
>>>
>>>> rohit verma wrote:
>>>>
>>>>> Hi Wang Yong,
>>>>>
>>>>> I have observed the following thing in case02 of the test case
>>>>> utimes01 in latest ltp release.
>>>>>
>>>>> Expected error value is =A0EACCES (In the code below)
>>>>> But the actual error value is EPERM.I have checked this on =A02.6.27 =
and
>>>>> 2.6.29 kernel.
>>>>>
>>>>>
>>>> You can try root user and noroot user, the return error is different.
>>>>
>>>>
>>>>> static struct test_case tcase[] =3D {
>>>>>
>>>>> =A0 =A0 =A0 =A0 { // case00
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
>>>>> =A0 =A0 =A0 =A0 },
>>>>> =A0 =A0 =A0 =A0 { // case01
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
>>>>> =A0 =A0 =A0 =A0 },
>>>>> =A0 =A0 =A0 =A0 { // case02
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ttype =A0 =A0 =A0 =A0 =A0=3D NORMAL,
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .a_sec =A0 =A0 =A0 =A0=3D 1000,
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .m_sec =A0 =A0 =A0 =3D 2000,
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0=3D "nobody",
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ret =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .err =A0 =A0 =A0 =A0 =A0 =A0 =3D EACC=
ES, // RHEL4U1 + 2.6.18 returns EPERM
>>>>> =A0 =A0 =A0 =A0 },
>>>>> =A0 =A0 =A0 =A0 { // case03
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
>>>>> =A0 =A0 =A0 =A0 },
>>>>>
>>>>> =A0 =A0 =A0 =A0 { // case04
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
>>>>> =A0 =A0 =A0 =A0 },
>>>>> };
>>>>>
>>>>> Kindly confirm whether you are facing the same issue at your end.
>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>>
>>>
>>>
>>>
>>
>>
>>
>
>
>
> --
> Regards,
> Rohit
>



-- =

Regards,
Rohit

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
