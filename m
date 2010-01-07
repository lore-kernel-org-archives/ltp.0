Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NSoIS-0003m9-73
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 09:04:48 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSoIQ-0002gL-Oc
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 09:04:47 +0000
Received: by pwj11 with SMTP id 11so12915033pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Thu, 07 Jan 2010 01:04:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100106171812.GA15444@us.ibm.com>
References: <1262791548.15424.31.camel@moss-pluto.epoch.ncsc.mil>
	<20100106171812.GA15444@us.ibm.com>
Date: Thu, 7 Jan 2010 01:04:39 -0800
Message-ID: <364299f41001070104q1b8e54es14fbf467fda6f6a@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] regression: selinux testsuite broken since October
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net, Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>

On Wed, Jan 6, 2010 at 9:18 AM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> Quoting Stephen Smalley (sds@tycho.nsa.gov):
>> It seems the Makefile rewrite last October broke the selinux testsuite.
>> Is it unreasonable to expect that someone who rewrote the Makefile would
>> actually try running the testsuite?
>>
>> Please, revert the changes or fix them.
>>
>> See testcases/kernel/security/selinux-testsuite/README for the
>> instructions.
>
> Seems I have a part in breakage as well. =A0Here are patches to get the
> execshare_parent to compile.
>
> Now to get the policy to compile...
>
> --- ltp-full-20091231.orig/testcases/kernel/security/selinux-testsuite/te=
sts/execshare/selinux_execshare_parent.c =A0 =A0 =A0 2009-11-03 15:07:35.00=
0000000 -0500
> +++ ltp-full-20091231/testcases/kernel/security/selinux-testsuite/tests/e=
xecshare/selinux_execshare_parent.c =A0 =A02010-01-06 11:58:47.000000000 -0=
500
> @@ -18,9 +18,12 @@
> =A0#include <selinux/selinux.h>
> =A0#include <selinux/context.h>
> =A0#include <sched.h>
> +#include <test.h>
>
> -int clone_fn(char **argv)
> +int clone_fn(void *in)
> =A0{
> + =A0 =A0 =A0 char **argv =3D (char **) in;
> +
> =A0 =A0 =A0 =A0execv(argv[3], argv+3);
> =A0 =A0 =A0 =A0perror(argv[3]);
> =A0 =A0 =A0 =A0return -1;
> @@ -73,7 +76,7 @@ int main(int argc, char **argv)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprintf(stderr, "%s: =A0unable to set exec=
 context to %s\n", argv[0], context_s);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit(-1);
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 pid =3D ltp_clone_quick(cloneflags | SIGCHLD, child_fn, arg=
v);
> + =A0 =A0 =A0 pid =3D ltp_clone_quick(cloneflags | SIGCHLD, clone_fn, arg=
v);
> =A0 =A0 =A0 =A0if (pid < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror("clone");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit(-1);
>
> --- ltp-full-20091231.orig/testcases/kernel/security/selinux-testsuite/te=
sts/execshare/Makefile 2009-10-09 13:55:51.000000000 -0400
> +++ ltp-full-20091231/testcases/kernel/security/selinux-testsuite/tests/e=
xecshare/Makefile =A0 =A0 =A02010-01-06 11:53:53.000000000 -0500
> @@ -25,6 +25,6 @@ top_srcdir =A0 =A0 =A0 =A0 =A0 =A0 =A0?=3D ../../../../.
> =A0include $(top_srcdir)/include/mk/env_pre.mk
> =A0include $(abs_srcdir)/../Makefile.inc
>
> -LDLIBS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D -lselinux
> +LDLIBS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D -lselinux -lltp
>
> =A0include $(top_srcdir)/include/mk/generic_leaf_target.mk

Committed.
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
