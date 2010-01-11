Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NUOJ8-0004LH-PU
	for Ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 17:44:02 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NUOJ7-00005n-MQ
	for Ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 17:44:02 +0000
Received: by pzk26 with SMTP id 26so12390384pzk.4
	for <Ltp-list@lists.sourceforge.net>;
	Mon, 11 Jan 2010 09:43:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1263226258.2410.24.camel@plars-t500>
References: <1263226258.2410.24.camel@plars-t500>
Date: Mon, 11 Jan 2010 09:43:55 -0800
Message-ID: <364299f41001110943q4c476dc7n6dbf1fcf8b05c57d@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Fix for make autotools
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
To: Paul Larson <paul.larson@canonical.com>
Cc: Linux Test Project <Ltp-list@lists.sourceforge.net>

On Mon, Jan 11, 2010 at 8:10 AM, Paul Larson <paul.larson@canonical.com> wr=
ote:
> Make autotools seems to break on more recent versions without this.
>
> Signed-off-by: Paul Larson <paul.larson@canonical.com>
> ---
> diff --git a/include/mk/automake.mk b/include/mk/automake.mk
> index e23d5d4..889e6cf 100644
> --- a/include/mk/automake.mk
> +++ b/include/mk/automake.mk
> @@ -59,7 +59,7 @@ include:
> =A0 =A0 =A0 =A0mkdir -p "$@"
>
> =A0m4/ltp-version.m4: ChangeLog
> - =A0 =A0 =A0 sed -n '1{s:LTP-:AC_DEFUN([LTP_VERSION],[:;s:$$:]):;p;q}' $=
< > $@
> + =A0 =A0 =A0 sed -n '1{s:LTP-:m4_define([LTP_VERSION],[:;s:$$:]):;p;q}' =
$< > $@
>
> =A0.PHONY: automake
> =A0AUTOMAKE_FILES :=3D config.guess config.sub install-sh missing stamp-h1

Hi Paul,
    What version of automake and m4 are you using?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
