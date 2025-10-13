Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C120CCA476
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 10:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760352569; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=eL5Yn//LuzhovkhItEBIuh6nlspUj4oh0Qk4/Qkoo5E=;
 b=enKJkT2CS+53hmaCA+jf62SeilB1/GhzsoRNlsvYFrHoZksWo0Re6WzLp+vgDImbIqjMf
 Thoezjjvq6LBmEBL21wI6Cr7QaBuqTG3jjI7TTS9QQhJRMWSy4ra+ZaLENxpzWLoLsFyimY
 2ojqS4cSqvf2bj7YH+Kf8/6VnlsNydM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE83A3CEB77
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 12:49:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 471D83CB3AF
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 12:49:06 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5A3A020093E
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 12:49:06 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e61ebddd6so43270065e9.0
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 03:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760352546; x=1760957346; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bei74OfFQYGpCBPpOkQzbbuB9Lb3NTE134qe8alQbG4=;
 b=LuZEuedUz1drr/16IUEioNVQBtzx9WgAit+3aRNUXU3HJk4eu2uWRsE8hYFViNZ6/z
 djQLfUeYbx44ahicQpueS35cL/S5uGDqfT+CQ8AYhtN+n+TUR1cGeQgNqh0uuz9dvek1
 j0go2o2LkEpueFqyWmMvMeHZb4DSzFOxCH9d/XAn3LgJDSNaMQXYPar59JDKjUpGxNUX
 NG6vOd/tFdnisxP1oMMAQBE+p83x35gNgzvc/QN4UsG8XixqjKk66Xw8Q902J2xV4na/
 /klzaXVJzASZVF7K3tj/Mh9dh4zEw4zwNNUClND2e2WUztda0CGi0xDulh74ilNOFPDT
 V/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760352546; x=1760957346;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bei74OfFQYGpCBPpOkQzbbuB9Lb3NTE134qe8alQbG4=;
 b=Z9r35wmxCyj86w0YimTkioufaLGnadpN+QV/GMmMKvdDwEHP0On6fNRobCa6BNgd4T
 FJxlBWwfcqZNOsWGWeolylS2gJCAU883O1TTV/C5bFgYjJW6LFWkm4ZM4pzpWH5FV1WT
 qNqybHwOjPULBNUmd1yoONlQrPGbb4peHhMi7joqNkImdwrWSx4vuEfQrMqDny4CGbJ3
 F4tffA/YJNoFxP68it687VcULTNQZ0qGmmZ0Ll1R+mQHRyCm7w1dvBM/v8ji2mxpyENz
 O12jtcEan0LJsqa+x/IBZpwQTRzRcODoDNuLVdKo4jOv/7JNMH7XVg15Hl2X1JyrUt5B
 jcPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKJyef0t98h9L65j8KoWMQK7yhxo6hfSnpoFyCEiWoObx/ZiY4HyNDAC/VBrM2U9FHp/k=@lists.linux.it
X-Gm-Message-State: AOJu0YxL5dtvWbm1caepsHJ7xti2nrMNy9cbJAmubKgNxD0c+cBxiHQv
 D0phCiVXfn3FXmbXwgcg+hWYRB2qxmDiC2zwCYEfzRhz5v5FqdxxT2zHQZRP+fRR5NGqptPT1Aj
 pQgST7I8=
X-Gm-Gg: ASbGncuapME3kqZNwDSKW28kn0rlTtA6kds5vM8Lko1D2T+W59KWctygTqkRnO28fh2
 ieLJMhWxumhIc0/eWxd2OlBTK10Air3Zl4xEF8fT1bm3nqLDELq5W8lchHbQSp1Eecg8CxqsdF0
 vCbZ0jMcilO3ta1adxjWaP0VwBE9v6w9G1i7rgZjRwPk/GmII0RT/7qdhlLIb3WzS0cyX0mCZDt
 4+jHM7d385R0Xnu4+BbGvOXhLzaNZfwl+v/8Xa9dG6QgJzNHTvUHPHgmdcqnA6D70j19ksIDmpi
 nZvkM+mcAuh3l5HSdCiYxT7eeXYWJ5wG+ZX8vWjL7I8S470HU65fGT/Zj05hTOF6vhZ+8LZ855l
 ENZQmkG1T4hrRer7GRniTNfGE6M3aJvcsVtJIqc/NzLf4Fl0RCaNFJEghzv3qs+w+jmSRp0SJhN
 AH6GqyW8/cgZ7TsVQRXzPIpFDlyyKe5LGRRzZFy6/TDe9inoH9Rf3wn+O1
X-Google-Smtp-Source: AGHT+IFw8IBEt03FL32Fvfg/MNPHxmMcLoQnEGqYereGyFW/n2F4T2MAJ9QG9hJp3vw5KQK6Hw9aMg==
X-Received: by 2002:a05:600c:6212:b0:46e:27f7:80ce with SMTP id
 5b1f17b1804b1-46fa9af8f39mr140943665e9.23.1760352545509; 
 Mon, 13 Oct 2025 03:49:05 -0700 (PDT)
Received: from localhost
 (p200300ef2f176d00961bd2614569b9c8.dip0.t-ipconnect.de.
 [2003:ef:2f17:6d00:961b:d261:4569:b9c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb49d0307sm178503995e9.18.2025.10.13.03.49.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 03:49:05 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 13 Oct 2025 12:49:04 +0200
Message-Id: <DDH4WAW0M111.1XZ3UJKV8QQTO@suse.com>
To: "chunfuwen" <chwen@redhat.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.21.0
References: <20250826044129.946421-1-chwen@redhat.com>
In-Reply-To: <20250826044129.946421-1-chwen@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v14] Add tls parameter and flag:CLONE_SETTLS cover
 for clone and clone3 syscall
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
Cc: ltp <ltp-bounces+andrea.cervesato=suse.com@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Can you please check the CI? The patch-set is not compiling in both
opensuse/archive:42.2 and ubuntu:bionic

https://github.com/linux-test-project/ltp/actions/runs/16932202541/job/47980182839


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
