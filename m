Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MGVBV-0001ME-DZ
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2009 09:42:29 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MGVBJ-0003gj-AE
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2009 09:42:29 +0000
From: Jiri Palecek <jpalecek@web.de>
Date: Tue, 16 Jun 2009 11:46:37 +0200
References: <ab64ec20906160106g664052edo690bdaf97c2ed847@mail.gmail.com>
In-Reply-To: <ab64ec20906160106g664052edo690bdaf97c2ed847@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200906161146.38317.jpalecek@web.de>
Subject: Re: [LTP] unable to install ltp-full-20090531
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: naveen penumala <naveenspen@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Tuesday 16 June 2009 10:06:49 naveen penumala wrote:
> Hi,

Hi,

> Please look at the below compilation error at the time of "make all" after
> configuration.
> Here i'm using Suse linux, and kernel version is 2.6.16.21.
> =

> Please help me regarding this.
> =

> =

> make[4]: Entering directory
> `/home/kevin/tests/LTP/ltp-full-20090531/testcases/kernel/mem/mem'
> gcc -g -O2 -Wall -I../../../../include    mem02.c -L../../../../lib -lltp
> -o mem02
> mem02.c: In function =E2main=E2:
> mem02.c:71: internal compiler error: in merge_alias_info, at
> tree-ssa-copy.c:235
> Please submit a full bug report,
> with preprocessed source if appropriate.

Well, this means you have a buggy compiler. If you have an older version, j=
ust try updating it; otherwise, do what it says: file a full bugreport to y=
our compiler's (or maybe to Suse) bugzilla with preprocessed source.

Regards
    Jiri Palecek

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
