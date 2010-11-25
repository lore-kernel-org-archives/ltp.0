Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PLiUD-00084d-KT
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 20:32:09 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PLiUA-0006Qo-Tc
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 20:32:09 +0000
Received: by wwb39 with SMTP id 39so38583wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 25 Nov 2010 12:31:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4CEE2299.1080605@cn.fujitsu.com>
References: <4CEE2299.1080605@cn.fujitsu.com>
Date: Thu, 25 Nov 2010 12:31:56 -0800
Message-ID: <AANLkTikJjKXKrCxHa8hnjRHfaM6hGM-xy28ps6ca0Yep@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [RFC][POSIX][PATCH]Get rid of the test of
	pthread_mutex_getprioceiling
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Nov 25, 2010 at 12:47 AM, Bian Naimeng <biannm@cn.fujitsu.com> wrot=
e:
> Hi,
>
> =A0The 1-1 and 3-3 do the same test, but they expect different result.
> I do not know why?
>
> However, i think we should get rid of 3-3. Because it looks like not a PO=
SIX
> compliant case.

I'll look at cleaning this up. I didn't clean everything up yet in
that area as I was going through and adding testcases for missing
POSIX assertions.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
