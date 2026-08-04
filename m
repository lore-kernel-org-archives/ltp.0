Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B83C55822
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 14:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785852384; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=gSK/KF9DHmLcJ3O3ilN4XEdqgzdTqDcyG4Z0PvO3hlE=;
 b=e48yEVpf/cUSwoob2v4gDogJIDtqYzGf/ZpZuQC2ZRdFySI+2k+yPENltGCyWP8R2F4wx
 QcJQOmGAaOj8zmDjmRmLSG9WvDwspkQRvP9jN4OjjTFPXEhz8p48dS6Lt1dvNjBcmsWfBko
 y46Wtm8Y4cWALfHGJHRBeYSBEGVtcjY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 676493E7185
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 16:06:24 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C6BF3E1A7E
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 16:06:05 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8C53D6008EF
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 16:06:04 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so19715765e9.0
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 07:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785852364; x=1786457164; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=F/5FW+28bQ9pfwYVUbVH92LjZAvj+E3CmMoQiSqFXjY=;
 b=Lek563GIhKW7hjlUpKypFEUFILBg22mmvkkNwBBAAeDs8EC/TrgI6IbFp8A3KMge5n
 vD+L4r89JDKN8bMsVJ4X812a4sEhf87BcTPWEaG53QcwC8t0/HTizlQmYCp2jE0Je7B0
 KgkqmGltQy+n+6zCRyqdwaZzyZNUt0XItyPnhlFifyRxH8UQQIqfCNj5XPwgqZrbkJZ4
 TRy2lg1O4GcyYJQytPa6e/79Kd9A4hPiK8BmtgBZDWIQiA1xav7zx5E/So8UkJpUqQb2
 vmTDyJy5c+QT2pAGuxYrCFhp2a9CMOnzPIodTf7YNS6R+ic9OwKLtb1BcS0BlCluLkgq
 X4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785852364; x=1786457164;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F/5FW+28bQ9pfwYVUbVH92LjZAvj+E3CmMoQiSqFXjY=;
 b=NvndRNcndzttMm02MZS2mT8lXocxr8r5uwL+e1PpWYFbROuW+xOgViGjlBOsnwvB+b
 N3ScS1mEedcSW1pwkejIh4zWxeiJSrNk6D9XGWZZXK6bE9bsq/I8RhsKi/YdIi/oMnRk
 DuI0yQ0I7AVGvAqMzX8zHDXo8JEkM8G3g+Z45T1hIQKlMrUYxu9ueN4sEfWjUm0d/hQr
 aMQh0BQKlSNarVXUP04YQmXhNAfa38pu/Z1jSOC66ddUR9sUrQF6IDkivktPUQ0MI9u4
 TX/meH1KUxhqmKyh11NbQNXFheAOIa1j8fefPdTHNgHG68f0O35pNIRY8LAd7lpOnwpg
 m1kg==
X-Gm-Message-State: AOJu0YxPR0RpTydYMruzjOAx07PHXmfg66Cc70tEmGPqxyUDtSlC/FRu
 ag6PoRe2+bT3r9ILmWnu/XantTSBiuWO6untM3N38ev+fqHKpyWobUYLxZCwXhJZPvTtfLmxYMX
 Uli8qxwU=
X-Gm-Gg: AR+sD11KrIofU9bJ15NEEi/jrF9GD5bTXN3cgL96HJjkbDgTKvLhvTJDGTNuQxbWhng
 lvJmglIGMU/o/L3W2oaIHI85zKQrZexoXJ6iQumRmN+NI/8YVFBlSQYSL6Ts0EkbcqiUBMP8SJa
 Z421nl8jzxdKbhC79A0LLd3hjxuzlD/NXoO6DtnMxfDoE8DGkubhPPlzRu60wZ1axP4x0RUeppP
 AtWT0lZNYN0CXR9LUvn5er/fS/DtUS0A9oSccXoKgXEgisx8iUvVqyQnX/XmJAKkms/4Doyyi14
 xoINA+Mv8BZDC8PZGf+A/Zl8FlnOMR6UEOszyQhI13WglF8W6O+pcHs28qLMzfn6/zxF3WFY5D2
 E9msT53dEH3Im0/sT4+jD/1ZQWVlSqE62G1NJYhPHCztqGb3SMheuJzHXT1kEM6pHOBDqvbvxFa
 3eCf9U2e4MiABHjvxdJkXuT4ph2NY3MaJ9czDrEgci/2GFysEjo+7VFS5VTUdqNerYQLHLC+NxJ
 DeapnwtTkgTpkDHGz02cARdcym/UVezWl//E7TC/LgweBCD1o16rBDjt51HBKDz1gwmvADMFVIQ
 Md1eTFL67odT+/5cMDpGVS7X89bI782I14mwJQ==
X-Received: by 2002:a05:600c:e48a:b0:493:c634:952 with SMTP id
 5b1f17b1804b1-4980c66d76emr254114805e9.7.1785852363879; 
 Tue, 04 Aug 2026 07:06:03 -0700 (PDT)
Received: from p200300ef2f11090032755c67e6ad8da4.dip0.t-ipconnect.de
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994a0f7bf4sm90328655e9.11.2026.08.04.07.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 07:06:03 -0700 (PDT)
Message-ID: <6a71f1cb.87c5160c.6fd18.8323@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260317225124.GA371512@pevik>
Date: Tue, 04 Aug 2026 14:06:02 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_kconfig: Don't consider
 CONFIG_FAULT_INJECTION slow
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

Hi Petr,

sorry for the delay.

> 
> Do you mean to look if /sys/kernel/debug/fail*/verbose exist and contain 2?
> 
> https://origin.kernel.org/doc/html/latest/fault-injection/fault-injection.html#configure-fault-injection-capabilities-behavior

Yes, that was my idea

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
