Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P2Cxu-0002lC-Sd
	for ltp-list@lists.sourceforge.net; Sun, 03 Oct 2010 01:02:11 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P2Cxt-0004J9-SD
	for ltp-list@lists.sourceforge.net; Sun, 03 Oct 2010 01:02:10 +0000
Received: by iwn2 with SMTP id 2so7056466iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Sat, 02 Oct 2010 18:02:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000001cb5f90$60970370$21c50a50$@co.jp>
References: <000001cb4e59$573184b0$05948e10$@co.jp>
	<AANLkTi=FA6Ojf2=B5w60e5F4y=E_n6nkPRE9seE4kyPn@mail.gmail.com>
	<000001cb5f90$60970370$21c50a50$@co.jp>
Date: Sat, 2 Oct 2010 18:02:04 -0700
Message-ID: <AANLkTi=s14JAEQJ-ZE08qNvj0XMLyOnZ3L3=yzQpLto2@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] About "hugeshmat01" and "humeshmget03" testsets
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
Cc: ltp-list@lists.sourceforge.net

On Tue, Sep 28, 2010 at 9:40 PM, Mitani <mitani@ryobi.co.jp> wrote:
>> -----Original Message-----
>> From: Garrett Cooper [mailto:yanegomi@gmail.com]
>> Sent: Tuesday, September 07, 2010 4:04 PM
>> To: Mitani
>> Cc: ltp-list@lists.sourceforge.net
>> Subject: Re: [LTP] About "hugeshmat01" and "humeshmget03" testsets
>>
>> On Mon, Sep 6, 2010 at 11:53 PM, Mitani <mitani@ryobi.co.jp> wrote:
>> > Hi,
>> >
>> > I sent patches of "hugeshmat01" and "humeshmget03" testsets to
>> mailing-list
>> > in the middle of August, but they aren't updated.
>> > Would you teach me what kind of situation they are?
>> >
>> > =A0hugeshmat01:
>> > =A0 =A0http://www.mail-archive.com/ltp-list@lists.sourceforge.net/m
>> sg10448.html
>> > =A0humeshmget03:
>> > =A0 =A0http://www.mail-archive.com/ltp-list@lists.sourceforge.net/m
>> sg10467.html
>> >
>> > =A0(The "humeshmat01" was revised on August 16, but same failure has
>> > =A0 occurred in my system.)
>> >
>> > I am glad if I can get some information about the patch.
>> > I'm looking forward to reply:-)
>>
>> =A0 =A0 Sorry... another item I forgot to follow up on. I'll look into
>> this over the next couple of days and provide feedback about this.
>> Thanks,
>> -Garrett
>
> Were my revisions OK?
> I am glad if you consider about these patches when you are free.

1. Where's the requirement noted that you added the code for in hugeshmget0=
3 ?
2. How do you know the value added to hugeshmat01 isn't page aligned?
Why not get the page size from sysconf and subtract the value from
one, and add _that_ value?

Thanks,
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
