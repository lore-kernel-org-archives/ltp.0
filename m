Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2954F8D748
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 13:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776347750; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=YvqeNtpBPm9qc3OSfFqse2kZPSzscZfUvg/b/x7dFB4=;
 b=BTx2KvFtWbA3ewScf7EyNQlrRx5hCN1J/qylb3AXJhtCUT4dtJHmhua1muDY4focv1OqT
 KCYVYawxJPduzxDYrFeScuT8QarMRnn3n0OG7zjkcPTYqXc4FByfAOh45IeV2pHImcjyg02
 GpcJdqpy2SBZb/b1bsDR3eM8FaQNdH8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C2693E2DEB
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 15:55:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B6893C1C92
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 15:55:26 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4A3DC600A43
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 15:55:21 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488ba6366a7so96477305e9.0
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776347721; x=1776952521; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=vwL83qEngN7e6AD1Mj79n9iCe0N+D5Z/xknt+6rp9xw=;
 b=T+itLf+bth0Vn1JLdSiNEBh4dfWDrJ03eXT2x/qgbGAQKBLaKFUIKuIHVgR2fIRJge
 FaYfB9vapTs4i6Sq73tXNGc75sCJ5HN0COM8HxxIQ88utP0c21vLQCf7LOc49oLBZLzI
 jBFQgXwQ8F22ILMK6h+3TAjLN9pT4243OQg/JACjePivhUMDkVAN8DbsNvxcsPF/z1mf
 zAkiT0dSgUygfluHbWvi4ZEn7R2vQ6MH/CBRd/Isb4UAaPa1n5QFBULSDbuumHdt6umB
 qU2bi5PSZx2OYioCNaRVrn2mkzuTGtF3Y91inA2BYWnCztlg/lfyxfEso1GH+0eB2f05
 Cb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776347721; x=1776952521;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vwL83qEngN7e6AD1Mj79n9iCe0N+D5Z/xknt+6rp9xw=;
 b=g9dn3humMilKGvcktf0BjxZk9oWjBy/JyoA/f/rSgGg0ulGUWeWh04uKjfNx2CETY8
 aRM8ZzK8DNg/wlWKhDxPfGMA4k98Yv5Mo0cgIVQMIc/X5DbyvQNmj4adi15DNdoG/m1A
 bpomGNYa2iGFWTG2DZm4dmFuX8kROYqqcCbl7sQaGY90yP7F3ijf2WoWEwPO028yqcPG
 +F3IuyIPMomQIMCIWowUnpeb9MaKVgot7awll6skWzBbyc3xCiFZEhdUCwa6Ap2Sn0p9
 BmD8ZdJ+wQlVqPudUwwrhRs9KqUFjJ+4hg2JVYrXCcfxqYBQRfwuWT/EhRiTwv7eB4q7
 J1MQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zjnTeYVK1yXuMSIKWs1tOZ28ceJbTOgWsmiedsEv5VJl26pwZ/ApbFSQMizVKWryGX68=@lists.linux.it
X-Gm-Message-State: AOJu0YwPCEct9OSCde+Y+zhqO/O4MenaKeugVOhrYijTFCm7CDUKQPq/
 EHZV+soJ2RzfmX9QivEbMdY2aB7cj/ApAbgBTj4AEcgaNbM3kTLm0wVU1mJb0Dbf9/c=
X-Gm-Gg: AeBDieuRyEITvMk6WXGRf4/D2iQFNMxF1xMd05E1DHh2ueqPttNbc5lm3vxASbl2/rp
 y7fhC5h/J5mo14Rv0VrCUmL+SiveNKTGVCH2ZI8CaLNxvkpXkxNHtZk7rDrW09XHkBsUUNGOHhX
 Kzsd1q2ZedfE4XS7Ktxj6oVXXjpTkwI9rhRgKiUrRE0V6YtIwxEdLDT8C/erxCuUPHxrpj5IQHC
 Kgp9L8S8NovqcVu5M8U6NZ9OoOzKsUCyyonIxiqi8wsIELTnkYa5py3RvQOsYKGvwxUsb7JxTNK
 WjYl2HdSrmTJL7KVEihrzUSj08zrIrz3UUCMpjwtHmwkmMaR0+D2k+eMgL2KbIVtx9f/rG+Syr/
 3ZiBvHvesl6GzZ6FLGI90RKG/fR47Icvt87um+5pswBVeQFuHG6srV+M4tniKHor3MwpyuSsTGg
 TJs3G0CxG0SWffW3YiaoOcGaWogSClt6aUk6OSb3jNF7359T84spk=
X-Received: by 2002:a05:600d:9:b0:488:b4e3:aeca with SMTP id
 5b1f17b1804b1-488d67bf177mr289831615e9.1.1776347720595; 
 Thu, 16 Apr 2026 06:55:20 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f581d8eesm58408085e9.9.2026.04.16.06.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 06:55:20 -0700 (PDT)
Message-ID: <69e0ea48.050a0220.3113a3.2c6c@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260416135252.3834-1-linuxtestproject.agent@gmail.com>
Date: Thu, 16 Apr 2026 13:55:19 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fsconfig04: Check FSCONFIG_SET_PATH
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> The patch has a `Fixes:` link to GitHub issue #1169, making this a
> regression test. Add a `.tags` field:
> 
> 	.tags = (const struct tst_tag[]) {
> 		{"github", "1169"},
> 		{}
> 	},

Please ignore this, I will add a rule so this won't happen, we dont
want to have github fixes inside the tst_test struct :-)

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
