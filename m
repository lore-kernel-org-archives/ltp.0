Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MHCSO-0000W9-J7
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 07:54:48 +0000
Received: from [209.85.217.207] (helo=mail-gx0-f207.google.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MHCSN-0005BH-PX
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 07:54:48 +0000
Received: by gxk3 with SMTP id 3so3419672gxk.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 18 Jun 2009 00:54:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090617214220.GA227500@medusa.sis.pasteur.fr>
References: <f5a7b3810906171320p432db48l92fc6a42cddfa6df@mail.gmail.com>
	<20090617214220.GA227500@medusa.sis.pasteur.fr>
Date: Thu, 18 Jun 2009 13:24:07 +0530
Message-ID: <f5a7b3810906180054v457c0ab9s9fc075804b270e22@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] [FIX PATCH] ltp-rt_sigprocmask
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
To: Nicolas Joly <njoly@pasteur.fr>, subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Oleg Nesterov <oleg@redhat.com>, Manas Kumar Nayak <maknayak@in.ibm.com>, rohit.170309@gmail.com

Hi Nicolas Joly,

=A0 =A0 =A0 =A0>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(sys=
call(174, 33, &act, &oact, 8));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(syscall(__NR_tkill=
, 33, &act, &oact, 8));
>
> This one looks wrong ... Shouldn't it be __NR_rt_sigaction ?

yes.
your right it should be __NR_rt_sigaction.

Subrata,
please ignore previous patch.
i have attached latest patch.

Best regards
Naresh Kamboju

>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if(TEST_RETURN !=3D 0){
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFA=
IL,"Call to
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cleanup();
rt_sigprocmask()succeeded,but should
>> failed, errno=3D%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 fail++;
>
> --
> Nicolas Joly
>
> Biological Software and Databanks.
> Institut Pasteur, Paris.
>

---------------------------------------------------------------------------=
---
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing =

server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
