Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <afridi.waqar@gmail.com>) id 1MJmMn-0006Ew-Ti
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 10:39:41 +0000
Received: from mail-px0-f197.google.com ([209.85.216.197])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MJmMk-0005F3-Es
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 10:39:41 +0000
MIME-Version: 1.0
In-Reply-To: <1245921062.5542.51.camel@subratamodak.linux.ibm.com>
References: <78aaeffc0906250000i150418e8k3637acb41976c1a0@mail.gmail.com>
	<1245921062.5542.51.camel@subratamodak.linux.ibm.com>
Date: Thu, 25 Jun 2009 16:39:37 +0600
Message-ID: <78aaeffc0906250339q1051eceak19a244c968b4ba0c@mail.gmail.com>
From: waqar afridi <afridi.waqar@gmail.com>
Subject: Re: [LTP] Can not run Test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2515718880296192061=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>

--===============2515718880296192061==
Content-Type: multipart/alternative; boundary=000e0cd3298222a589046d29d782

--000e0cd3298222a589046d29d782
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Thu, Jun 25, 2009 at 3:11 PM, Subrata Modak
<subrata@linux.vnet.ibm.com>wrote:

> On Thu, 2009-06-25 at 13:00 +0600, waqar afridi wrote:
> > Hi All
> >
> > I have downloaded ltp-full-20090531.tgz and installed it using the
> > commands make autotools, ./configure, make all, make install. but when
> > I try to run a test like
> >
> > # ./ima_tpm.sh
> > ./ima_tpm.sh: 163: source: not found
> > ./ima_tpm.sh: 164: setup: not found
> >
> > I get the error above. What could be the problem, Desperately need
> > help.
>
> Look through:
>
> http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/security/integrity/ima/README
> ,
> on instructions to setup before executing those tests.


I already have done these steps. but I think  the problem will be with
mounting partition with iversion support(I have done this too, added
iversion to fstab). I am not clear about whats iversion, so thats why I am
going to clear my Idea about iversion. but if some body can help with both
the problem and iversion, I will be very thankful.

>
>
> Regards--
> Subrata
>
> >
> > --
> > Waqar Afridi
> > Research Associate
> > Member: Security Engineering Research Group (SERG)
> > IM | Sciences Peshawar
> >
> ------------------------------------------------------------------------------
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>


-- 
Waqar Afridi
Research Associate
Member: Security Engineering Research Group (SERG)
IM | Sciences Peshawar

--000e0cd3298222a589046d29d782
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Jun 25, 2009 at 3:11 PM, Subrata=
 Modak <span dir=3D"ltr">&lt;<a href=3D"mailto:subrata@linux.vnet.ibm.com">=
subrata@linux.vnet.ibm.com</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt =
0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">On Thu, 2009-06-25 at 13:00 +0600, waqar afridi wrote:<br=
>
&gt; Hi All<br>
&gt;<br>
&gt; I have downloaded ltp-full-20090531.tgz and installed it using the<br>
&gt; commands make autotools, ./configure, make all, make install. but when=
<br>
&gt; I try to run a test like<br>
&gt;<br>
&gt; # ./ima_tpm.sh<br>
&gt; ./ima_tpm.sh: 163: source: not found<br>
&gt; ./ima_tpm.sh: 164: setup: not found<br>
&gt;<br>
&gt; I get the error above. What could be the problem, Desperately need<br>
&gt; help.<br>
<br>
</div>Look through:<br>
<a href=3D"http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/s=
ecurity/integrity/ima/README" target=3D"_blank">http://ltp.cvs.sourceforge.=
net/viewvc/ltp/ltp/testcases/kernel/security/integrity/ima/README</a>,<br>

on instructions to setup before executing those tests.</blockquote><div><br=
>I already have done these steps. but I think=A0 the problem will be with m=
ounting partition with iversion support(I have done this too, added iversio=
n to fstab). I am not clear about whats iversion, so thats why I am going t=
o clear my Idea about iversion. but if some body can help with both the pro=
blem and iversion, I will be very thankful.<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<br>
Regards--<br>
Subrata<br>
<div class=3D"im"><br>
&gt;<br>
&gt; --<br>
&gt; Waqar Afridi<br>
&gt; Research Associate<br>
&gt; Member: Security Engineering Research Group (SERG)<br>
&gt; IM | Sciences Peshawar<br>
</div>&gt; ----------------------------------------------------------------=
--------------<br>
&gt; _______________________________________________<br>
&gt; Ltp-list mailing list<br>
&gt; <a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourc=
eforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Waqar Afridi<br>Researc=
h Associate<br>Member: Security Engineering Research Group (SERG)<br>IM | S=
ciences Peshawar<br>

--000e0cd3298222a589046d29d782--


--===============2515718880296192061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============2515718880296192061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2515718880296192061==--

