Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93617CDB482
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 13:31:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A23B3CD3F0
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 15:31:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A84B33C6BD3
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 15:31:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B6E12200B65
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 15:30:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697203858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DrSRZ0QuElq9w3ZfBrrWZhiIhpMBQH352h9pyutMOKs=;
 b=IwheNON2ZKJT2wezkvnuIIJeWA6GeYlh9UsO9KswTxnp92Axxu/9lj4vxsuIo6llzuC2qt
 5r4bvN2bIY+Sd5vRG41LJaXrJUuPOHD19TW3gunozraIFRhnqKzauE6jVZ5ItwO88x8hJ9
 m0Q7rYI5mHxHE7Z7IE9VASdJFrEPIvA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-vOyqeARpNcGpzfK1y72evw-1; Fri, 13 Oct 2023 09:30:46 -0400
X-MC-Unique: vOyqeARpNcGpzfK1y72evw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50433324cf3so2196822e87.3
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 06:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697203843; x=1697808643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DrSRZ0QuElq9w3ZfBrrWZhiIhpMBQH352h9pyutMOKs=;
 b=s6KH/X/Doq1Oz0bsU6modCSSc3WiDvfi4R3RxfZ0/hCNrNTzbu3B/OYuktclIF9rbZ
 Kj38IgNh+Xvc9bWe2fUMGXQNNSKKMEaX/z/dNour8U3VW0SLGec7ur0SwFJtrTov6KXY
 lHi+FGj5rT5DsxxEPKNnNvsIQ/pUCKq8IpGBKkOUdira4cpAwS1RrsLIv6hfOLKz/2/9
 GmvwbqJIi9nkFw102YiklWuyohRXR5A/d591J1AuzcfLDCcWniuc7DMwiDjfPy8JMp0W
 mZqEzPkJYWvA4I48Kr1egW93lMLqcUsoqbobzwEopC+8nWbrv/wek7BPN6MHY9/cqiPF
 pMmQ==
X-Gm-Message-State: AOJu0YyYfLlkr1TJ3999KtWJx4YIgw2+gEIAWxPkGnuIh3AJ/HWshE+J
 5CMFpZPoYWPN+/u44nHIIh5EKHk4bZl7GP3lZfWBtfN3ZWlcJGxceIsNaK9Zsnr1dPxXugmCWj8
 JwGvD2Y3g4KuhvhxPWCgudRvsbvGxYpgfhUx2DADGkJo=
X-Received: by 2002:a19:8c48:0:b0:504:3a7c:66ce with SMTP id
 i8-20020a198c48000000b005043a7c66cemr20067276lfj.68.1697203843167; 
 Fri, 13 Oct 2023 06:30:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH71IM21nJQ7NpKzFjQOpFruERJKdTyM0gOkw+QjbBgn+cBzfjUnfWFRsNAXrvNaInb0Wv4rMkvGTV1gQnKVt0=
X-Received: by 2002:a19:8c48:0:b0:504:3a7c:66ce with SMTP id
 i8-20020a198c48000000b005043a7c66cemr20067263lfj.68.1697203842828; Fri, 13
 Oct 2023 06:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231013074902.702534-1-pvorel@suse.cz>
In-Reply-To: <20231013074902.702534-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 13 Oct 2023 21:30:31 +0800
Message-ID: <CAEemH2eW+K78tj3fGE3wwnnDy-7Y6vDoC0u43JePg6y=0tqfJg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH 1/1] Remove load_stress_all_kernel_modules.sh
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

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
