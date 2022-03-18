Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF42C433EF
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 06:15:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 770DD3C9477
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 07:15:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85E673C8CBE
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 07:15:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1256F100096A
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 07:15:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647584112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E+NqIayJP5HARMCm3bG0+eQak9ofhd57dC4pi55d/r4=;
 b=Wg1B2oLJzLuYfZLWc8HLY7v3uMsromXs1pePBl+a4foCpm7gUN0GJDCCsueKLDbcLw52O6
 DUo0QaSLrmQ9G3P3yUt1e1wJ7i8Z+q1X6k1hnU3cTuFZrNIDiJCMHznWTMLOJiAdO8GMXq
 pCEh/nVkOPMNJgS0RPK0YJ/dJ9vmPso=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-YbWtT7BnMG-hh1gD_lNb8A-1; Fri, 18 Mar 2022 02:15:08 -0400
X-MC-Unique: YbWtT7BnMG-hh1gD_lNb8A-1
Received: by mail-yb1-f198.google.com with SMTP id
 y10-20020a5b0d0a000000b00633b9765410so975163ybp.18
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 23:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E+NqIayJP5HARMCm3bG0+eQak9ofhd57dC4pi55d/r4=;
 b=iU6dpTZU4i99s5rWmlgNmZ76uuensXoly883Pf54soEqYJMbnxSnOEA9CREy1sF0xy
 v70pCfooZMXj1X7Z8b6D/ruNuklv6rtBWTaZ5hpO4Jtq7CabZ10JXL22tSWT0E7ub67V
 1b4wa3tjU2ABpIvCNI6lJT5VpzwDB7nOulx3Bp4VsgoMR6T7k/RJ5v5HVTAnT5lmBT6o
 dEAuhn2l66Ji2uRITLaHodKfU+o3zbJenq9dTYZgM+AUkRihIO/0QKhrBv2Xvx2e3Y0m
 uMp+5sX++Rdb+QjVMPIBdoyN0TYzEugLjXPIoARfogkdzd5U5KqjkAd60C3n/5KwIO5f
 tl+A==
X-Gm-Message-State: AOAM5301qv6mpguRZMpp7fckkp8FVBHYdy0KEffQjeLagU/TmYLe2ORQ
 irwedBxLNbBfl2v4B/JwIOSbim2DempWALexT7LgFKV5UNofDYUdJ+0hEgQvlGTS9heKHOeQpmn
 eG7oVOREzhfF7Ybp+BddaUvwNfyI=
X-Received: by 2002:a05:690c:314:b0:2e5:9e04:7ed3 with SMTP id
 bg20-20020a05690c031400b002e59e047ed3mr9964713ywb.370.1647584107807; 
 Thu, 17 Mar 2022 23:15:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDeM0Ha/Rd8fYmUkyo0pyn/BHQ+2D6TGvdNt9wfdM1isR2/mzygf/Yy5TmzMD7hU+12NyBVJJqDlOu4aCkocs=
X-Received: by 2002:a05:690c:314:b0:2e5:9e04:7ed3 with SMTP id
 bg20-20020a05690c031400b002e59e047ed3mr9964701ywb.370.1647584107430; Thu, 17
 Mar 2022 23:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220316150429.2873-1-pvorel@suse.cz> <YjH9dDef3w7Iu3vG@pevik>
In-Reply-To: <YjH9dDef3w7Iu3vG@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 18 Mar 2022 14:14:52 +0800
Message-ID: <CAEemH2cB+k+dbS_N=S0jGs9H3ct1wBUYhuaR-+V7wRVtydVN_g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 1/1] ci: Ubuntu xenial -> bionic
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
Content-Type: multipart/mixed; boundary="===============1622418649=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1622418649==
Content-Type: multipart/alternative; boundary="0000000000007615ee05da7811a5"

--0000000000007615ee05da7811a5
Content-Type: text/plain; charset="UTF-8"

Hi Petr,

On Wed, Mar 16, 2022 at 11:08 PM Petr Vorel <pvorel@suse.cz> wrote:

