Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PvSPS-00079x-Sw
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 10:38:58 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PvSPR-0000mQ-VC
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 10:38:58 +0000
Received: by wyb38 with SMTP id 38so2270865wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 04 Mar 2011 02:38:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110225103620.GA10350@hpt.nay.redhat.com>
References: <20110225103620.GA10350@hpt.nay.redhat.com>
Date: Fri, 4 Mar 2011 02:38:51 -0800
Message-ID: <AANLkTi=_K2Q1iYtN0T6izFmnmeEe1Tyyst1CzRHiN+Yg@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] thp testcase come from CVE reproducer
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
To: Garrett Cooper <yanegomi@gmail.com>, ltp-list@lists.sourceforge.net

On Fri, Feb 25, 2011 at 2:36 AM, Han Pingtian <phan@redhat.com> wrote:
> This is a reproducer of =A0CVE-2011-0999, which fixed by mainline commit
> a7d6e4ecdb7648478ddec76d30d87d03d6e22b31:
>
> "Transparent hugepages can only be created if rmap is fully
> functional. So we must prevent hugepages to be created while
> is_vma_temporary_stack() is true."
>
> When running in a loop, it can trigger panic like this, if kernel
> unpatched:
>
> kernel BUG at mm/huge_memory.c:1260!
> invalid opcode: 0000 [#1] SMP
> last sysfs file: /sys/devices/system/cpu/cpu23/cache/index2/shared_cpu_map

...

> +static option_t options[] =3D {
> + =A0 =A0 =A0 {NULL, NULL, NULL}
> +};
> +
> +static void usage(void)
> +{
> + =A0 =A0return;
> +}

You can delete this if you do what I suggest below...

...

> + =A0 =A0 =A0 msg =3D parse_opts(argc, argv, options, usage);
> + =A0 =A0 =A0 if (msg !=3D NULL)

`if ((msg =3D parse_opts(argc, argv, NULL, NULL)) !=3D NULL)' is preferred.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (execve(=
"/bin/true", c, c) =3D=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 tst_brkm(TBROK|TERRNO, NULL, "execve");

Not all systems have /bin/true. It would be better to do:

/bin/sh -c ':'

etc, as we have code that depends on this type of shell-required POSIX beha=
vior.

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
