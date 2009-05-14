Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rohit.170309@gmail.com>) id 1M4S91-0003eE-35
	for ltp-list@lists.sourceforge.net; Thu, 14 May 2009 04:02:07 +0000
Received: from mail-fx0-f177.google.com ([209.85.220.177])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M4S8w-0001vH-LZ
	for ltp-list@lists.sourceforge.net; Thu, 14 May 2009 04:02:07 +0000
Received: by fxm25 with SMTP id 25so1088294fxm.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 13 May 2009 21:02:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090513.223538.71106642.caiqian@cclom.cn>
References: <d51f89b0905070410v468978ecjf6d8ee31bb4ede3c@mail.gmail.com>
	<20090508.232031.104047613.caiqian@cclom.cn>
	<d51f89b0905120440y8d3eacbh6874458946af6ea3@mail.gmail.com>
	<20090513.223538.71106642.caiqian@cclom.cn>
Date: Thu, 14 May 2009 09:32:00 +0530
Message-ID: <d51f89b0905132102y8a8e57dpeb6b73a24b693ea7@mail.gmail.com>
From: rohit verma <rohit.170309@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd29702ced8f90469d76327
Subject: [LTP] Fwd: Patch for  :Unzip01 Test Not Working Correctly
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--000e0cd29702ced8f90469d76327
Content-Type: multipart/alternative; boundary=000e0cd29702ced8ed0469d76325

--000e0cd29702ced8ed0469d76325
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

---------- Forwarded message ----------
From: CAI Qian <caiqian@cclom.cn>
Date: Wed, May 13, 2009 at 8:05 PM
Subject: Re: Patch for [LTP] :Unzip01 Test Not Working Correctly
To: rohit.170309@gmail.com


From: rohit verma <rohit.170309@gmail.com>
Subject: Re: Patch for [LTP] :Unzip01 Test Not Working Correctly
Date: Tue, 12 May 2009 17:10:36 +0530

> Hi Qian,
>
> Yes you are correct. We cannot predict the output order of unzip. So I
> have sorted the
> actual and expected output and attached the updated patch with this mail.
>
> I request you to apply this patch and let me know if any issues.
>
> Regards,
> Rohit
>

Works fine. Please submit to the mailing list.

Acked-by: CAI Qian <caiqian@cclom.cn>

Thanks,
CAI Qian

--000e0cd29702ced8ed0469d76325
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">---------- Forwarded message ----------<=
br>From: <b class=3D"gmail_sendername">CAI Qian</b> <span dir=3D"ltr">&lt;<=
a href=3D"mailto:caiqian@cclom.cn">caiqian@cclom.cn</a>&gt;</span><br>Date:=
 Wed, May 13, 2009 at 8:05 PM<br>
Subject: Re: Patch for [LTP] :Unzip01 Test Not Working Correctly<br>To: <a =
href=3D"mailto:rohit.170309@gmail.com">rohit.170309@gmail.com</a><br><br><b=
r><div class=3D"im">From: rohit verma &lt;<a href=3D"mailto:rohit.170309@gm=
ail.com">rohit.170309@gmail.com</a>&gt;<br>

Subject: Re: Patch for [LTP] :Unzip01 Test Not Working Correctly<br>
</div>Date: Tue, 12 May 2009 17:10:36 +0530<br>
<div class=3D"im"><br>
&gt; Hi Qian,<br>
&gt;<br>
&gt; Yes you are correct. We cannot predict the output order of unzip. So I=
<br>
&gt; have sorted the<br>
&gt; actual and expected output and attached the updated patch with this ma=
il.<br>
&gt;<br>
&gt; I request you to apply this patch and let me know if any issues.<br>
&gt;<br>
&gt; Regards,<br>
&gt; Rohit<br>
&gt;<br>
<br>
</div>Works fine. Please submit to the mailing list.<br>
<br>
Acked-by: CAI Qian &lt;<a href=3D"mailto:caiqian@cclom.cn">caiqian@cclom.cn=
</a>&gt;<br>
<br>
Thanks,<br>
<font color=3D"#888888">CAI Qian<br>
</font><div><div></div><div class=3D"h5"><br></div></div></div>

--000e0cd29702ced8ed0469d76325--

--000e0cd29702ced8f90469d76327
Content-Type: text/plain; charset=US-ASCII; name="unzip01.txt"
Content-Disposition: attachment; filename="unzip01.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fuoxo68j0

