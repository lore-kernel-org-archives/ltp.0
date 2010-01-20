Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NXYqI-0008Ib-EE
	for ltp-list@lists.sourceforge.net; Wed, 20 Jan 2010 11:35:22 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NXYqH-0003en-Fy
	for ltp-list@lists.sourceforge.net; Wed, 20 Jan 2010 11:35:22 +0000
Received: by pwj11 with SMTP id 11so3439601pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Wed, 20 Jan 2010 03:35:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41001190317i6dde56d1m643d78cb1e19729@mail.gmail.com>
References: <653A85C7F32C4741880F71219266EA02031A02FFB1@EXGMBX01.sasken.com>
	<364299f41001190317i6dde56d1m643d78cb1e19729@mail.gmail.com>
Date: Wed, 20 Jan 2010 03:35:15 -0800
Message-ID: <364299f41001200335s17d565aatf2228f7d9bd12ef9@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP installation configure Error
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
To: Shanmuga Jayabalan <shanmuga.jayabalan@sasken.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Tue, Jan 19, 2010 at 3:17 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Tue, Jan 19, 2010 at 12:50 AM, Shanmuga Jayabalan
> <shanmuga.jayabalan@sasken.com> wrote:
>>
>> Hi,
>>
>> I am doing cross compilation of LTP with ARM.
>>
>> When I do ./configure, I'm also getting the same error message in
>> ltp-full-20091231 release.
>> =A0=A0=A0=A0=A0=A0=A0 configure: error: Couldn't find functional copy of=
 quota v2 - are
>> you > running 2.4.x ?
>> As per your suggestion I have tried to do `man 2 quotactl', I'm getting =
the
>> following message.
>> =A0=A0=A0=A0=A0=A0=A0 No manual entry for quotactl in section 2
>> I have ubuntu in my system. I'm able to cross compile with the previous
>> release "ltp-full-20091130".
>> Is there any setup is missing in my system for this release?
>> Help me to resolve this issue.
>
> Sorry for not getting back to you sooner. I'll look into your issue
> ASAP tomorrow.

    Please try again off CVS and see how it goes (I still have to fix
the testcase so it does the right thing end-to-end, but the compile
shouldn't fail now).
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
