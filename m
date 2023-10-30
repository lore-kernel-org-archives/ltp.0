Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F65AC4332F
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 08:22:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC1A43CCBCC
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 09:22:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D6B93C848A
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 09:22:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 08127602510
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 09:22:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698654161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jFFTkaVRoyOx6E4oslOw0sGw+0QbPrRUQnbRO9raHJ4=;
 b=OMe9gc4QBhtAltT//8RNYrrE9o3HqnOoEMj7rpJkHNY8XjM7Y55F6lHG+t3U8QyrjtlaKy
 8CPxFD9j6eEIONCbnKKcBvB0Gx0iflNmOUZtumpVzfQdcewHQts58G1kZbmbSWkEGQCaoK
 7CzwKO3SpvHwVYXpqd/JCevCDdCTiQM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-jTmNsNBjMvyNPt7T1drwGQ-1; Mon, 30 Oct 2023 04:22:28 -0400
X-MC-Unique: jTmNsNBjMvyNPt7T1drwGQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507be692ce4so4393246e87.2
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 01:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698654147; x=1699258947;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jFFTkaVRoyOx6E4oslOw0sGw+0QbPrRUQnbRO9raHJ4=;
 b=KF6sG8FnvE2tYxDGpcKJrAuF6RlEViirwTAisWutqyd1IojhJvlBC7EL4fVF1qU5ID
 OaksiTc81uymRrVrVxeZiC/qOWwYDr2FeZaAr/6OzLqUVDAPI6h0grJuRY6hhL1/qIbd
 EeFR36mfkMDzY/rVWUZnT7sl0Ybe0ObPI3QNuYaEqy/M9MilV7U9DkatscFhyo0vMxyy
 vGg97WVJNdUNUYOgRhq1OHsyLMOWIB/9jXoiqsZbq+vaoj5W58ddIHOBsbTwFpwngqN2
 1oJvdZrZqfHFkOLc/aRssDWbhVJtLUPlauRwDMOEHQiDubKUN9AuniL6ksT4LalbVfP+
 aChA==
X-Gm-Message-State: AOJu0YzAuj5Evnfsp679RxjfQf8sw+F62PfssLmw22HNsleHOiMtF3XN
 oHCjOscSt2B/jCzBlRwT1UiD/XmLfGt7ks3dFfl628c114lGEOjzrLnIrUuMb5bNE8oOL4xEDBV
 l5XEy8RdAHIVXW6a4jNQi7hpfl2s=
X-Received: by 2002:a19:f713:0:b0:507:a33f:135d with SMTP id
 z19-20020a19f713000000b00507a33f135dmr6490855lfe.4.1698654147376; 
 Mon, 30 Oct 2023 01:22:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgOV/35SraJ5HgLw7oc41AZpDkO6hiHZ7mGCw33XfMGBdCnLZzkEb+oMzN7E0US4lZNnnyfTQC7J0N8TQxyig=
X-Received: by 2002:a19:f713:0:b0:507:a33f:135d with SMTP id
 z19-20020a19f713000000b00507a33f135dmr6490837lfe.4.1698654146880; Mon, 30 Oct
 2023 01:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231027174322.710674-1-pvorel@suse.cz>
 <CAEemH2fuA+YfFGNzSResMprEeT8+zhO1S_2Kscc14d2T828YYw@mail.gmail.com>
 <20231030072819.GA9167@pevik>
In-Reply-To: <20231030072819.GA9167@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 30 Oct 2023 16:22:15 +0800
Message-ID: <CAEemH2eUQxxQAh-Ln_hyzu_C_AL36fXsjbKZJqC3rcHsASgQgQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] compat_16.mk: Cleanup INTERMEDIATE object
 syntax
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
Cc: Stanislav Kholmanskikh <stanislav.kholmanskikh@bell-sw.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > > -%_16: CPPFLAGS += -D$(DEF_16)=1
>
> Not related to this effort: shouldn't we convert all CPPFLAGS to CFLAGS?
> Or the
> LTP build system it just prepared to the crazy ideas about using C++? :)
>

No, I don't think so. I guess you memories it confused with CXXFLAGS :).

FYI:

CPPFLAGS (C PreProcessor Flags) are options for the C preprocessor,
which is the first stage of compilation where macro substitution occurs,
and conditional compilation directives are processed. These flags are often
used to specify additional include directories.
    e.g. CPPFLAGS="-I/some/include/path"

CFLAGS (C Compiler Flags) are options for the C compiler. These
flags are often used to specify various compiler settings, such as
optimization level, warnings level, and debugging information.
    e.g.  CFLAGS="-O2 -g -Wall"

CXXFLAGS (C++ Compiler Flags) are options for the C++ compiler.
It can be used to define options like optimization levels, debugging
information, warning levels, and more.
    e.g.  CXXFLAGS="-O2 -g -Wall"



> > Seems we need to keep this one line, otherwise it can't transfer the
> > 'TST_USE_COMPAT16_SYSCALL=1' macro in the compilation.
>
> Ah, thanks!
>
> > The rest looks good to me.
> > Reviewed-by: Li Wang <liwang@redhat.com>
>
> BTW I'm going to push it with you as an author + with your Signed-off-by:
> tag
> (you're effectively the autor of the code) and with my RBT.
>

Sure, thanks for doing this for me.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
