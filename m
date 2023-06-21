Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEEAEB64D7
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 02:44:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 114503CE10C
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 04:44:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35BC13C9BB9
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 04:44:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 71E091A005E5
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 04:44:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687315456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R9E9StUMzNPNxEdGtYb3GLIbr7iSPYiqKnVUD0+6x/w=;
 b=U706I9MCBHKQIklccvOGZngLFw/uSxR+BZajHJE+QLZkXkWkgq93vnCQdJRhnpsyd6zIYA
 pjYbSU6QqnS6uxo1TFd7mFwqtAtuA0e92VuXTG/roHQ+ZiPbVKW5Vgm9HbrHQ/rAFCdqtX
 404xB85MVW5ivrtMcgWW4DrjDE7mm/o=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-FuroTY97PGG-sqWrORq6pw-1; Tue, 20 Jun 2023 22:44:14 -0400
X-MC-Unique: FuroTY97PGG-sqWrORq6pw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4edbdd8268bso3980189e87.2
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 19:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687315452; x=1689907452;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R9E9StUMzNPNxEdGtYb3GLIbr7iSPYiqKnVUD0+6x/w=;
 b=M/WdvDFoAymO3Z9RQ+JtA6tCGcRq07q13PkyDBW6BJB45bVq7ev3PfeyTZFiI8XGKT
 lUG9cGED2jNCiNSmGeiI8jsfg3Xqq9XbvC05xCQL/9nFfAe+GHhA9864w6qrE1IJ0zWZ
 Hyl1zezWoO3JlLsv1NlTCg6U/SF2e8/exNX2HiiyGOY3jG3sdsprBZdh6iz5PxUzw09H
 KFHUlSlMDiuLpocGcfcMWeu/jGr8J1Rxoak0by4jr9WXk4u45HHYDABzm0Ld91tbCD9x
 3HWnDesFJ5usxLeC0PpV7dO/ik183emLw/sOyXM7rE0ofNpPmo+5OuCbSAb/9s2Xo+v+
 b2ig==
X-Gm-Message-State: AC+VfDzQH5HPkcSqfYur0YUDq5mycfnPDgufNVPVY9cL2qpI4XIinaPv
 kEk1aAgN8pOV7ik9PnYFNgMFZIA5LfwZuPaXckQD19IbGpAXYmU2BnETeb9TW1PozENjBeOCcdx
 dgOcOBWDJlsPK2qq6NVPIcJ6dV7khG4qXIOKaCdnS
X-Received: by 2002:a19:5f5b:0:b0:4f9:567b:c35d with SMTP id
 a27-20020a195f5b000000b004f9567bc35dmr1164843lfj.55.1687315452092; 
 Tue, 20 Jun 2023 19:44:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6yad7v9YNMD8Qlly2M7WF4lKx6Y8ZZUyVmiDtm6qeTDrSv/GoTe6HkAEDwIdRZ+HVT6oLt+rZzaUlQP08x0TU=
X-Received: by 2002:a19:5f5b:0:b0:4f9:567b:c35d with SMTP id
 a27-20020a195f5b000000b004f9567bc35dmr1164837lfj.55.1687315451722; Tue, 20
 Jun 2023 19:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230608091426.107673-1-liwang@redhat.com>
In-Reply-To: <20230608091426.107673-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 21 Jun 2023 10:44:00 +0800
Message-ID: <CAEemH2fk-7F7LspSQ6PDF4mFFnxvJ8K9cWnJsfn+F=YHC2XjyQ@mail.gmail.com>
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] preadv203: guarantee the subloop exit timely
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All,

As these two are simply to reduce the timed-out issue, I dare to merge them
directly.

1790832 New          readahead02: set dynamic run time
1792108 New          preadv203: guarantee the subloop exit timely

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
