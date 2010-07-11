Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OY1hy-00062j-8Y
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 18:56:58 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OY1hx-0008RS-F3
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 18:56:58 +0000
Received: by iwn34 with SMTP id 34so2892286iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 11 Jul 2010 11:56:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1278853007.8660.7.camel@sumit>
References: <1278853007.8660.7.camel@sumit>
Date: Sun, 11 Jul 2010 11:56:51 -0700
Message-ID: <AANLkTiksBkRDAMLVKlj4U3N6scjkBWYZdFLPDL4PdOwd@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 0/3] nfstests: Bug Fixing
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

On Sun, Jul 11, 2010 at 5:56 AM,  <sumitbd@linsyssoft.com> wrote:
> Hi,
>
> I am working on LTP-20100630. While doing networktest for nfs, I came
> across to following bugs.
> I have fixed these bugs =A0and created a patch which is I am sending in
> subsequent mail.
>
> [PATCH 1/3] MAKEFILE: testcases/network/Makefile - bug fixing
> [PATCH 2/3] nfs02: testcases/network/nfs/nfs02/nfs02 script - bug fixing
> [PATCH 3/3] runtest/nfs: TCbin path not exported for few tests
> After applying above patches networktest for nfs completed successfully.

Thanks for the patches :).

Take care,
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
