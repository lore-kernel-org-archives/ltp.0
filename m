Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1RiBKY-0000Eq-Ef
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:51:34 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RiBKX-0002RX-Og
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:51:34 +0000
Received: by obcwn6 with SMTP id wn6so18294047obc.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Jan 2012 12:51:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201201031521.18371.vapier@gentoo.org>
References: <4F02E420.5040100@imgtec.com>
	<201201031521.18371.vapier@gentoo.org>
Date: Tue, 3 Jan 2012 12:51:28 -0800
Message-ID: <CAGH67wRjvqesfUuEmuV9f2FkBFTF7j1y=DGHq08bR0MNrmt_mA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 12/21] syscalls/{getcontext,
 profil}: Move test.h header and TCID variable to the top
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net, Markos Chandras <Markos.Chandras@imgtec.com>

On Tue, Jan 3, 2012 at 12:21 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Tuesday 03 January 2012 06:18:56 Markos Chandras wrote:
>> Hi, please review the attached patch
>
> the test.h header should be after all system includes. =A0moving it befor=
e them
> is not a good idea. =A0so NAK this patch.

Good point. Rescinding my Reviewed-by...
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create =

new or port existing apps to sell to consumers worldwide. Explore the =

Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
