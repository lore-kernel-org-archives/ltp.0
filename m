Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC15C3DA79
	for <ltp@archiver.kernel.org>; Mon, 26 Dec 2022 03:37:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B9DD3CB8DE
	for <ltp@archiver.kernel.org>; Mon, 26 Dec 2022 04:37:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C68F3CB8A2
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 04:37:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 57AA12001D7
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 04:37:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672025838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QiNTOFQ6U46J8zW7GTSH8dA58TUshmkRz4QYFxeNNAE=;
 b=GYlOa2x2Htz7DvghiE0yiNLhKiGKn5crHMTyd2ModUzb6r1XCVslN5iI5rlHHsTWq4yksg
 rXNRYT4ShxMp3aGKfEz3Ek0IHa+Fy1YRKGdh8URaGOYRwYq0IYEo7GQpcyqcj5w7Dhca40
 RP3T2ZFBeodR2jsKAvU+ZDs5GlMAz/s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-576-W9G1px40NyuJdOWeFwXmiw-1; Sun, 25 Dec 2022 22:37:14 -0500
X-MC-Unique: W9G1px40NyuJdOWeFwXmiw-1
Received: by mail-wm1-f69.google.com with SMTP id
 c23-20020a7bc857000000b003d97c8d4935so820680wml.8
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 19:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QiNTOFQ6U46J8zW7GTSH8dA58TUshmkRz4QYFxeNNAE=;
 b=g8hiNY10g2k1zkN6NXUoQ7TK90E3EX5qedGmquNeUJLsouQLyyAZARCEtAuRVF8bPF
 +HnmhJBALczdHvuq7wIZwz7CWGCBeYHQT6M9mY0TaWYNTYBDiJOLoM0aLftdSEQCaIUu
 1KJAvfnXB6zN/ztg0WG6Fyf+4oqvbDQiIs2BmbYfLMDDaDOq8HnxteNg3l6UozU60x/2
 Y/jTagF9tBIHyB9TzMX1X3wj2yXTKgIFj82pDUrKMuCrJMG2Y7/iDhpz2mEPDAju8tR8
 fUk56RbtzzSAf9/VE1vmAJyfGwikh56ZADO4pVwIbQND1bD9sulu+hVEA3913k7D0POn
 6w5Q==
X-Gm-Message-State: AFqh2krqj6rJx1UE46dBMtmRmCtvh2AOzqttD7JvuV8LXy0tYAZspTUr
 E9BiBHIde4oKyXlYYhJ2rftc/OQfGdiiLCepww7BJ/tlTnWpRhkxbgc7rLmy1VAVVD6eHGIoLgF
 rSe0bA5w5a5hSeXsIrNm8bp0lfhI=
X-Received: by 2002:a05:6000:1e13:b0:271:2ddc:80b9 with SMTP id
 bj19-20020a0560001e1300b002712ddc80b9mr565866wrb.316.1672025833248; 
 Sun, 25 Dec 2022 19:37:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvqOTK75kXwDP+F2fBorqjlND1ePwpEgLQDIBxrPB03VAyIdfdUNr6LJfXHS7bbGhPAh87yhAc9NT2kmfCtS6M=
X-Received: by 2002:a05:6000:1e13:b0:271:2ddc:80b9 with SMTP id
 bj19-20020a0560001e1300b002712ddc80b9mr565864wrb.316.1672025833059; Sun, 25
 Dec 2022 19:37:13 -0800 (PST)
MIME-Version: 1.0
References: <1671434187-2038-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAASaF6zD1dWaRHkpkQtXU1Q7EDZFfayJFSYsSMsd3SbY_H8sAQ@mail.gmail.com>
 <4de9831d-a76c-81eb-182d-569f4775f571@fujitsu.com>
In-Reply-To: <4de9831d-a76c-81eb-182d-569f4775f571@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 26 Dec 2022 11:37:01 +0800
Message-ID: <CAEemH2ccw5VTvDq-VBNKZBErYUDcP+AWDgPWJR3UyN58n-YYhQ@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] tst_kvercmp: Add rhel9 support
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com> wrote:

HI Jan, Li
>
>
> Sorry for the late reply, I came back after one week covid2019 sick,
>

No worries, Xu.

This round of the epidemic looks serious, almost everyone (including myself)
around me gets infected COVID.

Take care and have a good rest!!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
