Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44115C19776
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 09:31:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01C303C9E32
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 10:31:20 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 439BE3C66A0
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 10:31:02 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BD88162FB91
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 10:31:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740735059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NuTlVaKw8vdDFYw8JlYewAclyoYkHOqqjR3/BLHaxtU=;
 b=ddoOn/F9kIQL6KJPfItnjfsphwZDnUPj1AqV+bAc6ISvgCKDekzCdW7mk6pxeQ7fam60iY
 20RinmZbAWvYoLhGY1JnY8gsm9Tn2LVaT9lBBX6S9pXFo1jgs8QW13RBC/TkUsXbUWS+xS
 v4UnL3VU3wXUHHRoCKM3J77/yvKhN+8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-wYnIXI1ZP66xjMN8RuEUMw-1; Fri, 28 Feb 2025 04:30:58 -0500
X-MC-Unique: wYnIXI1ZP66xjMN8RuEUMw-1
X-Mimecast-MFC-AGG-ID: wYnIXI1ZP66xjMN8RuEUMw_1740735057
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fc4fc93262so4233727a91.1
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 01:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740735055; x=1741339855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NuTlVaKw8vdDFYw8JlYewAclyoYkHOqqjR3/BLHaxtU=;
 b=bINEYVAwaLW0BElWbXH6QU+6/9+dsMYeVs+FtnCe/YDirxl1ZqpbV3VoZMZ0sP8CF4
 hURrqgDqEAszdt5M8w8Qz89d3Gd15Rj/heME9n0VL7zIwQLsQ4VmEWXOtivMOFaJsM+e
 nKRuBiZv207gp4KNmFL5SD9WDVFfc/yZnr56dqKtJJJUf4FBYwQXnOL+eIsCVFOxETwe
 M0eZlvqYi0nPtJiXSn3XzEj0KYfC5REhY/H0Q3BkdJsfrLFfhdOyPUsjkMjwdCtaedYC
 szU5sbcy2iz/uf+tkKEk1P+aHEsnwk4yKZF7MFeLK91SPJrgsPhT1ndEEtuNzrRbixiB
 AAUw==
X-Gm-Message-State: AOJu0YyK9tCXzALiwB2/ADoZS2EXwFZX4DHPybxpYCTureywfi3qIRoN
 iXfWlqRjVxg7U1nuAzKldHqWsgJIjyVhonqkug+sbubp6ok7EkP1NBcHpJc0TrQvKIvHnOd0csK
 AIczNPh+8dphwF7chCzg05ESpEmUSZfZSIHR7h+a+erNUhLk+tZ+D/Co87UWL6wwjrDGnwQcNWc
 YwXRJ7yBtbXbwzCZgfjlH8VwyNdD6kqVz3VlAR
X-Gm-Gg: ASbGnctgFqQ83DbNarxvLrieMOGAsMZDa+yUuG05EEATHjbsmxktD50aZ0mz0LFk2vV
 hRxT9d7YbiskVbK6lvOItYADYi0rCdHeqa/t1ykibOQhQv87M22HaS9Kft4YtEKeX/gCzMR+K6g
 ==
X-Received: by 2002:a17:90b:180b:b0:2ee:cded:9ac7 with SMTP id
 98e67ed59e1d1-2febab79a02mr4438123a91.20.1740735054838; 
 Fri, 28 Feb 2025 01:30:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZWyq+GQYSP1JFKTjuBC9knp4/BPpL2kHAKMITds1siqSwsUMUIWbKh3AiLgmcJE4viZioojnj6YP9W+UsThs=
X-Received: by 2002:a17:90b:180b:b0:2ee:cded:9ac7 with SMTP id
 98e67ed59e1d1-2febab79a02mr4438059a91.20.1740735054197; Fri, 28 Feb 2025
 01:30:54 -0800 (PST)
MIME-Version: 1.0
References: <20250228091451.579579-1-liwang@redhat.com>
In-Reply-To: <20250228091451.579579-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 28 Feb 2025 17:30:42 +0800
X-Gm-Features: AQ5f1JqtRaIZFpCrxygkKtgU3NSlSsf1NqYV3lBnoqmrg7asCba_vcNYMiePDE4
Message-ID: <CAEemH2dSqXFsff=ie+eR1NT6pc_zTEtxjXC0KdC+oW2AqfDs9Q@mail.gmail.com>
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e7Cd3ku7VbIWyVHOHVG8SFUcRlfAu5BtZPLZftUYbT4_1740735057
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] resource: explicitly define _LARGEFILE64_SOURCE
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

CI Job passed: https://github.com/wangli5665/ltp/actions/runs/13584917259/

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
