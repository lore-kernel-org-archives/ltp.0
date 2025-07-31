Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B2DC87FCC
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 09:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753954937; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=OhmYe7OgNoUnxFjRMuNJdDCTSSVFKceiSqqyfAXfIHw=;
 b=GddYkQ3QX/wYmIW5GrNjNe92FU5+hhZ/y790eMK9xSPrcGj4sEi/lHoVUStEbzxnJUPHH
 6S1owxaIFqRBNUld49bzTGn1v1afBJa3WuI7jTesyuhQyDE2WltnHFRNYJv3kCQDtL3Q1d2
 Mtskx+C4ZCnTUEyb99r8yCpYMEfqo/s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 133423CBE01
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 11:42:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 542343C0980
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 11:41:56 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B43A520005A
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 11:41:55 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso612459f8f.3
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 02:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753954915; x=1754559715; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kRufNKhIefrINCX5sI1/99wHGjr6let3bYW2fa5ZgN4=;
 b=WEed6l/5e1l4RBQp+Hz58JN57ueiQD1S8L+YJ2Qo5vrdmXSAXr6/Vpv+zzFtectZvS
 JQvNYL67Dc5NC001xQ2jM0acmBV3yEZJBLumd/VI1Rqx2OuF09TVvE4Eb+7EEl0A656/
 jxgOaJWZ0RK4HeB1W9609vpZ43UqQhtzAudrtm4qUFu018BwJR2A9nvNk1t4h/3zJIZv
 6irrF4wwLX2hqOAruqITne2TDXhL4zuE2ncuVvjxSCndzD+0useYiab7kRDxR5yGmfFY
 7pp2sXX0kUWQX1Po8xmjZBoqXq6UQIBlqH2BQfia285iHZVTLeM5Z5yhOQi3Xy6mrzvl
 riMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753954915; x=1754559715;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kRufNKhIefrINCX5sI1/99wHGjr6let3bYW2fa5ZgN4=;
 b=YIiaBRDuuMklAl/PH6qojQyF47Pe/o+4FxVyUqhJ3xzlOgsm32+LLuCvf+hjNHDnUZ
 UqXedj6+edHQlpG9V+0alQARU1tEXiS7qkNsVKfOp+W/KiYA0G6vflreLy96WI6L9O4E
 YaoDFJsyElQlNnamSE54F7lMgcyIuB+gDW4JIGW9dARmVRiqG0rPtl7tl2R0K8MKvDur
 vFItrqeyRr3Z5+2GcQm311BN6bK5n3OgYI/F2x7aCKBj/w4UhZJcec6wGL32YYefWhvx
 Kw9k+D2Njgxp5ASF2mZCvSenAP5PHxCu0C8cyfIjvptmL2Mhr8ehrmcw+JIQGYomXgRG
 OTSw==
X-Gm-Message-State: AOJu0Yxbh5WmrMP2d28rnZzMGy0dL/ljyspRYSirJp9JNpHQfCYkiDn7
 /QDUqc7ZdKmJrSuxAtJLD0k/syDOg1edVqd5HWt7ScRbaxqDw5JKYcJGokKsfvIY8V8=
X-Gm-Gg: ASbGncsFnu95muOXkPbahdSk+HwZpKv89uq6zuoEPQ6GoBzoxJ8pZ9m/2LWkW380J4U
 fwFXdFiWdptj0U1p1tlnEjR5FpjG7ZrT2P0Y2ASZyHNTxpbU46zIgpcPgznkW8pR8Wk989WJUVC
 c+XBrdl2SSXR4vzxWO6QHQuMnhCb0THJrfM3+FCqvJhHbj2FLu7Nc7C+pUEKcS5AhPIU8R4Teoz
 EHciEmPL1qoDV9qjmUje9VTQGmXbua9D1IZmbB6KwNoXhE+0Zv/PHppEb82vwlx5t8rR+WBQaWg
 Wnwpxu3CCaFtrBjUBkt3+a0Nu1rZwX0pbCXbXHVlj/PLuBpUahY+X4iEohnPE64xy+RrNY0jQf3
 8uyZF1tv5qOJxJsnb8bEe0bFJOzeqpB6lhQIzOQmCLqAp
X-Google-Smtp-Source: AGHT+IFGs4x4KXesiTYDMDQgyrYXJ4VWSa4eePk7dXYHoLtUuR8ome80l9QQRtYLKfQilGrqrmar/Q==
X-Received: by 2002:a5d:5d0c:0:b0:3b7:75e8:bd17 with SMTP id
 ffacd0b85a97d-3b794fe4f05mr4615605f8f.8.1753954915071; 
 Thu, 31 Jul 2025 02:41:55 -0700 (PDT)
Received: from [192.168.1.91] ([151.51.222.116])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8aab53dsm13065205ad.170.2025.07.31.02.41.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 02:41:54 -0700 (PDT)
Message-ID: <b0a34ad9-9e59-4d46-b202-2eada747b791@suse.com>
Date: Thu, 31 Jul 2025 11:41:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250717-clock_nanosleep05-v4-0-78bc62df960f@suse.com>
 <20250717-clock_nanosleep05-v4-2-78bc62df960f@suse.com>
 <aIjUY9_MhWC3KMaN@yuki.lan>
Content-Language: en-US
In-Reply-To: <aIjUY9_MhWC3KMaN@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] Add clock_settime04 test
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


On 7/29/25 4:02 PM, Cyril Hrubis wrote:
> Here as well, SAFE_CLOCK_GETTIME() uses struct timespec as defined by
> libc, so we have to either use syscall that corresponds to the
> begin->type (tv->clock_gettime), or covert the value from
> SAFE_CLOCK_GETTIME() into the right type. I guess that it would look
> like:

Why not just going back to the original idea in v1, where we are using 
the clock_gettime/settime corresponding to the right libc?

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
