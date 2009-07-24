Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MUP8X-0003PI-3R
	for ltp-list@lists.sourceforge.net; Fri, 24 Jul 2009 18:04:53 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MUP8S-0003oN-8h
	for ltp-list@lists.sourceforge.net; Fri, 24 Jul 2009 18:04:53 +0000
Received: by yxe33 with SMTP id 33so3342127yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Fri, 24 Jul 2009 11:04:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200907241349.58754.vapier@gentoo.org>
References: <f5a7b3810907240831t75a058a2m96abdc28a28c4365@mail.gmail.com>
	<200907241349.58754.vapier@gentoo.org>
Date: Fri, 24 Jul 2009 23:34:40 +0530
Message-ID: <f5a7b3810907241104g498b00a6i60c8858b8805091a@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] Char Limit issue on 2.6.29 kernels
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
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, tim.bird@am.sony.com, rohit.170309@gmail.com

Hi Mike,

On Fri, Jul 24, 2009 at 11:19 PM, Mike Frysinger<vapier@gentoo.org> wrote:
> On Friday 24 July 2009 11:31:59 naresh kamboju wrote:
>> I have come across with char Limit issue on 2.6.29 kernels.
>>
>>
>> SIGFAULT:
>>
>> #define SIZE =A0 =A0 =A0 =A0 =A0 =A08053759
>> char buf1[SIZE] ;
>>
>> NO SIGFAULT:
>>
>> #define SIZE =A0 =A0 =A0 =A0 =A0 =A08053758
>> char buf1[SIZE] ;
>>
>> This SIGFAULT not observed on 2.6.23 kernels.
>
> -ENOINFO
>
> post some actual code rather than saying "i declared a large buffer and t=
hings
> crashed".

currently i am debugging this issue.
i'll come up with more details.

>is there a reason you cc-ed LTP ? =A0is this a crash i >a LTP test ?
No.
it is not a test cases of LTP.
i am a member of LTP. want to share this information to LTP community.

-naresh

>
>> What could be the changes that effecting from 2.6.23 to 2.6.29 kernels.
>> Please share me the information.
>
> git log v2.6.23..v2.6.29
> -mike
>

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
