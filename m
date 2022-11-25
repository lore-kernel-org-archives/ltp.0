Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76022C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 02:00:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDC543CC966
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 03:00:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F8373C0123
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 03:00:20 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CE87A6010EA
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 03:00:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669341618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AMW9WWzJ4d0VxMXQLKWAI+TgUPgKD4F4fdarrLZtsbQ=;
 b=a/pfbMpcLu+fIPzclNvgbwd8sGPE8YkjHBzQ/S2XaCSOzTRo75Vii3Zqqr0G2DJOe7OUbX
 NJZYNxPa3LtLKun650D1Ic2B3hkoR9DgsDXiZqKgsDV7DrtnotghYpdGHQaLe8SwKsxrCG
 B2QsA8/k9y+Fz17YHqODg9I5g1lcUk0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-44-shc0BE-oPS6bEdhnty3bsg-1; Thu, 24 Nov 2022 21:00:16 -0500
X-MC-Unique: shc0BE-oPS6bEdhnty3bsg-1
Received: by mail-wm1-f71.google.com with SMTP id
 c126-20020a1c3584000000b003cfffcf7c1aso3449303wma.0
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 18:00:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AMW9WWzJ4d0VxMXQLKWAI+TgUPgKD4F4fdarrLZtsbQ=;
 b=tiWwo3euLvY5JGKoVe+iHksY4C9nCCo9mlsJPIfXaZtutd7psbjIbqfnQZ7qPhn37E
 uA+j1R0x5AN8YLwOrn2fvFh7UGs+fB/yDqhBTH9A4XrVnU7FzxyqAaQGnRMTXxeL6ONl
 7rZtnOau8JKA/OhJKgwreiKVzfiQmxX51h6ig3Gxb6kTwFpdrK+4C2agx8oGwojBm/A5
 VVdlvOp0pgjDGmYBYFuC4x/alVKvbiyVZ6ij3jTHPNH7SIKjR+XocloM06O2B0hIwkIu
 nYmVQibeT36/2jowiZxmRFgdcKWE44WHJMNS+XKQfnMbeMJVgxYfpf3IPL0I99QzHtI5
 pdrA==
X-Gm-Message-State: ANoB5pkCx3lcz6dcNGZIne9VilZ4Wkh2WFB+wxkmaaKUouWSSzmbkKXM
 THSQxazDwtS0MJG3chhx+1pnHeiudcyeiPZdbT7qqW3kAyLoKyeiYoi03Npox9ufzOxD0pp332Z
 WO/QNUHokohaYhwnS/EYYsr39tGE=
X-Received: by 2002:a5d:4946:0:b0:241:f7b9:7c05 with SMTP id
 r6-20020a5d4946000000b00241f7b97c05mr4826477wrs.528.1669341614309; 
 Thu, 24 Nov 2022 18:00:14 -0800 (PST)
X-Google-Smtp-Source: AA0mqf428dZ0KvIGJCmeVxP62R6S1Q8EQghMc/ws885gT3KoAaTUDR9/6R7bklgdHPkrKzCaX3lamQaZzrjeO9fjYQs=
X-Received: by 2002:a5d:4946:0:b0:241:f7b9:7c05 with SMTP id
 r6-20020a5d4946000000b00241f7b97c05mr4826472wrs.528.1669341614085; Thu, 24
 Nov 2022 18:00:14 -0800 (PST)
MIME-Version: 1.0
References: <20221124154209.14541-1-akumar@suse.de>
In-Reply-To: <20221124154209.14541-1-akumar@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Fri, 25 Nov 2022 10:00:02 +0800
Message-ID: <CAEemH2ezCRD-vzA3By7TTfZdVLODC1oKwkNqGjrfv3Hzejzozg@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] statvfs02: Convert to new LTP API
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
Content-Type: multipart/mixed; boundary="===============0653145630=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0653145630==
Content-Type: multipart/alternative; boundary="000000000000eaba1a05ee41e153"

--000000000000eaba1a05ee41e153
Content-Type: text/plain; charset="UTF-8"

Merged, thanks!

-- 
Regards,
Li Wang

--000000000000eaba1a05ee41e153
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr"><div class="gmail_default" style="font-size:small">Merged, thanks!</div></div><div><br></div>-- <br><div dir="ltr" class="gmail_signature"><div dir="ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000eaba1a05ee41e153--


--===============0653145630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0653145630==--

