Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OqT5P-0002UI-0J
	for ltp-list@lists.sourceforge.net; Tue, 31 Aug 2010 15:49:23 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OqT5N-0000hP-PR
	for ltp-list@lists.sourceforge.net; Tue, 31 Aug 2010 15:49:22 +0000
Received: by bwz12 with SMTP id 12so5829180bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 31 Aug 2010 08:48:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=ShuJOPjaywptWgDaFFG9zhb_uk=_42bpwSavA@mail.gmail.com>
References: <AANLkTi=ShuJOPjaywptWgDaFFG9zhb_uk=_42bpwSavA@mail.gmail.com>
Date: Tue, 31 Aug 2010 08:48:40 -0700
Message-ID: <AANLkTi=9PFi3k0eEyYO_SvwBsOK77CBECXkrWLy7rkhY@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] ld01
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
To: Deepti Thite <dthite@in.mvista.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Aug 31, 2010 at 2:47 AM, Deepti Thite <dthite@in.mvista.com> wrote:
> ld01 test fails as native compilers don=92t match in the expected and out=
put
> file.
>
> The attached patch will grep expected results from the output file genera=
ted
> and will not create an expected results file.

What is the actual error message that gets printed out by ld(1)?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
