Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NX9Ep-0008RZ-Pz
	for ltp-list@lists.sourceforge.net; Tue, 19 Jan 2010 08:14:59 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NX9En-00017E-US
	for ltp-list@lists.sourceforge.net; Tue, 19 Jan 2010 08:14:58 +0000
Received: by pwj11 with SMTP id 11so2511492pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Tue, 19 Jan 2010 00:14:42 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 19 Jan 2010 00:14:42 -0800
Message-ID: <364299f41001190014n2cf1b908j64dde2562e5bfea6@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] make 3.80 enabled in mainline [was Re: Ran into a brick wall
	with make 3.80]
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
To: LTP list <ltp-list@lists.sourceforge.net>
Cc: Andi Kleen <andi@firstfloor.org>, Stephen Smalley <sds@tycho.nsa.gov>, =?ISO-2022-JP?B?GyRCP0BDK0p+SE8bKEI=?= <mitani@ryobi.co.jp>

On Sun, Jan 17, 2010 at 11:33 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> =A0 =A0So... it appears that I've run into a serious brick wall with make
> 3.80 with eval blocks, which looks like:
>
> make[4]: Leaving directory
> `/scratch/ltp/testcases/kernel/controllers/libcontrollers'
> make[4]: Entering directory
> `/scratch/ltp/testcases/kernel/controllers/libcontrollers'
> /scratch/ltp/include/mk/env_post.mk:72: *** missing `endif'. =A0Stop.
>
> =A0 =A0There are so many bugfixes that have gone into read.c and a few
> other things in make that I don't know which one is causing the
> problem, yet. I honestly don't know if getting past this would be
> possible, or fruitful, but I'll keep on trying...

    Fortunately a lot of whacking away at the code and the idea, and I
finally got it to work on my system.
    So, everyone with make v3.80 -- HAVE AT IT AND BE SURE TO TEST
FROM CVS :D :D :D :D :D :D :D!!!!!!
    Now, to go off and fix the selinux-testsuite...
Cheers,
-Garrett

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
