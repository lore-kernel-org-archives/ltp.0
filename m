Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapierfilter@gmail.com>) id 1PaxfF-0002Nn-Qy
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 21:46:33 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PaxfE-0003hq-Uq
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 21:46:33 +0000
Received: by fxm17 with SMTP id 17so15616937fxm.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 Jan 2011 13:46:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTin-yaUcPd8GZHgWnoYkxpOxDFs4enEik8afaeEc@mail.gmail.com>
References: <4D259E4A.2050704@cn.fujitsu.com>
	<AANLkTinX9M3EsBxSDsVy56iKqskSWKQE4vMhXy0kcxNG@mail.gmail.com>
	<20B25B11-E8BD-45A7-AAD5-209D62BC6274@gmail.com>
	<AANLkTi=L8Vai5_=fn0psJeovura_Y=VjdN28ufiqBiiA@mail.gmail.com>
	<AANLkTin-yaUcPd8GZHgWnoYkxpOxDFs4enEik8afaeEc@mail.gmail.com>
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 6 Jan 2011 16:46:06 -0500
Message-ID: <AANLkTinFbVBZtA_hCfRqTK=sZW+ZBSi3KbjA7Butkfum@mail.gmail.com>
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Jan 6, 2011 at 4:38 PM, Garrett Cooper wrote:
> On Thu, Jan 6, 2011 at 1:30 PM, Mike Frysinger wrote:
>> On Thu, Jan 6, 2011 at 2:35 PM, Garrett Cooper wrote:
>>> A really bad merge (I posted a reply to it a while ago in the archives).
>>
>> is there a way for us to manage the git hooks ? =A0we could have them
>> reject trivial merge commits (ones that should be fast forwards), and
>> commits with merge cruft in it ...
>
> =A0 This was nastier. A lot of the problems I caused was ignorance and
> human error based -- in particular I thought that git reset --hard
> would actually reset merges (but it didn't!)

sure it will ... you just have to reset to before the merge

> I didn't bother to fake the push before I did it and the rest is history.

if you caught it soon, you could have pushed up an old one and forced
it back to the sane state ...
git push --force origin <older commit>:refs/head/master

> So I don't know if adding hooks would fix that

i saw that you had actual conflicts in there, and the hook would have
caught that (">>>>>>>>>" and "=3D=3D=3D=3D=3D=3D=3D=3D=3D" and such)

but i'm not sure if your non-trivial merge would have been detected as
a trivial merge since we dont want that (it'd prevent people from
being able to pull a branch from someone else)
-mike

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