> Tested
>
> * bionic
> https://github.com/pevik/ltp/actions/runs/1993375270
>
> * focal
> https://github.com/pevik/ltp/actions/runs/1993443143
>
> And as I noted xenial still works. I wanted to avoid false positives when
> repos
> get down, but obviously we have 4 years time (ends in 01 Apr 2026).
>

+1 for bionic. (we can do an upgrade to focal when bionic reach EOL)

According to the release cycle page[1] of ubuntu ORG, the
Xenial (16.04) version is being deprecated, which means
no hardware and maintenance updates anymore. But we (LTP)
still merging new features and regression testcases, I'm afraid
that will bring some known failures in Xenial then to cost energy
for debugging.

[1]https://ubuntu.com/about/release-cycle

-- 
Regards,
Li Wang

--0000000000007615ee05da7811a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Petr,</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Mar 16, 2022 at 11:08 PM Petr Vorel &=
lt;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">Tested<br>
<br>
* bionic<br>
<a href=3D"https://github.com/pevik/ltp/actions/runs/1993375270" rel=3D"nor=
eferrer" target=3D"_blank">https://github.com/pevik/ltp/actions/runs/199337=
5270</a><br>
<br>
* focal<br>
<a href=3D"https://github.com/pevik/ltp/actions/runs/1993443143" rel=3D"nor=
eferrer" target=3D"_blank">https://github.com/pevik/ltp/actions/runs/199344=
3143</a><br>
<br>
And as I noted xenial still works. I wanted to avoid false positives when r=
epos<br>
get down, but obviously we have 4 years time (ends in 01 Apr 2026).<br></bl=
ockquote><div><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">+1 for bionic. (we can do an upgrade to focal when bionic reach EOL)</d=
iv><div class=3D"gmail_default" style=3D"font-size:small"><br></div>Accordi=
ng to the release cycle page<span class=3D"gmail_default" style=3D"font-siz=
e:small">[1]</span> <span class=3D"gmail_default" style=3D"font-size:small"=
>of</span>=C2=A0ubuntu<span class=3D"gmail_default" style=3D"font-size:smal=
l"> ORG</span><span class=3D"gmail_default" style=3D"font-size:small">, the=
</span></div><div class=3D"gmail_quote">Xenial (16.04) version is being dep=
recated<span class=3D"gmail_default" style=3D"font-size:small">,</span> whi=
ch<span class=3D"gmail_default" style=3D"font-size:small"> </span><span cla=
ss=3D"gmail_default" style=3D"font-size:small"></span>means</div><div class=
=3D"gmail_quote">no hardware and maintenance updates<span class=3D"gmail_de=
fault" style=3D"font-size:small"> anymore.=C2=A0</span>But we <span class=
=3D"gmail_default" style=3D"font-size:small">(</span>LTP<span class=3D"gmai=
l_default" style=3D"font-size:small">)</span></div><div class=3D"gmail_quot=
e">still merging new features and regression <span class=3D"gmail_default" =
style=3D"font-size:small"></span>test<span class=3D"gmail_default" style=3D=
"font-size:small">cases</span>, I&#39;m afraid</div><div class=3D"gmail_quo=
te">that will bring=C2=A0<span class=3D"gmail_default" style=3D"font-size:s=
mall">some</span>=C2=A0known failures in Xenial<span class=3D"gmail_default=
" style=3D"font-size:small"> then to cost energy</span></div><div class=3D"=
gmail_quote"><span class=3D"gmail_default" style=3D"font-size:small">for de=
bugging</span>.</div><div class=3D"gmail_quote"><div class=3D"gmail_default=
" style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D=
"font-size:small">[1]<a href=3D"https://ubuntu.com/about/release-cycle">htt=
ps://ubuntu.com/about/release-cycle</a><br></div><div class=3D"gmail_defaul=
t" style=3D""></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></d=
iv></div></div></div>

--0000000000007615ee05da7811a5--


--===============1622418649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1622418649==--

