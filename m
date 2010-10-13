Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hakehuang@gmail.com>) id 1P5t6l-00045V-Qo
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 04:38:31 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P5t6k-0001rr-Ty
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 04:38:31 +0000
Received: by ywl5 with SMTP id 5so2144698ywl.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Oct 2010 21:38:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimhAOpaWN7KDwg_PCQ=_j81A1fddRe5_KaB+RLY@mail.gmail.com>
References: <AANLkTimb=F0NaS+Sipp8EzrbRUqPqRf+9-nBZQMPpD=w@mail.gmail.com>
	<AANLkTimhAOpaWN7KDwg_PCQ=_j81A1fddRe5_KaB+RLY@mail.gmail.com>
Date: Wed, 13 Oct 2010 12:38:25 +0800
Message-ID: <AANLkTinOLVvd1B90s3Hn735YqH+Ku=BmUwyu-w1yZK_Y@mail.gmail.com>
From: hake huang <hakehuang@gmail.com>
Subject: Re: [LTP] Patch to record kernel dump message to each testcases log
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5108539047975861885=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============5108539047975861885==
Content-Type: multipart/alternative; boundary=0016e684c2fc02ad7d0492782a29

--0016e684c2fc02ad7d0492782a29
Content-Type: text/plain; charset=ISO-8859-1

Hi

I see this simple solution is no quite fit. But the kernel dump message for
each test case is necessary for analysing. I can work on this further, with
below help:
1. Where can I find the reason for the IIRC break?
2. Can it  be an option to avoid the size limitation on some embedded
system?
3.  A kind of seperating tag is needed for kernel message, right? e.g
<kernel_dump_start>dump message<kernel_dump_end>
4.  I see in ltp-pan.c the file descriptors, terminals are changed in child
process. if the system(3) has problem, the worst cases is there are no
kernel messge output in parent process, but the pan can still function well.

if not use system(3), can you give your suggestion on this, exec(3) seems to
have the same problem as system(3)?

Regards,

Hake

2010/10/13 Garrett Cooper <yanegomi@gmail.com>

> On Tue, Oct 12, 2010 at 5:56 AM, hake huang <hakehuang@gmail.com> wrote:
> > Hi,
> >
> > I wnat LTP to record the kernel dump message during each test case, and I
> > make a patch for this. Any comments?
>
> Low:
> 1. This will break existing functionality (IIRC) with runltp provided
> by Subrata (CCed for comment).
>
> Medium:
> 2. It will bloat logs output on embedded systems / systems with limited
> space.
> 3. It could have other potential unwanted side-effects with tests
> and/or system services (in particular because some people on the list
> have been executing LTP on production systems, not testbed machines...
> even though I argue that's their mistake).
>
> High:
> 4. The change would confuse end-users.
> 5. The change would break scripts which parse the output in different
> ways from what you intend.
> 6. Using system(3) to execute a program could yield some unintended
> side-effects with file descriptors, terminal handling, process
> wait(2)ing, etc.
>
> Thanks,
> -Garrett
>

--0016e684c2fc02ad7d0492782a29
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi<br><br>I see this simple solution is no quite fit. But the kernel dump m=
essage for each test case is necessary for analysing. I can work on this fu=
rther, with below help: <br>1. Where can I find the reason for the IIRC bre=
ak? <br>
2. Can it=A0 be an option to avoid the size limitation on some embedded sys=
tem?<br>3.=A0 A kind of seperating tag is needed for kernel message, right?=
 e.g &lt;kernel_dump_start&gt;dump message&lt;kernel_dump_end&gt;<br>4.=A0 =
I see in ltp-pan.c the file descriptors, terminals are changed in child pro=
cess. if the system(3) has problem, the worst cases is there are no kernel =
messge output in parent process, but the pan can still function well.<br>
<br>if not use system(3), can you give your suggestion on this, exec(3) see=
ms to have the same problem as system(3)?<br><br>Regards,<br><br>Hake<br><b=
r><div class=3D"gmail_quote">2010/10/13 Garrett Cooper <span dir=3D"ltr">&l=
t;<a href=3D"mailto:yanegomi@gmail.com">yanegomi@gmail.com</a>&gt;</span><b=
r>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=3D"im"=
>On Tue, Oct 12, 2010 at 5:56 AM, hake huang &lt;<a href=3D"mailto:hakehuan=
g@gmail.com">hakehuang@gmail.com</a>&gt; wrote:<br>

&gt; Hi,<br>
&gt;<br>
&gt; I wnat LTP to record the kernel dump message during each test case, an=
d I<br>
&gt; make a patch for this. Any comments?<br>
<br>
</div>Low:<br>
1. This will break existing functionality (IIRC) with runltp provided<br>
by Subrata (CCed for comment).<br>
<br>
Medium:<br>
2. It will bloat logs output on embedded systems / systems with limited spa=
ce.<br>
3. It could have other potential unwanted side-effects with tests<br>
and/or system services (in particular because some people on the list<br>
have been executing LTP on production systems, not testbed machines...<br>
even though I argue that&#39;s their mistake).<br>
<br>
High:<br>
4. The change would confuse end-users.<br>
5. The change would break scripts which parse the output in different<br>
ways from what you intend.<br>
6. Using system(3) to execute a program could yield some unintended<br>
side-effects with file descriptors, terminal handling, process<br>
wait(2)ing, etc.<br>
<br>
Thanks,<br>
<font color=3D"#888888">-Garrett<br>
</font></blockquote></div><br>

--0016e684c2fc02ad7d0492782a29--


--===============5108539047975861885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
--===============5108539047975861885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5108539047975861885==--

