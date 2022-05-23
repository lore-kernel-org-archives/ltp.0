Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D0CC433F5
	for <ltp@archiver.kernel.org>; Mon, 23 May 2022 11:15:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4261C3CABFE
	for <ltp@archiver.kernel.org>; Mon, 23 May 2022 13:15:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 493B73C001D
 for <ltp@lists.linux.it>; Mon, 23 May 2022 13:14:49 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6FEBC600281
 for <ltp@lists.linux.it>; Mon, 23 May 2022 13:14:49 +0200 (CEST)
Received: by mail-qt1-x82e.google.com with SMTP id g3so12255101qtb.7
 for <ltp@lists.linux.it>; Mon, 23 May 2022 04:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=ovM2IRDxyIFUmN5v6jZTkt7URejpITumS5NFMWXIjrM=;
 b=dgjYvB4gxOhNZ+5B+XKDQBfLy5nSXsZQPoxqmTrAUIH7hD3VAYdzjjAWnWcYc8dTqo
 5j1a6nb1MBFkdqQrHG6T40W5KTXoJJNHo5fzaTgHW/ZpHsx+5CcpyK6mRGJZK2WLVDLH
 y35ihoeAqKGQPnNAQDhauQ7lyz8PNTwafrmAqRi/bqCC5/piKp/2s+DzAld7VhyAlyA3
 n+Sovz8uNbjnHRnWo0ZQNpmILU4gJb5jmPTc2+BUG3yoRkVugO5NBQuPt6ZOchMU+QCd
 rWpElxOm4JErZSvhzEPXVihR+J0hwQazj699iL4eAbnpi0rFYxTnbJ1SHQMIX9ZNGglb
 tbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ovM2IRDxyIFUmN5v6jZTkt7URejpITumS5NFMWXIjrM=;
 b=WSP+GeOgc+ISrrjo60ImaHHTeDU/07qN5gYVuU1XrVcmlYG2o/nkn+swFBLlYTtMSe
 sXeajfR4YrroqvN59QSgcGf8Zhf60p+Sd0A1f9YR8VKqRZMF5nwrszlDIjUDfpTe1YkT
 VXCeTKFcnH0kii1/FIrwe+0EEm4JX999zP7xHkSOlFRhfA3aXgapJn7Mb6WNR1iW6oRF
 5DirS3gThxoXciWc+W14MyUdDTZcMSXsMCJ8TCmYqEMOnvXp44SXTLD3rwUCkanvm92J
 AlzFCqkOKfwxUCHtpOafgQxY9ELTBZQs5OsBHlvH0Dy52wRnSNErveAp4gATiTKh6KtQ
 Gv2g==
X-Gm-Message-State: AOAM5325jTeqBrletZd2ZyEy8EVEt5fx7A8JzbZCKtBw148wiI152kq6
 f3uaMhd24/2H8PtpIM05puEh/QSF92N3VFv+BuE32hd6k5S9cw==
X-Google-Smtp-Source: ABdhPJywd6XFqYXZPc0RO814IX+uspptHbTZXczwRJvlS6TW9XP4tbdNlfUJqlOppSOlgwLaUbFq8usfJtdwOmoDWWU=
X-Received: by 2002:a05:622a:6082:b0:2f1:1f9c:251e with SMTP id
 hf2-20020a05622a608200b002f11f9c251emr15838202qtb.230.1653304487989; Mon, 23
 May 2022 04:14:47 -0700 (PDT)
MIME-Version: 1.0
From: samir mulani <samirmulani93@gmail.com>
Date: Mon, 23 May 2022 16:44:37 +0530
Message-ID: <CADqa+6zANC_gug=VZtsobF+CBuVyBO1umoEpx+9GCwUNK3iM1A@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] LTP network test case failed.
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
Content-Type: multipart/mixed; boundary="===============1257626751=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1257626751==
Content-Type: multipart/alternative; boundary="000000000000b655e005dfabf20e"

--000000000000b655e005dfabf20e
Content-Type: text/plain; charset="UTF-8"

Hi Team,

The following network-related test cases are failing. Could anyone help me
to understand why they are failing?
*Platform*: SUSE
command used: Under /opt/ltp
-> ./runltp -f net.features

