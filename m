Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PdeXf-00009s-E6
	for ltp-list@lists.sourceforge.net; Fri, 14 Jan 2011 07:57:51 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PdeXe-0002pj-A7
	for ltp-list@lists.sourceforge.net; Fri, 14 Jan 2011 07:57:51 +0000
Received: by wyb40 with SMTP id 40so2472408wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 13 Jan 2011 23:57:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=gsOkRM0NQNsKp5-L37hTDwd4+5euqXD9E5gXe@mail.gmail.com>
References: <AANLkTi=gsOkRM0NQNsKp5-L37hTDwd4+5euqXD9E5gXe@mail.gmail.com>
Date: Thu, 13 Jan 2011 23:54:47 -0800
Message-ID: <AANLkTikQNHCvRUmYL8dYEayweEEmusAG2nobuPM5qF66@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [Bug Fix] utimes01.c can't build in uclinux
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
To: Vivi <violetleigh@gmail.com>
Cc: LTP mailing list <ltp-list@lists.sourceforge.net>

On Wed, Dec 29, 2010 at 1:35 AM, Vivi <violetleigh@gmail.com> wrote:
> LTP test case utimes01.c can't build in uclinux as it failed in file
> common_j_h.c.
> Fix this by diable fork related part in uclinux platform.
>
> --
> Index: testcases/kernel/syscalls/utils/common_j_h.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- testcases/kernel/syscalls/utils/common_j_h.c
> +++ testcases/kernel/syscalls/utils/common_j_h.c
> @@ -115,6 +115,7 @@
> =A0/*
> =A0 * Generate a child process which will send a signal
> =A0 */
> +#ifndef UCLINUX
> =A0pid_t create_sig_proc(unsigned long usec, int sig, unsigned count)
> =A0{
> =A0=A0=A0=A0=A0=A0=A0 pid_t pid, cpid;
> @@ -142,6 +143,7 @@
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return cpid;
> =A0=A0=A0=A0=A0=A0=A0 }
> =A0}
> +#endif
>
>
> =A0/*
> @@ -351,6 +353,7 @@
> =A0/*
> =A0 * Get unexist pid
> =A0 */
> +#ifndef UCLINUX
> =A0pid_t get_unexist_pid(void)
> =A0{
> =A0=A0=A0=A0=A0=A0=A0 pid_t pid;
> @@ -368,4 +371,4 @@
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return pid;
> =A0=A0=A0=A0=A0=A0=A0 }
> =A0}
> -
> +#endif

    This will break more testcases than it's worth. Please revise your
strategy of fixing the UCLINUX testcases.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand =

malware threats, the impact they can have on your business, and how you =

can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
