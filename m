Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BD4C433F5
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 04:10:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF4ED3C952C
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 05:10:35 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DB483C93B6
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 05:10:25 +0100 (CET)
Received: from sender-op-o11.zoho.in (sender-op-o11.zoho.in [103.117.158.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 794551A00615
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 05:10:22 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; t=1642047000; cv=none; d=zohomail.in; s=zohoarc; 
 b=NuSAezcNBKazBQP3rWlw4gSCaQIebJcmUjdw+VEnqiiqB/3RvAfiBMjCaYTtFoYRlwTUX/tJL/hSCkEeWYBBaXsc5DUiciVlkq5WFvFvlvsQu/FnvWDtjVx62TBuweuPRXCarhqsFy0ym+I1/8seFFFKSQSljQINXeKKNYx4tJI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in;
 s=zohoarc; t=1642047000;
 h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=Q8SRV8wXt4iD21n1RAiAci6OgYa7i1XtbQEGYCtBEp8=; 
 b=AigEXOy8TqJwoFXXkuWY8PpT6k7zzhO1Ljp8SxooHDnWzPSLGq/Aiod58my69XNcDtpy7WkRFb44FMcD8r7DMpqE+EyKF56KqICaHef0K7TqM77JkYrgd9CLLpc83o6plfuIj1+L+gp4Hrm61hf+VEuHPloK1dbEN6eu6QY6e3c=
ARC-Authentication-Results: i=1; mx.zohomail.in;
 dkim=pass  header.i=zilogic.com;
 spf=pass  smtp.mailfrom=kushalchand@zilogic.com;
 dmarc=pass header.from=<kushalchand@zilogic.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1642047000; 
 s=zoho; d=zilogic.com; i=kushalchand@zilogic.com;
 h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Subject:MIME-Version:Content-Type;
 bh=Q8SRV8wXt4iD21n1RAiAci6OgYa7i1XtbQEGYCtBEp8=;
 b=AqaQQamVltGbjMzBjT/aoZkN5EGIERxwrhWsZV0pUnJ1wZW8r80MxeX4OEtNiOWT
 rV8OyhRG1xdF1tDi0kffG/LZ8XADuCSAwZeMQ7CjA40jN/ObvKrStenFP1a5lTerZnC
 P8B0r+JI2em0yfvoco4RC2IRUtPP6OWOK9gcV1Yk=
Received: from mail.zoho.in by mx.zoho.in
 with SMTP id 1642046988586675.9589403633844;
 Thu, 13 Jan 2022 09:39:48 +0530 (IST)
Date: Thu, 13 Jan 2022 09:39:48 +0530
From: Kushal  Chand <kushalchand@zilogic.com>
To: "Petr Vorel" <pvorel@suse.cz>
Message-Id: <17e51a0a10c.33eb200245902.4455067589425493654@zilogic.com>
In-Reply-To: <Yd7xWuhoI+IBUi9l@pevik>
References: <20220111150028.92961-1-kushalchand@zilogic.com>
 <Yd7xWuhoI+IBUi9l@pevik>
MIME-Version: 1.0
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] tst_taint: Print readable error message
 instead of numerical code
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0293335018=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0293335018==
Content-Type: multipart/alternative; 
	boundary="----=_Part_155675_2094209751.1642046988556"

------=_Part_155675_2094209751.1642046988556
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Petr,

I am really sorry I forgot to mention the link to issue on LTP for which I =
have submitted the patch.=C2=A0

Can you please check=C2=A0https://github.com/linux-test-project/ltp/issues/=
776=C2=A0if you have not already?=C2=A0


I just followed what the issue points out.=C2=A0

If not I will follow what you have mentioned if given more references to ts=
t_strerrno()






---- On Wed, 12 Jan 2022 20:48:50 +0530 Petr Vorel <pvorel@suse.cz> wrote -=
---



Hi Kushal,=20
=20
>  =C2=A0=C2=A0=C2=A0=C2=A0if ((taint & taint_mask) !=3D 0)=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tst_brk(TBROK, "Kernel i=
s already tainted: %u", taint);=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tst_brk(TBROK, "Kernel i=
s already tainted: TAINT_D (OOPS)");=20
=20
Kernel can be tainted before testing with different flags than D.=20
=20
If you don't like the number, how about create function to map taint flag t=
o=20
char? i.e. similarly to tst_strerrno()?=20
=20
Kind regards,=20
Petr=20






Regards,
Kushal
------=_Part_155675_2094209751.1642046988556
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"><html><head>=
<meta content=3D"text/html;charset=3DUTF-8" http-equiv=3D"Content-Type"></h=
ead><body ><div style=3D"font-family: Verdana, Arial, Helvetica, sans-serif=
; font-size: 12pt;"><div>Hi Petr,<br><br>I am really sorry I forgot to ment=
ion the link to issue on LTP for which I have submitted the patch.&nbsp;<br=
><br>Can you please check&nbsp;<a target=3D"_blank" href=3D"https://github.=
com/linux-test-project/ltp/issues/776">https://github.com/linux-test-projec=
t/ltp/issues/776</a>&nbsp;if you have not already?&nbsp;<br><br></div><div>=
I just followed what the issue points out.&nbsp;<br><br>If not I will follo=
w what you have mentioned if given more references to tst_strerrno()<br><br=
></div><div><br></div><div class=3D"zmail_extra" data-zbluepencil-ignore=3D=
"true"><div><br></div><div id=3D"Zm-_Id_-Sgn1">---- On Wed, 12 Jan 2022 20:=
48:50 +0530 <b>Petr Vorel &lt;pvorel@suse.cz&gt;</b> wrote ----<br></div><d=
iv><br></div><blockquote style=3D"border-left: 1px solid rgb(204, 204, 204)=
; padding-left: 6px; margin: 0px 0px 0px 5px;"><div>Hi Kushal, <br> <br>&gt=
;  &nbsp;&nbsp;&nbsp;&nbsp;if ((taint &amp; taint_mask) !=3D 0) <br>&gt; -&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tst_brk(TBROK, "Kernel is al=
ready tainted: %u", taint); <br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;tst_brk(TBROK, "Kernel is already tainted: TAINT_D (OOPS)"); <br=
> <br>Kernel can be tainted before testing with different flags than D. <br=
> <br>If you don't like the number, how about create function to map taint =
flag to <br>char? i.e. similarly to tst_strerrno()? <br> <br>Kind regards, =
<br>Petr <br></div></blockquote></div><div><br></div><div id=3D"Zm-_Id_-Sgn=
" data-zbluepencil-ignore=3D"true"><div><br>Regards,<br>Kushal<br></div></d=
iv><div><br></div></div><br></body></html>
------=_Part_155675_2094209751.1642046988556--


--===============0293335018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0293335018==--