sctp01                                             FAIL       1
Error: sctp01 2 TFAIL: performance result is -342% < threshold -200%
sctp01_ipv6                                        FAIL       1
Error: sctp01 1 TFAIL: performance result is -1887% < threshold -200%
Error: sctp01 2 TFAIL: performance result is -347% < threshold -200%
macsec01                                           FAIL       1
macsec01 1 TFAIL: performance result is -309% < threshold -100%
macsec01 1 TFAIL: performance result is -315% < threshold -100%
macsec01 1 TFAIL: performance result is -298% < threshold -100%
macsec01 1 TFAIL: performance result is -309% < threshold -100%
macsec01 1 TFAIL: performance result is -288% < threshold -100%
macsec01 1 TFAIL: performance result is -301% < threshold -100%

 Following is a common observation for all three test cases:

macsec01 2 TINFO: AppArmor enabled, this may affect test results
macsec01 2 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires
super/root)
macsec01 2 TINFO: loaded AppArmor profiles: none

Is it correct that to pass the above three test cases, AppArmor needs to be
disabled?
There are a few error logs observed in AppArmor logs when the above three
test cases are run,
/org/opensuse/Network/Interface/252.getManagedObjects failed. Server
responds:
May 23 06:42:31 localhost wickedd-nanny[824]:
org.freedesktop.DBus.Error.UnknownMethod: Method "GetManagedObjects" with
signature "" on interface "org.freedesktop.DBus.ObjectManager" doesn't exist


Thanks,
Samir M.

--000000000000b655e005dfabf20e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Team,<div><br></div><div>The following network-related =
test cases are failing. Could anyone help me to understand why they are fai=
ling?</div><div><b>Platform</b>: SUSE</div><div>command used: Under=C2=A0/o=
pt/ltp </div><div>-&gt;=C2=A0./runltp -f net.features</div><div><br></div><=
div>sctp01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 FAIL =C2=A0 =C2=A0 =C2=A0 1=C2=A0 =C2=A0=C2=A0</div><div>=
<span style=3D"background-color:rgb(255,0,0)">Error: sctp01 2 TFAIL: perfor=
mance result is -342% &lt; threshold -200%</span><br>sctp01_ipv6 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FAIL =C2=A0 =C2=A0 =
=C2=A0 1=C2=A0=C2=A0</div><div><span style=3D"background-color:rgb(255,0,0)=
">Error: sctp01 1 TFAIL: performance result is -1887% &lt; threshold -200%<=
br></span></div><div><span style=3D"background-color:rgb(255,0,0)">Error: s=
ctp01 2 TFAIL: performance result is -347% &lt; threshold -200%</span><br><=
/div><div>macsec01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 FAIL =C2=A0 =C2=A0 =C2=A0 1=C2=A0 =C2=A0=C2=A0</div><div>=
<span style=3D"background-color:rgb(255,0,0)">macsec01 1 TFAIL: performance=
 result is -309% &lt; threshold -100%<br>macsec01 1 TFAIL: performance resu=
lt is -315% &lt; threshold -100%<br></span></div><div><span style=3D"backgr=
ound-color:rgb(255,0,0)">macsec01 1 TFAIL: performance result is -298% &lt;=
 threshold -100%<br>macsec01 1 TFAIL: performance result is -309% &lt; thre=
shold -100%<br></span></div><div><span style=3D"background-color:rgb(255,0,=
0)">macsec01 1 TFAIL: performance result is -288% &lt; threshold -100%<br>m=
acsec01 1 TFAIL: performance result is -301% &lt; threshold -100%</span><br=
></div><div><br></div><div>=C2=A0Following is a common observation for all =
three test cases:<br></div><div><br></div><div><span style=3D"background-co=
lor:rgb(147,196,125)">macsec01 2 TINFO: AppArmor enabled, this may affect t=
est results<br>macsec01 2 TINFO: it can be disabled with TST_DISABLE_APPARM=
OR=3D1 (requires super/root)<br>macsec01 2 TINFO: loaded AppArmor profiles:=
 none<br></span></div><div><br></div><div>Is it correct that to pass the ab=
ove three test cases, AppArmor needs to be disabled?=C2=A0</div><div>There =
are a few error logs observed in AppArmor logs when the above three test ca=
ses are run,</div><div><span style=3D"background-color:rgb(255,0,0)">/org/o=
pensuse/Network/Interface/252.getManagedObjects failed. Server responds:<br=
>May 23 06:42:31 localhost wickedd-nanny[824]: org.freedesktop.DBus.Error.U=
nknownMethod: Method &quot;GetManagedObjects&quot; with signature &quot;&qu=
ot; on interface &quot;org.freedesktop.DBus.ObjectManager&quot; doesn&#39;t=
 exist</span><br></div><div><br></div><div><br></div><div>Thanks,</div><div=
>Samir M.</div><div>=C2=A0<br></div></div>

--000000000000b655e005dfabf20e--

--===============1257626751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1257626751==--
