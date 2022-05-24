Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E934DC433F5
	for <ltp@archiver.kernel.org>; Tue, 24 May 2022 06:41:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 560F13CAC24
	for <ltp@archiver.kernel.org>; Tue, 24 May 2022 08:41:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50F973CAC08
 for <ltp@lists.linux.it>; Tue, 24 May 2022 08:41:17 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 754176002BF
 for <ltp@lists.linux.it>; Tue, 24 May 2022 08:41:16 +0200 (CEST)
Received: by mail-qv1-xf2a.google.com with SMTP id h18so838076qvj.11
 for <ltp@lists.linux.it>; Mon, 23 May 2022 23:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=qec6D/Mb3H2shKhgI+l0jv7Aml7HMEqhjZmxBlYeEqg=;
 b=mWHCIPaTds8hkXx88nDgkf+fIl/53xYMB2PD5fBdvwFxFsbgHMag0hTZSK8e+Nd7DH
 hhViikTvT9rCFcU0asmaWUoezNUM75BW+xiHVbbfUY6gqOCSeNzsNLTvoY6EDtcoNabx
 XDSiyuhytd+mNFYnYRGyRPkp5agkhl4Pwq8BCvkmfjndmidCWjMlz9Q2Fez9ps8n+Tt3
 Zq36RylsepRKrtD3ZoJDLZ1uvDH7NF70rTjE8e8JHf5R/JWHlLertrINO3yqAQr0fSpQ
 HZHM0o3TS3kOnKcVBQSkX5foNL3X1EquCqVzkbVOAerd+i/tsx82R1Ke2PmbML3VxhXN
 Vvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=qec6D/Mb3H2shKhgI+l0jv7Aml7HMEqhjZmxBlYeEqg=;
 b=SiIFTFi5zP4JJ0HO2osVcP6WNd0prLl0c5xJyRzUrRJO3X5MDA4wBDTV8IUFEc+fjr
 03FYNKLj3p1QJO5G7OrVM/lSGM7E8baEBCCSz4gvn0o+CmDblzvQ/zTOcZ2m/mTMFCiu
 RtbhIoZwXXFKWU8TxusnmguytczcNP1Z04IMp+RzG+U4hOWUvclikhPlFsS00sVcgrIx
 RnaBsESa6pp6sWgoNGbYVOoGoXTDRLCjCLQ52VAgugKXKfPmJg/z/RRSIJkofjN8vY45
 Ln8pnEfwnQ+4V+omrodEkyo4ECKBN6ohTLcj68FiYtFbLWQLh7JbnLWUiA5/qOt4bBaX
 WOkg==
X-Gm-Message-State: AOAM533oRuFFcbk0R9F4qPW6NE7Cwzc8QfnlK3dbx5yObAvf3TmWRWac
 uAnZwdkXm5t/aaaWMub86XskbxA+n0DUPsBi+1SQoOGCQd5rIg==
X-Google-Smtp-Source: ABdhPJzs2j/EhWQ6Oka7RQl4I5ixBIotTB2m607sY5Uv82obJXb3xhBr/CmNvkcRIXbAfjoof3hrGWal34dHZnsxqIE=
X-Received: by 2002:a05:6214:1d0d:b0:462:2637:ada5 with SMTP id
 e13-20020a0562141d0d00b004622637ada5mr9940246qvd.98.1653374475112; Mon, 23
 May 2022 23:41:15 -0700 (PDT)
MIME-Version: 1.0
From: samir mulani <samirmulani93@gmail.com>
Date: Tue, 24 May 2022 12:11:04 +0530
Message-ID: <CADqa+6wf1V66p=sLa2bWz0ayL+E9Kvn2gPA1nUEx9tdxR6tLsQ@mail.gmail.com>
To: ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>
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
Content-Type: multipart/mixed; boundary="===============1467976985=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1467976985==
Content-Type: multipart/alternative; boundary="0000000000004514e505dfbc3e09"

--0000000000004514e505dfbc3e09
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
Samir M

--0000000000004514e505dfbc3e09
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Team,<div><br></div><div>The following network-related =
test cases are failing. Could anyone help me to understand why they are fai=
ling?</div><div><b>Platform</b>: SUSE</div><div>command used: Under=C2=A0/o=
pt/ltp</div><div>-&gt;=C2=A0./runltp -f net.features</div><div><br></div><d=
iv>sctp01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
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
>Samir M</div></div>

--0000000000004514e505dfbc3e09--

--===============1467976985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1467976985==--
