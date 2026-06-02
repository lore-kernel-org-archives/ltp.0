Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C35CD6E60
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 16:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780416973; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=1ar8dwM++J2Qjx2KOAIk7Utz1c5l7WJC01QFvFeIaWs=;
 b=S06KIHuLY2eb8Xo2G1nf8o4PSpy3ohlqMEcndUzVRE8MBMAs2oRL52/Fh16sAEmj23yhU
 hHf8BIjJi3CGnxxJM8cxIWPQGSQmEEoLiTykPMHvxtKSpGsvw1fTsTzZLwSlDQGc0hs4PKF
 XdkqTXfRJo7mpS4T8F2elrQzTFEaurE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D03F3E4B69
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 18:16:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A94F3E4B69
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 18:15:50 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 27CC16005CC
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 18:15:49 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4906238c62eso95465645e9.3
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 09:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780416948; x=1781021748; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ODLtFDz/i/2PHZv5BtYafyJp+AmaXNMoBQnxOp02QZY=;
 b=Xt5zPb6AZaW6p0sevDpuDT7BijO0ksmD+tewvqEoUJAv3qOLx4e161asNi0mKMBcPP
 cyoYPOkWFnNdC8ddP36dCdRe8JdN+D2kxezclj54SWDo1H/W2oWy/iOuRYLvap9UICgA
 itH93WuyLSZupnkjnmevBCH3UdY+zLsZs3ojsLnatY8KulzasLgYzEkXf+7KVgC20q4p
 LZTuHGoR/m1eX/Dv9YDvjwH/FKflkrPqGknQySHmgAs2z8Dn6FkphrFOv2t5XT+icN4i
 CSaBT74ubsZn2pKYd1RAb8lKqlQ4gzvV1ZqGC4HWQ0szXIYjURUCr7kTXAmOMwZyd7S3
 u3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780416948; x=1781021748;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ODLtFDz/i/2PHZv5BtYafyJp+AmaXNMoBQnxOp02QZY=;
 b=eCoEXqsnH2qqt9tcjvgAIGW3PycCvd3yFy52PpPMyyMjnczzrFhiDc1U375Nb3ec3I
 dhXVMUBrS/e/GH0xQPw7NBtqYS1WdpXzK9ZZqpsHVL0oYnlCAv6mMILr1g//2mxac1wD
 VSRSW3xxCK6dec/A9KxO4rpNOCMSJfv++1Dsl1iWZ4eVsF5taZuErU1Ho3xun+3t5SWt
 RT/bnASkg/+WHXjCz2Atcj8KB2EmUXIeZmzHmidRMrjZC7h7tg8DNToqJgeeXfmcW7R4
 Jlk/cj/IAxbuWPViscWiQVCB258LEQUkiPcLnnbyZsInlCtlfOw/WdRQ9PbVhg4/OGlR
 rYRQ==
X-Gm-Message-State: AOJu0YxjCdysG7XWuGtfMjpf7x+NEsUhl3LMHVzSt/jayc+NYRgiw/6o
 r++K8sk5ydnoIwzuyLT7DHv/MJbtfrmX3OvhQLuRqi+BYZ6WtkZHg/1WslMB+YJwSYM=
X-Gm-Gg: Acq92OERy1zgelv+jtQ9Kh8hD+0PzCmR/HsYy+cYNXWxGnhOiBVLaANS+na6o7kjP55
 iSI+AzbFWwuQJ0JlJ5EVy0V48Gwi6WJ6yJrPf54ftKgxYdAzQVm0e7Mo0ny1u2Mjb7GwGNYk2MY
 mWHcnj5/uBIGOdDL7wacTBYuUHiOAh4qNjc6DMWDZVoKDnzbnPIHjS2OLvjQeRWl/N3zlXd7S+r
 Xk1pj8UsqruFZEEshWxR0V7KNZ0VHkfiuKqdrYcL7jzlve9T1wEVZhc490DV5+McnYFEGxSG7bE
 daxZkwszSVHNacSn3j/jSBK6SFVhVfRgVv0/FhYgw/0CbI92V3k5wV0yoYF9fE+zz/KCGM8gC/v
 slmKDSaPvVk3U3WRORigti/MENZJpaDZ/jKoj0hWIvyRnefhhqIjUgHlI6QftYORPNCpDRCpR3m
 uD7xh7Rfp6XF4dlw0LFytSmlWHFdh7JpREQzI/LnzxbZ2Y4GUIJbyCXFkfx39Jwdewnziigxbhz
 pdSJL/X9k0eH9kOuS5QFQ==
X-Received: by 2002:a05:600c:8518:b0:490:b1bb:cdc6 with SMTP id
 5b1f17b1804b1-490b503f584mr7261415e9.5.1780416948470; 
 Tue, 02 Jun 2026 09:15:48 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b0e26050sm66760995e9.9.2026.06.02.09.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 09:15:47 -0700 (PDT)
Message-ID: <6a1f01b3.5e46ca1c.1e45c8.1c98@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260602-doc_add_missing_headers-v3-0-474deff77d2a@suse.com>
Date: Tue, 02 Jun 2026 16:15:47 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/3] Complete the documentation adding missing
 headers
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

The whole patch-set is failing the CI. I need to send
a new one. Please don't review it.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
