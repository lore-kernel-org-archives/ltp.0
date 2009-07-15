Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jw.itee@gmail.com>) id 1MQt29-0007pW-DX
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2009 01:11:45 +0000
Received: from mail-qy0-f200.google.com ([209.85.221.200])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MQt1z-0005sM-HO
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2009 01:11:40 +0000
Received: by qyk38 with SMTP id 38so2989755qyk.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 14 Jul 2009 18:11:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200907141843.05629.arnd@arndb.de>
References: <4A5C8068.6020203@monstr.eu> <200907141652.59049.arnd@arndb.de>
	<4A5CAEFF.9080206@monstr.eu> <200907141843.05629.arnd@arndb.de>
Date: Wed, 15 Jul 2009 11:11:34 +1000
Message-ID: <9e6f3dfd0907141811p512b4edp3f9dd0fdeae1123e@mail.gmail.com>
From: John Williams <jwilliams@itee.uq.edu.au>
Subject: Re: [LTP] access_ok macor
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4190832868535330350=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Arnd Bergmann <arnd@arndb.de>
Cc: LTP <ltp-list@lists.sourceforge.net>, monstr@monstr.eu, Linux Kernel list <linux-kernel@vger.kernel.org>

--===============4190832868535330350==
Content-Type: multipart/alternative; boundary=0016367f96e07c88d0046eb43c66

--0016367f96e07c88d0046eb43c66
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Wed, Jul 15, 2009 at 2:43 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday 14 July 2009, Michal Simek wrote:
> > Arnd Bergmann wrote:
>
> > >>  r29=00000000, r30=00000000, r31=CE9759A4, rPC=C000123C
> > >>  msr=800045AE, ear=00000001, esr=000000B2, fsr=000080D0
> > >> Segmentation fault
> > >>
> > >
> > > I guess then you should check if 0xc000123c is in your
> > > exception table, or why it is not.
> >
> > on that address is load instruction for unaligned exception because addr
> is odd number
> > that's why is called unaligned exception handler and from this function
> > is called load instruction which failed. :-(
> >
> > Currently this make more sense why that tests failed. If that pointers
> are
> > even number exception is not taken and exception sure don't have fixup
> for it because
> > this is generic code. :-(
> >
> > That's the problem because we are looking for regs->pc but this point to
> unaligned exception
> > handler.
>
> Ok, that makes a lot of sense.
>
> The solution then is to handle fixups from the unaligned exception handler
> if you come from the kernel. That should fix the three text cases.
>
> I don't fully understand your exception handling there, but I think you
> also need to add code checking for __range_ok() to your unaligned handler,
> to prevent malicious user space code from accessing the kernel through
> unaligned pointers.


Just to try to clarify - are there any alignment rules in the ABI on
user-space pointers (which end up going to get/put_user)?

It seems the failure path is like this:

1. userspace passes unaligned pointer
2. get_user attempts to access
3. CPU raises unaligned exception (if only it would raise the segfault as
higher priority, before the unaligned!)
4. unaligned exception handler attempts to simulate the unaligned access
with multiple partial read/write ops
5. CPU raises MMU exception on the read/write by the unaligned handler
6. kernel segfault handler looks up faulting address, it is in the unaligned
exception handler, which has no fixup.
7. no fixup -> failure

So, I suppose the question is - where in the sequence is the true failure?

Clearly LTP thinks it's ok to pass unaligned pointers to the kernel,
suggesting (1) is fine - thus my question about alignment rules in the ABI.

Do we need fixups on the unaligned handler itself? This will be ugly ugly
ugly.  Or, some way of tracing the segfault back through the unaligned
exception and to the root cause (the get/put-user), and call that fixup as
required?

Thanks,

John

--0016367f96e07c88d0046eb43c66
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">On Wed, Jul 15, 2009 at 2:43 AM, Arnd Bergma=
nn <span dir=3D"ltr">&lt;<a href=3D"mailto:arnd@arndb.de">arnd@arndb.de</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"border-lef=
t: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1=
ex;">
<div class=3D"im">On Tuesday 14 July 2009, Michal Simek wrote:<br>
&gt; Arnd Bergmann wrote:<br>
<br>
</div>&gt; &gt;&gt; =A0r29=3D00000000, r30=3D00000000, r31=3DCE9759A4, rPC=
=3DC000123C<br>
&gt; &gt;&gt; =A0msr=3D800045AE, ear=3D00000001, esr=3D000000B2, fsr=3D0000=
80D0<br>
&gt; &gt;&gt; Segmentation fault<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; I guess then you should check if 0xc000123c is in your<br>
&gt; &gt; exception table, or why it is not.<br>
&gt;<br>
&gt; on that address is load instruction for unaligned exception because ad=
dr is odd number<br>
&gt; that&#39;s why is called unaligned exception handler and from this fun=
ction<br>
&gt; is called load instruction which failed. :-(<br>
&gt;<br>
&gt; Currently this make more sense why that tests failed. If that pointers=
 are<br>
&gt; even number exception is not taken and exception sure don&#39;t have f=
ixup for it because<br>
&gt; this is generic code. :-(<br>
&gt;<br>
&gt; That&#39;s the problem because we are looking for regs-&gt;pc but this=
 point to unaligned exception<br>
&gt; handler.<br>
<br>
Ok, that makes a lot of sense.<br>
<br>
The solution then is to handle fixups from the unaligned exception handler<=
br>
if you come from the kernel. That should fix the three text cases.<br>
<br>
I don&#39;t fully understand your exception handling there, but I think you=
<br>
also need to add code checking for __range_ok() to your unaligned handler,<=
br>
to prevent malicious user space code from accessing the kernel through<br>
unaligned pointers.</blockquote><div><br>Just to try to clarify - are there=
 any alignment rules in the ABI on user-space pointers (which end up going =
to get/put_user)?<br><br>It seems the failure path is like this:<br><br>
1. userspace passes unaligned pointer<br>2. get_user attempts to access<br>=
3. CPU raises unaligned exception (if only it would raise the segfault as h=
igher priority, before the unaligned!)<br>4. unaligned exception handler at=
tempts to simulate the unaligned access with multiple partial read/write op=
s<br>
5. CPU raises MMU exception on the read/write by the unaligned handler<br>6=
. kernel segfault handler looks up faulting address, it is in the unaligned=
 exception handler, which has no fixup.<br>7. no fixup -&gt; failure<br>
<br>So, I suppose the question is - where in the sequence is the true failu=
re?<br><br>Clearly LTP thinks it&#39;s ok to pass unaligned pointers to the=
 kernel, suggesting (1) is fine - thus my question about alignment rules in=
 the ABI.<br>
<br>Do we need fixups on the unaligned handler itself? This will be ugly ug=
ly ugly.=A0 Or, some way of tracing the segfault back through the unaligned=
 exception and to the root cause (the get/put-user), and call that fixup as=
 required?<br>
<br>Thanks,<br><br>John<br></div></div><br>

--0016367f96e07c88d0046eb43c66--


--===============4190832868535330350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--===============4190832868535330350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4190832868535330350==--

