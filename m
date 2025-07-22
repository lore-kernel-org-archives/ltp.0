Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CA2C83F27
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 06:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753166432; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=jmZcNH4CNrTitTFkVT5ij2gAUQVZiVjvqgSBDstLKNI=;
 b=ETnZArlRE8z8DoT/bB2vq31TnqmlxRRLvoM0/h3/dMFXJGYFLyMrplJ/ygOfI0qaRU5HZ
 hUiRu0Bd+zt3dLNA2cwTBjtHafXjHSv4ZOH2USX1zhziYZ98npKEdN/2SLjG1bNzeu0L2KY
 3jCpAT/0IIaXwpxhmTWC13wkkVX/6tM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E1553CCC73
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 08:40:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 481153CC03E
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 08:40:11 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6957F6009F2
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 08:40:10 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so3849866f8f.1
 for <ltp@lists.linux.it>; Mon, 21 Jul 2025 23:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753166410; x=1753771210; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WNzBkJP/2VXrnuphV9MXsgDJh3jh/65kwp9c51+toL0=;
 b=MHXxdb3fGiYHnBToGh3zFaWyf1OP9D+CQWKCJWMtuHINBdGKam9g2gm9LO5h69YESF
 TEkEbnXt7pMTGSueCYSQVw3jsF7DGUY4LPwB4KlcEMUzp8HGEwivXNoG6a61hbS6M0xd
 MlrLpkDmYIy8K8RiXdwjmUMsuetqL14JLc4mySTMdfgkgcENsZltjll9+DcrRKlCZ2Gv
 i1ugIAg7pjeYmQvzCzm4dfvvJ81mabPFtz34oPeAzGzsTaOT+efaeJZc25K3CJg2aVha
 pKWlLGGXEVl8t9LcA6CYml5yzD0BqI9FdV4rXf76Gvh03JwcizYwPvwex9l6GATujw6K
 ulHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753166410; x=1753771210;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WNzBkJP/2VXrnuphV9MXsgDJh3jh/65kwp9c51+toL0=;
 b=okV5r7RgwiNxuYMVLsi9khbDnJMVs7fCmN68FRyNfpFsyqHSGUqWnLpEZwM5PcL6cm
 kh8/Wc6fEBDmnZzd35CT1i3HpNSDkqYCxQctukKjQ0w9hkBSdTgiJPTuFWih+BpGjvEp
 gqRFktNSDqhtWX5obePzzyGUA/qSwvP+jwSABJKYGyy/Z3A2uDmmw9Pm3cTk6tjG0HbB
 1DKFP/XSteZ/V0iA4EMlj24SzswLnRkjkLE+QFTNw7tpupWOO8GkOdLJ/xaxhYaTIMmR
 oOtObkCYmQaRigme7JQAfWVeLENw9EbTIaTrgyauJ1Ee6lU1Ikn2kWCppau4bSMbtqnM
 LggA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOADbG42lwz+3IdSVdQJSGgZCL/boWzEIBr+qL4xjP3R6wRZSwNkBKfstWwZsx2ilFvxI=@lists.linux.it
X-Gm-Message-State: AOJu0YwSG68H43FZYuUBhsaaDMKOAKUyLPdEzVmnXINpw0BaX/zkFER6
 TbF+bQkf6e5ce0qPX1uAIcFJbks6dIZ23wUd7iEEAldpTk9E5dviXET4OPfzzN8oUu20IveZtx9
 d1C043Es=
X-Gm-Gg: ASbGncskYXZUGAwauMUGcolOVrVbgT4QvaG0GgrsojZdpJy6aGkcfGjRh0oOt6ZpJkR
 zh/XHUZeKcujzbbAvN0OklyxdbOKzVhTLQLZfpcwskKt3c162KfsEVxIszDtmB2t1NEbJD8gWQU
 4NZHr28HaH7rGkkMLonOPtFzyBp0VBOXhV4ewC0xGjmM18HUrUQoGpmlb3roEAQx+cuadpwqkmX
 Tk71Q8Cd9JNu3UwoZMRmpxZ7d5TPTponzkWAeesQrzhyctHvrBwIdlzsUfN8mZn4LwairQpkSED
 7V4S84FW3SgLYwKdm3fgNhkRGCydi7qhWfz2K4o5H1QRnjYykeZ8OA4gpUeJHQrMwoc4s1GFWnj
 nYz5LtFro/NlSHjFmHKCHGz4bAjoyAKshPJCpwmOFChLYky6GSirJC+h8ujQS/58RRoefKoPBWL
 W7EkLvaiVLRhOUC/EzzgFsM8HGfLagIC4mdpD8iw2oW3b9SqJVFUzMn0exEFwsFQ==
X-Google-Smtp-Source: AGHT+IEQIMpXDWKinoKNN7r1ZJWM2aLxswcFX+br1uBLo+4S/x0GmJvpKmkrWxnEMYdpR4gZ0P9seA==
X-Received: by 2002:a05:6000:40c7:b0:3a5:8abe:a264 with SMTP id
 ffacd0b85a97d-3b60dd731edmr16426629f8f.37.1753166409665; 
 Mon, 21 Jul 2025 23:40:09 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f2fe8dd22sm6315109a12.30.2025.07.21.23.40.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 23:40:09 -0700 (PDT)
Message-ID: <3a5abe95-3b9b-4232-a120-eda5fc7c86cf@suse.com>
Date: Tue, 22 Jul 2025 08:40:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20250321151143.11332-1-wegao@suse.com>
 <20250721200428.2627117-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20250721200428.2627117-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] mount08.c: Restrict overmounting of ephemeral
 entities
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

Hi!

please achieve the v4 given by Cyryil before sending a new patch.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
