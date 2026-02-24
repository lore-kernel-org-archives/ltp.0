Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42570E9B258
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 13:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771939988; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Wfk4xEpsZVROzV0N0e3SuChL9KlOeX3vk3tHsiIT3B4=;
 b=EIZvxRWXr157kzXXJ/AMvOZf31SoTe8ICJfgEcP0NX70a6TOmRqO6aJZCgiS5jbzmSZ6/
 qy48ltnCDWBUcBGZthRKjJ6vnHsZTOC5nfg8gcPoOBGSLjtiQEkogUBfO0CJg31IuM2HPrN
 tLLXeoVAH3kKivjAPSGL/Il7GCY4VCU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3BAC3D0F9D
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 14:33:08 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E83C13D0FAA
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 14:32:42 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DB2BF1A00902
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 14:32:41 +0100 (CET)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4362507f0feso3457264f8f.0
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 05:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771939961; x=1772544761; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWYXEUEifFZBMHeVmrbJAPnEJvyyfnEVusXUsSRAp9o=;
 b=Hfsi6EgvPn1+0BqrMkpuJPcwPA7GTvGxBij8SkSVvvVNB+eShmbfwt95ktf0G5bBXq
 IZSyPKgc+9xUbCU0qg7CoVZdEZJTUbQIRkLmwIIxNSKUhf7A6zV+Vu6YYlkN/fY3xieN
 eaN8+FF/tpTvT2wgpFFPOJ2TuYEMoMOoAP06Fr0Dd2uI+/QLcOdPFe/e8aaUZZI5qLdh
 AODE8IN5GUlc8M3altNv5QBSNrh/h+MxomJiwYjeG1XIEMuEDSZBQxbx4SMqnttsKf5y
 x8KagpHoHs9fmtRj3eDKgsYUirFw77QJWL73tzpCc6IOmlkjmuHnAbx/OvTdJKAUS63p
 Nlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771939961; x=1772544761;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oWYXEUEifFZBMHeVmrbJAPnEJvyyfnEVusXUsSRAp9o=;
 b=TwnXsY5hKMV8wKmFL3nODL0c5BSKPUCEAk+Pg8PzafKS15uko8wbu5OPqY9b2mE2T4
 L9h739M/8xkNl+3QCNu6nIGsvEbso6CIn/QJizyhpzK5ubBk2sdhEkEOxGWcpDc4XJFi
 b/AbXqJjeUzaWd+0mQnRbGZSTXG2dhXR8EqGk2nH28Ei/Lsiuo/rGhx9h+tjIWyDAX+S
 6yPAFvXcgubkpU2Kqqco3YcxiicB+rEGU0MTBFxC7bQJF61F+opViElE5I4HdszFZih+
 yqRB2Gm/5WczciMwIdxH2EPtsqZwv1WYAMpG99BTNv9ng2VetaOMLuywMj6snXGTCONp
 mrSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQCMTi8c9Fx7Ln36Y/5G/vxZqj2NZGE70N1bVCvCXBtZjV98JsrlM6NoGuG4Z+WnKPwDM=@lists.linux.it
X-Gm-Message-State: AOJu0YxPYRmdjZY6K09OsECcitfNb3l2/ycdtTqf2kgKI50G5Ww1Kaaf
 jEAelXUZENQWZ4rEULijjbrtGs5z8rprveMAsxu0dB20wPRJs0a3syMC3PjiuzD699I=
X-Gm-Gg: ATEYQzyVl0kEvaV0jePk9nPa09XtedVB/gd3BlIb+vCUEURxvVtaaoSRiA5a3VRkOyI
 eGTqGy8MS64hTeQhKthq3wBqK543IJOc9EzQAwNDWg4aLWnsRz4R1fXvSdodlQrDsOvc65Cm3kR
 5Vblxf77DhLJ+CxNu3qedQvhLQmJ+udP+FndX9qot+4bSE0FUJhtNzhubEQCQmvdNYS57AnZ5Tn
 qdj/HZT/UZ/9q78xiPukTe4qBGiYyTIAsd7VKBrhiAdqQr7qoe1rbVQ1V3cOmUWs7byHJFpAphf
 7WurUUPfpoQA0KoKaaU0hDIa+4Cy4Mww14gYn1hie0MrAoF114mH3hTT2YRmNbftgpVOhTI+nq5
 By58diLLi/FxWAZe3HrKxcRmoHTumpYNu1VmY7dhtE7S5bIvV8l5hnWQIQxiinjqm8WqNV4uGX9
 4KAqpsyYYmAxM5INi0zEfG+TyYYCEFEWDerM0=
X-Received: by 2002:a5d:5d86:0:b0:435:9d70:f2a2 with SMTP id
 ffacd0b85a97d-4396f1782e2mr23791851f8f.25.1771939961084; 
 Tue, 24 Feb 2026 05:32:41 -0800 (PST)
Received: from localhost ([88.128.90.16]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d3fc12sm24687223f8f.24.2026.02.24.05.32.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 05:32:40 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 24 Feb 2026 14:32:40 +0100
Message-Id: <DGN8AK2NZAW9.1I64WWQDXSMCW@suse.com>
To: "Jinseok Kim" <always.starving0@gmail.com>, <chrubis@suse.cz>,
 <ltp@lists.linux.it>
References: <aZh4Tsd1V2rlgoAn@yuki.lan>
 <20260221082139.1709-1-always.starving0@gmail.com>
In-Reply-To: <20260221082139.1709-1-always.starving0@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] inotify: modernize with SAFE_ wrappers
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
