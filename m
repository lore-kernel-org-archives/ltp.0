Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2225BCD98F2
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 14:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782137497; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=citIBF2ARErDosufXsAgT4lhNHU3GQPbrY+AIm1GDddwRBMPhuyQinLYvNfadN6Tj7/X0
 RNYb0sT1xY7KO4ImoGplEMIDTyZ2AFsL/ZkVREq+y7nyYuIj9muOCyzPRhipoyKnj6FLmcO
 6CgLRdFfDWhU9yOrDXi1Utolnxz4b+g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 933853E4A7E
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 16:11:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AFAE3E234B
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 16:11:18 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9125D100076A
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 16:11:17 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4924f8db066so8965585e9.2
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 07:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782137477; x=1782742277; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Od8CuVSiT61zKIrIQeRRxJ3fTep7zD7iMCXc1dXmZxct3PmXIEuWmoo/eYW061MTsy
 8gIhLYFR1CPCPKVb0z+6onEl7rnLiDD9SwULlx7/whdm/jvc/gdB1QC6hjW1P9Fh9HUl
 acV8diIVpnQj1tcwDVjol14JoU2V5mYuMlN09iudVahG5fQhG73+OzyZ4TDORymCLE9n
 UZyNpKQ9PPltOL8ZUeMxKAkLhi8yBhvcL4n91ZjC+2Yht2VRC0unk3mYGPDoDROEhkdt
 8dgbBDLShHJy6hsDwA+sNSBxgkApEG9C7mhhFnYNviTclsQoMxiIhaFMvhLCep0P7VTZ
 hrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782137477; x=1782742277;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=G0uM5fMl3b3z/+CPp0s7yckadTK/LpAepfMllh9Q+xPGr9irm+vlmSdPSQpc2HjJxp
 mF8LRgPyfFXJ537qX7rU42ZWLaIiBJ7f6Dmr6i77oviUP4/sVN6RiY04E+lBrNZV0bT+
 fWZbgQOh8vNkCkkHvuQmFtL2uutHNDN9MD5smA5lcpVNnwgGBKPJ0/nB5A9u0U6pF1Xa
 dYUX0+77HGmnohsBXU0Iys/zVXW6Vu2j6SEHe3f4Vbs/KSDiAWpufohr0qThEqAM27jg
 7QCH2BGRMNKWETofS0hfX6QFLv2M8BDQ1Z31SFBDkzF8HYdFPs98w7jD/z7rUNXx3tVS
 PZWQ==
X-Gm-Message-State: AOJu0Yyixu+298R06s/mWA2rr++xDClyTwB2KMLTxIUk4YuijG60YjvR
 w5dIclXpNow6+XOiDQ1lMjEnEsnbwiv7kwdse79XMofLdr12X2r3fNL3WkGZpPxRaacp8Qi5GCS
 s+I7Np4tJag==
X-Gm-Gg: AfdE7cnK2R/hcE1TnBxQF92UgPCAzwc66O7sWPMuHAOeXFbfft2HdkKIiha+LC7Dr7p
 TO8EJaPfDr9TJnIxwTi3FsNJJt9xIRVzu9JrqekTEUJW2o4wlPRDzUMM/40GsxSQK6VulIfo43x
 WPJjQELLD6IwmCRmPpCh8LqWmSqX8BVReD/S3YAOWR6iO1xztMxBF7YjtVpMxGH2Vpb55SKfGza
 vPMP+6EpiaGDv8w3LmoD0Cde/7ht/v+oweEcmypG/87vJxFwKHoTRYBhh0J/KPzYMBR6sboT6z+
 S03QS3JT6EeQoMLQTCJsDQr3zHUqCl7+pCo2sKyZLcWjb6SmGAIMKr9wmLntWDnCiRWpwhuSoNs
 TmILAcUDISgsJ3YpOhnm+HJDcxyBIU0ZWfaWWFbcUPMqlNYbNJ5w3QjuYxkmx+niztoWIecCfpS
 OeRzN+ftOZr0RoaOK7L/KA3SO2L9sp3FT2J3rfHMao18I+zHTIT4lc9lwCIo6JNA==
X-Received: by 2002:a05:600c:a012:b0:492:58d6:2565 with SMTP id
 5b1f17b1804b1-49258d62612mr16371115e9.25.1782137476889; 
 Mon, 22 Jun 2026 07:11:16 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49245a69f81sm268432975e9.1.2026.06.22.07.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 07:11:16 -0700 (PDT)
Message-ID: <6a394284.3dabba3e.3a6ad5.6c4e@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260622-metadata_cve-v2-1-51a43dd6c4f3@suse.com>
Date: Mon, 22 Jun 2026 14:11:15 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] metadata: automatically detect groups via tags
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
