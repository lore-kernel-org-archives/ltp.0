Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OA56P-0007JN-6i
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 17:43:13 +0000
Received: from mail-iw0-f200.google.com ([209.85.223.200])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OA56O-0000cM-FL
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 17:43:13 +0000
Received: by iwn38 with SMTP id 38so154550iwn.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 May 2010 10:43:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100506144556.GA11460@us.ibm.com>
References: <20100506144556.GA11460@us.ibm.com>
Date: Thu, 6 May 2010 10:43:07 -0700
Message-ID: <o2y364299f41005061043yf5044aa0u136c168855622abd@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v2] make filecaps tests succeed
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
Cc: LTP list <ltp-list@lists.sourceforge.net>, Subrata Modak1 <subrata.modak@in.ibm.com>

On Thu, May 6, 2010 at 7:45 AM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> (Garrett I was going to add your ack, but wasn't absolutely sure
> whether you meant it should apply to the whole thing or not)
>
> Most of these are belated cleanup after the move to using /opt/ltp.
> But come on, replacing 'return' with tst_exit(), are you just trying
> to mess with my head?
>
> Changelog:
> =A0may 4: address Garrett's feedback
> =A01. single return 0 in print_caps.c
> =A02. use $TMP if defined for location of caps_fifo
> =A03. use tst_brkm in place of tst_resm.
> =A0may 5: address Garrett's comment:
> =A0don't add 1 to null pointer and then check for 1
>
> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

Acked-by: Garrett Cooper <yanegomi@gmail.com>

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
