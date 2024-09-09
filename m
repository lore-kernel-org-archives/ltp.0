Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C727ECE57B
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 08:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725871784; h=message-id :
 date : mime-version : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-transfer-encoding : content-type : sender : from;
 bh=izlSie44aprVtXeZaaF6wClIL1yWwaeZ52ChGex8PSI=;
 b=b2y1ZywZ400pVt2Vv42oOBhe3R1QCE3JM5WMXpkgT90hJb+iZadUPFG+bTmPgLzq/rpyi
 jl6z9aIPHqSw7WpHTyl7MzsF1OEWlxdLPGa7Weatuz4GK5HccHVEqmfh9uD00DMBt8loR/A
 96YxP4nIRUvmaLIOTzg9eaDUbMV8M6U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC9423C1011
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 10:49:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E7EA3C094A
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 10:49:23 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 542A2609699
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 10:49:23 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42ca4e0299eso18119415e9.2
 for <ltp@lists.linux.it>; Mon, 09 Sep 2024 01:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1725871762; x=1726476562; darn=lists.linux.it;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wMEdx64hzeJDGztJlRDCflFi1dQ5bB5S/3AmJY8a1B8=;
 b=Dz5Sav0ai++Xm8ecdmeG5tBJkTYJC4Telyaa9ki/kuDLSPLZMvc6ckrEKZjIUTlbOA
 S1p7ErPw4DkRoHfs0NeAVtBCTqYDiE2EOv6ziy3ax2xBQqcj8uhfycFpitsIGZY4KwRy
 K22s8BNktE780IZDnP/7pHV/WOlEnU/gHWYiOgGXDbeHazhJM5MshHk7jHar+cPyPuNc
 vLYJa4TmI/0rMtFE6O8c2HMeRPQPG4dBbn7JFDc18GsNVm+T11WSjd051pYlmmQgsM51
 nD+Su1ExHla+g+CiqWZE5aDq97HaVc+IYkGGPwlUKi6o/L0Oob9YfZHaui0HIPeBDyxy
 Z87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725871762; x=1726476562;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wMEdx64hzeJDGztJlRDCflFi1dQ5bB5S/3AmJY8a1B8=;
 b=v707oMEJ+svW2Ectg4foXq42YLGpZIsm+KEUIbLuToyYOf/8p2gsHySF7P8awzK1Cj
 akVAkDznoQDeDyDJ38CfyceSojuAbYILYZtSN1uK5Vs6vozK7HMOSxkf4k4OA7lOyFAj
 dByc6JDorRC1GIaGBgq64hKTGtU25iFL3y2nZub0tN5i7eLca2tF+3kKkgpr3vg/TF6t
 ri2RefbWgZJFOVmg9uVO8DfTC5OsW+J3zSMYtmaG00RonJ2KrTOWkA/KgTfr6pFwFjE1
 VCJ92adqGrqv1USSOgmF3iNYacuBbzmhnyAPElPXoTSS5L1gqs3BeRI1VP2dx+DfkyWv
 OU9w==
X-Gm-Message-State: AOJu0YzFEsgVxt2PDtIpFSEjJEs1tnRX91updv65xwF2N9sOWx7ld6Yj
 8NcrhCmlzg3P570mQDy8zmlCUvSHMUHYqEofBvoXKh1YSgwFhj1OTU9cr4svQ67JVnRiv6l3ui/
 lTGk=
X-Google-Smtp-Source: AGHT+IFOqZWv9KaGYyPNewcCUJVDsx/f1i3JKk7MH2G5ePL6xjgpISw73avthNpAWlcoeezt58TAag==
X-Received: by 2002:a05:600c:3d93:b0:426:62c5:4742 with SMTP id
 5b1f17b1804b1-42cad74649emr50766695e9.7.1725871761141; 
 Mon, 09 Sep 2024 01:49:21 -0700 (PDT)
Received: from [172.20.10.3] ([37.162.76.55]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649b93sm5427890f8f.3.2024.09.09.01.49.20
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 01:49:20 -0700 (PDT)
Message-ID: <228e56c2-5bfb-4f96-a494-cdf98f96cb1e@suse.com>
Date: Mon, 9 Sep 2024 10:49:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Open LTP meeting 11st of September 09:00 UTC
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello everyone,

this is a friendly reminder for the LTP mailing list about the next LTP 
meeting.
As previously discussed.

Next meeting will be on the 11st of September 09:00 UTC.
Platform: https://meet.google.com/jon-gytf-uei

Thank you,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
