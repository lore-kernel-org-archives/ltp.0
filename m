Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OwKIS-0001in-4e
	for ltp-list@lists.sourceforge.net; Thu, 16 Sep 2010 19:39:04 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OwKIN-0003OV-6H
	for ltp-list@lists.sourceforge.net; Thu, 16 Sep 2010 19:39:04 +0000
Received: by yxg6 with SMTP id 6so706017yxg.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 16 Sep 2010 12:38:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100916185331.GA1541@hannu-ubuntu>
References: <AANLkTim+EuMGgPZWxoZjAX0-4Mmrvfm_Jb_MpW3Y6QM+@mail.gmail.com>
	<20100916185331.GA1541@hannu-ubuntu>
Date: Thu, 16 Sep 2010 12:38:53 -0700
Message-ID: <AANLkTikE-yGKKA6JFp9X3t_jfg_1YSGQG7U6xaMGz0Dc@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] rwtest03,rwtest04
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
To: Hannu Heikkinen <hannuxx@iki.fi>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Thu, Sep 16, 2010 at 11:53 AM, Hannu Heikkinen <hannuxx@iki.fi> wrote:
> On 16/09/10 14:24 +0530, ARJIT SHARMA wrote:
>> hello...
>> =A0 =A0 =A0 =A0 =A0I am facing the error in rwtest03 and rwtest04, both =
of them are
>> failing due to some data comparison error.
>>
>> =A0 =A0 =A0 =A0 =A0Please help me out to sove this error, i am running L=
TP om ARM
>> architechture...
>> --
>> Regards,
>> Arjit Sharma.
>
> Hi,
>
> please include relevant parts from your logfiles.

Maybe you guys failed to see my last reply, so I'll be more curt now:

STOP CCing THE ltp-list-request@lists.sourceforge.net LIST!

Its purpose is to get access _to_ ltp-list@lists.sourceforge.net, not
email anyone in particular.

>> cd $LTPROOT
>> ./runltp > your.log

Try runltp -o your.log instead.

>> head -n 115 your.log
>> grep FAILED result/LTP_RUN_ON-<your-run-date>.log
>
> And dig also the few lines from and below those FAILED lines.
>
>> failing due to some data comparison error.

Actionable data =3D> actionable help. I don't see actionable data, so
you won't get any actionable help.

Thank you,
-Garrett

---------------------------------------------------------------------------=
---
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
