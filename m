Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N6a6p-0004q4-1t
	for ltp-list@lists.sourceforge.net; Sat, 07 Nov 2009 01:28:55 +0000
Received: from mail-pz0-f191.google.com ([209.85.222.191])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N6a6i-000662-By
	for ltp-list@lists.sourceforge.net; Sat, 07 Nov 2009 01:28:54 +0000
MIME-Version: 1.0
In-Reply-To: <4AF4B955.2080308@xenotime.net>
References: <1257167821.4977.41.camel@subratamodak.linux.ibm.com>
	<87iqdn76jg.fsf@basil.nowhere.org>
	<364299f40911061339x7b689d3cw705674bd9b332e5c@mail.gmail.com>
	<4AF4B955.2080308@xenotime.net>
Date: Fri, 6 Nov 2009 17:28:42 -0800
Message-ID: <364299f40911061728g37c0cd6ble40974b0fe5b5597@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [patch 2/2] INSTALL corrections & TODO
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
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: ltp-list <ltp-list@lists.sf.net>, Andi Kleen <andi@firstfloor.org>

Hi again,

On Fri, Nov 6, 2009 at 4:03 PM, Randy Dunlap <rdunlap@xenotime.net> wrote:
>
> "Configuration" section to match Makefile message.
> How to use DESTDIR and --prefix together.
>
> TODO:
> "Quick Start" does not work.
> "Not using autoconf:" does not work.
>
> ---
> =A0INSTALL | =A0 =A09 ++++++++-
> =A01 file changed, 8 insertions(+), 1 deletion(-)
>
> --- ltp-full-20091031-auto.orig/INSTALL
> +++ ltp-full-20091031-auto/INSTALL
> @@ -29,7 +29,7 @@ downloaded from:
> =A0- http://ftp.gnu.org/gnu/m4/m4-1.4.7.tar.bz2
> =A0- http://ftp.gnu.org/gnu/m4/m4-1.4.7.tar.gz
>
> -Configuring
> +Configuration
> =A0-------------------
> =A0Using autoconf:
> =A0 =A0 =A0 =A0 $ make autotools # This must be run from "$TOP_SRCDIR!"
> @@ -74,6 +74,13 @@ in the same directory where the source f
> =A0 sysroot, as opposed to the host system's sysroot.
> =A0- Specify SKIP_IDCHECK=3D1 if and when you don't want to modify /etc/{=
group,passwd}
> =A0 on the target system's sysroot.
> +- If you want to build and install ltp inside its source tree (e.g., in
> + =A0$TOP_SRCDIR/ltpbin/), to support multiple versions of LTP on one sys=
tem,
> + =A0then use
> +
> + =A0 =A0 =A0 $ cd $TOP_SRCDIR
> + =A0 =A0 =A0 $ mkdir ltpbin
> + =A0 =A0 =A0 $ ./configure DESTDIR=3D$PWD --prefix=3D$PWD/ltpbin
>
> =A0If you get a build error, please report it to ltp-list@lists.sf.net wi=
th
> =A0following information,
>

My only question about this is this step above a frequently used usecase?
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
