Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE53C8303C
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 09:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751968744; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=euOJxLPca0OyR/tGC/WJ5h0jrhS/gO/xFgMeGmC7vAg=;
 b=EAwl5eXdx7S59uxkz09NNDCNcDCjvUBYzO/0YjCo0ptTvNifGEEHlLepuUxqPV6QMH2Ja
 2BDJ4U/aawg1pFpqO7qQT2l48hYiy6d2zdfidxthMS5jBLmq1lUwRXqSgu2oytuM5qt+lde
 VE4JPMncWFb44dUx5GlVpasDQLtK430=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 354163CA1ED
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 11:59:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1512C3C65DA
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 11:58:41 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 822193655958
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 11:58:40 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so3375670f8f.2
 for <ltp@lists.linux.it>; Tue, 08 Jul 2025 02:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751968720; x=1752573520; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qQhKqsigHBrH6hD1XTBDo5NmDt/JHXdTOE6pZESIJEA=;
 b=IG+o41m9iIB8XpErBNE+gvBOUoK3I/VsgPYxnn+DkndOEtYUMzbRXGIPByDitGOWoP
 ZYR8hBE2/yFL7H2HBombNzNEB1xSfqwSa6jTOARvEtZsjAnJzmBqKa8mJ7oFMWsr9fUz
 Ep4+ejAjIuTvjNvi9dcCgd/dJf3IEys6Il79GnjElQYJ90xaL6ufqtQRY6530s+taP7V
 Y4S2sJpOxrV9uLiRtSyPbwNiC0gBAT7INoDdvsAkyTlShWCgIlR/v4YYooJo4Gq5A1qg
 b2MDiM/SrSAIdH3v/bOijkPpd4+zQlK8TZ6L+clvMAKqe2rnGqSnbq7Ex2pS40KXGc54
 5vHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751968720; x=1752573520;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qQhKqsigHBrH6hD1XTBDo5NmDt/JHXdTOE6pZESIJEA=;
 b=gNfKV6pBkbGi9a0Fq/rwOA93L5jS4k+gQqV5/J3G8McpMkjM4sZeB/gNp/28ADbQvZ
 xAMDXfFwkxRYd3CqzueOP3kWt4AHDF0PNzXcWxsk04LIrrkQmnrifAc+7gjrHN+uHADA
 3/C9+cPU/9V7OvL57W61a0F8ngSoXtR6wl9uyPNQZA1adjyUI7Ld7D7Ec2vclPsQWwJl
 6t0A9EsebD0JYwou/HAw7cvTAgnR87Xe9u3B/kyqzNzmxCWHHzbOi3eyd0ybr1tAEnXA
 hg74enxXvX2dHvUrWNm4jUdvrYr760JHsyg01GzvtnRZwpSLyycCnV0dTgA4buuWosbu
 o5Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8CmQ9FWJCxkk2BtzRxDkFYom+yX/cboS+IzeBWy2g4XAwBz91IsRM3EL/TpJwUzUko6U=@lists.linux.it
X-Gm-Message-State: AOJu0YyRsJgQNmYLlP9yhn3UfggfReAr4wRBk84Nqkode/bXC7lBllrF
 ZIDaHiavMU1daDpJFcXR/xcajyCrCWyG9E5aUUdigR+OZTQgG0/u8aGImufeHxHwqds=
X-Gm-Gg: ASbGncvQfRlPGAuqwUWxXlgextGmP2qNmDksrDjV6NLeKiDahIeYHV0vTrrQbM1b1hB
 GGF0QOctESDJsTDHkX961cHGzATCDPCvzjS0P/35oCPiRDRkBpEY2lu8/eW0TBbtZ9Hg4AZEVJd
 D4mBrZh1eGb7RG0lnoTPssDSzkDMhjymPc1a4yImux/3yVkFw8HY3/xnbaTyHhJKich3+gbrx0q
 2zX/SYeAtg0MQnhN4Ia5zJxafTeTIaP67yGdAdziXPVSiHnAGQfBjqh6cyai3s4XmhE2rQeYLSc
 5TcjxK5AihKKb3/HNUngCZ+hISdeaPfg482TmfWjYsHEjG2QGBR/gb+MAMyiG+Rps/cFNSpXECo
 M186nxIfPTafJT28mkPlegLDHjBsJT9ykv5QNV6K7LAVO15EL11F6zifWOB0JHQqh+5+PSdegvF
 yfvh7F38yvNX5lAPd0fATPlqetvUsGf1A6330I
X-Google-Smtp-Source: AGHT+IFBRNc2q/b9YJ0Gsbel9W1/gqXBHFK36Ro8cL5GuYbMGt/O4Dtcmza9kpPjWSbJYT6U+7grGA==
X-Received: by 2002:a05:6000:4308:b0:3a6:e1bd:6102 with SMTP id
 ffacd0b85a97d-3b4970429fdmr11127044f8f.49.1751968719929; 
 Tue, 08 Jul 2025 02:58:39 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c845c0039sm110584825ad.251.2025.07.08.02.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 02:58:39 -0700 (PDT)
Message-ID: <9f28b9be-a071-4694-8e29-5455d111c48d@suse.com>
Date: Tue, 8 Jul 2025 11:58:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250708-conversions-munmap-v6-0-e6b02f57ac29@suse.com>
Content-Language: en-US
In-Reply-To: <20250708-conversions-munmap-v6-0-e6b02f57ac29@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 0/3] syscalls: munmap: Convert to new API
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

Merged thanks!

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
