Return-Path: <SRS0=89zk=N5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABF2C433FE
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 02:40:49 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650D6610C8
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 02:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 650D6610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 790203C9782
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 04:40:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7C4E3C2849
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 04:40:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F0A00140054E
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 04:40:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630982435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hTsh7OT8ZGEUXjTnY/FkjRRaK3xBvU+xKiTE9/coxhk=;
 b=T2iSimBcfKOaPse76TT66uFlaEzmGelLb6L5rOE0IzBPoPIJk4Zg/xEUQR/1rYe7Lf5cJ4
 2OaDjD9dphTuBahaS3G2aO5qlcvD+GKe1ihv8wq6MjDJ3RXbOI3utCuRlqN0llhMAspxmx
 F2lPSUEpET4IZEtpqOAs3AOXhjiLD+M=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-9zYtNvaMO2SIzB1kSeAbYQ-1; Mon, 06 Sep 2021 22:40:34 -0400
X-MC-Unique: 9zYtNvaMO2SIzB1kSeAbYQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 f8-20020a2585480000b02905937897e3daso9973637ybn.2
 for <ltp@lists.linux.it>; Mon, 06 Sep 2021 19:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=hTsh7OT8ZGEUXjTnY/FkjRRaK3xBvU+xKiTE9/coxhk=;
 b=fL467WzcC4gw9XrAxfTrHLKdnt1iEHe+l0ovOYs3xstTUmIDyp2CW44a/KYq36hIQB
 K9WSELENjcNZ8vysFalZkXVhYpX+JHznib1EZYDLvav26m1Ol36Of+PGTm6xXFys4/pv
 LKKCehqy6S0w25rS9OpaypydVT/pFdnKn7srEcaWouHLeYKi8eHG0TOjtt7H3Ttf0XXc
 bdtO4QAlKxCIclhQOBE6QCmFdH9qhByDa7B5Mf3NgNmQZNWFhhZAFjB+3PAL491wSjXh
 ojHnc8UoDtnD4VY90zOSYXQPwF6GWkOdbVyxcPMQ34qLqzUQFmXe5b5Ifck7rOZpKwut
 avMQ==
X-Gm-Message-State: AOAM533YWIMtBvzi2IXVaKeqgx6OvZrlP2Bb86K1egH7BXHKkL444c5w
 8wpwBvZkdztBFVJ8hArwqhzXzjh8ls64hq68w2CaAB6eUr7a/dLAwJl8z2TACxHLqIdaNPEzi/K
 6Sa5gBFoE3D85ncMpRZSFyx/cktQ=
X-Received: by 2002:a25:b941:: with SMTP id s1mr19526792ybm.304.1630982433407; 
 Mon, 06 Sep 2021 19:40:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFa5hyAi8uUUuqDbG2DArrqK8s7A+isieh39Lwv2ISVmpVBP+rUWRnNXNJFWrPegLvESrlJtAYO58SXuxd8F0=
X-Received: by 2002:a25:b941:: with SMTP id s1mr19526767ybm.304.1630982433144; 
 Mon, 06 Sep 2021 19:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210817104625.2559362-1-liwang@redhat.com>
In-Reply-To: <20210817104625.2559362-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 7 Sep 2021 10:40:21 +0800
Message-ID: <CAEemH2fOWt1SjoTyqcWFkSyGf_S28FsPreLrKcUvOHu0pRz9OQ@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] fallocate05: increase the fallocate and
 defallocate size
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
Content-Type: multipart/mixed; boundary="===============0396410915=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210907024021.HIjLXUNx18r7aC84EWhgJl8mGw0s-vIfdx1kbngpYgw@z>

--===============0396410915==
Content-Type: multipart/alternative; boundary="000000000000901d7005cb5eb029"

--000000000000901d7005cb5eb029
Content-Type: text/plain; charset="UTF-8"

Ping~

This patch is only to increase the test blocks to make it robust,
it's no harmful and actually changes nothing from code logic.

I will merge this if no objection by the end of this week.

-- 
Regards,
Li Wang

--000000000000901d7005cb5eb029
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Ping~</div><div class=3D"gmail_default" style=3D"font-size:sm=
all"><br></div><div class=3D"gmail_default" style=3D"font-size:small">This =
patch is only to increase the test blocks to make it robust,</div><div clas=
s=3D"gmail_default" style=3D"font-size:small">it&#39;s no harmful and actua=
lly changes nothing from code logic.</div><div class=3D"gmail_default" styl=
e=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-=
size:small">I will merge this if no objection by the end of this=C2=A0week.=
</div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature=
"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div=
></div>

--000000000000901d7005cb5eb029--


--===============0396410915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0396410915==--

