Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EC7C5AE59
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 07:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748936756; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=NhU+xiOLc2O4/LUbrp+eJukJ4a34OnfxndmX2t8lC5U=;
 b=k1xH4WtNFT6/ZITEIoHcDrN9iV+jgCV03qX5tWw6TryTTwD0b93b1fQvXOz3PlFkFrB1k
 V/tfTC00/LR1nZWETOyQlEASgtBn6rsvCZ7veN2Ql5nzvjek8kYdWhqfYd7xAWWgzYwIhK8
 Z+kaJ1S5CKGZIOUyw66D3+E6hO2YchA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E08E3C9ECD
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 09:45:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D11CF3C7A25
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 09:45:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1E966600D67
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 09:45:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748936733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MBlxiozqnL7WF4H5jHimhKioGHPctu7HKMHGQNp5HRU=;
 b=WcLb11GYyuZNE6anV8nDhQQvFfScyWjY0Cyt7hpx7HvH8XKYbvHJ5Cw4ABZKiB3qoxp6qn
 VRHJ5HX/vpxPzeT9nIltL03blxjg4xiENmlGe5aumGuZR+PFoYvbcPZgonpu/X8UbiCWqW
 zGkOlSXGv0pbehOXQTEnWsfKXcybUU4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-OSOIcQizNyWrQVlq4aHv-A-1; Tue, 03 Jun 2025 03:45:29 -0400
X-MC-Unique: OSOIcQizNyWrQVlq4aHv-A-1
X-Mimecast-MFC-AGG-ID: OSOIcQizNyWrQVlq4aHv-A_1748936729
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac79e4764e5so547882166b.0
 for <ltp@lists.linux.it>; Tue, 03 Jun 2025 00:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748936728; x=1749541528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MBlxiozqnL7WF4H5jHimhKioGHPctu7HKMHGQNp5HRU=;
 b=AYTqxRi0Po9qGIW9b5PNyvlu88yLYoqMKPnRV7QD1kmdSh7a7fcm13wuoAyfgBID0l
 v8LcQ9Zp8yGNjFy4yG/18+Qe+T0X4NIXwaVVOPcBU3vd109IdAopSFfB65MqRunZdL+v
 MdQ3utiluLD/J2S2DbV0bZxzN2Mzv3xyW+4lOhcCC3bhrzBPAQzgI5oAu0EZkQJk438P
 Avvc6i1vNKC1+0S++vdpW5ENLmZHR3WrwnOkxDiegmYrrDREEjhL5MIBf9IXG9hF/EGN
 X3TbaaIHIkzqNwsXZxbWxpBZscI4l5od2hCSKnI9TfBFnJuDZfUuQCVWmlBjCkNCUl5n
 6rEQ==
X-Gm-Message-State: AOJu0YzL3xZjJbTemU4V0EetrHfjEcZaa78q5nJ+y7JRPmSYKVO8P3p7
 KBcdUWUlk53uGilOX3cgIdnruL7O0qSfNbHiD/NyrgFaUHfSIhuDcgPWsl/RkhrwQ+ZdjEorfxc
 fGHnsSpDLR77vxZwHNujW6Xgv/i/Tmu9cJuJrdtdZKse4cU5q7xfXUYRJ8oi2HPAOTL5s7HKFSc
 r9QYR2OZlIlaWgk7I5qLKbzOU8ffk=
X-Gm-Gg: ASbGncv7/VHBthY1pJAEqSh/tLhrCodnxdk5xnHgeYYTyX6XFCulmZKi5tlnLsWnbPR
 YE2mp9zf9mWCd7QZ6qdboVulcd6vGSwCVBjDQtcBR3C3hQRD5q5bmOb+OQT469dXUTwTxVVV2sm
 AoTT8J
X-Received: by 2002:a17:907:60d6:b0:ad8:a684:a1f5 with SMTP id
 a640c23a62f3a-adb36c18f79mr1194977966b.60.1748936728416; 
 Tue, 03 Jun 2025 00:45:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6cLp87N6RwPYcablyVSuH5dM2YYhL53nXIHEEkhQdK1H1SvMwhXs05Bhxjfzeo7zEAEda2vHTQK/Vol9p9zk=
X-Received: by 2002:a17:907:60d6:b0:ad8:a684:a1f5 with SMTP id
 a640c23a62f3a-adb36c18f79mr1194976366b.60.1748936728026; Tue, 03 Jun 2025
 00:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250602141919.329370-1-pvorel@suse.cz>
In-Reply-To: <20250602141919.329370-1-pvorel@suse.cz>
Date: Tue, 3 Jun 2025 15:45:14 +0800
X-Gm-Features: AX0GCFua0NltuFwg5_JEfbLjdMWVGSqUUKDdl2-noTbNpbEusnM-zO94CaS0GEM
Message-ID: <CAEemH2cth5uVKT+o=vvQsq+onLMUg0jZpTzBr9TLrgb8UBxuVw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ADH5YqVe9ccB9Znls0LvZ0jEXYJEIjbcNBiNQB-orFE_1748936729
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH 1/1] Remove kdump testsuite
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
Cc: Qiao Zhao <qzhao@redhat.com>, Jie Li <jieli@redhat.com>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

I confirmed with our kdump engineers that they had ever got some
inspiration (on crasher) but did not run those code directly.

Acked-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
