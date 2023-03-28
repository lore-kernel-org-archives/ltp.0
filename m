Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF84CC6FD1D
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 02:51:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31AF03CCD76
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 04:51:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A908A3CA3A6
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 04:51:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E04BF6020CF
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 04:51:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679971862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yPJJKuaHEUNMK92C3YYnXeWeSVfyhLEy19eUhKdhkso=;
 b=bbqcUgs0ZA0ur3wPRCRJ2jTgCXxxvWsUSYfZzr2p+FVmsItKMddKp9ubAwGivthepNqiJ5
 WDMKNZ+nHc/HSCwRoLNZzVphzND/BNH4b7e3gW3sjsgf9valhXUUBXzsGGXlCQVMvq65GY
 wIbOINcyK6pihZ6FccuAif0sD6PQLHk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-H92g_bLHPz2ZrGaJvurHTA-1; Mon, 27 Mar 2023 22:51:01 -0400
X-MC-Unique: H92g_bLHPz2ZrGaJvurHTA-1
Received: by mail-wm1-f70.google.com with SMTP id
 o37-20020a05600c512500b003edd119ec9eso5580690wms.0
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 19:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679971860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yPJJKuaHEUNMK92C3YYnXeWeSVfyhLEy19eUhKdhkso=;
 b=U9POjkKsT7tLDiySa1SanhEYZt8GmuXE/NqGgtwA9TSdnIUG21b1xY67CL6Fb5B4Bh
 pWldMaKryXswRMaWpjFBaFKu5vSX1cPgvpf9xWkz9SKWVsjCkXvrdBddJSinNbxbA6Ct
 6eXRPneHyprIOqQPR73xsvPGVc9SJlwpJRjW4hhXgGtmpDsQehkVqJ1n+bMs4SmQhTst
 MVRAT6muJ8949ahubqEGzgocwCp8t+qVNlzotqujQFervd4wC0Biqf1aBlVJkThcNZZO
 bPcDTsCHy7MWm+XC15KagPeI7SGZ2l+bnnq++VDbfUmDHI/m6ipPYEWAj9FZoTvjyz2C
 /kpg==
X-Gm-Message-State: AO0yUKXYjXmcJY4w7onDUaA616bkP/XeNjJWlDuM707tvyDGppJX7lMX
 R/zTkmyH4NXVc979mdgeTqxWMvV6iVSZuEwlWStLboCac0DQGXSAyYgNTfiD/CQQs+pfHWeiaxe
 iQJtx7NKk3cctkz86PvhAZYd41WY=
X-Received: by 2002:a7b:cd0d:0:b0:3ee:10fb:56f8 with SMTP id
 f13-20020a7bcd0d000000b003ee10fb56f8mr3046362wmj.8.1679971860162; 
 Mon, 27 Mar 2023 19:51:00 -0700 (PDT)
X-Google-Smtp-Source: AK7set/wU4ygnah/NRwgAM+ushjW/0lwMEQqJ3VgriBm8OYH9UEWG2M82Kdt+zx/FY6CWn9AnS4imiF3ehT63tsvYrg=
X-Received: by 2002:a7b:cd0d:0:b0:3ee:10fb:56f8 with SMTP id
 f13-20020a7bcd0d000000b003ee10fb56f8mr3046358wmj.8.1679971859933; Mon, 27 Mar
 2023 19:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230327110234.266785-1-teo.coupriediaz@arm.com>
In-Reply-To: <20230327110234.266785-1-teo.coupriediaz@arm.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 28 Mar 2023 10:50:48 +0800
Message-ID: <CAEemH2egXAZ0JrjV1KPQXpQjPN=1zmXgLmeebJ4SRDOxF7jZiA@mail.gmail.com>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/sockioctl: Make buf a struct ifreq
 array
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

LGTM.

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
