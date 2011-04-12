Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Q9XBF-0002uD-Cn
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 06:34:29 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q9XBE-0006tL-KS
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 06:34:29 +0000
Received: by pzk35 with SMTP id 35so3366305pzk.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 11 Apr 2011 23:34:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1302546702.2580.26.camel@doink>
References: <1302546702.2580.26.camel@doink>
Date: Mon, 11 Apr 2011 23:34:22 -0700
Message-ID: <BANLkTim_3eSavC-kj9KHoT-YHGB2_f0JBg@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 1/3, v2] ltp: fix warnings in "growfiles.c"
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
To: aelder@sgi.com
Cc: ltp-list@lists.sourceforge.net

On Mon, Apr 11, 2011 at 11:31 AM, Alex Elder <aelder@sgi.com> wrote:
> In "testcases/kernel/fs/doio/growfiles.c" there are a number of
> variables of type off_t which are formatted using a "%ld" conversion
> specification. =A0When I build on an i386 system I get warnings,
> because evidently off_t is not defined as a long in this
> environment.
>
> Updated to address Garrett Cooper's concerns that variables named
> "tmp" are used for a number of purposes in this file. =A0In one case I
> renamed the variable "off_tmp" (its type is off_t) (but did not
> change corresponding printed text). =A0The other cases the "tmp"
> variable was more appropriately type int.

Things look ok here minus the spaces between casts.
-Garrett

---------------------------------------------------------------------------=
---
Forrester Wave Report - Recovery time is now measured in hours and minutes
not days. Key insights are discussed in the 2010 Forrester Wave Report as
part of an in-depth evaluation of disaster recovery service providers.
Forrester found the best-in-class provider in terms of services and vision.
Read this report now!  http://p.sf.net/sfu/ibm-webcastpromo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
