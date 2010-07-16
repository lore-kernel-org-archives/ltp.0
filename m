Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OZtbQ-0006qc-8E
	for ltp-list@lists.sourceforge.net; Fri, 16 Jul 2010 22:41:56 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OZtbO-0006Pj-0c
	for ltp-list@lists.sourceforge.net; Fri, 16 Jul 2010 22:41:56 +0000
Received: by iwn34 with SMTP id 34so3632485iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 16 Jul 2010 15:41:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1279260560.2855.33.camel@sumit>
References: <1279260560.2855.33.camel@sumit>
Date: Fri, 16 Jul 2010 15:41:48 -0700
Message-ID: <AANLkTikgjCX3ddqtw6oeA2kgk0bnKm4vI2oeSUG7_UeS@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 0/2] multicasttest: Bug Fixing
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
To: sumitbd@linsyssoft.com
Cc: ltp-list@lists.sourceforge.net

On Thu, Jul 15, 2010 at 11:09 PM,  <sumitbd@linsyssoft.com> wrote:
> I am working on LTP-20100630. While doing networktest for multicast, I
> came across to following bugs.
>
> I have fixed these bugs =A0and created a patch which is I am sending in
> subsequent mail.
>
> [PATCH 1/2] mc_opts: network/multicast/mc_opts/mc_opts script - bug
> fixing
> [PATCH 2/2] runtest/multicast: wrong TCsrc path exported for multicast
> tests

    Looks good based on the patches I saw. It's too bad that mc_opts
really has to install files though .. doesn't make sense (it seems
like the logic is missing to do that in the Makefile itself).
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
