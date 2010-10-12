Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P5lQE-0001Io-Br
	for ltp-list@lists.sourceforge.net; Tue, 12 Oct 2010 20:26:06 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P5lQD-00030f-9O
	for ltp-list@lists.sourceforge.net; Tue, 12 Oct 2010 20:26:06 +0000
Received: by gya1 with SMTP id 1so817386gya.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Oct 2010 13:26:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000601cb6506$51bcadc0$f5360940$@co.jp>
References: <000001cb4e59$573184b0$05948e10$@co.jp>
	<AANLkTi=FA6Ojf2=B5w60e5F4y=E_n6nkPRE9seE4kyPn@mail.gmail.com>
	<000001cb5f90$60970370$21c50a50$@co.jp>
	<AANLkTi=s14JAEQJ-ZE08qNvj0XMLyOnZ3L3=yzQpLto2@mail.gmail.com>
	<000601cb6506$51bcadc0$f5360940$@co.jp>
Date: Tue, 12 Oct 2010 13:25:59 -0700
Message-ID: <AANLkTimt2JrCSJ5BBnL9JhF5OC+yor8KA2dGy+RVjK==@mail.gmail.com>
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

On Tue, Oct 5, 2010 at 8:26 PM, Mitani <mitani@ryobi.co.jp> wrote:
>> -----Original Message-----
>> From: Garrett Cooper [mailto:yanegomi@gmail.com]
>> Sent: Sunday, October 03, 2010 10:02 AM
>> To: Mitani
>> Cc: ltp-list@lists.sourceforge.net
>> Subject: Re: [LTP] About "hugeshmat01" and "humeshmget03" testsets
>>
>> On Tue, Sep 28, 2010 at 9:40 PM, Mitani <mitani@ryobi.co.jp> wrote:
>> >> -----Original Message-----
>> >> From: Garrett Cooper [mailto:yanegomi@gmail.com]
>> >> Sent: Tuesday, September 07, 2010 4:04 PM
>> >> To: Mitani
>> >> Cc: ltp-list@lists.sourceforge.net
>> >> Subject: Re: [LTP] About "hugeshmat01" and "humeshmget03" testsets
>> >>
>> >> On Mon, Sep 6, 2010 at 11:53 PM, Mitani <mitani@ryobi.co.jp> wrote:
>> >> > Hi,
>> >> >
>> >> > I sent patches of "hugeshmat01" and "humeshmget03" testsets to
>> >> mailing-list
>> >> > in the middle of August, but they aren't updated.
>> >> > Would you teach me what kind of situation they are?
>> >> >
>> >> > =A0hugeshmat01:
>> >>
>> > =A0 =A0http://www.mail-archive.com/ltp-list@lists.sourceforge.net/m
>> >> sg10448.html
>> >> > =A0humeshmget03:
>> >>
>> > =A0 =A0http://www.mail-archive.com/ltp-list@lists.sourceforge.net/m
>> >> sg10467.html
>> >> >
>> >> > =A0(The "humeshmat01" was revised on August 16, but same failure
>> has
>> >> > =A0 occurred in my system.)
>> >> >
>> >> > I am glad if I can get some information about the patch.
>> >> > I'm looking forward to reply:-)
>> >>
>> >> =A0 =A0 Sorry... another item I forgot to follow up on. I'll look into
>> >> this over the next couple of days and provide feedback about this.
>> >> Thanks,
>> >> -Garrett
>> >
>> > Were my revisions OK?
>> > I am glad if you consider about these patches when you are free.
>>
>> 1. Where's the requirement noted that you added the code for in
>> hugeshmget03 ?
>> 2. How do you know the value added to hugeshmat01 isn't page aligned?
>> Why not get the page size from sysconf and subtract the value from
>> one, and add _that_ value?
>>
>> Thanks,
>> -Garrett
>
>
>>1. Where's the requirement noted that you added the code for in
> hugeshmget03 ?
>
> It is in follwing URL in August 13:
> =A0http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg10467.ht=
ml
>
>
>>2. How do you know the value added to hugeshmat01 isn't page aligned?
>
> It is in follwing URL in August 09:
> =A0http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg10448.ht=
ml
> =A0http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg10532.ht=
ml
>
> The reason that hugeshmat01 isn't page aligned is from the shmat()'s
> error code 22 (EINVAL).
> shmat()'s man page says about this error code:
> ------------
> =A0 =A0 =A0 EINVAL The value of shmid is not a valid shared memory identi=
fier,
> the =A0shmaddr
> =A0 =A0 =A0 =A0 =A0 =A0 =A0is =A0not =A0a =A0null =A0pointer, and the val=
ue of (shmaddr
> -((uintptr_t)shmaddr
> =A0 =A0 =A0 =A0 =A0 =A0 =A0%SHMLBA)) is an illegal address =A0for =A0atta=
ching =A0shared
> memory; =A0or =A0the
> =A0 =A0 =A0 =A0 =A0 =A0 =A0shmaddr =A0is =A0not a null pointer, (shmflg &=
SHM_RND) is 0, and
> the value of
> =A0 =A0 =A0 =A0 =A0 =A0 =A0shmaddr is an illegal address for attaching sh=
ared memory.
> ------------
>
> The failure occurred in following shmat():
> ---(hugeshmat01.c)---------
> [...]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i=3D0; i<TST_TOTAL; i++) {
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Use TEST macro to make =
the call
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0errno =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0addr =3D shmat(*(TC[i].shm=
id), (void *)(TC[i].addr),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TC[i]=
.flags);
> [...]
> ------------
>
> This failure occurred in second loop (i=3D1), and arguments of shmat()
> are as follows:
> ------------
> =A0 shmat(id, 0x10000000eee, SHM_RND)
> ------------
>
> "shmaddr" argument (second argument) of shmat() is not NULL. Therefore
> I thought that page aligned occurred.
>
>
>>Why not get the page size from sysconf and subtract the value from one, a=
nd
> add _that_ value?
>
> This value is dynamic address, and this is the value which the first shma=
t()
> returned.
> This is the value with achievement in the each users system at least.
> When a fixed address ("0x10000000eee" or "0x60000eee") was specified,
> depending on a case, this address may be the address which other processes
> use.
> I thought that this method of using dynamic address is better than
> using fixed value to "shmaddr" argument.

    If you have links to official documentation from your copy of
RHEL's kernel / glibc sources I could reference, that would be much
appreciated.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
