Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96C2ECAAA1
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 10:44:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03BDC3C97EA
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 12:44:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA4523C60C9
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 12:44:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 267601400761
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 12:44:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666608272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zPuQaaekP+pxZVj5jPQMQVEQWP06ii3ynFjmHFh4gTY=;
 b=AeUVyh8TexrrZrHCdsBzXuLsjlTGOZsdF16tpxee+yIxCagoGn/5DCF4+pHg61SHuO52bS
 FpG1bqKETcc7vFK05oQBAG2GexPnJeMn2AwEHxRCtFIDurpBF800wlug3/IHay3SGPmIvN
 Jsd3NphKykeN2uOEnpb3pqXSqAWFyR8=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-232-E4CoO1CuMBarIASXpLAatQ-1; Mon, 24 Oct 2022 06:44:31 -0400
X-MC-Unique: E4CoO1CuMBarIASXpLAatQ-1
Received: by mail-vk1-f200.google.com with SMTP id
 g2-20020a1f2002000000b003af57e81b47so2870305vkg.17
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 03:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zPuQaaekP+pxZVj5jPQMQVEQWP06ii3ynFjmHFh4gTY=;
 b=iOUPhiHEPRPuMzy2WYQrMsUuPAgSRafFa2YxtbVHG28r8A6K29xJLzwk8Gt1gyw+lq
 8Cf8c+OhhO7jaxZH75M56ZalIgpFALvUsgpZuB7TetaUXDvxWeu5IcLbHZvcY4u1RAH5
 PXu+Oz0uS6Lkz3R0DY5u4CH3rxv7002QUyNNgofJjp1qNM4whV4cZmJYAyq5GtxJMqdG
 sGwphyi4QlHnsYm0vVRaKhZK6sKQ0tGY4kbNH6njdjs3S9XibIKtE2f43Bks6gPfMtz2
 xflCkxWlHiX7Hewu1og1klsdP3yxt7kdLTMbNxt8u8KuNQOLAILZodEqTm11aX/I+goy
 peYw==
X-Gm-Message-State: ACrzQf1SI4IBZ/+7lAJj4fBSDXO4qvZgRPWqiwKq2VncB7/e1DPB+iIi
 W7KjuL8myMd56YfFfQd4IOzchFa1Ef34C6tYsujfMPZ3U41U2sYQXAoWlymnm5VlSVxNDF/2iWa
 rnVavm+jz1qM1KIO0BktWtgIhBAo=
X-Received: by 2002:ab0:6f02:0:b0:40b:e4f0:9383 with SMTP id
 r2-20020ab06f02000000b0040be4f09383mr1901585uah.103.1666608270801; 
 Mon, 24 Oct 2022 03:44:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5ICI/oDye9VnlU4BdlV9VPJXShoq53CQBIQ3ULiBW9o+JhbOM16eRbilDtHJvmNesFC5kuk+Lgzm3c3SM/9IA=
X-Received: by 2002:ab0:6f02:0:b0:40b:e4f0:9383 with SMTP id
 r2-20020ab06f02000000b0040be4f09383mr1901573uah.103.1666608270538; Mon, 24
 Oct 2022 03:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221024103836.6394-1-rpalethorpe@suse.com>
 <20221024103836.6394-2-rpalethorpe@suse.com>
In-Reply-To: <20221024103836.6394-2-rpalethorpe@suse.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 24 Oct 2022 12:44:14 +0200
Message-ID: <CAASaF6w5Z7vfYCQ_qLc-MVmY-hEY1q5u-ouKN2WZVKRf4bXgfw@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] cpuid/ptrace07: Only compile on x86_64
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Oct 24, 2022 at 12:39 PM Richard Palethorpe via ltp
<ltp@lists.linux.it> wrote:
>
> Both cpuid.h and ptrace07 contain inline ASM for x86(_64). There is no
> need to compile any part of the test or cpuid.h
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Suggested-by: Martin Doucha <martin.doucha@suse.com>

Acked-by: Jan Stancek <jstancek@redhat.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
