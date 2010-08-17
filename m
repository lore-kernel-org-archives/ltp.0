Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapierfilter@gmail.com>) id 1OlSXr-0007KA-C5
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 20:14:03 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlSXq-0000vU-Hl
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 20:14:03 +0000
Received: by fxm6 with SMTP id 6so4756494fxm.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Aug 2010 13:13:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C6AEA91.6080004@redhat.com>
References: <4C6AD62B.2010905@redhat.com>
	<AANLkTimTbSmbAf+sVJz6KsMxcYsg0Em6+1jrgcNLuDcF@mail.gmail.com>
	<4C6AEA91.6080004@redhat.com>
Date: Tue, 17 Aug 2010 16:13:56 -0400
Message-ID: <AANLkTinJH+UFWiEH4gOfDzNanfRqArGEjvkx-JK7Y7yr@mail.gmail.com>
From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [LTP] problems building lchown02.c for uClinux
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
To: dmarlin@redhat.com
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Tue, Aug 17, 2010 at 4:01 PM, David Marlin wrote:
> Garrett Cooper wrote:
>> It would help if
>> there was a breakdown of what functionality is and isn't available in
>> uclinux that's gating builds / testing (I honestly don't know right
>> offhand what those pieces are).
>
> Me either. =A0I'm just using trial and error at the moment (see what
> works). =A0Many (most) syscalls tests have code to skip unsupported
> functions based on UCLINUX=3D1, but a few seem to be missing that test.

there are some which shouldnt be skipped any more, so i wouldnt use
the existence of UCLINUX code as a clear indicator that something is
"OK"
-mike

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
