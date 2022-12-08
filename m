Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19F1C4708E
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 02:39:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 155D63CAEDD
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 03:39:00 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F6173CAEDD
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 03:38:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6DA5C200991
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 03:38:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670467126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WZdxtwdu2kqleW5SIS159XCWYPlZ4kFLcN3KcNdYf6c=;
 b=KNAy9hi2QauDBJJQNIQfTqy45oEVvtuEDLxHVHPTz0CowRZo0T3DExxeNkIBW+HNotDAp8
 NO6hXPkpcLDAIOsCWODu/s6auh/khcEpGFn4bf2uWpk4OP6ilhOdOtBxcphQDXbREC2ASL
 i32bYqKf4vt+Yp3NjegEfMIeUEsRVnI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-93-r4GkOYt7NuydT1_DpDIWsQ-1; Wed, 07 Dec 2022 21:38:45 -0500
X-MC-Unique: r4GkOYt7NuydT1_DpDIWsQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 b47-20020a05600c4aaf00b003d031aeb1b6so1695015wmp.9
 for <ltp@lists.linux.it>; Wed, 07 Dec 2022 18:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WZdxtwdu2kqleW5SIS159XCWYPlZ4kFLcN3KcNdYf6c=;
 b=MtVciXXufTHMePpNxeqkMCrzSFO9nltp004h1APmRfkW4uJXyECejlG+UKTOWUmSto
 bMJMdk+PzncX/YxXv8bk1p1QZ2EBSVsZU/FyECTFeRlv0Hiu2Kw+FiW3POJNXRFG9tco
 o/pWfr98UJ3ZbmBEt1vAaQ05l0rwrjnSdcna1wsnWLvHF/jXTObac8A8r/T8O46yi0DM
 KwCB+51TOW3c3SM40/iUJYW3lhF5z4ReJNDVWkhZ4+oZFQTUUVJluetdo24Yo4eUMOsd
 nf+LS4Ty2+DG+9WgmQ4YAXtPxm9+vrJN7o0vyEkgDCbGz3aEO5HtewMJrNtDne/YzaXV
 0fdQ==
X-Gm-Message-State: ANoB5plcPERMS/EgX7cTzxgNCcDJHuseEWLbcmZWJwRHcNZ6NuiqLHw4
 A+XLw8ekGs52F4Y1SeGQIuRRNXyec8VAJeWCPK2qhZvYDQcku3EK+ifSmLsrMsKkRkA0kZRwYbA
 FKrd29rLv7apO8yQ2IndH4bzeS4s=
X-Received: by 2002:a5d:4d4e:0:b0:242:c59:b979 with SMTP id
 a14-20020a5d4d4e000000b002420c59b979mr32042750wru.707.1670467124022; 
 Wed, 07 Dec 2022 18:38:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4s+4OevLSE77oesPqc5QCjYIkFAPWm8uIB6eLMX7txdRlVhOa3jU3CKEDwpqbHLlycG/wbuXtkzb/J7x5HdfI=
X-Received: by 2002:a5d:4d4e:0:b0:242:c59:b979 with SMTP id
 a14-20020a5d4d4e000000b002420c59b979mr32042748wru.707.1670467123804; Wed, 07
 Dec 2022 18:38:43 -0800 (PST)
MIME-Version: 1.0
References: <20221207155307.13118-1-akumar@suse.de>
In-Reply-To: <20221207155307.13118-1-akumar@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Thu, 8 Dec 2022 10:38:32 +0800
Message-ID: <CAEemH2dzfXxJemcoVsDpn4HO8_1RXhKWO79YO18wvVtZ_8=q2A@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setresuid05.c: Rewrite using new LTP API
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

Merged, thanks~


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
