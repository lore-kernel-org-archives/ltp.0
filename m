Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PvSJY-0008B9-Rj
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 10:32:52 +0000
Received: from mail-ww0-f41.google.com ([74.125.82.41])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PvSJY-00026g-2K
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 10:32:52 +0000
Received: by wwb29 with SMTP id 29so59291wwb.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 04 Mar 2011 02:32:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110225075728.GB2902@hpt.nay.redhat.com>
References: <20110224101921.GA30765@hpt.nay.redhat.com>
	<AANLkTimuSUtaPSL5x1N75_nF2OtXfjMzcvu5wK4b2FJ7@mail.gmail.com>
	<20110225025148.GA2902@hpt.nay.redhat.com>
	<AANLkTi=cqRqDH_JKyVTx0cnRRy74Yidd9T8Ww-cSJMs4@mail.gmail.com>
	<20110225075728.GB2902@hpt.nay.redhat.com>
Date: Fri, 4 Mar 2011 02:32:45 -0800
Message-ID: <AANLkTim2_K5WV11qPm9GG8Xz9vQ-YAVgQ=B+a225vRU3@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] basic mlock() testcase from lkml
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
To: Garrett Cooper <yanegomi@gmail.com>, ltp-list@lists.sourceforge.net

On Thu, Feb 24, 2011 at 11:57 PM, Han Pingtian <phan@redhat.com> wrote:
> On Thu, Feb 24, 2011 at 10:16:58PM -0800, Garrett Cooper wrote:
>> On Thu, Feb 24, 2011 at 6:51 PM, Han Pingtian <phan@redhat.com> wrote:
>>
>> ...
>>
>> > Updated as required. Please review. Thanks.
>>
>> =A0 =A0 close should be under TEST_CLEANUP. Other than that it's fine.
> Updated. Thanks.

Committed -- thanks!
-Garrett

---------------------------------------------------------------------------=
---
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
