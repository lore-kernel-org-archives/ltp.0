Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EBDC624A4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 13:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788442324; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=yfEnLpCFrtW5HMXUE/NqU5aazzkjnRG5G7sKxe4i+HM=;
 b=gNn/8+FU33plWHcifC7fJW8jXHKTgTp2JQDr8JbVc6zZSoKcIlbEFPTiYGwIciar6k1+L
 oWK7GigNbstBTGRlQFdQI2+vpteVFiGOh97e9kvdqC3RvZY4vMJUxrjcRlqoNku5iuwjZ4/
 nmHACf0lvx1LqZ/I9kFGejoZLvJxL6k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 314183EAD9A
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 15:32:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 399C53E939A
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:31:46 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7A08B1400DEF
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:31:45 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso17768035e9.0
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 06:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788442305; x=1789047105; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5x17tLRJyt17yCyc0vbHTWpuMsKkHNVabVZePLHQCYY=;
 b=cnF3LwT0XkVWO00Qeo0EUxsI4fykt9DVLlEc+5+XidkdRqMGbyJBgzwJG4XdZfoUZa
 DsZwqsrZ6So7N/V6ZyE/R9tNWwsQXDPbXdftiW+2lbnKFXdXrnpNMYY/Z5ZO1idXwj4L
 VXMhF9wULcNiLeJvsohx7t0deU+uJQcKJ6UDm1K6+GgdJ0ZIQqDTaTBEwTye8BtRyVeY
 gNW6T+V38qy8/9hgAxhQr0OyrO1f48kDYZ8+Z4tl/M7ceEIbFm6pwHtQPwIMZwdALg3n
 jXSRUtVpm+qC0fHsgmA7fpLgGoTgVUq8Wbhp/WhUFb1/z8LFXQXaMSby8nhQPNtpZDFm
 5UTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788442305; x=1789047105;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5x17tLRJyt17yCyc0vbHTWpuMsKkHNVabVZePLHQCYY=;
 b=S+X+C1T5ANzqS9Y4cZ1xGimn45trp8e/e75UsvViA90/BfZd/h/zEdRujI77QiPcBp
 ErSJkqbGndwtsJVjSfjJ0HSAdDQOKL9gRf/vuJxk2Sd9SrdMvAUePUn71KOaf+CNXRpd
 wfV32HJYn+bzMq8Fp9J0E15SGx4FaGuw7Owl5rvQWP1/3lf6YHqzPfLXhNl1CS8LmKdJ
 yrGgbx6Q10eoo6wGNoHgH8Q10Sh41fGm9xzmOOthLUGjs8esIfGlgku9kuG2AOkNZ6nD
 Zd/qxfWYplE4GzENtjQoETibE73vp84bSO3EfcMQbPI/3AzPzRwOp32IXIsjAGugeUmf
 9htQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOUW2cht6qQRBBKC9S4wTtAnx7PK0la+1ix6v9YpSj9D+Kc6qb3Rt4EsB8sOp8nz3QEjk=@lists.linux.it
X-Gm-Message-State: AFuF++meRfYDlQdFIBXRa3V4yS0CJt6TJY0uEYVUlTDsLoHjmlnsxoSL
 TqCfoJ9hEalU+gf7HSc4rOMWD2SCgW2I/LgrN8hlXswD4gzZ4GOE+0Aev1/rHlK5WBk=
X-Gm-Gg: AYBFou1RGW1xm1+Herb9q+2ibyTqjKVGqen6xo6ce7ZzaxiQszjxtdKdv1YntKV7KOH
 LyK8sNHkB5zVAhG/TvG9SGuRTd+vukWyygxIeFmZN9QrbOcQ2NCCGOvf++muTOyV/Z/xVsX2QJn
 CZBj1JmJNpoa/iiXQMVg5jRJPWIUf9GQw5kymD+1mxzfknAaSEbNROWT2E1iSLRatSGgOQP8+Wy
 vI+Yl35chW/7L5zhYpiphYMD7DixFGAWWmoaRChwiwDmlSiI2pRlK1iO2Q6N9JwjixbDCNGTOdZ
 Z1bkCfPXVL+7iCihft2nCJZL9+R2BfxAIb8vT6bPCttfjriF37KaSSx+Auf1sZuaKMZm5iybukE
 A3YsYmqAyQkcRC6z9+Xe3fCzpp6xBaVLt4jva+zlUSN1HEa1yFplfYV5mcD+fyDheZqvFbpHfaX
 IuautfBACBiWs+ccQgsVib+mQwXkTyzE8ONTk007vqkWB0RRV1Rq3jz0/WeWSZLUz8lpAjK++QU
 Phg
X-Received: by 2002:a05:600c:c48f:b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-49ce582276dmr196611185e9.14.1788442304737; 
 Thu, 03 Sep 2026 06:31:44 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-484492cf550sm14003740f8f.37.2026.09.03.06.31.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 06:31:44 -0700 (PDT)
Message-ID: <b293955d-7a83-4b8b-807f-3248f8eaeab8@suse.com>
Date: Thu, 3 Sep 2026 15:31:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20260903124631.1100746-1-pvorel@suse.cz>
 <20260903124631.1100746-2-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20260903124631.1100746-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/4] Remove testscripts/network.sh
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
Cc: Tim Bird <tim.bird@sony.com>, Steffen Jaeckel <sjaeckel@suse.de>,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 9/3/26 2:46 PM, Petr Vorel wrote:
> Script was using ltp-pan (already removed), kirk should now be used.
> 
> Fixes: 5e5fd4a1ae ("pan: Remove")
> Reported-by: Steffen Jaeckel <sjaeckel@suse.de>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Acked-by: Avinesh Kumar <avinesh.kumar@suse.com>
for the series.

Thanks,
Avinesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
