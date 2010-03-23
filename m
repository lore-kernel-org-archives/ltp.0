Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Nu7CK-0000Dv-Ip
	for ltp-list@lists.sourceforge.net; Tue, 23 Mar 2010 16:43:20 +0000
Received: from mail-px0-f204.google.com ([209.85.216.204])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nu7CJ-0005ch-Nk
	for ltp-list@lists.sourceforge.net; Tue, 23 Mar 2010 16:43:20 +0000
Received: by pxi42 with SMTP id 42so1506197pxi.24
	for <ltp-list@lists.sourceforge.net>;
	Tue, 23 Mar 2010 09:43:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100323093953.GE4384@linux.vnet.ibm.com>
References: <20100323093953.GE4384@linux.vnet.ibm.com>
Date: Tue, 23 Mar 2010 09:43:07 -0700
Message-ID: <364299f41003230943wa3c1614v13acace2d4b3118d@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Removed Warning from filecaps
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

On Tue, Mar 23, 2010 at 2:39 AM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> These warning will appear when HAVE_LIBCAP is not defined.
>
> c.c: In function =91main=92:
> c.c:28: warning: unused variable =91ret=92
> c.c:27: warning: unused variable =91caps2=92
> c.c:27: warning: unused variable =91caps=92
>
> Signed-off By: Rishikesh K Rajak<risrajak@linux.vnet.ibm.com>
> ---
> diff --git a/testcases/kernel/security/filecaps/c.c b/testcases/kernel/se=
curity/filecaps/c.c
> index ee6cf05..5e1696c 100644
> --- a/testcases/kernel/security/filecaps/c.c
> +++ b/testcases/kernel/security/filecaps/c.c
> @@ -24,10 +24,11 @@
>
> =A0int main()
> =A0{
> +
> +#ifdef HAVE_LIBCAP
> =A0 =A0 =A0 =A0cap_t caps, caps2;
> =A0 =A0 =A0 =A0int ret;
>
> -#ifdef HAVE_LIBCAP
> =A0 =A0 =A0 =A0caps =3D cap_from_text("cap_setpcap+ep");
> =A0 =A0 =A0 =A0caps2 =3D cap_from_text("cap_setpcap+ep");
> =A0 =A0 =A0 =A0ret =3D cap_set_proc(caps);

This is better because it also avoids compilation failures when libcap
isn't present. The conditional around sys/capability.h should be
restored as well.

Acked-by: Garrett Cooper <yanegomi@gmail.com>

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
