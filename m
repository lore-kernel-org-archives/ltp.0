Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NHiXQ-0002Vb-8s
	for ltp-list@lists.sourceforge.net; Mon, 07 Dec 2009 18:42:24 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NHiXL-00068a-DS
	for ltp-list@lists.sourceforge.net; Mon, 07 Dec 2009 18:42:24 +0000
Received: by pwi13 with SMTP id 13so24520pwi.2
	for <ltp-list@lists.sourceforge.net>;
	Mon, 07 Dec 2009 10:42:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1260186841.6866.20.camel@subratamodak.linux.ibm.com>
References: <200912041649.nB4GnQbj014719@e35.co.us.ibm.com>
	<1260186841.6866.20.camel@subratamodak.linux.ibm.com>
Date: Mon, 7 Dec 2009 10:42:13 -0800
Message-ID: <364299f40912071042o50d0ac40le913ac35b6003dda@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] New sigwaitinfo test
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
Cc: Jiri Palecek <jpalecek@web.de>, ltp-list@lists.sourceforge.net

On Mon, Dec 7, 2009 at 3:54 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> On Fri, 2009-12-04 at 17:46 +0100, Jiri Palecek wrote:
>> Hello,
>>
>> this is the test for the rt_sigtimedwait et al. functions I promised ear=
lier. The code is unchanged since I sent it for the first time, but the Mak=
efiles are adapted to the new build system, with the help of Garret Cooper.
>>
>> Regards
>> =A0 =A0 Jiri Palecek
>>
>> Signed-off-by: Jiri Palecek <jpalecek@web.de>
>
> Thanks Jiri. Would you also take the trouble to make entries in the
> runtest/syscalls file for these tests to run ?

Someone needs to verify whether or not the rt_* test is functional on
x86_64 as well, because these tests require additional setup for
x86_64; unfortunately my desktop is disconnected (and will remain so
for the next week while I move), so I can't verify this.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. =

Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
