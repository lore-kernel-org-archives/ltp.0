Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OUjB4-0006fD-BV
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 16:33:22 +0000
Received: from mail-iw0-f174.google.com ([209.85.214.174])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OUjB3-00034z-Cv
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 16:33:22 +0000
MIME-Version: 1.0
In-Reply-To: <1278087148.6654.80.camel@moss-pluto.epoch.ncsc.mil>
References: <1278087148.6654.80.camel@moss-pluto.epoch.ncsc.mil>
Date: Fri, 2 Jul 2010 09:33:14 -0700
Message-ID: <AANLkTinSQUSXGO5Ifu8Z-RVoCvagpFZqZKROWkXAN7SY@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] ima: Fix ima_measure
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
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: ltp-list <ltp-list@lists.sf.net>, Mimi Zohar <zohar@us.ibm.com>

On Fri, Jul 2, 2010 at 9:12 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> ima_measure doesn't build correctly. =A0It needs config.h to determine
> whether openssl headers are present, and verbose needs to be global.
> Broken by commit ef77253961f909f87e82e6d2b620e87af33e9665.
>
> Signed-off-by: =A0Stephen D. Smalley <sds@tycho.nsa.gov>

I don't remember why I did this originally (might have accidentally
committed a test version of the program), but the diff looks sane.

Acked-by: Garrett Cooper <yanegomi@gmail.com>

Thanks,
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
