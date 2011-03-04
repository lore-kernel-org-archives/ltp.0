Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PvXtV-0007Gv-LD
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 16:30:21 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PvXtU-0007wQ-Qo
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 16:30:21 +0000
Received: by wwb29 with SMTP id 29so3164912wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 04 Mar 2011 08:30:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTin_4rBGj5O-ZgTdu2C8nV6Lc9-pa9ig8NsAowAd@mail.gmail.com>
References: <20110304170932.19819907@regolo>
	<AANLkTin_4rBGj5O-ZgTdu2C8nV6Lc9-pa9ig8NsAowAd@mail.gmail.com>
Date: Fri, 4 Mar 2011 08:30:14 -0800
Message-ID: <AANLkTik6nKzqp2tuyhsuk6FvMd540xZVGGddr=B13D-R@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] kill05: fix regression
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
To: Cristian Greco <cristian@regolo.cc>
Cc: ltp-list@lists.sourceforge.net

On Fri, Mar 4, 2011 at 8:29 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Fri, Mar 4, 2011 at 8:09 AM, Cristian Greco <cristian@regolo.cc> wrote:
>> Hi,
>>
>> this should fix a regression in kill05.
>>
>> Why did tst_resm/tst_exit get replaced by perror/exit in 84f181fd?
>
> =A0 =A0Because it's a child process and child processes should _not_ use
> libltp for sanity and to avoid introducing determinism, test bugs, and

s/determinism/non-determinism/

> for cluttering up output (remember: you have to communicate to the
> user which process is actually doing the work, they're sharing file
> descriptors potentially, etc).
> =A0 =A0The proposed fix doesn't make sense though because do_master_child
> always exits when the flow is executed correctly (i.e. there aren't
> any early return statements from do_master_child, etc. Is it not
> resuming the stack appropriately after it gets signaled? What's the
> call flow exactly for the failure?
> Thanks,
> -Garrett
>

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
