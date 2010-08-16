Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Ol8et-0006vA-C5
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 22:59:59 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ol8es-0006Cd-Co
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 22:59:59 +0000
Received: by bwz12 with SMTP id 12so3069760bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 16 Aug 2010 15:59:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C69889C.6040202@redhat.com>
References: <4C69889C.6040202@redhat.com>
Date: Mon, 16 Aug 2010 15:59:52 -0700
Message-ID: <AANLkTi=0pMNRLg5YyitKdDoTzYpDZzTAgo-OV=yJabyP@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] warning when building sighold02.c
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

On Mon, Aug 16, 2010 at 11:51 AM, David Marlin <dmarlin@redhat.com> wrote:
>
> The functions read_pipe and write_pipe in sighold02.c each expect a single
> file descriptor as arguments, however the function prototypes define no
> arguments. =A0Also, the function references to read_pipe pass two argumen=
ts, a
> file descriptor and '0'. =A0The second argument should not be passed, as =
it is
> not used.
>
> Attached is a patch to make the function argument definitions and uses
> consistent within this testcase.

ACK.

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
