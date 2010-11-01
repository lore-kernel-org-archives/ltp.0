Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PCqv1-0000Bu-0D
	for ltp-list@lists.sourceforge.net; Mon, 01 Nov 2010 09:43:11 +0000
Received: from mail-ww0-f41.google.com ([74.125.82.41])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PCqv0-0006r9-1X
	for ltp-list@lists.sourceforge.net; Mon, 01 Nov 2010 09:43:10 +0000
Received: by wwb34 with SMTP id 34so90502wwb.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 01 Nov 2010 02:43:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4CCE73A6.9020901@cn.fujitsu.com>
References: <000001cb798d$1aaa0210$4ffe0630$@co.jp>
	<AANLkTiktyyfpSX+ZkOucGCNg2vSajcVPQ8Q60z4Uj8kh@mail.gmail.com>
	<4CCE73A6.9020901@cn.fujitsu.com>
Date: Mon, 1 Nov 2010 02:43:03 -0700
Message-ID: <AANLkTi=TyhLVZ5OOcRduBwvkxS3-u4f7A1W+bv+WO6Y1@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix "sigaction" tests
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
To: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, =?Big5?B?t+2ueSCwt6Wr?= <toza@ryobi.co.jp>, Mitani <mitani@ryobi.co.jp>

On Mon, Nov 1, 2010 at 1:00 AM, Gui Jianfeng <guijianfeng@cn.fujitsu.com> w=
rote:
> Garrett Cooper wrote:
>> 2010/10/31 Mitani <mitani@ryobi.co.jp>:
> ...
>>> =A0int main()
>>> =A0{
>>> @@ -133,6 +152,12 @@
>>>
>>> =A0 =A0 =A0 =A0struct sigaction sa;
>>>
>>> + =A0 =A0 =A0 /* Checking for Kernel Version */
>>> + =A0 =A0 =A0 if ( kernel_ver_cmp(2, 6, 21) !=3D 0 )
>>> + =A0 =A0 =A0 {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 UNTESTED( "sem_wait() returned EINTR on k=
ernel versions
>>> lower than 2.6.22" );
>>> + =A0 =A0 =A0 }
>>> +
>>> =A0 =A0 =A0 =A0/* Initialize output */
>>> =A0 =A0 =A0 =A0output_init();
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> Above patch is revision only for templates.
>>> The following procedure is necessary after applying patch:
>>> ------------
>>> #cd testcases/open_posix_testsuite/conformance/interfaces/sigaction/
>>> #./gentests.pl
>>> ------------
>>>
>>> Similar revisions are necessary for other 25 "sigaction" tests.
>>
>> =A0 =A0 Sorry, but Linux-isms can't leak into the open_posix_testsuite.
>> Same with BSDisms (at least they shouldn't... if they do, then slap me
>> or whoever did the commit).
>
> Do you mean the culprit is Linux-isms?

Mitani-san is proposing that I `fix' the testcases to work on RHEL
4.8. These testcases should function with minimal change for all
versions of Unix.

...

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
