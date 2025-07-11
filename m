Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE5CC83F1B
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 13:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752240363; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=aNVborDzmCqGi6l1tdxotQFvzHMirS7uxZKLEdg6lLM=;
 b=S4xw66eK661P3vdRWh08njHWRzBvDe+c+Hm44GoSl/1NCQ6qr9DMtUt4OiG4iDomrvUkf
 1i1aMsU8wGJljibKNxhq65OnTZsSqcH6CHZOqM/EtXbYKTh/RjL2fRsWFc89CGUyxGVx5/D
 lq2nHiIpc6dF2LFGEtbCKPv77XRjb3Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C3073CB328
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 15:26:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEF953C2F9D
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 15:25:42 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 28F47200AE9
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 15:25:42 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so1397634f8f.1
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 06:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752240341; x=1752845141; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xd3vrdujVsf/bmQsp76v8MIpqjIblh7k1JTd5Ygaxg0=;
 b=VLa+LtnyfJ0ykOo2LYPYPv47BajeUefivqTkIxeQfDga414an5iHSZze0v1R0PMrki
 4huw84yLQNTZBRRlGCLEZ+eR/j44PQaqDDV3RfzcXWRVWwZYAVQesWJ0r7aSlcP174Ku
 JQd4bknMwMSOYSbccDZkmwfYsGOD7E/M63QargCMK19gLAF1U1waxaYEsTqPs5rGUJCk
 6ZxjdTq9EYeyWB2virkKyHiMApI+m6UU7QhRY+LuGdI70ylMbWCZWsxmVLCOo2voKRyl
 5HzZK3SnjUbA47+NeX90DOom8/tibFVpE2QpLzBmCZ6LGdFYapNLagurq4jPJu5sJCAC
 ns4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240341; x=1752845141;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xd3vrdujVsf/bmQsp76v8MIpqjIblh7k1JTd5Ygaxg0=;
 b=MZKBfgrOWVpHZsmVEYFoFVMdR8Gq05sYVR7cqTZ+sz1Feph7ImH7Z5r53y2O51C9mT
 Z+kGvHYVx7h1LxkPaLQ5XaW8FMnK5BHUyRDsOFwMgKamV3nIYENL+dUF1QyznET3dZQG
 Mkf9vF/o9fhiJjEr/Fnrp7xzfTr5Jbh7UBIhMyvuJgTqgZz41H+nL534yz6oX34ZiU23
 LquXzFcLfYUImtytySbWw2bdDTy0n/+xNZlKkLIKvzE0bzSg38MTsZgatu2IlXf2+/C2
 2zXHcO9dBB1cNlxG0ZWmFdWHuZvBr5mZi1pkOpEyrGEAgC9llVkOlU0ZEIFzbBUvh3rz
 naJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXN/WRr5PVtOeIFbnVU8S0inVHxZccSLrpBByEkgu20aYtBDqbabFBF0M+YTWzv68wcBM=@lists.linux.it
X-Gm-Message-State: AOJu0Yx8bDY9D+HtAn+qYBx3/uPoDR9fDP0xbJEYIZonEE18INXQkkRd
 XT5t5w1ygUGKwc+RlvUwMjYR4Vq+vK7ArsMNDIaggd0B27Tf7+8BovHJmuuRHMdJWUeuSUGhLSo
 a27XIsjh75Q==
X-Gm-Gg: ASbGncvpBY5tQcu+pJK5VcI6ELjkoxeAcLDnY77tc0vGDQhLvlwo8VSrglLYGgYv37y
 lN6h5gKdOFqH8zu3zCdIlgz9iFqEXi90AtcXIHJrfONUlraVU65+oXOYHqLGCP7yHIYvZ8cMv0R
 GWSEDcsN6Dxu5l9kedXxZb0SmefTI5wAWJLEBGY71xFg6JkeOQ7ksE34oit4IqPCZU/QYoLLAh8
 ED++BJiTrTsehy+vXDfJxNVhrdYZApds3Zla7Sx3x4eKRv05kVbZ6+P8I43cN/v+UeD8voFZDtd
 MYIEzmA2bdCC0+umDkENgFNKjbsVdjCvDiKCY6EEHaRGBAUR/ohinkLcMpqslKWQg+Gcw2sbTYW
 VFZX2ZRhf2iZB/CmrZxdQzPXtMtahqgMZWxO4PH3gD7EaIsp3RhhcKsmMf8bGiBACVEAIc6QEyg
 0Iq9DpJ0EMIbo/D+KNV24t5M8WoVpa8oZ6ioMpaWjBk02GLHghu6CllPbZRoNcTQ==
X-Google-Smtp-Source: AGHT+IFoJus8I9JETy+ESmFYIRosoQuz/5+kicQRs/xkxkLRQRaUoeZ+to/1KwD1z0skGzASe9T8qQ==
X-Received: by 2002:a05:6000:e06:b0:3a5:1cc5:4a17 with SMTP id
 ffacd0b85a97d-3b5f18d835emr2246170f8f.42.1752240341499; 
 Fri, 11 Jul 2025 06:25:41 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de4323e4csm45906335ad.131.2025.07.11.06.25.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 06:25:40 -0700 (PDT)
Message-ID: <f97b24f8-0b0a-474e-8360-b995acdba861@suse.com>
Date: Fri, 11 Jul 2025 15:25:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20250620154346.19864-1-chrubis@suse.cz>
Content-Language: en-US
In-Reply-To: <20250620154346.19864-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Two more metadata parser fixes
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

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 6/20/25 5:43 PM, Cyril Hrubis wrote:
> This series fixes a metadata parser for the ".filesystems" entry of the
> tst_test structure. First patch fixes the data storage to JSON
> serialization and second patch changes the parser to convert structure
> intialization with only designated initializers into a hash (object)
> rather than an arrray.
>
> @Andrea I suppose that the documentation generator needs a fix after
>          this is applied.
>
> Cyril Hrubis (2):
>    metadata: data_storage: Fix hash to json object serialization
>    metaparse: Map arrays with designated initializers to JSON objects
>
>   metadata/data_storage.h |  28 +++++++--
>   metadata/metaparse.c    | 134 +++++++++++++++++++++++++++++++++-------
>   2 files changed, 135 insertions(+), 27 deletions(-)
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
