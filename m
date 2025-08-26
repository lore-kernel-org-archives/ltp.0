Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B5CC8303F
	for <ltp@archiver.kernel.org>; Tue, 26 Aug 2025 01:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756171027; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=5nCNei7O35oXtkRl/pc/y0pio4oxTVN7vsdTyhLhgr0=;
 b=cJkPYiM47S7JfHPvUWwL1kM1tzAyOhRScE/un5B49jD9gjzHGuRwzhaCw6l6Ky24jzDkv
 xMBcyHLHZy+f4TQK3VCLV07d9cGgfyRUkNZElrvLuPkjjwac/kEPBqPTt4sc/JBv7nkj3cb
 pfd51A8LHJhYo7G2VmQAHrlE3ckmGYo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7956F3CA3BF
	for <ltp@archiver.kernel.org>; Tue, 26 Aug 2025 03:17:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2483C3C0372
 for <ltp@lists.linux.it>; Tue, 26 Aug 2025 03:16:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 81CD510005F5
 for <ltp@lists.linux.it>; Tue, 26 Aug 2025 03:16:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756171004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GsAy5q31mQuCJ99NKUztDu5RL1rSO/n5Snu2zLrlyHE=;
 b=QiHfiPIrZVa8srIA9gYgL2+okshl20AIjXQc8mXZoG5J+twFWV3EwCjh8N+tMVJ5iWxeq5
 5i8j0qqJs30TlO0RNW7epyskrgdKLrRH32gMYDYY5f9jL2rHo5IoyUnuV+I4ExTQ8ThR0t
 2CjQeMDJmPyeDqXAAoBSx0JFuEMqCOs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-XNPP0gkRM0-fqdQFxRHimA-1; Mon, 25 Aug 2025 21:16:42 -0400
X-MC-Unique: XNPP0gkRM0-fqdQFxRHimA-1
X-Mimecast-MFC-AGG-ID: XNPP0gkRM0-fqdQFxRHimA_1756171001
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2461c537540so51103305ad.0
 for <ltp@lists.linux.it>; Mon, 25 Aug 2025 18:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756171001; x=1756775801;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GsAy5q31mQuCJ99NKUztDu5RL1rSO/n5Snu2zLrlyHE=;
 b=bgh/tAWDw4u8bEQ4tnMwavdpPHlVOlHf6vhByDjfy0p1zgmA7wa9+Sxda8v6MqRzA4
 +vmmzOAErnrHljGdpR0W51delbBuErNCO+HobhD2Jr0vWTvRs36bCj62qSzd1oVUtNgO
 yiNJpwdyGZfmKYSmCGMsjfbBmeW1hMPtX9bAmkFZ/9FXJvKAD3eQai9fljX7OGP2wgln
 X5mt6Ux1RlVbNLIbn57krImb83HNoj4/4JPGXNBBmXtHV3wREm3Ib3z3aeJ5haCeaf25
 BvrNwsk9WtHUkg+1WcHn4Pq8jIicNogdLZfrQnilVLD/R17LmdK8ZcbCnasHzlbK8h4r
 +wZA==
X-Gm-Message-State: AOJu0YwYibNFdyWGPS9k9jfjR7jUgKWmlEatLNHV7TscPS8zsfD6unHQ
 ovMhk21I18tiYY73wY9AcmqYxA6ai5V/2BZ0+BWLmkPIbrd6GS4MmYjZkjes47f/JlKu8Di9E+x
 6ytBDgwITjEAfHBGmw3NoTk8Us6nUtaxieiakJ6v2CGkPF2odjtB90bcvLvWUsm0xf7OD0ArYkj
 75ce03ukfpBeHNpUcRl4E8F0pu+LY=
X-Gm-Gg: ASbGncve4LG0ONYBEE4LgzxBKKrgKIuLg04kZooR89LOb4xKkj0VxGy8LojZfMeczuZ
 Nh7/7YIhtqcRNpforCXF9SJkGBgsCItSzdp3pYZNukgtLY3kPUBhy6vyNk5/zw+D4SwxLBEa5ef
 F69C01yoMVnGr4xfrch9ImAQ==
X-Received: by 2002:a17:902:d488:b0:246:a4ec:c3a5 with SMTP id
 d9443c01a7336-246a4ecc618mr102032165ad.25.1756171001012; 
 Mon, 25 Aug 2025 18:16:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFELVk/SbTGkNq45V19YRX9Rwcy+UaYbJFFh1bplZEG1e5zu787kuEstZqtc1vW8dzydzrIjIwJXlj7L4OD/Iw=
X-Received: by 2002:a17:902:d488:b0:246:a4ec:c3a5 with SMTP id
 d9443c01a7336-246a4ecc618mr102031795ad.25.1756171000575; Mon, 25 Aug 2025
 18:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250822072204.2191382-1-liwang@redhat.com>
 <aKggM4ZVmjt7x6fJ@localhost>
In-Reply-To: <aKggM4ZVmjt7x6fJ@localhost>
Date: Tue, 26 Aug 2025 09:16:28 +0800
X-Gm-Features: Ac12FXxEAqh04402vRMwrGum7ELEvJhmpWCPYvbBgixcYNBbIqovIWI4CM2e6wM
Message-ID: <CAEemH2f3AG1=BNKh5dE-Vva088ndp4E6doszbf=4XjCf+A97Vw@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rBoAVbTse-RGkvssICwNuwQt4YnBk3Ad1qetj4CMfJU_1756171001
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] tst_device: refine tst_is_mounted()
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

Wei Gao <wegao@suse.com> wrote:


> Thanks for your patch!
> Reviewed-by: Wei Gao <wegao@suse.com>
>

Patchset merged, thanks for the review.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
