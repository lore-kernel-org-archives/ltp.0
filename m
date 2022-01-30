Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80228C433EF
	for <ltp@archiver.kernel.org>; Sun, 30 Jan 2022 07:59:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC51C3C9798
	for <ltp@archiver.kernel.org>; Sun, 30 Jan 2022 08:59:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 649F93C9762
 for <ltp@lists.linux.it>; Sun, 30 Jan 2022 08:59:27 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 57F02600849
 for <ltp@lists.linux.it>; Sun, 30 Jan 2022 08:59:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643529564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fg8qKiCqaAVQV7tzTa84QFxYdd5m0MswH5oGSteuI4s=;
 b=JkD9G1G2HcsC9Kmbo4aLAZfTtAxHmjopr/JRbVjWhvuXRnCOpgxeBxNfXJN0IeCS1lpl5f
 Lpm3GnSQyTjajOMqFA7kxkGeujjXN3CXI31yWvLG3sfzawo0nDS5Hm8+eJBsNFT6wWqLYE
 KQFBLRMN0QVfR84Pftb4wmBlD5KL7Ig=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-mN-g_ICSPWWtQBQP4XA_Eg-1; Sun, 30 Jan 2022 02:59:22 -0500
X-MC-Unique: mN-g_ICSPWWtQBQP4XA_Eg-1
Received: by mail-yb1-f199.google.com with SMTP id
 i10-20020a25540a000000b0061391789216so21249875ybb.2
 for <ltp@lists.linux.it>; Sat, 29 Jan 2022 23:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Fg8qKiCqaAVQV7tzTa84QFxYdd5m0MswH5oGSteuI4s=;
 b=j5AoSXCD/HkSg0QgFxGzD9qJ8xy6ypiEhgMW0ixnni+Q3zNfIs5ihMSheuCPMpK2dW
 W5oM+uaTznCcSiDo2JTA3yuVV9s2vu5W8KOoKmJl8odi6b17rejOPygBXwI3T1gI52kI
 tasgE59628iOXqp3nBsm2Ux2zJiSeU3LsAfyvQ5cOLqw0RtCDJnhMcj+9cRVdlKOu2TV
 6QiUGxvuej7E0fY6fENANw97kc6VqkKlC6nFmGmP7cTVGelmbYjYBOAzbhA+DIbjj0ai
 jAlBTjnt7vJTayWXewCkk2uEFhaBmU5R29CEVjYrZZWEgTe6kPHPkAwYGSF9twmJ6JXN
 V4Sw==
X-Gm-Message-State: AOAM532QezUwZUWxOHJ69AiC+aOAu36nqdScjHufzNTm7JQr4juFb1TR
 3SGIuSXrvDOO+tqU3UV+CrCY/KlfKJx2beAK1WX0Rulrr9UHywe94Obj5fCA/5kH6jQ+xwBDSpS
 ZSbr/lbVkF6aNwaMDyxyg70k3zKk=
X-Received: by 2002:a25:c70f:: with SMTP id w15mr23911845ybe.32.1643529561921; 
 Sat, 29 Jan 2022 23:59:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3Zokaqg7EqsuhtlEqzMPU38ew3O2IKWBh1iAk176+oALZLpB6jqxlaVVlHAGpP+KnWl3X+X50Jg1/OoPxRbQ=
X-Received: by 2002:a25:c70f:: with SMTP id w15mr23911837ybe.32.1643529561743; 
 Sat, 29 Jan 2022 23:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20220126145141.13825-1-pvorel@suse.cz>
 <20220126145141.13825-2-pvorel@suse.cz>
In-Reply-To: <20220126145141.13825-2-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Sun, 30 Jan 2022 15:59:07 +0800
Message-ID: <CAEemH2f+oNKsFc4+wG50tn6_FRTh_Vy060_WB8g4hPHvcCPuoA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_test.sh: Print environment variables in
 help
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

For series:
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
