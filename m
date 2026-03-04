Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A16EEB7EB7
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 10:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772619116; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=589K+9wYcBtEqZM3wW26vIZYcrFTeWIpP1ZUx4nCtOo=;
 b=fPEBcngJr7yH7gwvOOeS3It3nwAGUkTSBNA3OEWfTJEW2KmFd9H1tD3t+94ALInnT2rBh
 xSNkoHjskBgglON5IkjLO7tzRO7TDlvgUywG0msXbIF5xGFhwfB+gP31sU5ZYUmahO2B5SW
 kKjoEUv8sGdlkTBadDxn+nIPCaxDrps=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6E133DADA3
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 11:11:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCAAF3D0722
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 11:11:33 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2D0551400DA1
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 11:11:33 +0100 (CET)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-439aa2f8ebaso2397584f8f.2
 for <ltp@lists.linux.it>; Wed, 04 Mar 2026 02:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772619092; x=1773223892; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=QZny9dEDvJsw0S4ZHWLG/R6WUFc1vZ+wTSo7cbv6Oic=;
 b=Whbi4jkgEBkIia5+6jomJUpkY0EJNoWj1HUvZj4+xuuMKFKqZlENJt5yJyv6BYjGDJ
 5qPUP1WaM6SBqXmOnzNHY321+eiQDBsfbBfVSyMAOB0cp2+LI1KpVGu1DVh3sk0hpa8E
 KSUsE8pelmj9Pi356DUA6ltkPX7/AnP1lGTHvotTVCQgLHJHOomtinVRHqEivyd6kYYk
 DbClxSzV3XiUDccmqzlF8cyFP/6nPVZ8QnQeOCtMV7rhZ/qdIWHk+GJYNAG/2GzEPT4V
 tWizLFmDiiftH7oPOS4fPU+v9lXjU91pablB/FNw3gXsWFZBH1CGoioQfDJUml0ZbHcH
 xEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772619092; x=1773223892;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZny9dEDvJsw0S4ZHWLG/R6WUFc1vZ+wTSo7cbv6Oic=;
 b=q7w+jWVBP/aVW4WBbwAJh4aXHV5nWgKIUZ1VlnEA55SGq/nTqvue/xlwE52nGy1Yr+
 01D4qinwiIKbt9db9EQDyWqyD5fFfSbctoxSLQzLdRlT+zX8s/qbj2+j6xrrKRgKEGep
 kPELHu1p89/PglxY1wEsqw8R0InUWGzpnrsW8kmQSD4s/f06oYdLS5dF2fBtipbV8dp2
 R9Hyo96WL1i0z6ovtepm6/3rTinKEV6vwzWt2a45zXlZ7+DOBh07FsMN3U2txJlvaIlz
 GR2MI4n5h4StRVgj5n5nooJ+x6eJAVq6CQQ4oZhq77+IZ6Cle9xW9ZvArGnMJ3T8mmAz
 OPdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfWQOZBmsdll+44SfpbnthX4MpB+X6s6xhDx2whgqAPGzIAsK69pjKsDVO8eHw7NHVi98=@lists.linux.it
X-Gm-Message-State: AOJu0YzGRNtmPXJ22yWPC42mlURAPIQBOJJ5uUJadlAQXRt2ErAf2e2W
 WTQ8JJtRhewcAeHQnPLPEh1yX59YMfAI/76d1aTkUsAJYn6pC5PCKebgFOisWz7g5YE=
X-Gm-Gg: ATEYQzyMKbZpUTuVjE/ESS248MAi+5WqYGSQUxhJmkpd/ZRvZylRi5IL4AWfustRd4q
 jrD+ypwrpFhPDAbohT93Soi3kQYaCoid12q6Tyxk+J3xPsEUEZkOMB1lpb6rtCUdt6CmyNqPkOW
 tZAIzcpEK5RebuNzQffeaEP0x2CJMiVdrtg/lCnhHEbsZqTf6i9ZvrxItOrPO+uQbKWNH4CpPhW
 e6G9nuJZRGKGpWYMpB3SpovQr4JPawG8upPQnqj9pVCCiikd+b+aa49OCvI/9NHMiD0XaHM2X3Y
 XDCL4J76TTp9aCiNdQjgtoM277MY61JHsfGtsXs3Y7JWgZf2yNlUjfH4eXLqddAdmgN4Obhvbx2
 rfd0uE14R26bxu38tcRdr5ehhOTQqBaeAWsBVZcJLVXeX4eRKKiHQHHZZnz5QmnsIxtuEuhYq5z
 FkGW3qTMvUX9dt9vxHzp73pKcH2OWVRAXvK3ua+rUFRtbFr/v9M35NZ5F9HkCVoMB1r1rNaUqE4
 /qAS8azRbWnyvevKb8CiPxTA+qbK8L9gL8=
X-Received: by 2002:a05:600c:8715:b0:480:4d38:7abc with SMTP id
 5b1f17b1804b1-48519849bc7mr24982285e9.11.1772619092343; 
 Wed, 04 Mar 2026 02:11:32 -0800 (PST)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851a8d64dbsm10975915e9.3.2026.03.04.02.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 02:11:31 -0800 (PST)
Message-ID: <69a80553.050a0220.18a0c1.f1ed@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <aagEIyMmF04crhk0@yuki.lan>
Date: Wed, 04 Mar 2026 10:11:30 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] Add safe macros for stream testing suite
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

> Just do not add the cleanup_fn parameter to the new functions 1added
> there. That's all I ask for here.
> 

But their implementations inside safe_stdio.c requires the old test.h
header. Should I move them somewhere else?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
