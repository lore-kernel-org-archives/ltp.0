Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68014C433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 13:20:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7831E3CAE7E
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 15:20:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C0383CAE54
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 15:19:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C27A1600640
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 15:19:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665407996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7nHn1aZNl+oDqtci5akrEPGoIoz6RQVOJTyJj2zk3F0=;
 b=datUHZCkzqjQp1Glcq3OtM2urd7H5mEaY6nsuaNz2GkjtQrz1y6a0/kFdcs7rltyc9ov/q
 /aOuRndzLT2xCpGf6kl9uoz0AC77dPEFeQtzNW0r7432du550IV0cRgwUQkuid2v8t/Lu/
 xGnepbdWOL5CzEXikf3G8DYj32nCa80=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-92-dHMsdyo_OCS3zBLz0Dxq5Q-1; Mon, 10 Oct 2022 09:19:55 -0400
X-MC-Unique: dHMsdyo_OCS3zBLz0Dxq5Q-1
Received: by mail-vs1-f72.google.com with SMTP id
 65-20020a670344000000b0039b3020da1bso2452470vsd.3
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 06:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7nHn1aZNl+oDqtci5akrEPGoIoz6RQVOJTyJj2zk3F0=;
 b=CO06uVWdD5KYXLJcygQLEmPV3YyQTrP6SKgKg/oPayzAt11HrIBdi3Fbiw1swvBJft
 OUAkhlxaqfurHPIMDkaF8SynKyR2jnMQQmAWiryQfNzGGxjvS3eNexcaALgQBYxnLCjs
 UIo/vpx4ftE2pyi6pUJF1F6MGydgeA7HmWu7tm/RYRsJvWN4IKBdDQtpGvyUil3cMiP9
 VeCXzmgC37qOE8J91wCSMwRpbFAtLH4gjtVf3EpDzWD7L22NN9VA4GTHRZRMxjmSCQCu
 epe9BHmGz7TSlSgXK/lLCpcxfg2qtzzpHDliBCPkPFNGHoPrjJwXW7MPt5O0F8HppRnm
 PxWw==
X-Gm-Message-State: ACrzQf1tyeKlPYmhaU7gi9LmR8t2GUfNnAFVr3W7jZPNP2uVi7NHKjsc
 ATLMaJhlh9YJCLUGhaOveRI3YuTjaqc5UkWlnCzgKei2YlY/NcDTXdcJ04XDw6EXjYTDE/1d5Dn
 iSS1tRny1kKmmm74ym9t4jn1sVkI=
X-Received: by 2002:a05:6102:6d3:b0:398:6ba5:f6ac with SMTP id
 m19-20020a05610206d300b003986ba5f6acmr8835347vsg.65.1665407994830; 
 Mon, 10 Oct 2022 06:19:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5CUd1RYoidOF9fhlPH3GJO2wjBRaJaowWgmRFKfMAD7Ubtt4gSgiyFaSkjGr0uQCC2w1Kc1vD8shjoGlWWDbs=
X-Received: by 2002:a05:6102:6d3:b0:398:6ba5:f6ac with SMTP id
 m19-20020a05610206d300b003986ba5f6acmr8835335vsg.65.1665407994657; Mon, 10
 Oct 2022 06:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <adf3a4e338625d85401a7d5ec94b33f86a277c18.1665385670.git.jstancek@redhat.com>
 <Y0QVyF43F3ngrU3r@pevik>
In-Reply-To: <Y0QVyF43F3ngrU3r@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 10 Oct 2022 15:19:38 +0200
Message-ID: <CAASaF6wx-zFhbFG6TQ28hj5g9fwwciJQiZ-TXvPDOkDH-+9+Dg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/ioctl03: add IFF_NO_CARRIER feature flag
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
Cc: ltp@lists.linux.it, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Oct 10, 2022 at 2:53 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Jan,
>
> thanks for fixing this. Sven was faster [1], thus merged his commit
> with also your Signed-off-by:

Thanks Petr, I haven't seen his email - I received it only hour ago to
my mailbox.


>
> Kind regards,
> Petr
>
> [1] https://lore.kernel.org/ltp/20221007105727.2303349-1-svens@linux.ibm.com/
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
