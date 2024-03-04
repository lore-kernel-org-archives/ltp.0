Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3243EC54E49
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 08:45:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFAF93CEB95
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 09:45:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B82A73C972C
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 09:44:50 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 84A5E1402F8E
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 09:44:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709541888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=mhbgG1JQD8XMX8BNUfT48SgnI/S2E90HWKR71NZDhGU=;
 b=dQwPJGiH7oShKqr8vzTPudgsEqg26D+P8uQvi+bzAjhrbJxP3deaw5yWk1wPmKwjQ1nUj3
 Ggp9GsF5FsFiHiiO6OiCBNFFWSAzXkvXpAcYGniSRxRshPXhoEO/F21eF4Sp+n+0RV1/YV
 xZxfyRHwQRYViS46FuPb3gz1pFNBb5E=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-biYhB45zMOis_wDJDQ0DSQ-1; Mon, 04 Mar 2024 03:44:45 -0500
X-MC-Unique: biYhB45zMOis_wDJDQ0DSQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29b3a63c589so1309800a91.3
 for <ltp@lists.linux.it>; Mon, 04 Mar 2024 00:44:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709541884; x=1710146684;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mhbgG1JQD8XMX8BNUfT48SgnI/S2E90HWKR71NZDhGU=;
 b=X2jEiZjeVHaocn60uljPMOIrWK/TarkUrFIpVjOJSIhZF7V/lAJbgi2iOZylsHV/QR
 RsWukqGEuRnOTYy2359vw0cS+vODRWqB36RzgBvREYpO6RboN/5XGuGgo32F+MnWKzIU
 n7KLzF6DCS3QXNxPzFEQ8Oq4ZGDpJgrXAyv8/vh0DwEs3aGVZQvRW3saWIfBYFnqbo8b
 YRmfnwzgLr4VzfLfYDA3GIjlxk60lxhalwcR6XrT94shuNDGzYxK/c5L0aqH1GNSEvU4
 yG73rvBLjDgwx2EI8dkJPCalhURBi86V/tjAs53LVswS6FLPzZkXvVxZE2jnWD0AdHuy
 k7zw==
X-Gm-Message-State: AOJu0YzE5bzNrI6SlKuUtH7y8YxV0A2aoypilks1rIUqPLcclz/mbAfP
 yxhiSryVbrrA4UOunC1ao0PR1KU0biVGepcN4y+KarQN2EFWa7cUfuVjhDkQQ3Xxxk+z9hn04ak
 MPtiuppZ1Ea0KHoAFEy3kDORKnBzd8zFbRuBOXT4WxVMhvd1RiEjlkvSr1cr77XOzzwG0ZpOEGH
 rAQD9/n1+rJhPSDFlCg6aP/470hfQCg7mNoZkx
X-Received: by 2002:a17:90a:9b84:b0:299:6c50:c2a0 with SMTP id
 g4-20020a17090a9b8400b002996c50c2a0mr7044386pjp.23.1709541883858; 
 Mon, 04 Mar 2024 00:44:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7W5K18ncOI4c9dzITW/BSyqCuLcn4t/aeDyFr8X+wDOwxPmNU5mteFq5D2AVbrx1iZQipKPVz+rGwatYAOMM=
X-Received: by 2002:a17:90a:9b84:b0:299:6c50:c2a0 with SMTP id
 g4-20020a17090a9b8400b002996c50c2a0mr7044370pjp.23.1709541883375; Mon, 04 Mar
 2024 00:44:43 -0800 (PST)
MIME-Version: 1.0
From: Li Wang <liwang@redhat.com>
Date: Mon, 4 Mar 2024 16:44:31 +0800
Message-ID: <CAEemH2e0Rmua9XimhfPHJ4xfEpidvYfXuDfsxRrA-VRv=YytQg@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] function tst_parse_cmdline exist?
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

Do we have a funcion similar to tst_parse_cmdline() in LTP lib?

I asking this because recently people reached to me about the
init_module01 failing on the system with ' module.sig_enforce=1'
kernel parameter. That makes me think there are quite many
various kernel parameter changes in some behavior when added in,
so if not, I can help to create one to do such a thing.

In a word, the main purpose is just to parse '/proc/cmdline' contents
and export the necessary value to test case.

Or, any suggestions on the topic?

<<<test_output>>>
tst_lockdown.c:82: TINFO: Kernel lockdown: off
tst_lockdown.c:31: TINFO: SecureBoot sysfs file not available
tst_test.c:1709: TINFO: LTP version: 20240129
tst_test.c:1593: TINFO: Timeout per run is 0h 00m 30s
finit_module01.c:35: TFAIL: finit_module(fd, "status=valid", 0) failed:
EKEYREJECTED (129)

Summary:
passed   0
failed   1
broken   0
skipped  0
warnings 0


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
