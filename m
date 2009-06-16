Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naveenspen@gmail.com>) id 1MGY7P-0004Uj-P3
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2009 12:50:27 +0000
Received: from yw-out-2324.google.com ([74.125.46.28])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MGY7L-0002HT-54
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2009 12:50:27 +0000
MIME-Version: 1.0
In-Reply-To: <20090616095220.GA218461@medusa.sis.pasteur.fr>
References: <20090616095220.GA218461@medusa.sis.pasteur.fr>
Date: Tue, 16 Jun 2009 18:08:27 +0530
Message-ID: <ab64ec20906160538i392e4cb8oa3006186c202d1bd@mail.gmail.com>
From: naveen penumala <naveenspen@gmail.com>
Subject: Re: [LTP] Small typo in sgetmask01.c
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9106290021316309767=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Nicolas Joly <njoly@pasteur.fr>, LTP list <ltp-list@lists.sf.net>

--===============9106290021316309767==
Content-Type: multipart/alternative; boundary=001e680f13f4883d90046c7673c1

--001e680f13f4883d90046c7673c1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,
I have applied above patch and tested. In my testing i got below error
statements.
I have tested on suse linux and kernel version is 2.6.16.21

cc -I../../../../include -Wall    sgetmask01.c  -L../../../../lib -lltp -o
sgetmask01
In file included from sgetmask01.c:60:
../../../../include/linux_syscall_numbers.h:184:1: error: unterminated
#ifdef
../../../../include/linux_syscall_numbers.h:13:1: error: unterminated
#ifndef


Thanks & Regards,
-NVN
On Tue, Jun 16, 2009 at 3:22 PM, Nicolas Joly <njoly@pasteur.fr> wrote:

>
> Hi,
>
> Here follow a small patch that fix a typo in sgetmask01.c testcase,
> where __NR_ssetmask is badly used instead of __NR_sgetmask.
>
> Regards.
>
> --
> Nicolas Joly
>
> Biological Software and Databanks.
> Institut Pasteur, Paris.
>
>
> ------------------------------------------------------------------------------
> Crystal Reports - New Free Runtime and 30 Day Trial
> Check out the new simplified licensing option that enables unlimited
> royalty-free distribution of the report engine for externally facing
> server and web deployment.
> http://p.sf.net/sfu/businessobjects
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>

--001e680f13f4883d90046c7673c1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, <br>I have applied above patch and tested. In my testing i got below er=
ror statements.<br>I have tested on suse linux and kernel version is 2.6.16=
.21<br><br>cc -I../../../../include -Wall=A0=A0=A0 sgetmask01.c=A0 -L../../=
../../lib -lltp -o sgetmask01<br>
In file included from sgetmask01.c:60:<br>../../../../include/linux_syscall=
_numbers.h:184:1: error: unterminated #ifdef<br>../../../../include/linux_s=
yscall_numbers.h:13:1: error: unterminated #ifndef<br><br><br>Thanks &amp; =
Regards,<br>
-NVN<br><div class=3D"gmail_quote">On Tue, Jun 16, 2009 at 3:22 PM, Nicolas=
 Joly <span dir=3D"ltr">&lt;<a href=3D"mailto:njoly@pasteur.fr">njoly@paste=
ur.fr</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"b=
order-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddin=
g-left: 1ex;">
<br>
Hi,<br>
<br>
Here follow a small patch that fix a typo in sgetmask01.c testcase,<br>
where __NR_ssetmask is badly used instead of __NR_sgetmask.<br>
<br>
Regards.<br>
<font color=3D"#888888"><br>
--<br>
Nicolas Joly<br>
<br>
Biological Software and Databanks.<br>
Institut Pasteur, Paris.<br>
</font><br>----------------------------------------------------------------=
--------------<br>
Crystal Reports - New Free Runtime and 30 Day Trial<br>
Check out the new simplified licensing option that enables unlimited<br>
royalty-free distribution of the report engine for externally facing<br>
server and web deployment.<br>
<a href=3D"http://p.sf.net/sfu/businessobjects" target=3D"_blank">http://p.=
sf.net/sfu/businessobjects</a><br>_________________________________________=
______<br>
Ltp-list mailing list<br>
<a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforg=
e.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" target=3D=
"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
<br></blockquote></div><br>

--001e680f13f4883d90046c7673c1--


--===============9106290021316309767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
--===============9106290021316309767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============9106290021316309767==--

