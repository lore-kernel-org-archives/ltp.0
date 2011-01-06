Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PaxXy-0001mX-VZ
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 21:39:02 +0000
Received: from mail-ew0-f47.google.com ([209.85.215.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PaxXx-0006AJ-VZ
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 21:39:02 +0000
Received: by ewy28 with SMTP id 28so4336177ewy.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 Jan 2011 13:38:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=L8Vai5_=fn0psJeovura_Y=VjdN28ufiqBiiA@mail.gmail.com>
References: <4D259E4A.2050704@cn.fujitsu.com>
	<AANLkTinX9M3EsBxSDsVy56iKqskSWKQE4vMhXy0kcxNG@mail.gmail.com>
	<20B25B11-E8BD-45A7-AAD5-209D62BC6274@gmail.com>
	<AANLkTi=L8Vai5_=fn0psJeovura_Y=VjdN28ufiqBiiA@mail.gmail.com>
Date: Thu, 6 Jan 2011 13:38:56 -0800
Message-ID: <AANLkTin-yaUcPd8GZHgWnoYkxpOxDFs4enEik8afaeEc@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 00/13]Fix a few syntax error
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On Thu, Jan 6, 2011 at 1:30 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Thu, Jan 6, 2011 at 2:35 PM, Garrett Cooper wrote:
>> A really bad merge (I posted a reply to it a while ago in the archives).
>
> is there a way for us to manage the git hooks ? =A0we could have them
> reject trivial merge commits (ones that should be fast forwards), and
> commits with merge cruft in it ...

   This was nastier. A lot of the problems I caused was ignorance and
human error based -- in particular I thought that git reset --hard
would actually reset merges (but it didn't!) and I didn't bother to
fake the push before I did it and the rest is history. So I don't know
if adding hooks would fix that, but I think that the tool should reset
merges if I do reset --hard.
    I need to note some of the fun points I've had with git so far
because there are a handful of items with the tool that have really
made my life painful in the past couple of weeks that should be fixed.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, an=
d, =

should the need arise, upgrade to a full multi-node Oracle RAC database =

without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
