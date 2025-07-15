Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42F5C83F17
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 08:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752569383; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=SRRUlKHDkXiIvdbLZ67PW9YlJS+hAGa+2Zuu213u0WM=;
 b=Rd8OmNXAZgrytOcvjX1ckL749NsB0nxQFkqnO+TBubc//GFLfiOal0jQI3eaoWF62DRY9
 xG2bRgzUprk00VbNj6xfYXOj2Lmgks8kHwSr55VJUrXjtLXYnczZmrzFT5dT2RXEaCtuK4d
 gM1HDKS74U7gL+wjkLg1smO4nxAlP2Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 664623CCD6D
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 10:49:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E063A3CCC71
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 10:49:21 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1E50A1400F58
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 10:49:21 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a588da60dfso3477900f8f.1
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 01:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752569360; x=1753174160; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dhV4cpbBxUM5MIYXi7mAxxP+j4KurW9KhrYjzQ1G1js=;
 b=cQYa6d0ycuhUCTOaVmMNFOknUkS5232PlmGJdXI71o7lLdAutUVFxGT+s1DbCr4Uf9
 FMuEzWUkc17eVbdA6ihtaGUDpfjOs55lQJ4rMPPjFT1FSYEF5Yy+9zSdmEVTd1mC/H24
 4MAnjQXzlpMqzr3Nl4lt9+wRCJNoe6H3hUt/gsiPvPqJJPHl/etbFSbkrYQ/xn9aFFCH
 7p+DbqY6hOMaA2dyGEhKrdjABGFeC4WdMga3e8LtpIFPUOKYTuXXpuYFpX0cCqgMP9gr
 mk6RhUwNL7B1ntGT6ZVyKtt4542nmR5qMFrKmYQQKMaaRTGtsZ5X12+aFO+bX9WL37kn
 /GaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752569360; x=1753174160;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dhV4cpbBxUM5MIYXi7mAxxP+j4KurW9KhrYjzQ1G1js=;
 b=PQgauoKT/xtTB2wG3VbtK8lImxMSghcTxegRYsVk2PlCvDOK0Yt6RVAwTpNI9Irde8
 aT+bONT4slIsEG0fwYHQ6ihZh5aZjLTDpzq0n9wPvVzDOrb12TOUiVQxnHqgAQcY/2sU
 6jRy9xcCx6H0leY5A8KXRNzz29sNmzlQA0K6nrDWxZ6Pns1yXY8BV/HAkrShubBbficx
 cu0/NC3T+uNvGkaGoKKe/1jZmVoAOf8ngwrS0L0NceHPPw/GOqKEweSvjYedOafJBmWY
 Cm/C7arVz30v5+X9I/lX3k3F2iUTjK3hGyXR1BU8bl1+nxGICdK6QMOfWwM4TmWyFQUl
 hTgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWZgtKHTqCtu32cKn0X+k57OCY/0+2uc67mqXBw80rIlwPCZcNs8GvqBA/AHfwdXOZoM4=@lists.linux.it
X-Gm-Message-State: AOJu0YwTIpYXZruVBdz4rmEs6klGUt9QwH8Lx0TCxKQz2J4gr2qqoYRL
 NjjcpFQPT+xauX2YV5jkw0N4bJfmaZ+74T0KQuXZwhw7KNbvGOHy96DETmCHaKz3RrxopdNYW4N
 6raB9F/M=
X-Gm-Gg: ASbGncvXwnWSDRTAuue3SewQbIpSWdu4OyZJM+XxUrK1O6P1LGCgVfc0Kfhjz+z2A7h
 zrRzuuULIpHXBKZMgzGqtzXd5opov4wzCyev0K0G1N3KQmz3DtKruuuRJmV9b0cc9bUZQAGCd/4
 Cvr8Q/r0FmgbX2uAV5xQuloiNSfy77058yQP+Ys9qlgHjxvnFy0qrTvXkO8PoO69mqBUzKtleKw
 fpgYlalvpuVupARTWuZ3p9ZsWJdJ7vYeCGcrGbt9GKfL7PSDcgsXmn6+Xsul/wH9bBPwvEfS/Sj
 dutUeouemdPskTB6tLyWexroBWUOvPAX65KhRGfcnHZsqaE0fLHI4cVUHX9Wz+zE9IC94hX3P+s
 +Dhkt2TrzICmhb6QqMvOz9/r9joyzpwsS6WoaGRcElh70qN49Xji6sg4kUL7LoI0wqxaqvpeLNi
 VyDbhdB9nIBbK5lG/Xz+UdRbGWnRSrY4akp1vOYXxkRowZsYmEBKDLFk1hdsAgqQ==
X-Google-Smtp-Source: AGHT+IEof4HInIWS8+T24l6rTqhU6x84bvz5NVaXdL986ADHoc97dRNAJRPUArrVK3CKkgi/hO6EPQ==
X-Received: by 2002:adf:9cd0:0:b0:3a4:fbaf:749e with SMTP id
 ffacd0b85a97d-3b5f18f8bedmr10238801f8f.49.1752569360501; 
 Tue, 15 Jul 2025 01:49:20 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5f32ed100sm11615745f8f.0.2025.07.15.01.49.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 01:49:20 -0700 (PDT)
Message-ID: <40ffd9e9-e1f2-44fa-8b9c-690248b9be97@suse.com>
Date: Tue, 15 Jul 2025 10:49:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20250630125509.22775-1-chrubis@suse.cz>
Content-Language: en-US
In-Reply-To: <20250630125509.22775-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statmount{04,05}: Enable on FUSE
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

LGTM

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
