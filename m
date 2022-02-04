Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904B6C433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 13:30:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29B363C9ABC
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 14:30:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FAB23C70EC
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 14:30:09 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C9AB81001141
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 14:30:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643981407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v+eNq5uaI/eASnAIqIcgutbuvU96IBWgXC/XrViu/lQ=;
 b=WEXSndmBk7xvdPsAS/lF64cTjdCqZmtb9X7zS6gGS0Z1Xh3q4kJ92yAigtmUbtF1/e1cud
 Torvpu4KLTNuq6PQkKzM7majEUNkEto6SEol2pdAPjojEsJX5c+wmegeo3ms4NxgV6BbRh
 /whEQjlfZYm6vPiKa/U2T8kiShq9EQM=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-TaX9bQ9IM7q0U7NDc7rLkA-1; Fri, 04 Feb 2022 08:30:05 -0500
X-MC-Unique: TaX9bQ9IM7q0U7NDc7rLkA-1
Received: by mail-ua1-f71.google.com with SMTP id
 i47-20020ab015b2000000b0033bdcb385f5so3512544uae.12
 for <ltp@lists.linux.it>; Fri, 04 Feb 2022 05:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v+eNq5uaI/eASnAIqIcgutbuvU96IBWgXC/XrViu/lQ=;
 b=HYkwSL/2TTTVDLRoUH30FgIy5xOs30rRZ39maXXGXhkixxmYibP73ghdeRzZfx5tlv
 PrWyezdpr2iRGg62HPh7VIZDe0uRHPLZqdD/XNVT6JvBQHRtmLwzf+q+4KH8f33Xiism
 tPnuHFQdCNE1UuWxz4nPPDTqn6nOFrIsxxzjKRDkAkx2o1IWq48B75y6F7N0AVRZEHoX
 kattdr5pEz9eSkhJJe0DxeT+DzeOZh7eBpL5X3D0ppVa54xaqa8n87wx0Vkn4IQbBLxM
 ftAHnUix7tf6q6UDDB5TD4V/Ck7Qv8WFmNwJgNNUf6H0X729jUmKL+eumTFVmldst+lF
 L77A==
X-Gm-Message-State: AOAM533+yOW9X+MiO1Pv2glyWwmKMKuu+xYyNfLuafhgsmhbzguw3bv7
 ojP2kwnXjLXverdk4Nv8p9JX97ChbI4GqfdFPoVKJTyO3Gcc+3AslcwmAG5zSuDO7fYCNeNgHSj
 vnh1T2LlXUEhsRTLFS6iGxXP5fKU=
X-Received: by 2002:a05:6102:c11:: with SMTP id
 x17mr824414vss.57.1643981404805; 
 Fri, 04 Feb 2022 05:30:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyaKr50xKw+4RYig79nuurWVcWzvrtcIEHRT3ftuZe21sDmiYvpXNHX+qheh87skuSONWZyo8/Qk9HRRhef2b0=
X-Received: by 2002:a05:6102:c11:: with SMTP id
 x17mr824408vss.57.1643981404569; 
 Fri, 04 Feb 2022 05:30:04 -0800 (PST)
MIME-Version: 1.0
References: <YfwVcwpZU/lusVlC@pevik>
In-Reply-To: <YfwVcwpZU/lusVlC@pevik>
From: Veronika Kabatova <vkabatov@redhat.com>
Date: Fri, 4 Feb 2022 14:29:01 +0100
Message-ID: <CA+tGwnk9YO+0Df_BRqjOU4W5y-TgdJNE3PdnaB5RWWLRF0=8cQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkabatov@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] SCTP testing
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
Cc: linux-sctp@vger.kernel.org, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Feb 3, 2022 at 6:51 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi all,
>
> we've been just discussing, which repository should be hosting SCTP tests [1].
>
> Do you use these SCTP tests? If yes, do you use it from LTP [2] or the official
> SCTP kernel developers repository [3] ? If you use integrated to some testing
> framework, would it be a problem if repository changes?
>
> Also, do you use LTP network tests at all?
>

Hi,

we're currently not running these, but if I may offer a suggestion from my
experience: It's easier for people to pick up testing when it's already a
part of a test suite, rather than a separate test that they have to figure
out a) even exists b) how to run it

There are large test suites like LTP, kselftests and xfstests that most
people are aware of, but then you get a lot of smaller tests or random
scripts that, unless you're already familiar with the subsystem or get
them linked directly, people won't find easily. And if a CI system wants
to start running those tests, they most likely need to create a wrapper
to handle test specifics, while the enablement via a larger test suite
is way easier (as they can already handle it and all that's needed is
to enable that specific test subset).

Consolidating smaller tests into LTP or kselftests, where applicable,
would make the testing process more streamlined and easier to follow
for new folks too, as the expected testing could be unified across
subsystems and there would be no surprises.


Veronika

> Kind regards,
> Petr
>
> [1] https://lore.kernel.org/linux-sctp/YfpnVfrto4Elshy5@pevik/
> [2] https://github.com/linux-test-project/ltp/tree/master/utils/sctp
> [3] https://github.com/sctp/lksctp-tools
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
