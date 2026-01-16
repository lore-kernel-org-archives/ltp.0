Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C21D47CD6
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 11:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768562458; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=G0NH4Q0MCd+WPMnzqr9cooh6obbb/8kgnw2OW8kj6zg=;
 b=D0z8xgIc8chwY5RciZDzFECe9wXo1tY/wovUzArQFlaKkhn4dO9z/voJOSZOcp0MXy9xe
 zy1Y1drV9Jft0VW5RC41DR9Nc22BhDyLmvvYUJH2xnX6Nf+PE6lm/6ufFh+iiGZVRQ3N6gD
 qFhSvwq1lVxNJOXGLixDF5e3XeTscfQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A99B3CAA93
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 12:20:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D65793C9FBA
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 12:20:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5B53B200064
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 12:20:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768562431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xuMKcRCvB5tHnerPYgIEyxAxD7qu7P1WlIxutjYnAM=;
 b=KjaVyZ91XHK7N5K9Vy7lej5172y3dvdinwF3Y5AmRpUkQz4fXyM3OyyN1g2k/BbK5QDVId
 uupTPFh96TCI4tjSW84Y7LEo87RUN3IV/fEQ9vNC2qW9vTZqI8Mbny0u8n8XyAxP1BnkyG
 AlrrpurMDBhulSlwNSliUJeee+OF5RI=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-8vGByBw5OA27_E4HwSqtRQ-1; Fri, 16 Jan 2026 06:20:30 -0500
X-MC-Unique: 8vGByBw5OA27_E4HwSqtRQ-1
X-Mimecast-MFC-AGG-ID: 8vGByBw5OA27_E4HwSqtRQ_1768562429
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2b04f8c5e84so2352616eec.1
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 03:20:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562429; x=1769167229;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7xuMKcRCvB5tHnerPYgIEyxAxD7qu7P1WlIxutjYnAM=;
 b=EA6T92Mhsssrt1zXCxb8FVVlJ10e032RCbx5fKQBWYSK3GsbQcSjM5xUlwKCU0InwT
 22XYPtLQsw1IUlz1ceAC23tLZ3ouIrky3JRyCB/1LT2WWidmPl7IpE5kTEEl7ilWVQjx
 yJIu2KmzPKS0wZ/HZlAJu0dasmOxHZomIlVeLuffqVeg7f1j+2/lPH8upK6mSFEsKDsr
 RkwcEV45u/puSsW6Y2uAo4B+rEW1WNOhCHHTGZ3iWJS+h98XtV+O9GK9NlaozP2wRAMz
 /jKa0oVh4QFVeuovmj24PU2kYNpmIzeprwUa/eVobrVY6wsSgf1qTSLypNUM99yMMoZw
 zWhw==
X-Gm-Message-State: AOJu0YwyFfh/uFMqX/kMph12Pd1DymR8cct9yc4UKM9jM0zPkB3v0Fk9
 T9iN8KJH5t3aRE+uEaJJNAQES9Am7suLF+QxeAya2Kh1XzJOLmwUaQ7heyiCfnsCsONegtYoYQ9
 Mid4MpMaxRMOe/CrG2vU8wdzxfhE3N/Hm11m5bPjTnxzBZd7kgQKKgjTIHLDoH7kwOJg2qmk2VH
 0QwSVT6kCpkrcgVjmBsAvCbHnTzGk=
X-Gm-Gg: AY/fxX4gjBljcSRDZaxbSlw/1K+AFcQUbOOkHB8dSkTEFYdCZXc8dth8M3AZHpzFiVW
 jjKk982uZah7J/1gxi3hYoVe09N+qekTvJ9ZEALXI1dWzcT/4/XH5Aw/gySuHXc7Pk3OM/5yXgo
 lRfmBeVGby5RxSDuMkIcpn6mF3WgbqxhwyFugCG+8O8ja7msNp7YW6qB31JSyI1+GHC9U=
X-Received: by 2002:a05:7300:6c27:b0:2b0:507d:c2e4 with SMTP id
 5a478bee46e88-2b6b4eb3688mr2215557eec.39.1768562428828; 
 Fri, 16 Jan 2026 03:20:28 -0800 (PST)
X-Received: by 2002:a05:7300:6c27:b0:2b0:507d:c2e4 with SMTP id
 5a478bee46e88-2b6b4eb3688mr2215544eec.39.1768562428402; Fri, 16 Jan 2026
 03:20:28 -0800 (PST)
MIME-Version: 1.0
References: <20251014-file_attr_eopnotsupp-v2-1-c9827c8d8127@suse.com>
In-Reply-To: <20251014-file_attr_eopnotsupp-v2-1-c9827c8d8127@suse.com>
Date: Fri, 16 Jan 2026 19:20:15 +0800
X-Gm-Features: AZwV_Qhclcx6iX1dUpdFvTzieIwNiYCKXTCkqIW0tCaBaVTbdc7vf5AdrZuO5tM
Message-ID: <CAEemH2cZK9O-LE88qEVvj42KEAD6_U+eLB9H7CqFcr6BS=Hu3A@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UxrFPA4A9fgrKTzqQ0aW4BgRphBbvn2V30gqrt_CXnI_1768562429
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls: add file_attr05 test
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

Reviewed-by: Li Wang <liwang@redhat.com>


--
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
