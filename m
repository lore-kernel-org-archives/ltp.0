Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NkOae-0005HF-Q7
	for ltp-list@lists.sourceforge.net; Wed, 24 Feb 2010 21:16:16 +0000
Received: from mail-pz0-f176.google.com ([209.85.222.176])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NkOad-0001Zc-RQ
	for ltp-list@lists.sourceforge.net; Wed, 24 Feb 2010 21:16:16 +0000
Received: by pzk6 with SMTP id 6so876867pzk.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 24 Feb 2010 13:16:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B8502D7020000E80005EEE6@sinclair.provo.novell.com>
References: <4B8502D7020000E80005EEE6@sinclair.provo.novell.com>
Date: Wed, 24 Feb 2010 13:16:09 -0800
Message-ID: <364299f41002241316h549d84c6j366b7fff764e9b71@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] swapon03 cleanup
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

On Wed, Feb 24, 2010 at 9:43 AM, Murlin Wenzel <mwenzel@novell.com> wrote:
> This cleans up existing swap files in swapon03 test in failing test case.=
 =A0Otherwise, deleted swap files would still exist in /proc/swaps.
>
> Signed-off-by: Murlin Ray Wenzel mwenzel@novell.com

Why not implement this as part of cleanup?
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
