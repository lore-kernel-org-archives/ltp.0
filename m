Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NkSE2-0001j0-Fs
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 01:09:10 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NkSE1-0001fW-KE
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 01:09:10 +0000
Received: by pwi5 with SMTP id 5so4600805pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 24 Feb 2010 17:08:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B8558A6020000E80005EF62@sinclair.provo.novell.com>
References: <4B8558A6020000E80005EF62@sinclair.provo.novell.com>
Date: Wed, 24 Feb 2010 17:08:56 -0800
Message-ID: <364299f41002241708g1cd33c48k5f1e0e4553c02bec@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [patch] swapon03 cleanup v2
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
To: Murlin Wenzel <mwenzel@novell.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Feb 24, 2010 at 3:49 PM, Murlin Wenzel <mwenzel@novell.com> wrote:
> Added clean_swap() to cleanup routine. =A0This makes sure all leftover sw=
ap files are removed.
>
> Signed-off-By: =A0Murlin Ray Wenzel mwenzel@novell.com

Committed -- thanks!
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
