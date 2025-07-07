Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A41AC8303C
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 09:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751879902; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=dvSqBZGctDxmXrc+PBlqpXwfsaUcX8Izk8BGnfsKxYg=;
 b=VqMmWRkTQKDJTdeam14EuiJLq82YSYCwdg2P9A61815JTOccPcOgRk7zG9B3RBE6zLwY9
 IuHyog4JNf6bI6hJIXmFkTyEu7kk96tXDKarhRtWx4bPGRbAyMiQY1z1hYcAszIqxgCeQ1Z
 QkqviOQhCnrrmgc7zc7mEB7+oMeqbmE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87F133C7207
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 11:18:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 010913C659B
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 11:18:00 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 03DEB200753
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 11:17:59 +0200 (CEST)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6077dea37easo4565811a12.3
 for <ltp@lists.linux.it>; Mon, 07 Jul 2025 02:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751879879; x=1752484679; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MrsLGDQw6NCZqDod8ZwtqQHMmWY4YOWTyiRwgCbyD5U=;
 b=LXyqV5mK1yV7S1lSphXk7dy5I8XDB8jYhJdlvHGf0qG1A/yg4ITfA7ftcCiL7ioy6h
 T2AMAmCvfomoBwCs54FxaE5jw7AmTZH7aQWcoyH8nr5p3hjT3UjKG7XWdGedjtMjg23z
 6xcmkgFdgM5tAAeZoLvV9BCeYNqEysgIapzuDWWCf0RtQcYu+1TSSFoMhiOd1CZkw2KT
 24fbRhBCmxQbAeEkr0aFkqon9gHHUtRx8+14BV1eM6pKFk38bBVCl9AKc/jl3KCO5Ywb
 dMIztwFAb6SStqxNgVmN8OCBTVezrjmgsgxGhTHaEtJqiDhNes3tq3gXAnDKQyaA8RLP
 5d2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751879879; x=1752484679;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MrsLGDQw6NCZqDod8ZwtqQHMmWY4YOWTyiRwgCbyD5U=;
 b=f6V7djYL+hNyW2A96DVLnt4hbkrnIaNy5kdexAanVs1j4qGdjKJi79MckGJcEJyJoW
 VEKfwDuSJwduSc1QL3CKNe0l1CCNG5H3HkAyttvesKkduVyiGL74ayRSI8nhHkagDANb
 RINjP4CvauWqqo+SZQhYgvzrSZ1+gbiQLJoC3tM/9Qy/66mNayne/WQ3qQWKchmearFp
 jFTW+fq34tiyoe7sIz+BjmnDc9wwVnajOQBisd6Kx9iJNCKVHJzreuFDkYYAwuupPCnm
 rKzZkjsfGt2kZgnxMno3k9oXp4FL8mO2OifXnVHe8LhcxLFkryhtXIS7V6tnN8TZVO26
 V//g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOE0wpxWF6u3dBv8sIltQxUN3RKeZfkAWZfZPQ2KqClCh9tbvoR1tFFtLwIdakhEoLaaM=@lists.linux.it
X-Gm-Message-State: AOJu0YwOBex34cjhCfYMabYyY0PiBmg/5ydb77UUbMSDdzwgia5wQwtu
 7WbV4t2xUCTkRXtCaf7JgIJ9XYUcj8O8k5+88+Q5l8t2VjmorfFFWwZnguD+UefDyUQ=
X-Gm-Gg: ASbGncvfRYkVKpIuQPL3NUsTjDbUzJiYY9ps8avWIdrt0uCi25berczOcl0gLsVEmTQ
 6ccASWbJfz869jCb3Q9ThouXbByOC8xV8UHF/0BMeA7Bffc4luzEM3JMtUVTaYSXtjAGdNNdcBp
 /jlneKG5NP4ZGp6Fm2xc9AnvJY+venmpMRWTqfWXc5s98GRYG99x3qtO3O7p8jhRUSzNTDOnE7V
 o0TcScXv/OcRuzQ+aq/4gQx5OaeNXrNvZUR6RYJ4VG+bjCKsGWi1+iGxlOyaCZUEDNzosHIxG8N
 kukAGDh4alglvXmpZnYWI9sDYkjIKhDOK13hK35Iby313lSO/54GIgtlyxanKLuKXeN1pT6k
X-Google-Smtp-Source: AGHT+IE3ZSkvJpxJKRR5AtSNZkexHb9NKxWtNzGZ3+B4bopVQ5esh42HJPajQ9dVY6NtatOp+I2V/A==
X-Received: by 2002:a17:907:9621:b0:ae3:a717:e90c with SMTP id
 a640c23a62f3a-ae3fe695451mr991578366b.23.1751879879198; 
 Mon, 07 Jul 2025 02:17:59 -0700 (PDT)
Received: from [192.168.0.223] ([83.1.218.186])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6ac5474sm670769666b.77.2025.07.07.02.17.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 02:17:58 -0700 (PDT)
Message-ID: <ecc8797b-14ee-4532-8e4e-79bd2a32884e@suse.com>
Date: Mon, 7 Jul 2025 11:17:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Amir Goldstein <amir73il@gmail.com>, Petr Vorel <pvorel@suse.cz>
References: <20250628113334.228198-1-amir73il@gmail.com>
Content-Language: en-US
In-Reply-To: <20250628113334.228198-1-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify01: Fix regression on kernels < v6.8
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Merged, thanks.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
