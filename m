Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1ECC8302D
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 10:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751277678; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=xmvEmXr1BtD6t664EokFmcE14GKd32iiKXqxIJBWBQ0=;
 b=XI8wnVs3Aona5cfA/iT2XqItA12aFrHF0nzOiH8W+RN9OHMPKM4gZw3OX0uoPSPjyd1H4
 pzfJHU0DUIyYPF89Syk7ZadazGScBTC1Cle3OPQd6KLn+D1UHYHxAEDN/cbqSyn771zvo7f
 pIIiQSjlWGOiwo1ADSLKZaOKVY5604s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53C253C5906
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 12:01:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 23F043C22AF
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 12:00:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 213CA1000B57
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 12:00:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751277653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q/m4p2YeIAJpaguKk3ROzJsFR4aCOciTUpskTdXiH98=;
 b=DIWo1K7HoGWDYAegzhVrb+7oPokEOUCZfxuOIOZ3q1IUUO1MRmi8uRQaYsC4ZxhxbASifH
 E0MXdPiBhBWzqNdqQJSqXsBrn0MXWE0VZduMFt7V0oqNzQfXlF7c7XVuNos+CMEUvaoiPk
 FxiwHbXeL5TGSXtf9fqrP1D8wcP471s=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-AlSZ14ZdM9Ci5oMep6-50w-1; Mon, 30 Jun 2025 06:00:50 -0400
X-MC-Unique: AlSZ14ZdM9Ci5oMep6-50w-1
X-Mimecast-MFC-AGG-ID: AlSZ14ZdM9Ci5oMep6-50w_1751277648
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-31215090074so3354114a91.0
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 03:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751277648; x=1751882448;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q/m4p2YeIAJpaguKk3ROzJsFR4aCOciTUpskTdXiH98=;
 b=kYykcD1N1nFK2N+67cCBB9UV59kjygmkQNb90bkuodVJYjOvgPi/2ye+qyR4WBAqWM
 ++Kp6T3SuiZpcPYqebgCMza4mS9crWu0be3/c2QYaxk4du1NU3t/wjHrslegj3sodIZU
 u+VZAbEFFS0xy6vQvz2ChVlMYiL1d9IiA+3VAVUdOgV8iIC4mgg9DpkJYsQhSYVficWS
 Wd3nEHu0Zv7poRdv2NviTfqrY/AMX0OnX27YhJwW+iso5Vp/t/1RJtUkmKDrc9qwVX4N
 Y21CPir88QfMx32Np499JdhU5SsQBTBEH1LmuOZ8XL2W1PfKRnBhX25P5VDV0TupsMh7
 x1lg==
X-Gm-Message-State: AOJu0YwJ5YezbY4cOHeSZw3fMm/8otBQBL3wW72+KCFme3fE2/gfKLUw
 3lunT3kZXXPB61ETttOcW8cX3SSB0sQatPpezkG0IOdahBHxSVuYDAC2wUPMYmW9NXyV5uyTNNO
 IUgDz/S7hggavaHuQQmLFiWbqiZZBJ+nmaV7AMFhiMLGiHY6ulFpidvO9uJECa6lhRToJSwbeXF
 Z54Gp7uoZN9tdBexHFEjL6O8dCFTzhS75xrFgytg==
X-Gm-Gg: ASbGncu0DKEThNdZs/e3Cd+XHWpn+NubG/JYBaaYz2AqiMNc7UcRxc9zZCLNOD9tIac
 5CY9i/kZL1m5a/1giXcTLnn4D3ZAOR3KHmX5MRWhhAr5+pDXFr+akLleKocyRH+joP4bE+5spgz
 CPljtN
X-Received: by 2002:a17:90b:3e8a:b0:312:eaea:afa1 with SMTP id
 98e67ed59e1d1-318c92f09ecmr18228103a91.29.1751277647933; 
 Mon, 30 Jun 2025 03:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0RCim3GzdHIIru2nCpEI3OXpJMEheTBKyLwTuU46d6Dr13OZlpZ+xAGmMGkwpS348h1vZnB2t5Zu8oH4zrfA=
X-Received: by 2002:a17:90b:3e8a:b0:312:eaea:afa1 with SMTP id
 98e67ed59e1d1-318c92f09ecmr18228053a91.29.1751277647447; Mon, 30 Jun 2025
 03:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250628031302.196715-1-liwang@redhat.com>
 <aGJZgezUO3X52_iY@yuki.lan>
In-Reply-To: <aGJZgezUO3X52_iY@yuki.lan>
Date: Mon, 30 Jun 2025 18:00:34 +0800
X-Gm-Features: Ac12FXzebdUyZYN6VKeU3tQY0lRRiz1ChTSqi52mLl_rVheASg7iyzJ6CR0Xsbc
Message-ID: <CAEemH2dHB=ihfQ2nijszJy9VeGKcv181tkKKkyj_rbDBFB=Erg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 97nlbCxut-bbgwZOESWx2lqqg-THbmj3NzLbS_VjXhw_1751277648
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] lib/checkpoint: remove deprecated
 tst_checkpoint_init() and legacy macro
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>

Patchset pushed with minor adjustments (GPL License update, tst_ipc_path
drop).
Thanks for the review!


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
