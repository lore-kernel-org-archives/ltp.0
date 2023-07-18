Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D4AEB64DA
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 11:48:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 140743C9A2E
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 13:48:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E77D13C9A2E
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 13:48:06 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 55EA51000D8B
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 13:48:06 +0200 (CEST)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51e6113437cso7596511a12.2
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 04:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689680886; x=1692272886;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zlIs2dsVoMlsB/D5YESYBz8KY0+SG3lYxZZPQTzebVI=;
 b=frcHAFDOWpjvuR36HpnIiI72u46e2CI0GU5+TvRTYYrKYhzpHE1jrPxYSJpHb1WZ5u
 Rjvu3QuVwgrssy1PGJBfjXSgeoHvbLEBcq6o9pGZTRy8rXryEJkmJsKGrX44KuirUX/S
 Bjbra8AqzdhaNbsmCtLTLmR2L1UK9PwUFAEHGuIFjm5a+LQijfaIBIIj4z1HqpkM+Lwo
 pW0Ex8ONIDt9E45A2Zlex2R3W6Ho7WHjQA6dNGePcE9pod5uKo5N7m3vvl7MrKq3gYcy
 cy2AZU6ewullzS2mWYg3aXPuoOjS4HFCJ2vDeikr/9IrtasI5b+MryhNPKGWkJ6gEqSU
 I9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689680886; x=1692272886;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zlIs2dsVoMlsB/D5YESYBz8KY0+SG3lYxZZPQTzebVI=;
 b=iriMch1PlchjfTFkNu06NiT5OewTh9Uxh8VIxUGNfz412v0rJ8K5x8BODZvG2DNv67
 YI75An3ltFjfjDwfr12a/S4qVJX3Zrlfkq7tfT/QrNV+dUQh+/DZrcMLhL6R1flP/ddo
 FP7dSgC6AHq2BCzokCdD89aUcUhX6arqTI8q99eZBHtAerL9z9Boot1k9S2TVx+LO+6Z
 Wnjvrf75hhgVYVVqlFjojvwMo8hr1jD6cIovESiwdkqsuEPDpN8dtiLSt8yQLQ4v0ByZ
 A98xIcpVWgrNdOPWP44qaSM3PnussMMJVpugZ2lSoETGFotNyy++kek2uYDHuL79ER38
 LYvQ==
X-Gm-Message-State: ABy/qLZq05P1kOWLWvG5amKoq1sq6udJuXvLJLl9+KRZ3LuOeLwtdWh1
 zvbxcp+mgx38+E4RF0kCC8O0nPrUm9tFAYNDgPruAw==
X-Google-Smtp-Source: APBJJlFOb4s90Dp23tihg0GBLYaT6KbaJU1ZWY/54YeFcSGLkmVWc1J7vMYdT7KOfZGpbIWxsV9ACDuKXIxwSpFDJ64=
X-Received: by 2002:a05:6402:457:b0:521:8bf7:bd32 with SMTP id
 p23-20020a056402045700b005218bf7bd32mr4736081edw.19.1689680885550; Tue, 18
 Jul 2023 04:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <87o7kbnle9.fsf@doe.com> <87jzuyobch.fsf@doe.com>
 <20230717213424.GB3842864@mit.edu>
In-Reply-To: <20230717213424.GB3842864@mit.edu>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 18 Jul 2023 17:17:52 +0530
Message-ID: <CA+G9fYt4dDCw+nLvUGcX-JHG6fvyA8qsu1Caqdog53DW8MO4Mw@mail.gmail.com>
To: "Theodore Ts'o" <tytso@mit.edu>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] next: kernel BUG at fs/ext4/mballoc.c:4369!
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
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 linux-mm <linux-mm@kvack.org>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 18 Jul 2023 at 03:04, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Jul 17, 2023 at 08:04:54PM +0530, Ritesh Harjani wrote:
> >
> > These can basically trigger in extremely low memory space and only when
> > such ranges exist in the PA rbtree. Hence, I guess it is a little hard
> > to tigger race.
>
> Ritesh, thanks for looking into this!
>
> Naresh, how easy is it for you to trigger the BUG when using LTP?  I
> did two xfstests runs using "gce-xfstests -c ext2/default -g auto",
> one on the ext4 dev branch, and one on linux-next 20230717, and I
> wasn't able to trigger the BUG.
>
> If you can trivially trigger it using LTP (perhaps with a low memory
> configuration in your test setup?), that would be useful to know.

In our setup it is not easy to reproduce with the same device and
same build on x86_4 and arm64 juno-r2 connected with SSD drive
and running LTP fs testing.

LTP fs_fill is triggering several ENOSPC before getting this reported
kernel BUG at fs/ext4/mballoc.c:4369!

The reported issues are not noticed on latest Linux next tags.

- Naresh

>
> Cheers,
>
>                                         - Ted

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
