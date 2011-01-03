Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PZj7d-0007u9-Tl
	for ltp-list@lists.sourceforge.net; Mon, 03 Jan 2011 12:02:45 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PZj7d-0003k7-5I
	for ltp-list@lists.sourceforge.net; Mon, 03 Jan 2011 12:02:45 +0000
Received: by pzk12 with SMTP id 12so2738362pzk.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 03 Jan 2011 04:02:39 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1082)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <1294054372.10644.2.camel@subratamodak.linux.ibm.com>
Date: Mon, 3 Jan 2011 04:02:34 -0800
Message-Id: <DADDA9AB-BA92-477B-B370-6A785933357C@gmail.com>
References: <1294054372.10644.2.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] Build failures as of today
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: "ltp-list@lists.sourceforge.net List" <ltp-list@lists.sourceforge.net>

	There are 200 or so issues remaining with warnings in the sourcebase on i3=
86 at least. I'm working through them as quickly as I can, but I run into r=
oadblocks occasionally that slow me down... Any warnings that existed befor=
e will need to be resolved as well before we can continue.
	I've detailed what can be done to help fix things in a previous email -- a=
s long as people follow the lead for the changes I've made, it'll be easy t=
o resolve all of the outstanding issues.
Thanks,
-Garrett

On Jan 3, 2011, at 3:32 AM, Subrata Modak wrote:

> Garret,
> =

> I see them today:
> =

> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -Werror
> -I/root/LTP-GIT/ltp/testcases/kernel/include -I../../../../include
> -I../../../../include   -L../../../../lib  alarm02.c   -lltp -o alarm02
> cc1: warnings being treated as errors
> alarm02.c: In function =91main=92:
> alarm02.c:169: error: control reaches end of non-void function
> make[4]: *** [alarm02] Error 1
> make[4]: Leaving directory
> `/root/LTP-GIT/ltp/testcases/kernel/syscalls/alarm'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory `/root/LTP-GIT/ltp/testcases/kernel/syscalls'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/root/LTP-GIT/ltp/testcases/kernel'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/root/LTP-GIT/ltp/testcases'
> make: *** [testcases-all] Error 2
> =

> Regards--
> Subrata
> =

> =



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
