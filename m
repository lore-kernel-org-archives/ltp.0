Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NLqZ1-0000PY-UV
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 04:05:07 +0000
Received: from mail-px0-f189.google.com ([209.85.216.189])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLqYt-0006tW-Hf
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 04:05:07 +0000
Received: by pxi27 with SMTP id 27so823275pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 18 Dec 2009 20:04:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4b2c3830.4844f10a.06fd.fffff8f1SMTPIN_ADDED@mx.google.com>
References: <4b2c3830.4844f10a.06fd.fffff8f1SMTPIN_ADDED@mx.google.com>
Date: Fri, 18 Dec 2009 20:04:52 -0800
Message-ID: <364299f40912182004x337ae65co5f9ee8b976f8287f@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix the nfs runtest file
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Fri, Dec 18, 2009 at 6:18 PM, Jiri Palecek <jpalecek@web.de> wrote:
> Hello,
>
> =A0The command "export X=3DY cmd" means export variable X (valued Y) and
> =A0variable cmd; it does not run cmd. To do the latter, you can write
> =A0"X=3DY cmd" (as in this patch) or "export X=3DY; cmd"
>
> Regards
> =A0 =A0Jiri Palecek
>
> Signed-off-by: Jiri Palecek <jpalecek@web.de>
> ---
> =A0runtest/nfs | =A0 =A08 ++++----
> =A01 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/runtest/nfs b/runtest/nfs
> index 4f5d876..1cddcd6 100644
> --- a/runtest/nfs
> +++ b/runtest/nfs
> @@ -2,10 +2,10 @@
> =A0#
> =A0# PLEASE READ THE README FILE IN /nfs BEFORE RUNNING THESE.
> =A0#
> -nfs01 export VERSION SOCKET_TYPE; export TCbin=3D$LTPROOT/testcases/bin =
nfs01
> -nfs02 export VERSION SOCKET_TYPE; export TCbin=3D$LTPROOT/testcases/bin =
nfs02
> -nfs03 export VERSION SOCKET_TYPE; export TCbin=3D$LTPROOT/testcases/bin =
nfs03
> -nfs04 export VERSION SOCKET_TYPE; export TCbin=3D$LTPROOT/testcases/bin =
nfs04
> +nfs01 export VERSION SOCKET_TYPE; TCbin=3D$LTPROOT/testcases/bin nfs01
> +nfs02 export VERSION SOCKET_TYPE; TCbin=3D$LTPROOT/testcases/bin nfs02
> +nfs03 export VERSION SOCKET_TYPE; TCbin=3D$LTPROOT/testcases/bin nfs03
> +nfs04 export VERSION SOCKET_TYPE; TCbin=3D$LTPROOT/testcases/bin nfs04
> =A0nfslock01 export VERSION; nfslock01
>
> =A0# This will run 1 thread on 20 directories with 50 files in each.

Done -- thanks!
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
