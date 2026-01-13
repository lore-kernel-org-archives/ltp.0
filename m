Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7E6D0C830
	for <ltp@archiver.kernel.org>; Tue, 13 Jan 2026 10:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768299931; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=0ZfOE+zcB7WDEiUUgmR80pIH+Y5HxZubK8HBfwyOu6k=;
 b=Ep8GDDvqvRQEHxpm8rWJRvo5QH9hZjEasWH5d2ZRUxwTY44X5gf0BZWzkAOzUKain0I8R
 R0MLh6ncbEKqlYuv4Rk+Ho42rDO597CN7qfKabCStrt9oehvXTOTh2qLWHJwEkyKzOVKe5E
 lDdzIqGRAytFDFdiEZ7Y3dIDtH3AJ7w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC0E33C59F9
	for <ltp@archiver.kernel.org>; Tue, 13 Jan 2026 11:25:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA1D03C2EB2
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 11:25:07 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 940B9600845
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 11:25:06 +0100 (CET)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so74355655e9.1
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 02:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768299906; x=1768904706; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V60oyL1Rd3yeeev2Fmkn/pFswzr4GScRImx/dH6Zvy0=;
 b=VqSaBkT/qAaTqxOxABSVjp9siWl/a7ggW86Qll8pnnGO+DBWSiM9T7ESdWJOvlW2ha
 /7YNsqAf8mYRAXFVpe+ml9YtyoQMT6QwunZ3RLWazJ+SJl8N7aunTeoqTzQawibUe9N/
 7NdCXNHCiSAVfgZbC/RGM1jtEXUG0Ld9BWN32Vbu05TafExrJO1+NtYcVpuwUBJHdcul
 4AXL2qXsAMGfjMxeKlnJHmr3QhOQvuaEvnPG4l8CFMoBa2u407PqcSDZe1lc6cbvVYSV
 VPibP+7T5x9b8n42nX2PMW/26tjtch+DqNmTQe+R9mOq6/AEpPW9MgfMTDlCrVjtfP9D
 p/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768299906; x=1768904706;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V60oyL1Rd3yeeev2Fmkn/pFswzr4GScRImx/dH6Zvy0=;
 b=H8BrVp/+AWojcNjyZLUFFJLPRIbh7q08SpzcI4wdO6MsrRLfmReyjcM8M7nby2tiIA
 0NJxka1T4H0A13A3pJu4PI1Q+r8RN5FR95CjA/eEtfNsH+lyooDmWpM44kRKDKtaNFuQ
 13fZUs4AxCpmQi7fTdTHnWp//QIZNdQsJRrEOED1+DcQkLT3WnHWHAo07syahLFnVZJh
 UV0qVST3IIq57ZmfgqpU92lxe8H4d0nD+XYRoYTIEp7dlErsILWF6/r5wV/coi8wWDJq
 ElmKLwJ1rnmge/Ft7lITNg8yhSzNgnYR9iF2t2nkVhzvMRxpYkbG1K61+Kzn3wKnbHhi
 lRWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMtmzQdKBLoePaZARRLbVJsSAjJHnyijQ8ocCU1+7ZrjG4fYWNGQxqcaFGOlVVaxMe4PA=@lists.linux.it
X-Gm-Message-State: AOJu0YxSugzEQVP6t+JQC9qGPrNyoo4jAWJagD4plnB8nAkiHNsq95oq
 psJ/UkfbRQFgkXV+f53xfI8pc4sny9x4l3pke7HZzwMCPByrmTmf7mbdPRhRIlKQbXVQ0H+iio4
 U6m6bYsk=
X-Gm-Gg: AY/fxX7RquMIKfGZ0+5v3u5b0hgUhr/3DXY84ia+/p0ooYF5Sucbgcj2ug/gM9sL8XZ
 AnFpLv+/C6SY2L7N8+78Qng2LqPNoG6nO5ci35xjzqKvJb9ab0acfMTmFpT5St3ScbIZdNNhKsv
 BRI+hyTZjbZ11d4V03KVJzRNOtoBCk8k3n20AIuQxqU7Gx/oQRNgs9Cq5JYvycuk0CRI9FyzJx+
 4sy1OX+aj5yEC+wooc7spcqHFlEwYhB5gKsdzjsgV+HottqLbBPZ2187V04LeyuFvDkQVK+LqN3
 ch/ehREih9Ocq5n21GZe+JAVY+N9quaKJAsY+C7tpToGlHairMEEvJ1qOHtZ6oaaW+smLP3ArJ0
 bQc42NM0p2ClcXZrv2giJDd3hTCGgH0iZIx5PQFaPhZG0esI9l5W6+//s9Wx6nkVQp7HGcQNcrR
 aLkKrHjkEEQIA+oMbGZ68SsGw=
X-Google-Smtp-Source: AGHT+IFrpdKcStxXsAQP+Ma6rQReqclb+Cf9x5x0iyDj23c0zrI8/RbSaeqptcKuSCsAPO7fP5nChA==
X-Received: by 2002:a05:600c:4e86:b0:477:9574:d641 with SMTP id
 5b1f17b1804b1-47d84b3281fmr241719325e9.22.1768299905977; 
 Tue, 13 Jan 2026 02:25:05 -0800 (PST)
Received: from localhost ([88.128.90.24]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47eda443187sm11524355e9.13.2026.01.13.02.25.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 02:25:05 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 13 Jan 2026 11:24:59 +0100
Message-Id: <DFNDZZHQAM7H.3S2Z4I0U8HTWR@suse.com>
To: "Po-Hsu Lin" <po-hsu.lin@canonical.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260108162152.104192-1-po-hsu.lin@canonical.com>
In-Reply-To: <20260108162152.104192-1-po-hsu.lin@canonical.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCHv4] listmount04.c: update struct mnt_id_req support
 to kernel >= 6.17.9
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

Merged.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
