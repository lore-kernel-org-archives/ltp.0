Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NlTDl-0005lA-Gg
	for ltp-list@lists.sourceforge.net; Sat, 27 Feb 2010 20:25:05 +0000
Received: from mail-px0-f203.google.com ([209.85.216.203])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NlTDk-0007U9-U7
	for ltp-list@lists.sourceforge.net; Sat, 27 Feb 2010 20:25:05 +0000
Received: by pxi41 with SMTP id 41so411135pxi.23
	for <ltp-list@lists.sourceforge.net>;
	Sat, 27 Feb 2010 12:24:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d270b4401002270606y1f695cc8u3afaefb8b722528c@mail.gmail.com>
References: <d270b4400912250122y371c4d4dq6fa729b60e03f8a5@mail.gmail.com>
	<20100111162256.GB19010@saboteur.suse.cz>
	<20100128041619.GB16209@malik-laptop.in.ibm.com>
	<d270b4401002202353pec0431w4a2bb947544ff444@mail.gmail.com>
	<364299f41002261213q24890454jac60233bd8f92ded@mail.gmail.com>
	<d270b4401002270505n59e448eev69b6f7b263ecd61d@mail.gmail.com>
	<d270b4401002270606y1f695cc8u3afaefb8b722528c@mail.gmail.com>
Date: Sat, 27 Feb 2010 12:24:58 -0800
Message-ID: <364299f41002271224x2aef49b0i4079babd986403e7@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Testcase to validate the memory usage limit imposed by
	the topmost memory cgroup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7995020444112094970=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mohamed Naufal <naufal11@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============7995020444112094970==
Content-Type: multipart/alternative; boundary=000e0cd1b77c54d83404809acf73

--000e0cd1b77c54d83404809acf73
Content-Type: text/plain; charset=ISO-8859-1

On Sat, Feb 27, 2010 at 6:06 AM, Mohamed Naufal <naufal11@gmail.com> wrote:

> It seems my mailer screws up the formatting. Attaching the patch.
>

    This looks good (minus the unnecessary dependency on libcontrollers,
that I'll yank after commit). Rishi, are we ready for commit?
Thanks,
-Garrett

--000e0cd1b77c54d83404809acf73
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Sat, Feb 27, 2010 at 6:06 AM, Mohamed Naufal =
<span dir=3D"ltr">&lt;<a href=3D"mailto:naufal11@gmail.com">naufal11@gmail.=
com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"bor=
der-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-=
left: 1ex;">
<div><div></div><div class=3D"h5">It seems my mailer screws up the formatti=
ng. Attaching the patch.<br></div></div></blockquote><div><br>=A0 =A0 This =
looks good (minus the unnecessary dependency on libcontrollers, that I&#39;=
ll yank after commit). Rishi, are we ready=A0for commit?<br>
Thanks,<br>-Garrett</div></div>

--000e0cd1b77c54d83404809acf73--


--===============7995020444112094970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============7995020444112094970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7995020444112094970==--

