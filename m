Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sarath.tadi@gmail.com>) id 1T8WeV-0001KR-12
	for ltp-list@lists.sourceforge.net; Mon, 03 Sep 2012 13:25:19 +0000
Received: from mail-wi0-f169.google.com ([209.85.212.169])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1T8WeQ-0008La-W5
	for ltp-list@lists.sourceforge.net; Mon, 03 Sep 2012 13:25:19 +0000
Received: by wibhm2 with SMTP id hm2so3117463wib.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 03 Sep 2012 06:25:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAD15agakqdqNiZY_rKRyh0GocADu7F2rLdctJpSwdosiNz7CYg@mail.gmail.com>
References: <CAD15agakqdqNiZY_rKRyh0GocADu7F2rLdctJpSwdosiNz7CYg@mail.gmail.com>
Date: Mon, 3 Sep 2012 18:55:08 +0530
Message-ID: <CABhB_e8j2oRbKPererNep1-T5z3sCsvRPW-2rSoPg-tvF4AZoA@mail.gmail.com>
From: tadimarri sarath <sarath.tadi@gmail.com>
Subject: Re: [LTP] LTP test reults for kernel 3.0.15 and 3.4
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2549079866618599913=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Ritesh Harjani <ritesh.harjani@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============2549079866618599913==
Content-Type: multipart/alternative; boundary=00504502971d0fe86a04c8cc1215

--00504502971d0fe86a04c8cc1215
Content-Type: text/plain; charset=ISO-8859-1

Hi Ritesh,

May I know which version of the LTP you have used and the filesystem
environment used ?
The source can be found here
It is a testcase which does series of checks that memory can be allocated
and freed with various calloc, malloc, free, realloc, valloc functions.
please refer to the source here :
testcases/kernel/mem/mem/mem02.c

Regards,
Sarath.

On Mon, Sep 3, 2012 at 10:37 AM, Ritesh Harjani <ritesh.harjani@gmail.com>wrote:

> Has anyone tried running LTP tests on kernel 3.0.15 (Android ICS) and
> kernel 3.4 (Android ICS)
>
> Actually there is mem02 test which is failing in kernel 3.0.15 which is
> not the case with kernel 3.4.
> So, if anyone can point out why the difference and also if someone can
> direct me onto what exactly this test does and
> some source of information from where i can have a deeper understanding on
> this.
>
> Thank you
> Ritesh
>
>
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>

--00504502971d0fe86a04c8cc1215
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ritesh, <br><br>May I know which version of the LTP you have used and th=
e filesystem environment used ? <br>The source can be found here<br>It is a=
 testcase which does series of checks that memory can be allocated and free=
d with various calloc, malloc, free, realloc, valloc functions.<br>
please refer to the source here :<br>testcases/kernel/mem/mem/mem02.c<br><b=
r>Regards,<br>Sarath.<br><br><div class=3D"gmail_quote">On Mon, Sep 3, 2012=
 at 10:37 AM, Ritesh Harjani <span dir=3D"ltr">&lt;<a href=3D"mailto:ritesh=
.harjani@gmail.com" target=3D"_blank">ritesh.harjani@gmail.com</a>&gt;</spa=
n> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Has anyone tried running LTP tests on kernel=
 3.0.15 (Android ICS) and kernel 3.4 (Android ICS)<br><br>Actually there is=
 mem02 test which is failing in kernel 3.0.15 which is not the case with ke=
rnel 3.4. <br>
So, if anyone can point out why the difference and also if someone can dire=
ct me onto what exactly this test does and <br>
some source of information from where i can have a deeper understanding on =
this. <br><br>Thank you <br><span class=3D"HOEnZb"><font color=3D"#888888">=
Ritesh<br>
</font></span><br>---------------------------------------------------------=
---------------------<br>
Live Security Virtual Conference<br>
Exclusive live event will cover all the ways today&#39;s security and<br>
threat landscape has changed and how IT managers can respond. Discussions<b=
r>
will include endpoint security, mobile security and the latest in malware<b=
r>
threats. <a href=3D"http://www.accelacomm.com/jaw/sfrnl04242012/114/5012226=
3/" target=3D"_blank">http://www.accelacomm.com/jaw/sfrnl04242012/114/50122=
263/</a><br>_______________________________________________<br>
Ltp-list mailing list<br>
<a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforg=
e.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" target=3D=
"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
<br></blockquote></div><br>

--00504502971d0fe86a04c8cc1215--


--===============2549079866618599913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============2549079866618599913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2549079866618599913==--

