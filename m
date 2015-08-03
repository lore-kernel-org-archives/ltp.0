Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwan@redhat.com>) id 1ZMCkl-0005FH-2N
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2015 10:13:55 +0000
Received: from mail-ob0-f182.google.com ([209.85.214.182])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZMCki-0002q7-VL
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2015 10:13:55 +0000
Received: by obre1 with SMTP id e1so95528218obr.1
	for <ltp-list@lists.sourceforge.net>;
	Mon, 03 Aug 2015 03:13:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55BC1E51.6090508@huawei.com>
References: <1010625653.980528.1438323855616.JavaMail.zimbra@redhat.com>
	<55BC1E51.6090508@huawei.com>
Date: Mon, 3 Aug 2015 18:08:36 +0800
Message-ID: <CAEemH2f6Jd7TkXUDd0725be5yuoLyTYv4T-GA=S_Vz8YZr5j6g@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Subject: Re: [LTP] How to compie a ltp-case into 32-bit on the 64bit system
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2869403598779925379=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Cui Bixuan <cuibixuan@huawei.com>
Cc: ltp-list@lists.sourceforge.net

--===============2869403598779925379==
Content-Type: multipart/alternative; boundary=089e0111b2a2574f43051c655a0a

--089e0111b2a2574f43051c655a0a
Content-Type: text/plain; charset=UTF-8

Hi,

On Sat, Aug 1, 2015 at 9:18 AM, Cui Bixuan <cuibixuan@huawei.com> wrote:

> On 2015/7/31 14:24, Li Wang wrote:
>
> > Then, I came up with a idea that I don't include the ltp-lib file in
> 'msgrcv08.c',
> > and just add two lines in the .../ipc/msgrcv/Makefile:
> >
> >   msgrcv08:
> >       gcc -g -O2 -Wall -m32 msgrcv08.c -o msgrcv08
> >
> > It works for me, but I know it's not appropriate for LTP management.
> >
> > What should I do? or, Is there any good way to solve this problem?
> Hi,
>     For LTP, we can run './configure CC=[SDK-32]; make;' to compile 32-bit
> testcases.
> So, I think, if the case 'msgrcv08.c' will not work as 64-bit application,
> it can check the
> SDK first. And do 'TCONF: not gcc32' if it's 64-bit application.
>

Thanks for review.  Do u know how to check the SDK first in msgrcv08.c
file?

For me, LTP always running on 64-bit system. So I wanted to run this case
with others(msgrcv0*[1-7}) at the same time. seems like it's very difficult
to achieve.


>
>     It's not a good idea that ipc/msgrcv/Makefile to control it, I mean,
> LTP user to control
> it in ./configure which will be better.
>

>     What do you think?
>

Agree, it's not wise to control the case by Makefile.  and,  it's easy to
get TCONF but hard to get it work.


> Thanks,
> Cui Bixuan
>
> >
> > Thanks~
> >
>
>
>
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>



-- 
Regards,
Li Wang
Email: liwang@redhat.com

--089e0111b2a2574f43051c655a0a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Sat, Aug 1, 2015 at 9:18 AM, Cui Bixuan <span dir=3D"ltr">&lt;<a =
href=3D"mailto:cuibixuan@huawei.com" target=3D"_blank">cuibixuan@huawei.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span>On 2015/7/31=
 14:24, Li Wang wrote:<br>
<br>
&gt; Then, I came up with a idea that I don&#39;t include the ltp-lib file =
in &#39;msgrcv08.c&#39;,<br>
&gt; and just add two lines in the .../ipc/msgrcv/Makefile:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0msgrcv08:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gcc -g -O2 -Wall -m32 msgrcv08.c -o msgrcv08=
<br>
&gt;<br>
&gt; It works for me, but I know it&#39;s not appropriate for LTP managemen=
t.<br>
&gt;<br>
&gt; What should I do? or, Is there any good way to solve this problem?<br>
</span>Hi,<br>
=C2=A0 =C2=A0 For LTP, we can run &#39;./configure CC=3D[SDK-32]; make;&#39=
; to compile 32-bit testcases.<br>
So, I think, if the case &#39;msgrcv08.c&#39; will not work as 64-bit appli=
cation, it can check the<br>
SDK first. And do &#39;TCONF: not gcc32&#39; if it&#39;s 64-bit application=
.<br></blockquote><div><br></div><div>Thanks for review.=C2=A0 Do u know ho=
w to check the SDK first in msgrcv08.c file? <br><br></div><div>For me, LTP=
 always running on 64-bit system. So I wanted to run this case with others(=
msgrcv0*[1-7}) at the same time. seems like it&#39;s very difficult to achi=
eve.<br>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
=C2=A0 =C2=A0 It&#39;s not a good idea that ipc/msgrcv/Makefile to control =
it, I mean, LTP user to control<br>
it in ./configure which will be better.<br></blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
=C2=A0 =C2=A0 What do you think?<br></blockquote><div>=C2=A0</div><div>Agre=
e, it&#39;s not wise to control the case by Makefile.=C2=A0 and,=C2=A0 it&#=
39;s easy to get TCONF but hard to get it work.<br><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
<br>
Thanks,<br>
Cui Bixuan<br>
<br>
&gt;<br>
&gt; Thanks~<br>
<div><div>&gt;<br>
<br>
<br>
---------------------------------------------------------------------------=
---<br>
_______________________________________________<br>
Ltp-list mailing list<br>
<a href=3D"mailto:Ltp-list@lists.sourceforge.net" target=3D"_blank">Ltp-lis=
t@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" rel=3D"no=
referrer" target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/lt=
p-list</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br><div><div d=
ir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div>Regards,<br></d=
iv>Li Wang<br></div><div>Email: <a href=3D"mailto:liwang@redhat.com" target=
=3D"_blank">liwang@redhat.com</a><br></div></div></div></div></div></div>
</div></div>

--089e0111b2a2574f43051c655a0a--


--===============2869403598779925379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============2869403598779925379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2869403598779925379==--

