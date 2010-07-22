Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Oby1K-0006gD-L6
	for ltp-list@lists.sourceforge.net; Thu, 22 Jul 2010 15:49:14 +0000
Received: from mail-px0-f175.google.com ([209.85.212.175])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oby1J-0004Bz-67
	for ltp-list@lists.sourceforge.net; Thu, 22 Jul 2010 15:49:14 +0000
Received: by pxi12 with SMTP id 12so4023116pxi.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 22 Jul 2010 08:49:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1279792951.6951.2.camel@plars-t500>
References: <AANLkTikq6X_ICkQbfLS9GUSnA3jCUdodxrHkdGYtgZFk@mail.gmail.com>
	<1279792951.6951.2.camel@plars-t500>
Date: Thu, 22 Jul 2010 08:48:37 -0700
Message-ID: <AANLkTink8cgb9mCKSoGJdDvv9QanhqupCwXNd-qoJ1sX@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] ARM: Correct stack size & alignment for clone
	tests
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
To: Paul Larson <paul.larson@canonical.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Jul 22, 2010 at 3:02 AM, Paul Larson <paul.larson@canonical.com> wr=
ote:
> I tried this on my arm boxes and it fixes the clone tests, which were
> previously broken for arm. =A0Please apply.
>
> Thanks,
> Paul Larson
>
> On Thu, 2010-07-22 at 10:07 +0100, Peter Pearse wrote:
>> An ARM stack must be a multiple of 32 bit words in length, and 32 bit
>> aligned.
>>
>> Signed-off-by: Peter Pearse <peter.pearse@linaro.org>

ACK.

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
