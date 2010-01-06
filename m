Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NSP3M-0002Iy-5t
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 06:07:32 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSP3L-00009t-Ba
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 06:07:32 +0000
Received: by pxi38 with SMTP id 38so6221467pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 05 Jan 2010 22:07:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B420158.4060504@petalogix.com>
References: <000001ca8cfb$e04fb340$a0ef19c0$@co.jp>
	<4B420158.4060504@petalogix.com>
Date: Tue, 5 Jan 2010 22:07:25 -0800
Message-ID: <364299f41001052207j4e7f2e1dve2efbc30e4fc15d4@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] nanosleep testcase problem
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
To: michal.simek@petalogix.com
Cc: ltp-list@lists.sourceforge.net, Mitani <mitani@ryobi.co.jp>

On Mon, Jan 4, 2010 at 6:55 AM, Michal Simek <michal.simek@petalogix.com> w=
rote:
> Mitani wrote:
>> Hi,
>>
>> I want to wish you happy new year.
>>
>>
>> ------
>>
>> By the way, I found a new problem with the "nanosleep02" testcase.
>>
>> "main()" function executes fork(), and child process calls "do_child()"
>> function.
>> "do_child()" function must be ended by "exit()". But in "nanosleep02"
>> testcase, there is a case in which "exit()" isn't executed.
>> Therefore, the child process lives after "do_child()" function,
>> and it executes "wait()" function which must be executed in parent
>> process only.
>
> On Microblaze this test failed too. The patch fix it.
>
> Michal
>
>>
>> Here is the patch fixes these problem:
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- nanosleep02.c =A0 =A0 2009-12-23 02:35:13.000000000 +0900
>> +++ nanosleep02.c.new 2010-01-04 10:15:08.000000000 +0900
>> @@ -277,6 +277,9 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TPASS, "call succeeded");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(0);
>> =A0 =A0 =A0 }
>> +
>> + =A0 =A0 /* Everything is fine, exit normally */
>> + =A0 =A0 exit(0);
>> =A0}
>>
>> =A0/*

    Committed a change on CVS which forces the child to exit at the
end of do_child, like it should with tst_exit().
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
