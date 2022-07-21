Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D0EC43334
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 04:04:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DA283C9AD0
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 06:04:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E342F3C1BAD
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 06:04:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 73C9D600A3D
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 06:04:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658376267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F0/Y1zXVrHIyo7uAsftueC1zh16zbfffuGldSYZ84/8=;
 b=UWdmPUjZzddSCrOyPwqEToyg8hdiqvp9DFbRFC8DKDAoGdht7wyyy0V8GT0KpZU6WIQJKx
 jbWi1JCBWdmAOaApUofi+zW7g+tzMKSra+OCGV35VIuq8douBSuH9OO6bLQMme/ckcgxwL
 tw2ugPsUr84Mw4gJBrCpYdNUeLtZP8Y=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-bbIBmT04N2WD5Dp4c_wvNg-1; Thu, 21 Jul 2022 00:04:20 -0400
X-MC-Unique: bbIBmT04N2WD5Dp4c_wvNg-1
Received: by mail-yb1-f197.google.com with SMTP id
 y4-20020a25b9c4000000b0066e573fb0fcso400606ybj.21
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 21:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F0/Y1zXVrHIyo7uAsftueC1zh16zbfffuGldSYZ84/8=;
 b=EthPWhet0Wmi6E5XLIloCNVRon0nV0bSXkFhIZwRmmjHVBncAXorH1eAWiae0cJRZ/
 0akblx2Y3N6OghP74+S9D9dgIU7EHrsoopz/ZhJY4McsHyFz15HtDxEWvIIr6lg76LJg
 3i18uc7OFi28YtL/NtzTd2F7QZz8FjEKW09CQQiZSM4W9kDGUU0UoLtOuNIWBRW1xw6D
 yMO41AXVC2Dn0sHuW1pCHfOsSG0jeqiJuuA18zEHISg3XlQeaLDFmFVnge/Wx8vi627/
 7or4OQp88ZSLdaworZm0uFZU/3I3CLhNrNT226Vop01ySoLvEa0phaieAOuUWZ9fbakj
 gbhw==
X-Gm-Message-State: AJIora97Ud1DIWQBpixePGZkBivMT1bu1ZAplEz9ODtMuG0p/DkVEmom
 xFS+JDRTuNJ2c4FZ6/rOrS8daduMkMrpST9LDdbpALfTCW0bKuDijaurpO8/jkRW7Zgknq4aw1s
 LNmlqb4aEB6JgfjZ7zH/yzimLjaA=
X-Received: by 2002:a05:6902:70b:b0:66e:8dde:7a58 with SMTP id
 k11-20020a056902070b00b0066e8dde7a58mr39175347ybt.186.1658376259770; 
 Wed, 20 Jul 2022 21:04:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sFJmZ2xqiJ/FAZmh50Kw0WZopzqNUzTL6RvusKf6sd+yH2jxCEcNuR3jhVCHLZJDNRug2VtImEEG0T5ZSfHRE=
X-Received: by 2002:a05:6902:70b:b0:66e:8dde:7a58 with SMTP id
 k11-20020a056902070b00b0066e8dde7a58mr39175332ybt.186.1658376259581; Wed, 20
 Jul 2022 21:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220720104430.8614-1-akumar@suse.de>
In-Reply-To: <20220720104430.8614-1-akumar@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Thu, 21 Jul 2022 12:04:08 +0800
Message-ID: <CAEemH2eCd43jRJmYgEB6RpACqcd3gXudSE4UM2p2SwsOjMgN7A@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getitimer03.c: convert to new LTP API
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0986530616=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0986530616==
Content-Type: multipart/alternative; boundary="000000000000db4d9f05e448cfc6"

--000000000000db4d9f05e448cfc6
Content-Type: text/plain; charset="UTF-8"

Hi Avinesh,

Thank you for doing this. The code achievement is absolutely right but
we can do something unify to better manage the error test in LTP.

My suggestion is to combine this invalid-argument test into getitimer02.c
by creating a structure that populates with arguments of getitimer(). Then
we can traversal each item to complete all error tests for a syscall just
in one testcase. (see madvise02.c)

e.g.

static struct tcase {
       int which;
       struct itimerval *curr_value;
} tcases[] = {
       {},
};


-- 
Regards,
Li Wang

--000000000000db4d9f05e448cfc6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi=C2=A0Avinesh,</div><div class=3D"gmail_default" style=3D"f=
ont-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:s=
mall">Thank you for doing this. The code achievement is absolutely right bu=
t</div><div class=3D"gmail_default" style=3D"font-size:small">we can do som=
ething unify to better manage the error test in LTP.</div><div class=3D"gma=
il_default" style=3D"font-size:small"><br></div><div class=3D"gmail_default=
" style=3D"font-size:small">My suggestion is to combine this invalid-argume=
nt test into getitimer02.c</div><div class=3D"gmail_default" style=3D"font-=
size:small">by=C2=A0creating a structure that populates with arguments of g=
etitimer(). Then</div><div class=3D"gmail_default" style=3D"font-size:small=
">we can traversal each item to complete all error tests for a syscall just=
</div><div class=3D"gmail_default" style=3D"font-size:small">in one testcas=
e. (see madvise02.c)</div><div class=3D"gmail_default" style=3D"font-size:s=
mall"><br></div><div class=3D"gmail_default" style=3D"font-size:small">e.g.=
</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div=
 class=3D"gmail_default" style=3D"font-size:small">static struct tcase {<br=
></div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0=
 =C2=A0 =C2=A0int which;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0struct itimerval *cu=
rr_value;<br>} tcases[] =3D {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0{},</div><div c=
lass=3D"gmail_default" style=3D"font-size:small">};<br></div></div><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"><br></div></div><d=
iv><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"=
ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000db4d9f05e448cfc6--


--===============0986530616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0986530616==--

