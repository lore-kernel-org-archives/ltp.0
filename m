Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NZRlS-00066x-E9
	for ltp-list@lists.sourceforge.net; Mon, 25 Jan 2010 16:26:10 +0000
Received: from mail-pz0-f190.google.com ([209.85.222.190])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NZRlQ-0000mJ-48
	for ltp-list@lists.sourceforge.net; Mon, 25 Jan 2010 16:26:10 +0000
Received: by pzk28 with SMTP id 28so518255pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 25 Jan 2010 08:26:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201001251107.12675.vapier@gentoo.org>
References: <89D32649C0790143AB985A5BF77A104F02C6ACB0@etsmsg-hkexm05.etsmsg.org>
	<201001251107.12675.vapier@gentoo.org>
Date: Mon, 25 Jan 2010 08:19:16 -0800
Message-ID: <364299f41001250819s260bb44bsd1a86762b5220321@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP configure error
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
Cc: ltp-list@lists.sourceforge.net, Kiran.Girmaji@emerson.com

On Mon, Jan 25, 2010 at 8:07 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Monday 25 January 2010 06:32:45 Kiran.Girmaji@emerson.com wrote:
>> I am getting this configure error while compiling LTP
>> (ltp-full-20091231) for PPC arch.
>>
>> configure: error: Couldn't find functional copy of quota v2 - are you
>> running 2.4.x?
>
> attach the config.log. =A0your error report is too brief.

    This issue is actually fixed on HEAD as of early last week (IIRC).
I purposely made AC_MSG_WARN AC_MSG_ERROR because I didn't want silent
failures to pass as I knew there was a feature gap that needed to be
addressed in the test.
Thanks!
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
