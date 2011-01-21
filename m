Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PgCNh-0003Zd-K7
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 08:30:05 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PgCNg-0004T7-HV
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 08:30:05 +0000
Received: by wwi18 with SMTP id 18so1489536wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 21 Jan 2011 00:29:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D391BEB.9070508@cn.fujitsu.com>
References: <4D37EB92.3060901@cn.fujitsu.com>
	<AANLkTin4N+xuTwQP2w7WtGvO20qdsa2mEjeiMi5fFK2d@mail.gmail.com>
	<4D3903AC.2070901@cn.fujitsu.com>
	<AANLkTimPKEHGOc4-UQXxSZoNJi5UQD1wB1L2n3iUznhE@mail.gmail.com>
	<4D391BEB.9070508@cn.fujitsu.com>
Date: Fri, 21 Jan 2011 00:29:58 -0800
Message-ID: <AANLkTing1S_trGTyHmJixR7rrWVxu2WXcT+G+Ey-tWGw@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] mprotect02: fix error of the case need
	sighandler()
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Jan 20, 2011 at 9:38 PM, Peng Haitao <penght@cn.fujitsu.com> wrote:
> Hi Garrett,
>
> Garrett Cooper said the following on 2011-1-21 12:00:
>>> This is OK, but the default signal handler is invoked when an unexpecte=
d signal
>>> is caught. so I think we should add sighandler(). Furthermore, the defa=
ult
>>> signal handler make the child process exit 2, but the case expect the c=
hild
>>> process exit 1, this will cause the case fail.
>>>
>>> The following patch will reinitialize signal handler.
>>
>> =A0 =A0 This won't work if the number of test loops is > 1 (it will reset
>> the handler back to the default and fail on the next iteration).
>
> Thanks for your comment.
>
> The following patch will initialize signal handler to sighandler() in loo=
ps starting,
> and reinitialize default signal handle in the second part.

    I fixed it in a different way from what you did and it appears to
work well now (I simplified the test by not using tst_sig, as it kept
on segfaulting in the parent process when I used tst_sig).
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires =

February 28th, so secure your free ArcSight Logger TODAY! =

http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
