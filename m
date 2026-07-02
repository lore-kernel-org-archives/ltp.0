Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FB9C43458
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 10:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782987032; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=za2SfrUhy0GeKXF4AdV3U45sQJMmMHM2HLnuAXF5WRo=;
 b=DKgLOsxWChgzmeK2bHsd7kkBrj0CnUO+GuPshWMDNlX8+kGfSWWYWtvN+SvlGCqsvRnYs
 xmj1mL4qfpfwZVe2JkJotp3TLliRpRSbos4SILSVR6o7hV5DF7ZHyntB5OUdAjEKs53+bYm
 vfLSHI3OwRirbb1Qts2WlVTuj8LodEs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 047FB3E4A05
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 12:10:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3988D3C5EE8
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 12:10:12 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8F95B600141
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 12:10:11 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-472a14c9965so1357369f8f.1
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 03:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782987011; x=1783591811; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/LkirdcxMisVWei8nINXM8nKqQRMGR3iXaps2s8iLWs=;
 b=HjuJ2O9IAwPP0klXr/XzgrfrtBUL1/7V8VEqNTOYXGeYB5n3n/IKd7/7RPgVpYu4j0
 Do9SuaNIqRcLM1rlpx5ydfmSY8n4Sf5YNpMLQpgN20Qgdq3C0vl7dJzCa916fUmW1NAR
 ClGyzTmiQtzINkUFZiH6AMoSTkPseZ+HiNuyW+HFWsjSYrH/Gnm7a6kE44rqwOa3r9RX
 D8+yqmZq388SXtGom4r2DPn+UzYtDR5oj+/i8xCp07cU0iuODkdu8Say4OFHSLypftCM
 gc/XH+PVG8NY9mrYpQDKFOT2iFavhBZB+2zFwU0QA/uq8UpI+vEPNIrvIfb60GMtjeUR
 KKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782987011; x=1783591811;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/LkirdcxMisVWei8nINXM8nKqQRMGR3iXaps2s8iLWs=;
 b=GsV9Uo+627hlu19wfUdTfxxTJUgAwtpiSWo8sViOZ0Zy4Zj9A5StJoDhIzy96gyPQg
 2vmdW7HNEO9PEu3cPEkgSasZBhHXoSoRzt/wLSUjroJe4JHjIEogz+iny0HcUjVJinLR
 OLbeeQw/fEzCKlkYa6Brt/JHkZFgx2Mmh97UtjOBwJ3Bt0XplGNrDZe01tNFpCSIWRV0
 A5tjFg5CamWSI42SHyKugsAVgj6uoQT07/YyaX2E6RR8Plbrbokq2re2tiS7ADXlGsp/
 uPp52dVSRDloqe+hXll2ldp1rMsYe9/B2rklbZqjBRboZsvyEaRwq+nSToZcNNwgbKf4
 zrbQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrmr/Zfz3P3JIKf/zoMm77lK2UN3ONf5YmCSgpDNAHn3EcPXtzTCoMy526zc2q7WcD+5cM=@lists.linux.it
X-Gm-Message-State: AOJu0YwsgVKKZHxwJH+0NOaKh94qVTzN0IrUP3npif4BT1DALZCBNNKB
 fBkqCh9j6zJ3IRrMXG3XzeLqEO1cyqRcPRd5u/Ebeh3jvuyQazodvucmBxebEqW0S8o=
X-Gm-Gg: AfdE7cmCAqPSTMYpBk3TCVCVJaVOY/Gm7WRcDEN2fSdh//YAvz+41u7LxWmYMVGlbWu
 tQrDipqh8mGwb7s41XPB3b5/5YoRPDITksLzFeiXZbe7wwGpmsKDHcVL8mUWAAQwW+o5PWUbKxz
 PYVNWIvbm6VLVtcdN6ZeyqlOaRkzIog5iJ5dcd8nr0840CPElUe1MoYchbDltVqkI4K5lYY19FB
 Aj0RwRMOLtaq/KZkMb2T+mDH4GRUQ7Vvuga0oU2bfRF/RIwCV1AuQjHMYnhmuCUZBUIZDZUfulH
 Csh+pNqvSjUV0KugYzPj5poQN+nC5lDo1xy01dOSYD9Spgpi4dN0q5HWAjNQRYAnbn3XyHRWoj4
 xF5ySQuqCTHqtMgAEI5QFjErqRgtQk62sEo0WOWqob2QO+yyJTFlqEkDzgfth5JDbtd+q5s5DcH
 ENpL55iKfKFHnmb0whEbr8DioY83PQPsdlx/LamqTySes+qkGIzsAVud0cWAjknu3fJH1sb3QZz
 iGi4j7VzB2TYBvRckWVv4CVH/jj12TmzY2ARxPqlk6NLGfbwtYfzTGJ7lxFQuZ90jQ=
X-Received: by 2002:a05:6000:288b:b0:472:76ad:b329 with SMTP id
 ffacd0b85a97d-47757f4cb69mr8360915f8f.6.1782987010847; 
 Thu, 02 Jul 2026 03:10:10 -0700 (PDT)
Received: from p200300ef2f13eb00a65561a8bfe9e52d.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477d766e0b4sm7115401f8f.0.2026.07.02.03.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 03:10:10 -0700 (PDT)
Message-ID: <6a463902.41a38e5f.27f5bd.337a@mx.google.com>
To: "Jan Polensky" <japo@linux.ibm.com>
In-Reply-To: <ajQFErzQW4qfU_Cp@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
Date: Thu, 02 Jul 2026 10:10:09 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] swap: Add exfat to filesystems requiring
 tst_fill_file
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

Hi Jan,

I seen you implemented in v7.2-rc1:

commit 03a43677ca91e3997355a13b1da6e47329b025e1
Author: Jan Polensky <japo@linux.ibm.com>
Date:   Tue Jun 9 18:21:49 2026 +0900

    exfat: add swap_activate support
    
    Commit 07d67f3e9083 ("exfat: add iomap buffered I/O support")
    converted exfat buffered I/O to iomap, but did not add a
    .swap_activate handler to the address_space_operations.
    
    swapon(2) on an exfat swapfile then fails with EINVAL, which causes
    LTP swap tests to fail.
    
    Add exfat_iomap_swap_activate() and hook it into exfat_aops so exfat
    uses iomap_swapfile_activate() for swapfile activation.
    
    Fixes: 614f71ca1bdf ("exfat: add iomap buffered I/O support")
    Closes: https://lore.kernel.org/all/20260603110212.3020276-1-japo@linux.ibm.com/
    Signed-off-by: Jan Polensky <japo@linux.ibm.com>
    Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

what should we do with your patch in LTP?

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
