Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07222C3DA4A
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 12:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1722601244; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=SGp7KPCJEbW68X5tB3ufgvcieTs8lTH7/v3LNVt00d0=;
 b=SB44C3nJtnwvhxPCJmekHLt4gGc9BckjdcRbZs2d5faxpuxSInR5dbAIemSC12123BdxR
 RKgYLxJsLjeEJerY78FIVN5AiBXRZaxfBhBhaOJKZw/FZQ+jybyS32+c0kEcb/Naf4PeZlN
 JJhLzPOEPIJ9Yp0ENsA5UfohkW+ux3k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31A2A3D1F43
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 14:20:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A85DA3CF05B
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 14:20:22 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BBB1410085ED
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 14:20:21 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3686b285969so4081445f8f.0
 for <ltp@lists.linux.it>; Fri, 02 Aug 2024 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1722601221; x=1723206021; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6TCKYoa2fHM2nNG44G6y+D1oEV9TvJyy9Ro64AFlmDg=;
 b=OUPJwV6zquQ3/ADh28dD0EkCK+wSN0JbSWRaJMOTVViOyNWfdGQlL4FQz4pz/cWKBq
 FEzQUt2rvWBZy/EKjeItLDKn8s/OAb0gyYOmAciBWEIs7yhmPFGpefCJPl84ml3I4F5R
 XDktA2/OhfFD+7yzn6ve/d3Dux33yPV2WsAIUvSKkomV92tjtaTpck0e9CxUAz2x61SE
 q4mMppKl2/lJJGGu5iQ48E7+vuSdNZ6DxId8v9nfeWGzm5e2LWHLanff7lC0ynOHlTKm
 gvLajW67vwDpz5y+y3BOhGddcCJr+fVcoX8FNQAYBl4092spneNSoe2aNtTsdcnwuPOG
 ta3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722601221; x=1723206021;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6TCKYoa2fHM2nNG44G6y+D1oEV9TvJyy9Ro64AFlmDg=;
 b=Mc6YN5/VbfuvCZHhRc7kjPOkqXKLRq6Dh1DJgJfvTce1Hpi67wBXNc1tSFLNvF0lMa
 VgLbvJevM8QlXEo8NjZonXMhjEgmk34Yo/4qBUT9nd/ZXVClZgPOTzuTog1EMeIwEoTF
 fGAdZM60Ja6zlqClqD1bQVREyAn7YVb2+FodEGtugDDkAqdnq0T3HCdGXa0N7qJHMDK4
 VwxK/T9isNWFZlCrqLzHlj75xm4gqgRnmk1ByEPCldrzZyXZ3UwuQqEW555wPtBkxzBt
 3Flhw3MCl86OpyhOuV0Gy7EGGXSKJSeDS6dhdbPOP7jYzBKifFj1Ep9YYMW3nlk+xMH6
 xrcg==
X-Gm-Message-State: AOJu0YwWfXWQYNO2Ox0ms+Uu3QvjuFA70JpqA43yTEYlFYjFpdsGGYWX
 HYZXoTfwyyZsl4W8lgCctm90CTDqerqzwdntwFeUeJdrr3d4ewjJ2deKens/lx8=
X-Google-Smtp-Source: AGHT+IEFytZkehXhhBeaOHIzOYxW8678GCS2qXKqEXCO6YuTw/ZeXXsmXEPXmvyu/bMzc/iAhQKy0g==
X-Received: by 2002:a5d:522f:0:b0:367:9881:7d66 with SMTP id
 ffacd0b85a97d-36bbc14f915mr2224677f8f.41.1722601220561; 
 Fri, 02 Aug 2024 05:20:20 -0700 (PDT)
Received: from [192.168.1.59] ([151.51.15.217])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd06fbfdsm1825106f8f.106.2024.08.02.05.20.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 05:20:20 -0700 (PDT)
Message-ID: <23a18835-b83b-4cbd-8f5b-bf2b2264058f@suse.com>
Date: Fri, 2 Aug 2024 14:20:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240802-fchmodat2-v6-0-dcb0293979b3@suse.com>
 <20240802-fchmodat2-v6-1-dcb0293979b3@suse.com>
 <20240802113154.GB1626431@pevik>
Content-Language: en-US
In-Reply-To: <20240802113154.GB1626431@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/5] Add SAFE_SYMLINKAT macro
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

On 8/2/24 13:31, Petr Vorel wrote:
> Hi Andrea,
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr

Pushed!

Thanks,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
