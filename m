Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1P3Kel-00075g-QD
	for ltp-list@lists.sourceforge.net; Wed, 06 Oct 2010 03:27:03 +0000
Received: from out19.sjc.mx.trendmicro.com ([216.99.131.76])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P3Kek-0006j9-23
	for ltp-list@lists.sourceforge.net; Wed, 06 Oct 2010 03:27:03 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000001cb4e59$573184b0$05948e10$@co.jp>	<AANLkTi=FA6Ojf2=B5w60e5F4y=E_n6nkPRE9seE4kyPn@mail.gmail.com>	<000001cb5f90$60970370$21c50a50$@co.jp>
	<AANLkTi=s14JAEQJ-ZE08qNvj0XMLyOnZ3L3=yzQpLto2@mail.gmail.com>
In-Reply-To: <AANLkTi=s14JAEQJ-ZE08qNvj0XMLyOnZ3L3=yzQpLto2@mail.gmail.com>
Date: Wed, 6 Oct 2010 12:26:52 +0900
Message-ID: <000601cb6506$51bcadc0$f5360940$@co.jp>
MIME-Version: 1.0
Content-Language: ja
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
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Sunday, October 03, 2010 10:02 AM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] About "hugeshmat01" and "humeshmget03" testsets
> =

> On Tue, Sep 28, 2010 at 9:40 PM, Mitani <mitani@ryobi.co.jp> wrote:
> >> -----Original Message-----
> >> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> >> Sent: Tuesday, September 07, 2010 4:04 PM
> >> To: Mitani
> >> Cc: ltp-list@lists.sourceforge.net
> >> Subject: Re: [LTP] About "hugeshmat01" and "humeshmget03" testsets
> >>
> >> On Mon, Sep 6, 2010 at 11:53 PM, Mitani <mitani@ryobi.co.jp> wrote:
> >> > Hi,
> >> >
> >> > I sent patches of "hugeshmat01" and "humeshmget03" testsets to
> >> mailing-list
> >> > in the middle of August, but they aren't updated.
> >> > Would you teach me what kind of situation they are?
> >> >
> >> > =A0hugeshmat01:
> >>
> > =A0 =A0http://www.mail-archive.com/ltp-list@lists.sourceforge.net/m
> >> sg10448.html
> >> > =A0humeshmget03:
> >>
> > =A0 =A0http://www.mail-archive.com/ltp-list@lists.sourceforge.net/m
> >> sg10467.html
> >> >
> >> > =A0(The "humeshmat01" was revised on August 16, but same failure
> has
> >> > =A0 occurred in my system.)
> >> >
> >> > I am glad if I can get some information about the patch.
> >> > I'm looking forward to reply:-)
> >>
> >> =A0 =A0 Sorry... another item I forgot to follow up on. I'll look into
> >> this over the next couple of days and provide feedback about this.
> >> Thanks,
> >> -Garrett
> >
> > Were my revisions OK?
> > I am glad if you consider about these patches when you are free.
> =

> 1. Where's the requirement noted that you added the code for in
> hugeshmget03 ?
> 2. How do you know the value added to hugeshmat01 isn't page aligned?
> Why not get the page size from sysconf and subtract the value from
> one, and add _that_ value?
> =

> Thanks,
> -Garrett


>1. Where's the requirement noted that you added the code for in
hugeshmget03 ?

It is in follwing URL in August 13:
  http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg10467.html


>2. How do you know the value added to hugeshmat01 isn't page aligned?

It is in follwing URL in August 09:
  http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg10448.html
  http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg10532.html

The reason that hugeshmat01 isn't page aligned is from the shmat()'s =

error code 22 (EINVAL). =

shmat()'s man page says about this error code:
------------
       EINVAL The value of shmid is not a valid shared memory identifier,
the  shmaddr
              is  not  a  null  pointer, and the value of (shmaddr
-((uintptr_t)shmaddr
              %SHMLBA)) is an illegal address  for  attaching  shared
memory;  or  the
              shmaddr  is  not a null pointer, (shmflg &SHM_RND) is 0, and
the value of
              shmaddr is an illegal address for attaching shared memory.
------------

The failure occurred in following shmat():
---(hugeshmat01.c)---------
[...]
                for (i=3D0; i<TST_TOTAL; i++) {

                        /*
                         * Use TEST macro to make the call
                         */
                        errno =3D 0;
                        addr =3D shmat(*(TC[i].shmid), (void *)(TC[i].addr),
                                   TC[i].flags);
[...]
------------

This failure occurred in second loop (i=3D1), and arguments of shmat() =

are as follows:
------------
   shmat(id, 0x10000000eee, SHM_RND)
------------

"shmaddr" argument (second argument) of shmat() is not NULL. Therefore =

I thought that page aligned occurred.


>Why not get the page size from sysconf and subtract the value from one, and
add _that_ value?

This value is dynamic address, and this is the value which the first shmat()
returned. =

This is the value with achievement in the each users system at least.
When a fixed address ("0x10000000eee" or "0x60000eee") was specified, =

depending on a case, this address may be the address which other processes
use.
I thought that this method of using dynamic address is better than =

using fixed value to "shmaddr" argument.



Thank you--

-Tomonori Mitani



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
