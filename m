Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FBBC43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 08:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783672302; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=Fkw6PVwBQgim4CrE9+egL9eGQNnPP+KZS62a51Ndrrs=;
 b=OgCbZ/Q6ZVd4VAoNWUAd5etr0U3q7i29X2yjhynKEtMLIwbcf339a9671chyguv0Qv8Wl
 JeMdCdfgczkzPF0g/O8OztkJPxGPczKofpf1eqfH3rbSXC7dYVotZZsjU/afh6l6pulqoOF
 Svu6OVEgjUd0tRBEbB/4Y5JZuP9WULY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C79BE3E2965
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 10:31:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B0913E2793
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 10:31:23 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EF88E1A00CB8
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 10:31:22 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493f45e206dso1461655e9.1
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 01:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783672282; x=1784277082; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+n3U5wwSeV0LoCh2u4qLjtm5KEl+PjXBcMSOv2cFD4s=;
 b=V8hAc1v6F0aG8w/FQ6fA7ZJNNMtSimoW/dM9xdDBQRMxwcJwVTzJkhbBHD2gZuwCuL
 739jpOBlwtfn+N7lv2TXo06BNisRYdcVA8ZjcOIwEwViiGm5oooRXEpvDP77e8JJuWgb
 ubEHzN5CH7fOMB4UhjmcFJMTJ3CG3rSvvmz/yNTGW2tRWDieL7E2tdxAWa6DBDkvZgbt
 cO6RI1+8vtGdjgrkc0DuR6CD/5YVcJwr8KYL/0if+hKtki2MoU8HzXY9nhdzcvfnYCdY
 ZUqCqLFfjzuK8dtb1vGzKzU9c8kkAr7Jr+0FZFcwMe2T4y6/2hhANFETyiWS0EjqwCSK
 U4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783672282; x=1784277082;
 h=content-transfer-encoding:content-type:in-reply-to:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+n3U5wwSeV0LoCh2u4qLjtm5KEl+PjXBcMSOv2cFD4s=;
 b=oxg62Lt0lOAfdwgXNC0w41/eqrpQeoZEYkphTagW0r8UU09nBUyb2/T/of3j5t10Wl
 6UoKj570+S14rK+Ku3ZsLAyWJzuDLzs6nMDVm8rJ23D6W8twOfSyjO/Zbn23KjrqRAJk
 9tnDDhp+y3J1phJ3qGDdXA6kcpjTeufCSChWqYkYLE9axkb6BixyFC2Ej8y4UZPXV6zS
 rGHSWlEYRnw2bNNmp8mX/w0pJLovC0sqOOVxXHV0ljjJUp6oCoAl5InORN2PNK8rgMhp
 DJISsCEiXne4KeZg/PWb9AgP2eB+a93rwzHHDlKWZIfM1giUcm/Y9J7MMMpXS2zv0TBw
 nwPA==
X-Gm-Message-State: AOJu0Yx9Zw8kuDj4J2eIG3CM+FyIVTGWKjx/9z+x2hgj3tQeW61JJcgF
 jNX/Rq00PAXWF9b4HjANjCjEHF5X5kSzsK0ekv4ljTxu+NArdMNV5JH48ZVAe2RszNkjkxb79Zy
 Km/5mMPs=
X-Gm-Gg: AfdE7cmD2xmKmLC/kuDBr4Qu9biar1IGZ9KAwBRzbwLPgea4J//GtRCv57wXrXHEfMP
 PAT1IZ7mZnh/zhqRR3Vf2kZQWQGTQNRNK1v7xzwusQbto5XYn0rqubz9x31X4eS9EXNLaaCA3jP
 Zj91csO2zBkuoGbBhShq3hI17T3HoaAO/kxi7kmNJD4pLYFwbbt6DyZ8Wmxh/hA+vDaW05NTWHG
 f3xTy92sWlNK+d/ToLpSQAU9V7qlzTB28gCHd7qDAEUxyqmHmFFmi+Ogxzy3w2c+Dj1or9ZOGpI
 4DvOhVXf0dKyKeE9VV3M36qgFEHSn5XOMPEMQmztDk6S3ZCjzDgfVdgAqtgGC53pyUgKT7SXT3x
 R6/+f/zsjKsJ9wPhCcSDNmLtHkmGV+Kg6xXDi/C3pWRF7/idL+PqM+tH2PLknmTJLupE9ZeyORF
 zXtFqPP2XQ87w0hIbhBA1mZcv3taMUvA==
X-Received: by 2002:a05:6000:25c6:b0:473:f047:4f with SMTP id
 ffacd0b85a97d-47ef695b7f6mr3239619f8f.8.1783672282383; 
 Fri, 10 Jul 2026 01:31:22 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ad21sm57179170f8f.20.2026.07.10.01.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 01:31:21 -0700 (PDT)
Message-ID: <ee1e0025-4e1d-45f2-8756-7b0197e75b7d@suse.com>
Date: Fri, 10 Jul 2026 10:31:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20260710075548.1167519-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20260710075548.1167519-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test.sh: Remove LTP_ERR string from error
 message
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>

Regards,
Avinesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
