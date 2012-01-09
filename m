Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1RkJ7Z-0004v9-8T
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 17:34:57 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1RkJ7V-0005Oo-Kw
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 17:34:57 +0000
Received: by ggnh1 with SMTP id h1so1961300ggn.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 09 Jan 2012 09:34:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201201091219.20817.vapier@gentoo.org>
References: <4F0ACAC0.6010309@imgtec.com>
	<201201091219.20817.vapier@gentoo.org>
Date: Mon, 9 Jan 2012 09:34:47 -0800
Message-ID: <CAGH67wQGqmtPSjQFd_Py4KUyoZqYNGjERpSR5o+FBTwKYpS2RQ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Split UCLIBC and UCLINUX test cases
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

On Mon, Jan 9, 2012 at 9:19 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Monday 09 January 2012 06:08:48 Markos Chandras wrote:
>> Right now the use of UCLINUX implies the use of __UCLIBC__ as well. Even
>> though this is true from UCLINUX's perspective, it is not valid from the
>> uclibc's one. A non-uclinux system can perfectly work with uclibc. What
>> I suggest is to keep the UCLINUX option as is, but also add a new option
>> called UCLIBC which will enable us to avoid all the restrictions imposed
>> by the use of UCLINUX macro (especially the disabled tests in
>> testcases/kernel/systecall/Makefile).
>
> header/func tests should get moved to configure. =A0we should not introdu=
ce or
> rely on any new ifdefs like UCLIBC or __UCLIBC__.

+1

---------------------------------------------------------------------------=
---
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual =

desktops for less than the cost of PCs and save 60% on VDI infrastructure =

costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
