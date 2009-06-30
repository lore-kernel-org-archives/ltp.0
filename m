Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MLYt8-0006Iz-2y
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 08:40:26 +0000
Received: from [74.125.92.148] (helo=qw-out-1920.google.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLYt1-0000bN-0a
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 08:40:19 +0000
Received: by qw-out-1920.google.com with SMTP id 5so1777304qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 30 Jun 2009 01:39:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1246347691.4819.36.camel@subratamodak.linux.ibm.com>
References: <f5a7b3810906290953k7326b82ds617ee7bfdac92e48@mail.gmail.com>
	<364299f40906291412o1c24953n587406adcc465139@mail.gmail.com>
	<1246347691.4819.36.camel@subratamodak.linux.ibm.com>
Date: Tue, 30 Jun 2009 14:09:58 +0530
Message-ID: <f5a7b3810906300139i5aba5692la2854eeb80695684@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] [FIX-PATCH]Build-issue-cacheflush01.c on MIPS
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>, Jiri Palecek <jpalecek@web.de>, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>

On Tue, Jun 30, 2009 at 1:11 PM, Subrata
Modak<subrata@linux.vnet.ibm.com> wrote:
>> > Now build issue is resolved.
>> > Please find attached patch and below.
>> >
>> > Best Regards
>> > Naresh Kamboju
>
> Henry already submitted a patch to fix this:
> http://marc.info/?l=3Dltp-list&m=3D124615187102775&w=3D2
>
> I am yet to check-in that. It is the same as your patch ;-)

yes. almost same. only difference is Tab/Space before return. i was
not aware of his patch.

however, please accept any one patch and commit.

Best regards
Naresh Kamboju
>
> Regards--
> Subrata
>
>> >
>> > Build-Error:
>> >
>> > cacheflush01.c =A0-L../../../../lib -lltp -o cacheflush01
>> > cacheflush01.c: In function 'cacheflush':
>> > cacheflush01.c:52: error: 'B' undeclared (first use in this function)
>> > cacheflush01.c:52: error: (Each undeclared identifier is reported only=
 once
>> > cacheflush01.c:52: error: for each function it appears in.)
>> > cacheflush01.c:52: error: expected ';' before 'B'
>> > cacheflush01.c:53: warning: control reaches end of non-void function
>> > make: *** [cacheflush01] Error 1
>> >
>> >
>> > Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
>> >

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
