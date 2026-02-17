Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E562E68172
	for <ltp@archiver.kernel.org>; Tue, 17 Feb 2026 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771328454; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=96qGz6afS1BZziAC7ZxyvOu80TYmkk/SEB2hd6AG1sE=;
 b=NASEfza1sPz4+wCZWlLgodw42QKvI2S8zY3IddH7J95QSpq0pMDe3QmQ9g3NtyKhC5oDO
 ETEHcg14jfa4U3oTl97iNT95NA+TdMBHi6uNS/F+/aX8a5CA8zaoWRtGlgiq22arP2Wr2Q2
 jGYzt88CLJ0I/w6cqASTD3D/nzOXEkk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04C6E3D057B
	for <ltp@archiver.kernel.org>; Tue, 17 Feb 2026 12:40:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB0F33CC713
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 12:40:31 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4C0A16008E1
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 12:40:31 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso32038395e9.0
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 03:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771328431; x=1771933231; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rs072uU3ju+kAOxUFGnAYUXDi54C8MR6OImcn44pz74=;
 b=VWi7HOOvQdAH7YMtJ/GAS7FKhHkNZ2U/bJ+XOP8IJORnD5iIafuuEpxZQMAEEvCsvL
 mI0aaECuCehCna081QYf/yixX4mbdEP2hDIpLXS18goVhiowkMLP0gO8SDQ9mD1qq38Z
 RD4FY3A8r18eeLXGqoEgFjzL6fKx7zXVBdMcT12TedoqjDYxYz7Q8Ee44OW4Dpau6bgV
 xCYuOx+btdyS39lMo0gBDN2Up4j9rssGq4K3v+32wnuS0PC4ejKkInSfedOGlwP9MTIS
 f/+aGnjOeOyrDYtOyYNybSA5LNPdC8CsL9bBirVeaHPARcOeVwNwDnqaM+yAYJxvM5Gh
 YtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771328431; x=1771933231;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rs072uU3ju+kAOxUFGnAYUXDi54C8MR6OImcn44pz74=;
 b=LnVSIZ3qqaBcvedvmvjtTvZaudjs+Rzub6KC5B2WEoqcZ717lQmUE3MJdCRVbJ9mWi
 enUq6NVhfu9Np8vFokauHIJfLMSqIueg8yPzDXLpAp3ezz8XJo1DGr4E7MCmSG7HhY6i
 57niexb1Vhhs/OkX0RaTwOCSy+1IxREm61ZuxbYQvIyvK9LJHZrbkfee7hHuVWsyigoY
 7Y7+vNF7i5SzBY7EZDrkbw5fRE8MbnzNvyrr3drNhWWi0NVEmLV6lUmrQdvUxR9INH31
 yooedjur7w0YSX5vyq6ZgYr82HB6VSmDQ2czSE/ObQpzEDoVEEJZWmN/WeNFEmKrhkYm
 cHTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeU5ahqpwNnmxRjP5WqK2s/Ci+v2B83TzhngL3/zZnuUnBvu3AJlUOsZAmc+J9VpwdxyQ=@lists.linux.it
X-Gm-Message-State: AOJu0YxqMwalE6I3Jd9Zr01HaK0rr3DC6jAhaT5VmpPQONpris4MGIGT
 nN0mZObJ72kG1q6IyOPEStZ5Bl1s3BKXq1xn9ltPug13AoMuOg1W4lnTIKTtkGRBGKI+TzraB7L
 pfM80yXg=
X-Gm-Gg: AZuq6aIPGXGXtScfZ4/cvZ2eUp5/BsC4FaBFYo/Zf81+IiEia4JWxMkRvbI7cbjq4F1
 J0a9S0/Wgz9L6ZSGzW/V9FeKHxJXCZTCKB7uctybynzarp+RI+tApqV3B25t3wccLG9zmDgjizq
 lEmCC6c60HpWBW4vcwRhkZd35pyK4G+4sSyaFkB4BrRz5g1nW+PhXDiKJK3PU7cLP6CXYgGs9+N
 BqIWiyaFmqU/wwowQmAcJotvPOsqKwESPN3Jpgv22cH9wpwzicVlDu0CNJLjxRnTfGvp2jgDVUN
 F76SxA3fuxS1IFKtqN7WH/pVyDImMLXFBPf4/cm3VqDkaYceKwfsdSPc26z3un7akLS/HuSDRBA
 KofiKZen0f5XJoKVEufjVU4BuymKYQYOhJj/wMkhiRLCfSo8X8jtV9wSV2sCDf1dd1bNlBZqC7j
 n8yHTzr9aHDBuEVWclnjeyfnqhfPVb93OzVEcD/cFEq7nqxdNss1HT0ran2W9Uzl0r+lw2Ht2cE
 +bbWJ0UjJ96R9Iwulg=
X-Received: by 2002:a05:600c:8a16:10b0:483:8e43:6dce with SMTP id
 5b1f17b1804b1-4838e436e43mr45975665e9.29.1771328430641; 
 Tue, 17 Feb 2026 03:40:30 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371a34d66sm128183505e9.20.2026.02.17.03.40.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 03:40:30 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 17 Feb 2026 12:40:29 +0100
Message-Id: <DGH7IUS12FMT.QMUF16MQGD6U@suse.com>
To: "Jinseok Kim" <always.starving0@gmail.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260212132221.4231-1-always.starving0@gmail.com>
 <20260212132221.4231-2-always.starving0@gmail.com>
In-Reply-To: <20260212132221.4231-2-always.starving0@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] open: replace getdtablesize with getrlimit
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

Patch is ok, but it might be good to change `sprintf()` with `snprintf()`
in the setup() as well to ensure safety.

King regards,
-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
