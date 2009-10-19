Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mzk6P-0006IA-IX
	for ltp-list@lists.sourceforge.net; Mon, 19 Oct 2009 04:44:13 +0000
Received: from mail-px0-f181.google.com ([209.85.216.181])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mzk6J-0001jm-A7
	for ltp-list@lists.sourceforge.net; Mon, 19 Oct 2009 04:44:13 +0000
Received: by pxi11 with SMTP id 11so529625pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Sun, 18 Oct 2009 21:44:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40910141403mc5e784bpa8c76113a95edbbf@mail.gmail.com>
References: <364299f40910141403mc5e784bpa8c76113a95edbbf@mail.gmail.com>
Date: Sun, 18 Oct 2009 21:44:01 -0700
Message-ID: <364299f40910182144s7d46e09cxa72be5659bdc1945@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [PATCH] Re: [issue 12] check_envval is looking for the locale
	command (doesn't exist on all systems)
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

On Wed, Oct 14, 2009 at 2:03 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> =A0 =A0I'm seeing a lot of output from network_stress.log with the follow=
ing lines:
>
> /tests/ltp/output/network_stress.whole-output.log:/tests/ltp/testcases/bi=
n/check_envval:
> line 48: locale: command not found
>
> =A0 =A0Looks like the test needs to be integrated with cmdlib.sh and
> check for the command before continuing.

Checking into cvs now...

1. Add check for locale command with exists command in cmdlib.sh
2. Predefine any and all unbound variables so the set -u call in
cmdlib.sh will allow the script to continue on to a failure point of
some kind (or succeed if all is defined).

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: stress/ns-tools/check_envval
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/network/stress/ns-tools/check_envval,v
retrieving revision 1.1
diff -u -r1.1 check_envval
--- stress/ns-tools/check_envval        24 Oct 2005 20:18:22 -0000      1.1
+++ stress/ns-tools/check_envval        19 Oct 2009 04:41:17 -0000
@@ -42,6 +42,10 @@
 #trace_logic=3D${trace_logic:-"set -x"}
 $trace_logic

+. cmdlib.sh
+
+exists cut locale rsh
+
 # Unset the locale cocerned variables
 for env in `locale | cut -f 1 -d '=3D'` ; do
     unset $env
@@ -49,24 +53,28 @@
 unset LANGUAGE

 # RHOST
+RHOST=3D${RHOST:=3D127.0.0.1}
 if [ x${RHOST} =3D x ]; then
     tst_resm TBROK "Environment variable RHOST is not set."
     exit 1
 fi

 # LHOST_HWADDRS
+LHOST_HWADDRS=3D${LHOST_HWADDRS:=3D}
 if [ x"${LHOST_HWADDRS}" =3D x ]; then
     tst_resm TBROK "Environment variable LHOST_HWADDRS is not set."
     exit 1
 fi

 # RHOST_HWADDRS
+RHOST_HWADDRS=3D${RHOST_HWADDRS:=3D}
 if [ x"${RHOST_HWADDRS}" =3D x ]; then
     tst_resm TBROK "Environment variable RHOST_HWADDRS is not set."
     exit 1
 fi

 # LTP_RSH
+LTP_RSH=3D${LTP_RSH:=3D}
 if [ x"${LTP_RSH}" =3D x ]; then
     LTP_RSH=3D"rsh -n"
 elif [ "$LTP_RSH" =3D "rsh" ]; then
@@ -74,6 +82,7 @@
 fi

 # TMPDIR
+TMPDIR=3D${TMPDIR:=3D}
 if [ x"${TMPDIR}" =3D x ]; then
     TMPDIR=3D/tmp
 fi

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
