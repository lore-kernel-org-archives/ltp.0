Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Ogly5-00052P-UV
	for ltp-list@lists.sourceforge.net; Wed, 04 Aug 2010 21:57:45 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ogly1-00015w-Qi
	for ltp-list@lists.sourceforge.net; Wed, 04 Aug 2010 21:57:45 +0000
Received: by ywe9 with SMTP id 9so2813431ywe.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 04 Aug 2010 14:57:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinmH4_cho+2CGekNFa1=b24wbXvmd6n_3NbBne1@mail.gmail.com>
References: <6A4A1EB0E8FDFB46AC5D6C392E82277006AAB652@me-ex1.ctsl.cubic.cub>
	<AANLkTinmH4_cho+2CGekNFa1=b24wbXvmd6n_3NbBne1@mail.gmail.com>
Date: Wed, 4 Aug 2010 14:57:36 -0700
Message-ID: <AANLkTikECYvNp3eH25fRB0Gptf8vMYYYr7T350_rnOQF@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Install failure when cross compiling for ARM
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
To: "Boari, Doug" <Doug.Boari@cubic.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Aug 4, 2010 at 2:56 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Wed, Aug 4, 2010 at 3:04 AM, Boari, Doug <Doug.Boari@cubic.com> wrote:
>> Hi Garrett,
>>
>> Sorry I forgot to attach the zip (now enclosed)
>>
>> Here is the make --version:
>>
>> GNU Make 3.81
>> Copyright (C) 2006 =A0Free Software Foundation, Inc.
>> This is free software; see the source for copying conditions.
>> There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
>> PARTICULAR PURPOSE.
>> This program built for i486-pc-linux-gnu
>>
>> Hmmmmm After poking around a bit, I'm thinking that maybe LTP may not be
>> suitable for our board after all...
>> I was reading through some of the test_realtime scripts and it looks
>> like the tests need to build libs before running. Unfortunately we have
>> no on-board compiler, everything is cross compiled on a separate PC. Is
>> there anyway round this? I'm especially interested in the scheduling
>> sub-set of tests.
>
> Here's your problem:
>
> configure:7160: running /bin/bash ./configure
> --disable-option-checking '--prefix=3D/opt/ltp'
> 'CFLAGS=3D-fno-short-enums' '--target=3Darm-iwmmxt-linux-gnueabi'
> '--host=3Darm-iwmmxt-linux-gnueabi'
> 'host_alias=3Darm-iwmmxt-linux-gnueabi'
> 'target_alias=3Darm-iwmmxt-linux-gnueabi' --cache-file=3D/dev/null
> --srcdir=3D.
>
> Don't specify --srcdir=3D. and things should work a lot better (I'm not
> sure why anal retentive autotools didn't whine about that like it
> usually does.

Well, the alternative when doing out-of-build tree is to specify an
absolute path. If a path is non-relative autoconf, et all should have
bailed instantly.

---------------------------------------------------------------------------=
---
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
