Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9280CE69EAE
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 10:57:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4DBF3DDE40
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 11:57:51 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51CEE3DDE02
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 11:57:37 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=canonical.com (client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=po-hsu.lin@canonical.com; receiver=lists.linux.it)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F34A914057C6
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 11:57:35 +0100 (CET)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AB47B3F162
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 10:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1733223454;
 bh=+paDioP1e7HhpPkUjCXvMTRXQBfQOujYJ3ErMSJwzgU=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=Iloojh+AHvG8Ok70N1XiyXAQhfo65E6gNswpllV8uMS5dz9V2NO98eP9Z2imfNKrh
 5YmsfrNjbiqGD1xMW3ywHT/MU2N2FDNz+T7zLXxA+2se5r8fVGcMRN/1Ya57Q8qwIM
 ABVYdyXb+O5PN/8zgx0RuK7MwInR9D86h4l2vO6UFVVXuZ1IDTMzkKs+S5I2GTIR7G
 0zcl7YEH6kvdqKHINyXVOPTtBADTKd5bbkPVojRhURjNwQq5JnuXnTonCg6B8ecKT8
 jiIGNFgVAplAYNrlVIWe2reSy8Xxvszp2Hvi76EqdlzlCeDeRXDJVTWOa2VHx19Ygw
 I4TQorIFsHRBQ==
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa52b4b6962so347904166b.2
 for <ltp@lists.linux.it>; Tue, 03 Dec 2024 02:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733223454; x=1733828254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+paDioP1e7HhpPkUjCXvMTRXQBfQOujYJ3ErMSJwzgU=;
 b=dZOa1iUsOzCMzykGoRP5LyA0cD2o7lmYWBYUml9ZdfaYgjRQcDm7i9TpZWbSKNMqjQ
 Rhl8kP/p2rIBATtqDbxK+nDeACxGEpaPdZxal5cBCeTAyx4IklrneCC+4lXvh9tlGBDF
 A/PDC69Jt5PwvIF+XhTc4YHWwtMazjBHNVOAtuPMb3HHp6Fr05YGLDzgEw/MOzDNPGW8
 xCxmW2QzIELAgbpC/f4duHhF25ajvxXqYTTawii2rr7W2sDiOoZWfIOtnQeT7U+5sKBc
 KoOfB6VQOglIGAXpMczBWLYU1L2oS9M57du23LTp5t88UJtSFauByVhqT1NKdYAgJA9r
 4Bpg==
X-Gm-Message-State: AOJu0YzGjz3TQ99wnrdqlmbtM256llzj1WHF3n6q/bYXY9YXuSzJ/CZd
 NyWKhpAYuFgyServc8UM2oAWBZfr7E1puvMRSFCl1HkXqFBm2JZ0VKSGoMf3PE/P+YQAjQVRnz9
 SV3118QPZv7dXkn84MY2WybDcVEtXbCtWB1BGTmsniem9CffrqwzwL9wMbMaeoXFeX60iGUWc+v
 tq1Do+N6K+A7352lIzb5L3uKDDpMwT0Ppt8g8dbsITATE/SCyN
X-Gm-Gg: ASbGncu9MbRgnpUCm1I1Xp0XDEqXi4DVJgFxhiGKJ/tnVvX8ry1UBcSyMwySsvfg88b
 56Pop+bah1yE1nrHERkBdkXPAkenGD/Yaq4QaX2xNEB+Y+2l2ZVZGla8mnhc60hwJ
X-Received: by 2002:a17:907:7844:b0:aa5:152a:d0a5 with SMTP id
 a640c23a62f3a-aa5f7d1910amr165315666b.18.1733223454120; 
 Tue, 03 Dec 2024 02:57:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMCy8eVyxzqdsp7fXHrxlwiOAaoSuE/HO+wBuM1cG+ijFWTimgo3+r8nxPzxax7m0YH5U+tW+6sWOfo+LFf5g=
X-Received: by 2002:a17:907:7844:b0:aa5:152a:d0a5 with SMTP id
 a640c23a62f3a-aa5f7d1910amr165313766b.18.1733223453580; Tue, 03 Dec 2024
 02:57:33 -0800 (PST)
MIME-Version: 1.0
References: <20241128072820.364726-1-po-hsu.lin@canonical.com>
 <20241203101007.GC414034@pevik>
In-Reply-To: <20241203101007.GC414034@pevik>
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Tue, 3 Dec 2024 18:57:22 +0800
Message-ID: <CAMy_GT9k=+GerAtXJ+CdA-w4JTh=5yrRjW0cDhwF1hW3JH9h8g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] logrotate: support new rotate debug message
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 3 Dec 2024 at 18:10, Petr Vorel <pvorel@suse.cz> wrote:

> Hi all,
>
> > This test was found failing on Ubuntu Oracular with:
> >     grep -q forced from command line (5 rotations) tst_logrotate.out
> >     failed unexpectedly
>
> > This is because the logrotate debug message has been changed in upstream:
> > https://github.com/logrotate/logrotate/commit/be6a263c87
>
> > Include the new debug message to fix this issue.
> ...
>
> FYI alternative patch which removes the test entirely:
>
> https://lore.kernel.org/ltp/20241203100540.445098-1-pvorel@suse.cz/
>
> https://patchwork.ozlabs.org/project/ltp/patch/20241203100540.445098-1-pvorel@suse.cz/
>
> Hi

I am +1 with removing this test.
Thanks for the review and feedback.
Po-Hsu



> Kind regards,
> Petr
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
