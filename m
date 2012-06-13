Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <naresh.kernel@gmail.com>) id 1SehYU-0004rY-Ru
	for ltp-list@lists.sourceforge.net; Wed, 13 Jun 2012 06:59:50 +0000
Received: from mail-gg0-f175.google.com ([209.85.161.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SehYP-00047E-IO
	for ltp-list@lists.sourceforge.net; Wed, 13 Jun 2012 06:59:50 +0000
Received: by ggnp4 with SMTP id p4so136188ggn.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Jun 2012 23:59:40 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 13 Jun 2012 12:29:39 +0530
Message-ID: <CAO=8iAXNczFN1GH2x6jUGqEX-Y-KJwrJDRGp3c0tb=q7_XcXrQ@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] Openposix: pthread create, testcase 1-6
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
To: vaibhav <v.bhav.shinde@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi Vaibhav,

> Mike Frysinger <vapier@...> writes:
>
> >
> > On Monday 03 December 2007, Patrick Kirsch wrote:
> > > I have a question on testcase pthread_create/1-1.c :
> > > there is shared variable "int *ctrl =3D (int *) arg;" in function
> > > "hp_func" which should be protected through pthread_mutex or similar,
> > > right? As I understand this shared variable should always be protecte=
d?
> > > So is there a reason why there are no pthread synchronisation calls?
> > >
> > > As you can see in the suggested temporary patch below, is it possible=
 to
> > > add volatile-statement to the shared variables?
> > >
> > > I'm asking, because sometimes this testcase fails on s390x.
> >
> > perhaps look at the generated assembly code and see if gcc is incorrect=
ly
> > optimizing away memory loads ? =A0adding volatile sounds like you're ig=
noring a
> > deeper problem ...
> > -mike
>
> Hi Mike
>
> This test case is released with volatile variable usage in LTP january re=
lease.
> I tested it for MIPS target, it FAILS giving error :
>
> volatile int *ctrl =3D (int *) arg;
>
> Can you please point out whats could be the exact issue?
To understand problem in detail, please provide the Error log you are getti=
ng.
Are you not getting this FAIL error without volatile?
if the issue is only with MIPS, we need to understand MIPS compiler
difference from others.

IMHO, the test case is designed well.

Best regards
Naresh Kamboju

>
> Looking forward to your reply.
>
> Thanks,
> Vaibhav
> >
> >
> > -----------------------------------------------------------------------=
--
> > SF.Net email is sponsored by: The Future of Linux Business White Paper
> > from Novell. =A0From the desktop to the data center, Linux is going
> > mainstream. =A0Let it simplify your IT future.
> > http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
> >
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@...
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> >
>
>

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