ZGlmZiAtcnV4QiBsdHAtZnVsbC0yMDA5MDQzMF9vcmlnaW5hbC90ZXN0Y2FzZXMvY29tbWFuZHMv
dW56aXAvdW56aXBfdGVzdHMuc2ggbHRwLWZ1bGwtMjAwOTA0MzAvdGVzdGNhc2VzL2NvbW1hbmRz
L3VuemlwL3VuemlwX3Rlc3RzLnNoCi0tLSBsdHAtZnVsbC0yMDA5MDQzMF9vcmlnaW5hbC90ZXN0
Y2FzZXMvY29tbWFuZHMvdW56aXAvdW56aXBfdGVzdHMuc2gJMjAwOS0wMi0yNiAxODo0MDo1NC4w
MDAwMDAwMDAgKzA1MzAKKysrIGx0cC1mdWxsLTIwMDkwNDMwL3Rlc3RjYXNlcy9jb21tYW5kcy91
bnppcC91bnppcF90ZXN0cy5zaAkyMDA5LTA1LTEyIDAzOjQxOjUwLjAwMDAwMDAwMCArMDUzMApA
QCAtNDQsNyArNDQsNyBAQAogY2hrX2lmZXhpc3RzKCkKIHsKIAlSQz0wCi0Jd2hpY2ggJDIgPiAi
JExUUFRNUC90c3RfdW56aXAuZXJyIiB8fCBSQz0kPworCXdoaWNoICQyID4gIiRQV0QvdHN0X3Vu
emlwLmVyciIgfHwgUkM9JD8KIAlpZiBbICQ/IC1uZSAwIF0KIAl0aGVuCiAJCXRzdF9icmttIFRC
Uk9LIE5VTEwgIiQxOiBjb21tYW5kICQyIG5vdCBmb3VuZC4iCkBAIC05OCw4ICs5OCw4IEBACiAJ
Y2hrX2lmZXhpc3RzIElOSVQgYXdrICAgICAgIHx8IHJldHVybiAkUkMKIAogCSMgY3JlYXRlIGV4
cGVjdGVkIG91dHB1dCBmaWxlcy4gdHN0X3VuemlwLmV4cAotCWNhdCA+ICRMVFBUTVAvdHN0X3Vu
emlwLm91dC5leHAgPDwtRU9GCi0JQXJjaGl2ZTogICRUTVAvdHN0X3VuemlwX2ZpbGUuemlwCisJ
Y2F0ID4gJFBXRC90c3RfdW56aXAub3V0LmV4cCA8PC1FT0YKKwlBcmNoaXZlOiAgJDEKICAgICBj
cmVhdGluZzogdHN0X3VuemlwLmRpci8KICAgICBjcmVhdGluZzogdHN0X3VuemlwLmRpci9kLjAv
CiAgICAgZXh0cmFjdGluZzogdHN0X3VuemlwLmRpci9kLjAvZi4wCkBAIC0xNDAsMTcgKzE0MCwx
OSBAQAogCiAJdHN0X3Jlc20gVElORk8gIlRlc3QgIzE6IHVuemlwIGNvbW1hbmQgdW4tY29tcHJl
c3NlcyBhIC56aXAgZmlsZS4iCiAKLQl1bnppcCAiJHt6aXBmaWxlfSIgPiAiJExUUFRNUC90c3Rf
dW56aXAub3V0IiB8fCBSQz0kPworCXVuemlwICIke3ppcGZpbGV9IiA+ICIkUFdEL3RzdF91bnpp
cC5vdXQiIHx8IFJDPSQ/CiAJaWYgWyAkUkMgLW5lIDAgXQogCXRoZW4KLQkJdHN0X3JlcyBURkFJ
TCAiJExUUFRNUC90c3RfdW56aXAub3V0IiBcCisJCXRzdF9yZXMgVEZBSUwgIiRQV0QvdHN0X3Vu
emlwLm91dCIgXAogCQkJIlRlc3QgIzE6IHVuemlwIGNvbW1hbmQgZmFpbGVkLiBSZXR1cm4gdmFs
dWUgPSAkUkMuIERldGFpbHM6IgogCQlyZXR1cm4gJFJDCiAJZWxzZQotCQlkaWZmIC1pd0IgIiRM
VFBUTVAvdHN0X3VuemlwLm91dCIgIiRMVFBUTVAvdHN0X3VuemlwLm91dC5leHAiID4gIiRMVFBU
TVAvdHN0X3VuemlwLm91dC5lcnIiIHx8IFJDPSQ/CisJCXNvcnQgLW8gIiRQV0QvdHN0X3Vuemlw
Lm91dCIgIiRQV0QvdHN0X3VuemlwLm91dCIKKwkJc29ydCAtbyAiJFBXRC90c3RfdW56aXAub3V0
LmV4cCIgIiRQV0QvdHN0X3VuemlwLm91dC5leHAiCisJCWRpZmYgLWl3QiAiJFBXRC90c3RfdW56
aXAub3V0IiAiJFBXRC90c3RfdW56aXAub3V0LmV4cCIgPiAiJFBXRC90c3RfdW56aXAub3V0LmVy
ciIgfHwgUkM9JD8KIAkJaWYgWyAkUkMgLW5lIDAgXQogCQl0aGVuCi0JCQl0c3RfcmVzIFRGQUlM
ICIkTFRQVE1QL3RzdF91bnppcC5vdXQuZXJyIiBcCisJCQl0c3RfcmVzIFRGQUlMICIkUFdEL3Rz
dF91bnppcC5vdXQuZXJyIiBcCiAJCQkJIlRlc3QgIzE6IHVuemlwIG91dHB1dCBkaWZmZXJzIGZy
b20gZXhwZWN0ZWQgb3V0cHV0LiBEZXRhaWxzIgogCQllbHNlCiAJCQl0c3RfcmVzbSBUSU5GTyAi
VGVzdCAjMTogY2hlY2sgaWYgXCIkUFdEL3RzdF91bnppcC5kaXJcIiBleGl0cy4iCkBAIC0xODAs
NyArMTgyLDcgQEAKIAogUkM9MAogc3RhdCAiJDEiIHx8IGV4aXQgJD8KLWluaXQgfHwgZXhpdCAk
PworaW5pdCAiJDEiIHx8IGV4aXQgJD8KIAogdGVzdDAxICIkMSIgfHwgUkM9JD8KIAo=
--000e0cd29702ced8f90469d76327
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
production scanning environment may not be a perfect world - but thanks to
Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i700
Series Scanner you'll get full speed at 300 dpi even with all image 
processing features enabled. http://p.sf.net/sfu/kodak-com
--000e0cd29702ced8f90469d76327
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd29702ced8f90469d76327--

