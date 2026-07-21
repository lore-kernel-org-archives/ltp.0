Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C94CC4452F
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 12:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784638348; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=EW1j1APGl1rfQd607lj/DOuvRh+yCCIhNSsLnBkuDjI=;
 b=jIgpaOVgm0A0JM4hLl6G/OjIv9mz+IW4jlKIYl988v/LqClHtbTA3epQ3R8N9jSYQPe2p
 xkwlU3QJrKg/EYHLfmmG6x9u/e1YdHLxTuXswsOBCBPrKmCOHo1K2IjHPhoais/SEYtyxvI
 x1CgeEG/4IQYKpgQKaqa/TKirHmtqeU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 71A4B3E1FE0
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 14:52:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F27ED3C0224
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 14:52:08 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1EF541400979
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 14:52:08 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4955de8797cso13003855e9.3
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784638327; x=1785243127; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QKBK6Hm99B1nvWR2wYgHEqmZC+c4vy2I697YCQIWScw=;
 b=UeSJvPa+nKpm59K/2UPYteafZtIaf9aNLkqCG9LUBAh3YmGS0mbCUq5disSuugctq/
 Jkl0Jlb7rB7w9C9Fa0suCpU60XtWyq+w8YM6koNsL5rPq2r4m7KvHD80m0e2lSVvb+iX
 nG1FliIykWblXZkK5bxqVeDAEpS+43yrHsF1H114nYSRVymw1SkpaYCdl5PgnhEsqu6T
 KVFSdKr5E0C5cZAzjhW2adwgaQwA8obDXiXE8DlXYizMgh0XdqgGeVW0L+/YjUhiVXEF
 +HSSKi6HmWJsbSqoaSkbWka6S/fuspCeLUKl3OUBnfYQZkAwBTgotMR9gnQ286OnryNx
 3Gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784638327; x=1785243127;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QKBK6Hm99B1nvWR2wYgHEqmZC+c4vy2I697YCQIWScw=;
 b=hoGYrGbxtGQFJYanV7C8ZnQ1xGTInHfTRUQxevcLmXBCTVVGzrvHxcRVnwL1ASNP3X
 Ayl0wu1e/n3CLpFqqFXGpaJmw5kdIwnZg4QDHNY8U7udolCmU6oGGi8jXyCylsDxIJaZ
 rBPoJWqK1x47nMf9fhGFTALeaIlpnMPQtq1LR03ANGem+xYu+f0Hc20IDS2nPSDGACF7
 PohmxACcG3NVG7j6zDyqivLrMb5mLNQMfxEt/x1NfdNMfzkdh8pPnmMj4nW+F7yg1Izc
 d6cxein7ZQenoNr1tdcnumM0B/Q/KwihX+gPwmglEWgSSemdnVMIil4O9+N5Gd1Sj8Wr
 XHfg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBsfOFN+ckiNvQpcZRTgo3ziJaKMhP+DZMSXJJdvcdCf66AIFNvWtI9f+jUwcK6GesGL4=@lists.linux.it
X-Gm-Message-State: AOJu0YyyJe/kQWHfKw63OUrYChILpwH8hH/Ujwp/fIANJfGXkCA2gCJr
 t/VEjrcTkhJzDJRjSCbawzZqaD41mNPfNmPfShmIISJZkjaGRXsxe+T4YAKQoElDIHk=
X-Gm-Gg: AfdE7cnnfm4XfT2dTkkfCGFhskqWqmBJ/N0IrLkI28YhUzRxocoPibfHasorjxKAQpc
 DCAA1N6Y0yrpjcRPQrYh0zLZ6rj6XsyqXQxmBFRhSn6uVplssi7XRk4U4EPeOn6yEHdn9KX2QiT
 MEnhWyRDIuGbYNdcLbxBQJNJvSzaqeG1UwJXZ2cj8hq8H4h/v0OFUaSUcDj/wvbtdMLGWxxwedj
 Daf5Uxgh3+g38b6wXcZLS7thU3ZXXqEC1anTJMzTNvbczeh1VN3+qF4EGAnkVT5E7gS5ZI/peGJ
 HdECc54HskVDfKVuyaHsiMpP4AoiThy3v051wOO7kHLgJo0dQpSIL1W22vmRHM53OGoVBeTCFFY
 yYmXuPR/rqOcPnGJinRKRcLrZLBLyc/c8aVqw1u2Im12xWDr/TVyUkY92FdeZBkOoZlEnXbKF5a
 jSMVxEHzIeq+6MmaVfYbjey9pdNA==
X-Received: by 2002:a05:600c:4753:b0:493:bc4b:b8c with SMTP id
 5b1f17b1804b1-4954a413024mr200212815e9.38.1784638326222; 
 Tue, 21 Jul 2026 05:52:06 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f67466e09sm42286363f8f.21.2026.07.21.05.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 05:52:05 -0700 (PDT)
Message-ID: <6a5f6b75.f06d4667.29bbc9.3242@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <al82rifACZS3bJCJ@yuki.lan>
Date: Tue, 21 Jul 2026 12:52:05 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] cve-2026-46331: fix intermittent ENOENT
 failure
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Added the suggested check removal for modprobe command.

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
