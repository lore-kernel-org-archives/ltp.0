Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27414C79FAA
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 18:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788805649; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=FPl2QqkCoy/T7Gm/sTDasjOx3uHKgbftijQ1lC2x/Ma0ZALWg0N3FBblQ2l0depqnNWGJ
 b7fX/kj71qpkggZ6Imakz+f/KnyL81jklREto3/6Mivp1Wj+krIRp0Sx1JxAiN/3CqnxiOR
 DAB2zDMeA22OnLR3TKKc2Q549en+78A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D9F13E950C
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 20:27:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49BAF3E6EFB
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 20:27:09 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 887EA6008CC
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 20:27:08 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4843e397f74so4607466f8f.1
 for <ltp@lists.linux.it>; Mon, 07 Sep 2026 11:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788805628; x=1789410428; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=BsucLzlNd6geiheqvSWt3W4qMOeur0Ynl8aSQckx5eve6iA+i9lUsK3jBAfy5cUcFI
 cXsjoOhZrpIwJWNbypO73Dt8JMHbYjWxKPR4ZPiBaLz3V3E7ayxRG3l91CPmChxgNI9X
 7HlWdNleGlpVsNTYVqZO2Y2Pr+BJu0iKLrIpfTgzqaFmI78IqeBtBjQrTsCP6co0riXg
 sNaeRZVmn5BvD5A4KtTDhBRgUvoKI+XsW62z6rUtDEcOGzt8SOv+2RcoaFoEWKZuyb97
 1z75pfX2NjYVzG0C+MXFeOmiB1CAd9Nibo71UUmW4IzkzJxSbA10W1MckndFUEp9nKfy
 VNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788805628; x=1789410428;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=h7KE33xpq89pyAyYE3pX37/0teSWEVOYcHgtIC1JsSsSlbFxd0gitEc7NrnuKrTym3
 3/m6gPDcGcNg2U4faw/TLYDkLYeaXE4VzbDMCIb2H13mNOT/JG/sdRK/U8/Kmb4wwKRh
 8iWSCIP4Uku8Ny1mJbit6eNnffhnwvIMQEJ0bCUNl8ScK3T8NMmCTNdBXeV+zECqR7Jq
 spNeUPPwlS3i4TpG6wzE1dIdaRb2UvVUJtTGVR9UHR4BDjY1Ie9nZXKK2DK7cEVIwCj5
 ql5b2ddLxxrr2lhaXkWOPeBh8qWkYHvunjRjGWSSlwBYVPoIpdcLXmwxsgDxmrkL8QEQ
 ekKw==
X-Gm-Message-State: AFuF++lZUhPzg/pj7hlwQmZvoSl9smS9A8RtJo2U5ayqO2+Ro4VSsig9
 M5Izos1CHABkPNBUqABCetZZJ2IjN+vb843O/RbVD+KDKFAUy9ItDqfCrv2u6VqPZLQ=
X-Gm-Gg: AYBFou3e41ncw1HHEVZpBgmpqA12yETHxNYCx9MhigiVAox60aLFyHWVq/f3rErPdR0
 ukJ0S+e1fyu9qo5t1VWIP+GiM0QoTAPbU5pc+nwqaXn9eUU8+BwTp8UES7o7doQXHLF9qpvR/Vd
 H1v0O0u6H/evwr3uwcMn+sVnLuKDPiLWnmdgRtJHyYF3yX3RnVVaB57QLC4Cp7yUboS8cVSVj6C
 9EQRvHEzjAZ9rFgwm2UkbwIbjr1VDQVXmf4h4F4taBGyvXKunU5mIo6RKdws9KCtyy2qZzoM46z
 lUuA2Fv8obRolSw7VolFPGPJizSF5SVENvFbLI538y4HA9it9htWBImQ2+a9KkfD0Z2pxURoP+F
 hZFyhBZ35sUArmcTQwDFhsbOHuqyoIQ6mJ6eZota0hLXe4le+s+0TM/FCCzpqcxEDaF0zoIIbLo
 D9Xl67mCmtDfayT2d7Mo8LUULphhWiRlg0rvC/8Nc+5eKi1HqgCb24wkw+lGgzqwle2fAiUaKYI
 QGVxBBLaumHZkfrCCKHxc0fn8CbqHIVYFyTV5Vf5SYK5ShDn07OfQhEhzN7whVo88OCU8k=
X-Received: by 2002:a5d:5e88:0:b0:485:97ca:376 with SMTP id
 ffacd0b85a97d-48597ca0632mr11302994f8f.2.1788805627803; 
 Mon, 07 Sep 2026 11:27:07 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c6ba4sm34652749f8f.25.2026.09.07.11.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 11:27:06 -0700 (PDT)
Message-ID: <6a9f01fa.533956e2.3984f.7e8a@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260907-ci_patchwork_apply-v1-1-95d71dbacc5e@suse.com>
Date: Mon, 07 Sep 2026 18:27:06 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ci: apply Patchwork series via REST API
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
