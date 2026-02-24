Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0CAF3C989
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 14:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771944084; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Wfk4xEpsZVROzV0N0e3SuChL9KlOeX3vk3tHsiIT3B4=;
 b=kRGN5Pdfbb6SUa2yTVDJD42AgJW1sXRYVGhBlHWcP47X1pE/3lHcDCRbpvXhiDYxMB0fY
 yJqF8efahZoqB7N+vhMTO2/JlgBbaWLgickmVIj7hSgOSepZZKkHwCDswkcwECNDrv6SfGy
 DHvDTGULUEszcRDTlRXSHvrNbwULoZI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABBE33E11C6
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 15:41:24 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA5ED3E10D6
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 15:41:02 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3BFE3200910
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 15:41:02 +0100 (CET)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48373a4bca3so34143755e9.0
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 06:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771944061; x=1772548861; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWYXEUEifFZBMHeVmrbJAPnEJvyyfnEVusXUsSRAp9o=;
 b=XC24jKhDOVrWwz4ylN1kJpy2etO8bvW61IAKJrYTa+/ZoobkabeH0VA8ONa8vjvJ2R
 DgkRAkEVeIRmdXlRjHHsUum3T0UxATBY3N3bWMK0Qjt6+2svPshdkAe8p55+Bzrr6qqm
 xxncWQUYd9QBjSIz55SGYlllDa9/zQC3qq/x3evXHdBd/vkuQPevtg57cF+Gah0VUxce
 LJwn7h3Gy+3Tn8J7XXBc8aZDuiBT2lO41oxFS+3snpIa1SSYUDgc/E1aMnvXCH+okYpA
 68A1MjC07RBGCDfpjhsQHISUuXbBwPBLaWq+AQIRffu8Yttm0Vcicvu0Fpkjpu+l5LCj
 Wang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944061; x=1772548861;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oWYXEUEifFZBMHeVmrbJAPnEJvyyfnEVusXUsSRAp9o=;
 b=D52rr1hMxHtDOZcbBZu31E+dzvqc192GLdWvC6f6VHt4w5yeub6rUIG2lny9seiCUA
 /mVfha3kQ5hp7WWzkX+KS3xo1jlY5zCJt1h/KtQWV/UuShnsWlzB0f1LOmT32xCrNFH7
 HLc/VSmTTnMwgXRh2d0KKceAWT0o070RAI7mkh/0IORNMkTLEHToH2zF9veB3fXxph4c
 BDmCtnXBwlqeFAYiT/UENLPTSGavW5ggvrbwxXW8273yNxpyiPG7VfWO/xxJIgPpRUwq
 iRNNd3y95J56itXCPobx/Q9hjX7z/fZItDTnhCiMJXde/yW987P4jc00uXoxHsqLH26W
 8S3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+Q6X1+Hkk40c/qfyIohPegONhj13OOit8CT2HwEkSDT0YajI9ggSM6gZGD4u6Gul6ilk=@lists.linux.it
X-Gm-Message-State: AOJu0YwAG5vvNPdZLJDBWY0fzAQxZkTzFiuz2/FZSNG1wKXVFERWr96C
 0c/JkV35R1MtwBOUo8d6b36xk/6UFe9f40or+t1yVaS7Ipx9biiV24Rl9B3t9Ic/C+Q=
X-Gm-Gg: AZuq6aJpLesnAOdpLtnsgD8NMno4yDQA0elEFlklvIFa51guh85qfcl9ycvANKqtPKZ
 OC9RaZqcPZ4TmeyvOX1F3fAFJ0mQf9INu6EqdW1nrtWWCEs/cBHQi2bqNxZNohBwSsf+OF4smBM
 l5SsD49Xe4+VO1mbwoWS6pHqg8PWlcn+IW98bGYOxrwEG+WOcJJaIoFoo0jowYPWQWEMYSJZBon
 4ofLk1hHLYEfyv4mTZm0nnA0cEKSlzt/Yp2Wle361CyPhHOzbo85xLnIS9YBiO8AgoeVU6ve2Ed
 KEjuQrL8GebQlunvOrtkHyICH89H7guwKCXT5PNwUsNCjK1H9z5sXtH7Llt789ceUyjc3xEp/Do
 K5cmHtdCgGJeiwkEqfuWd2+mgZkwRKlcPB1ABpBdDGvTIXI+Me3KedGNzjZx03U3dg37Yx+q8H3
 0OHciJ6kq3yQdUxoW/BEsP3Gk+
X-Received: by 2002:a05:600c:858b:b0:483:badb:618f with SMTP id
 5b1f17b1804b1-483badb639amr25325995e9.25.1771944061558; 
 Tue, 24 Feb 2026 06:41:01 -0800 (PST)
Received: from localhost ([88.128.90.16]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd7141e4sm3227575e9.7.2026.02.24.06.41.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 06:41:01 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 24 Feb 2026 15:41:00 +0100
Message-Id: <DGN9QVONNXB5.20SY0XBZS3RQC@suse.com>
To: "Martin Doucha" <mdoucha@suse.cz>, <ppavlu@suse.cz>, <ltp@lists.linux.it>
References: <20260220154742.54150-1-mdoucha@suse.cz>
 <20260220154742.54150-2-mdoucha@suse.cz>
In-Reply-To: <20260220154742.54150-2-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_fs.h: Add TST_TRACEFS_MAGIC constant
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
