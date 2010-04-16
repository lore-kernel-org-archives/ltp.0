Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O2dkb-0008Js-7j
	for ltp-list@lists.sourceforge.net; Fri, 16 Apr 2010 05:05:57 +0000
Received: from mail-iw0-f183.google.com ([209.85.223.183])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O2dkZ-0001pa-3A
	for ltp-list@lists.sourceforge.net; Fri, 16 Apr 2010 05:05:57 +0000
Received: by iwn13 with SMTP id 13so1166332iwn.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 15 Apr 2010 22:05:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000001cadd0e$7b35e250$71a1a6f0$@co.jp>
References: <000001cadad6$c061c590$412550b0$@co.jp>
	<4BC487C9.9080300@xenotime.net>
	<000901cadb78$a2d05080$e870f180$@co.jp>
	<g2p364299f41004132317v539c2b02g3eea49dc830cea0f@mail.gmail.com>
	<000601cadbb0$9fb8b5d0$df2a2170$@co.jp>
	<20100414081953.7356b407.rdunlap@xenotime.net>
	<000001cadd0e$7b35e250$71a1a6f0$@co.jp>
Date: Thu, 15 Apr 2010 22:05:49 -0700
Message-ID: <w2l364299f41004152205ybf7a92eekb87553630949773a@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix "hugetlb" several tests
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net, Randy Dunlap <rdunlap@xenotime.net>

On Thu, Apr 15, 2010 at 7:42 PM, Mitani <mitani@ryobi.co.jp> wrote:
>
>> -----Original Message-----
>> From: Randy Dunlap [mailto:rdunlap@xenotime.net]
>> Sent: Thursday, April 15, 2010 12:20 AM
>> To: Mitani
>> Cc: 'Garrett Cooper'; ltp-list@lists.sourceforge.net
>> Subject: Re: [LTP] [PATCH] fix "hugetlb" several tests
>>
>> On Wed, 14 Apr 2010 17:58:17 +0900 Mitani wrote:
>>
>> > Hi,
>> >
>> > I suggest new patch.
>> >
>> > Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
>>
>> This one is OK with me also, but...
>>
>> Is it possible to determine the difference between a kernel that does
>> not support hugepages at all and a kernel that does support hugepages
>> but just does not have enough of them allocated?
>>
>> or maybe we don't care about this difference. =A0Do we?
>
> I cannot give a good opinion because I'm not a creator of these test
> programs, but ...
> I think that the difference of test refusal reason isn't so important.
> How about following message? :
> ------------
> Not support Hugepages or not enough available Hugepages
> ------------
>
> If users read above message, they will examine a reason by themselves
> and will do appropriate measures (set an enough hugepages value or
> gave up this test), I think.

    It's fine as-is. `Zero [supported] hugepages' is the same as `not
enough hugepages'. If people can't read the message, and put together
the details based on what's in the test output versus the
documentation and the source code, they quite frankly shouldn't be
running the tests.
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
