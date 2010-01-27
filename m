Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Na3pF-0005Vs-NH
	for ltp-list@lists.sourceforge.net; Wed, 27 Jan 2010 09:04:37 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Na3pE-0003E1-Hv
	for ltp-list@lists.sourceforge.net; Wed, 27 Jan 2010 09:04:37 +0000
Received: by pxi38 with SMTP id 38so5463pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Jan 2010 01:04:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <89D32649C0790143AB985A5BF77A104F02C6B55B@etsmsg-hkexm05.etsmsg.org>
References: <89D32649C0790143AB985A5BF77A104F02C6ACB0@etsmsg-hkexm05.etsmsg.org>
	<201001251107.12675.vapier@gentoo.org>
	<89D32649C0790143AB985A5BF77A104F02C6B55B@etsmsg-hkexm05.etsmsg.org>
Date: Wed, 27 Jan 2010 01:04:29 -0800
Message-ID: <364299f41001270104w4499f167mfa6876681f2329fc@mail.gmail.com>
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
To: Kiran.Girmaji@emerson.com
Cc: ltp-list@lists.sourceforge.net, vapier@gentoo.org

On Tue, Jan 26, 2010 at 9:47 PM,  <Kiran.Girmaji@emerson.com> wrote:
>
> Attached is the config.log.
>
> -----Original Message-----
> From: Mike Frysinger [mailto:vapier@gentoo.org]
> Sent: Monday, January 25, 2010 9:37 PM
> To: ltp-list@lists.sourceforge.net
> Cc: Girmaji, Kiran Kumar [NETPWR/EMBED/HYDE]
> Subject: Re: [LTP] LTP configure error
>
> On Monday 25 January 2010 06:32:45 Kiran.Girmaji@emerson.com wrote:
>> I am getting this configure error while compiling LTP
>> (ltp-full-20091231) for PPC arch.
>>
>> configure: error: Couldn't find functional copy of quota v2 - are you
>> running 2.4.x?
>
> attach the config.log. =A0your error report is too brief.

    My guess is that you have quota v1. As I said before this issue
(quota v1 support) was addressed in HEAD, so if you tested from HEAD
or wait for the next LTP release you won't `run into this issue'.
HTH,
-Garrett

---------------------------------------------------------------------------=
---
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the busine=
ss
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
