Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A25C64EC7
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 01:50:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1ACA53CBA84
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 02:50:43 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5D8D3CB7AA
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 02:50:32 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 43094100053D
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 02:50:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677635429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=njsskWOImqHvSPOY7jP/zm74QdhRQqY6beGsY45c8DU=;
 b=NGOndT6QFOa5zPcxKftFWIYGYo/505ePsBzXN84IiAdHhQ+HBMsxglGCww1qpUN4pn3Bin
 +dHvO8DKz6AHo9ptXtnu9q5PCfoUkarvgj+/swqCF20a5HaU//7CtdDuoP8ZN+5jDNHWIK
 CCJaulbAF9lCB0kGdzWPeNcfk+FaAE8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-530-rtiE5cOpPPec8_jMrLCQMg-1; Tue, 28 Feb 2023 20:50:27 -0500
X-MC-Unique: rtiE5cOpPPec8_jMrLCQMg-1
Received: by mail-wr1-f70.google.com with SMTP id
 d14-20020adfa34e000000b002bfc062eaa8so2019400wrb.20
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 17:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677635425;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=njsskWOImqHvSPOY7jP/zm74QdhRQqY6beGsY45c8DU=;
 b=fTeMBgkRAiggvMvXGpC4bV7m8seQnkeEmbRxH1BdYvZVvF4K8hWTgMt/hJyfa8IUCT
 cSkPGh9BMvAnDQ+wTenlfpCQTUg1+plmeFptQPCujpG9vHBbLlf6uwxUGcc0kx6FZ3PE
 PRJU3jCNUnw9x6wiCwJyTBcTpwKyKCDnN86Tr6pbxgN/1a/O352DzkqWZW4TdIJCWxNf
 ehAOtS7uN6+2Z04nls9YOh64uKmFGqamHwNETej8+JnhVYtcwWCmoDCLr3l8V5+7upJK
 rVioJbMXmU4Q1hzGjP+DXHksx7DMW9j2HmI12Zw3ka+HZFBP6zaGo4t2MEqMwZxYdxkk
 odGg==
X-Gm-Message-State: AO0yUKV8QnicOAhzC1hD7JU/CkG/DIO+33Rl0XRdRbEesod6Q0B7zf4D
 66DLxQbYAsJM8o6KCKKL3FfIVjY7+3wTsbw4ZEQz+h9nJnaF11qCMaAJPLbjvQxZ8xqXF3UtOSo
 J6+4p1859mP5plL29qLbQps2xKdDcUabr6szGzQ==
X-Received: by 2002:a05:600c:1c11:b0:3df:d8c9:caa9 with SMTP id
 j17-20020a05600c1c1100b003dfd8c9caa9mr1348006wms.7.1677635425721; 
 Tue, 28 Feb 2023 17:50:25 -0800 (PST)
X-Google-Smtp-Source: AK7set9puj/L/MbpYdowzgMo2lp/3pU4JRNBsRZTbLNUmruf1Iyqq+ustxEFEJP5Ihiyin5/v2fsHRrAt2E/CRx8Y2I=
X-Received: by 2002:a05:600c:1c11:b0:3df:d8c9:caa9 with SMTP id
 j17-20020a05600c1c1100b003dfd8c9caa9mr1348002wms.7.1677635425384; Tue, 28 Feb
 2023 17:50:25 -0800 (PST)
MIME-Version: 1.0
References: <Y/jRxug4oBqJeEmy@yuki> <20230228154203.2783-1-akumar@suse.de>
In-Reply-To: <20230228154203.2783-1-akumar@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Wed, 1 Mar 2023 09:50:13 +0800
Message-ID: <CAEemH2ckPoouuuBwG0q=GUUnh8T6D_FQ656E6gfT+9iS3Ry6ow@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/1] mknod01: Rewrite the test using new LTP API
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

Looks good:

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
