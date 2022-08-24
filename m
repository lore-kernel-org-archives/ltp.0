Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2980EC00140
	for <ltp@archiver.kernel.org>; Wed, 24 Aug 2022 13:35:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F1193CA429
	for <ltp@archiver.kernel.org>; Wed, 24 Aug 2022 15:35:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C38F3CA35E
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 15:35:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 63D83200C17
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 15:35:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661348099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UE2QA2XIdF1RHMgbXsPZbGldDscdFATUDjHiZIB63UQ=;
 b=Hu8+VCE8J1iS1kprxT3Zjyl4p2nApPlYWkPzyPZ7rGKTZTYiXtcu3Y52fRPYxPa6BRVS+N
 xnM+VF19Pww8FPgiP6Ef3C2wkCy/X/QRytX3IwoE9u/UL2OJuAuWhQ1Mu59N6XoUONk9no
 L3yum1Vgu/WnLcLMqA1gPttAm9e+DSg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-250-trGe9BdxPGm6-LnXRV9Jsw-1; Wed, 24 Aug 2022 09:34:58 -0400
X-MC-Unique: trGe9BdxPGm6-LnXRV9Jsw-1
Received: by mail-lj1-f199.google.com with SMTP id
 e1-20020a2e9841000000b002602ebb584fso3211204ljj.14
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 06:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=UE2QA2XIdF1RHMgbXsPZbGldDscdFATUDjHiZIB63UQ=;
 b=nxa/JjxYGCJ39ozDAfUOMZPOvxN23tERsQOLGgGonh7ga0DjmzWsWPVOjd+uw3puoV
 H9IadmDjVhUdLHf524uzPI1tV76fF7rKd+uWZ5n2tROEHtxa4dHaYX+ouF9R0VDNtvcb
 tSwFvg2BZuonHUdgB6YJLOL/7d5DahgA1kxvzpS8bQcRHl9MLRfq1MD4jHSWPTdoyVG0
 5Fe8gGRxkURlIL8/NHt0W/eA087QZN2aFatmqG3UhZsiYV0T6j/XZpmMU/ap3OJIdEmM
 VJX/zE/Xw4P1WLHJrrMRp2sYh2HQvGff6VxSphjn4X+KM5SoUSJqOguYQxBPLfI3I8P7
 r8dA==
X-Gm-Message-State: ACgBeo0KpxNs5Iz19k5OWeaohzdFfBhAjVcmAy6cA4bFX5z8c8ybhUkM
 RbXX4vky6dUGF+brJtdwVzhKspBcRTT1nTmpdLlp30cTgbO9zaiA4U7i1YIBSSxohth3uFyF3iY
 EXn2vGjCMvm7bkrtyJsKJyQnFeg8=
X-Received: by 2002:a2e:b282:0:b0:25e:46b6:ff33 with SMTP id
 2-20020a2eb282000000b0025e46b6ff33mr8065954ljx.503.1661348097316; 
 Wed, 24 Aug 2022 06:34:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4cF9XX7+pr+QOTkFLUybS8dyJvK+e/e0IgCTmG//GQT8c/pftjBOEty6fWkbQpMiVPGfNXyazprtF680HnlNE=
X-Received: by 2002:a2e:b282:0:b0:25e:46b6:ff33 with SMTP id
 2-20020a2eb282000000b0025e46b6ff33mr8065945ljx.503.1661348097109; Wed, 24 Aug
 2022 06:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220824123240.20092-1-pvorel@suse.cz>
In-Reply-To: <20220824123240.20092-1-pvorel@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 24 Aug 2022 15:34:40 +0200
Message-ID: <CAASaF6x8M516FiOqoJF2AiSceMgFJWsDt-HCE19G9jW=dLiFkA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] github: Add issue template
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
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Aug 24, 2022 at 2:32 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
>
> this effort is driven by reports like [1]
> You can see the result on my special fork [2].
>
> I considered to mention ML, but in the end I didn't.
>
> Kind regards,
> Petr
>
> [1] https://github.com/linux-test-project/ltp/issues/created_by/anilbp
> [2] https://github.com/pevik/_ltp_test_issue/issues/new
>
>  .github/issue_template.md | 5 +++++
>  1 file changed, 5 insertions(+)
>  create mode 100644 .github/issue_template.md
>
> diff --git a/.github/issue_template.md b/.github/issue_template.md
> new file mode 100644
> index 000000000..caf8907da
> --- /dev/null
> +++ b/.github/issue_template.md
> @@ -0,0 +1,5 @@
> +Issues are *not* support forum.
> +
> +Bugs in the tests should be reported to your Linux distribution.

Did you mean here "bugs in distro/kernel"?

> +
> +Issues are *only* for reporting bugs in tests.
> --
> 2.37.2
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
