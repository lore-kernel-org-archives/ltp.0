Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FADEB64D7
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 02:38:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C4453CD341
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 04:38:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EECDD3C9BB9
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 04:37:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9AA36600067
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 04:37:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687315071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qA47aN5Eb66Bfgmt5/4LstYEx50D71leEhuXx+gtQAA=;
 b=ODYf0+iobFL/TwRwy9JLz1sAQCT8ImRuicdSVjSRoQ7nRqwkdGrVgHwv824h56+WdQSYlw
 vYo/Oy9O/2Fn/MDnxe3kmCQ8kV8ro3UwcL1Wtr76GSFj4Sq3sm/bFjEsMXjInEuwh4NbIK
 Nu+z12Dx60NliyMW8f/mlLPQysUcQog=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-0-WVC_hCNq-VU37JzXVdBQ-1; Tue, 20 Jun 2023 22:37:49 -0400
X-MC-Unique: 0-WVC_hCNq-VU37JzXVdBQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f51dd0bf2bso2504636e87.0
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 19:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687315066; x=1689907066;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qA47aN5Eb66Bfgmt5/4LstYEx50D71leEhuXx+gtQAA=;
 b=U7oWEQvTm2ApOLUbliZE78/Wbfkr61JGLogDXZDD43koJC+c1yV5F+Yd9gs46hBH2J
 AIoMWoF150lIhh/k8aa6ToPa2OdNn0oiWd+hVjKA4CBZSTC/1oC8LeBjlzHkFfKlGZf+
 rnvYCc0LbuGCC47B3AHkfhtmZSokuCZTBb45G4p0YpHbmHQFCBA0rtZwDIfqhNawiIKj
 KBF/b1ajg/y0e/tZV/+LGUXtVGdFvObnvU096NUGxMZUcZBoOANN8YKtBQRkrdz7zbZQ
 ws96S00uUUDBL6xwDvggXzAc9+GWdciJZcAViKNTXMe8KKvMOOrjfBrHaDZZhxOSqLfQ
 0TgA==
X-Gm-Message-State: AC+VfDwpe0aAYs1Jgw+O9ktE98iqu79r/I/X5EXfmmflIeCFr9MUR90d
 ric8SoWT8U3ebJOJePq9BbWhLx8mmqPtzuR/qz/9h0frYZ3/0D/4Q/fr0G9YEPY62W7gL+5MvCO
 If7iZkPpYcR9TAWQaaV27/adXhNzbB72vyUIgLA==
X-Received: by 2002:a19:5042:0:b0:4f8:6b82:56b9 with SMTP id
 z2-20020a195042000000b004f86b8256b9mr2812683lfj.31.1687315066339; 
 Tue, 20 Jun 2023 19:37:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5xUbXgVeiI+TjwZ41FxaWeBh6ktVZbsBGashVibbm5GkZ2hRG90LWWlqRi6VlUzkQauQWr1JbTHfFKPBLiHDE=
X-Received: by 2002:a19:5042:0:b0:4f8:6b82:56b9 with SMTP id
 z2-20020a195042000000b004f86b8256b9mr2812678lfj.31.1687315066043; Tue, 20 Jun
 2023 19:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <80595ab205ea7b3f633bf4228bb43ee999aef3a1.1687247273.git.souta.kawahara@miraclelinux.com>
 <7ac34b5102d65e6bb7112234f6ad685e98d066f2.1687306661.git.souta.kawahara@miraclelinux.com>
In-Reply-To: <7ac34b5102d65e6bb7112234f6ad685e98d066f2.1687306661.git.souta.kawahara@miraclelinux.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 21 Jun 2023 10:37:34 +0800
Message-ID: <CAEemH2e6CpWo9OjuX9HArVOnSArYLE1=8a1kvt-95UdQ3qp=_Q@mail.gmail.com>
To: Souta Kawahara <souta.kawahara@miraclelinux.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/1] runtest/cve: Add some existing CVE tests
 to runtest file
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

Pushed, thanks for the quick response.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
