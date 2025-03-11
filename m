Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BA2C28B2E
	for <ltp@archiver.kernel.org>; Tue, 11 Mar 2025 13:12:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50A553C9F5E
	for <ltp@archiver.kernel.org>; Tue, 11 Mar 2025 14:12:01 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33D033C829A
 for <ltp@lists.linux.it>; Tue, 11 Mar 2025 14:11:45 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 573A7600B27
 for <ltp@lists.linux.it>; Tue, 11 Mar 2025 14:11:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741698702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wgAlsDpWvV2nrY1RREWtxK7j2lKNvc2PN5PJp5XoBRY=;
 b=KJtkPvpGxNX5Ovo+NoNKQYcWZpLpQg+dhnSf8ROVgayrIfFM5NPL5Uf9t7I1K/V/qGS+Q9
 rzf5sDnXJNuiENmY0pTvYJ7X8Yygu28O35Z25JU9Y4Py8qhj7TFK8xK2nGPIzpcjr9y6B9
 s0cnCak6m7Maqf+nN7hTrx5nFbe4B3s=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-EKlXJfTaPoaj4pCoUlMhZQ-1; Tue, 11 Mar 2025 09:11:41 -0400
X-MC-Unique: EKlXJfTaPoaj4pCoUlMhZQ-1
X-Mimecast-MFC-AGG-ID: EKlXJfTaPoaj4pCoUlMhZQ_1741698700
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ff7cf599beso7949874a91.0
 for <ltp@lists.linux.it>; Tue, 11 Mar 2025 06:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698699; x=1742303499;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wgAlsDpWvV2nrY1RREWtxK7j2lKNvc2PN5PJp5XoBRY=;
 b=uTJ2dHqVIFL5MRAhsy+0tFkxqIiCm+udjjUMqHKwIyGQGyjLG4IDAkb9sO5Z9/hiZM
 pi8Q1y1rNzutrA9fg20tVwYpDVb/pJlpsRBKpNeSe1/ZfZWaURfTTlHJBuwHROiS9/gi
 nSRrEDdfpHZuT8Hoie3AzG2CaStMhHv3zakQnhpL6eIDUUn44KvMU1wQHdBMjx9MC1Fo
 /A4iJq2JUb4vIvIz+RcieYYOoYlUcDwdU/Sz5aSJwYZW2jPko7nV2UtUGLPDq16uSK9R
 7XveIWwNciHfKIslsfRlmniHSJlFojKnRiIHEmLsS9Tx0bCakdWJ9QHkz7LnmB2XZBAr
 7vzA==
X-Gm-Message-State: AOJu0Yz0/T9QQfN5uV+el9ab4+IPbyCsH8DzqQN6xpPm/6EAMxk1OvwP
 1IGqkN8Ru3LB49V4gerAL3mpNb+YRkZg8oXBDvJHeOFIN+uONQZ/AqR4h2cyYsuW5SWcWGfdvuw
 xbbdKQ9qGXkisZGFrpcbXx/45gO8gzmebipizeT2cLW4+rgNTq5MVCG2krT5LjSIwN9VzhLZ2Wu
 4/QrHpO3SHZ6kzB/MF0hAYsOgr/WKqSAphBRuM
X-Gm-Gg: ASbGncsdFdQysHF23GtRwd+8RUP4fz+QYK5456faa7SPMOH4OKX3yDYNGbR+Ra8t4rc
 6VZGUb+0RB+EJj7heE21h5NmDuN8og9sK0bvDrUnKR1DiPllru5qMAYXbKI9Gm8zKHGXXgTqxsg
 ==
X-Received: by 2002:a17:90a:e70e:b0:2ee:f076:20fb with SMTP id
 98e67ed59e1d1-300ff10c978mr5471474a91.17.1741698699115; 
 Tue, 11 Mar 2025 06:11:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhTO5UhG4N8/e2TwKcDfGgTZkqFEwBqjW2VFTNnHPhwFlkCNq83oxVcXUuyzCACtxzt59LXz7cT9qOH837svo=
X-Received: by 2002:a17:90a:e70e:b0:2ee:f076:20fb with SMTP id
 98e67ed59e1d1-300ff10c978mr5471437a91.17.1741698698710; Tue, 11 Mar 2025
 06:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250310094745.142249-1-liwang@redhat.com>
In-Reply-To: <20250310094745.142249-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 11 Mar 2025 21:11:26 +0800
X-Gm-Features: AQ5f1JqvnoiS0t975Ws5W3WSO7v7mcijoW4kv37rYvpe9f8x-uYtGUBEv58-3Vo
Message-ID: <CAEemH2czQc8OT1OP2gb07P=-6nRBgpj=YrN2Sct9bPdDTuj-RA@mail.gmail.com>
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DLkZ0M5Mik2WonJaohgIcMggW7gjK3UuAtGE1iT9zwo_1741698700
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] ioctl_loop06: Update block size validation to
 align with kver
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

Hi,

Please hold off on merging this patch, there is still some discussion
about a bug in the kernel or ltp:

https://lists.linux.it/pipermail/ltp/2025-March/042610.html

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
