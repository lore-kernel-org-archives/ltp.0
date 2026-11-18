Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B22606A320
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=Hju1f3x/;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=MUtdbHo6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794995066; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=0QA1WQmnfhNgZmwEjPPkhlRFhln2LtnnP4KEymthBlM=;
 b=Hju1f3x/dRcp8AhedogJWBcskFgLv9OZipB5umhJCbAfha5glpYdKSpqHS5ZuWGum3Yc5
 3gagCvg3zk40DUNREivRMRtDtYsDmejRffyKqzm8IAO1ulkJvI5ptnhO0MD4tuDKLLcOonO
 f8afXEL5ADFx6ITXmaEwTWb9k39Xigo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D07C83E934D
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 10:44:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2BF83CC895
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 10:44:06 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4AB8D600719
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 10:44:06 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso7052205e9.1
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 01:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794995046; x=1795599846; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ye0hYX7QVzaA4TfEUH0VEUYwFI1F8HXb5iuYOplkfRE=;
 b=MUtdbHo6LQ/tlHxuJfEaBKawWu75NydkRvBnuuHVPQ4tgBP6MchIzT8+lBWDeWO0Q5
 d8cTL0zDj+fQZjlddpf15Tx8tZ3OwxOhHRqGrdqIow9bFL7WXNsPZpl6RUuNJ25F6TiN
 iTfQcXIX3hiBiuyt4Y1eaYAkzeQwfnW3cImQsIUKHJHNE563Q6bjHLtjULlCPxiRRkAW
 VFqlvE0jMJ6Eoom5prkQwUjfC6WG9MuO+5qYfbDVKYm9PKVf2zUjYmEsph3INdZ5Kp1s
 uP7NZXtNcaIURPmG7sJcmL0xEMh1p4LUqj63Gq0ruTjX+OmnpzRusi5M6sdleKbwVmut
 yaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794995046; x=1795599846;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ye0hYX7QVzaA4TfEUH0VEUYwFI1F8HXb5iuYOplkfRE=;
 b=GUWLN2vlXMfXkD6pc4/wmON4pxPCGve01Bw3c5aBzGOp+C2OVlEOtHutbhElgKtNAW
 s9n1RKhhnZ1zc0o2Txaf++k5Q6AN8rSjWOuOYwju5gRXVQOENGd+Tkagr9awG9g/Wud+
 QZQ8LaSj40HPxfQXV5lhT4mBKJfwlEUKxgb1R8CE7mx/nkncsOk6MF1IDXg4H4IuKv7D
 a53XvYVRNiQIb5dayyQ0u+4UfMF0GsJrnemkWaAp+fNxx4gxE4Hsnw3P8KuKkClBzc7P
 FqdLA9NWAALm3FIRGG8LIIrZvO/ZWIEyXGDbgiAdKbgVwq6jQ0PIUCvwAOJUrRHqObbN
 9png==
X-Forwarded-Encrypted: i=1;
 AL+hErHtUNfDfozLfMqnC9h2pV6WVfMpDl7k4p93Q2nuyrVHkjSlB8jf8MAIavaS1FcepW8zwns=@lists.linux.it
X-Gm-Message-State: APuU4Z9HJdCipSteTStYvrYO/X9v/yhyod+T45I+TweiJbhJWGtslSSI
 TAQDSC/OUZkAoebynaksviY2XBScGke3HWIFocwN+XwfJlR/ozvhlEsvGnnGen2JPug=
X-Gm-Gg: AYBFou3s6dIas3TJep6n75cJCwRqNkvMfk5eIxPHkobImGoIu4omfujOE01bOauQTib
 eSvuz8zW71ChWRh2BljYsWQfw5wk9Mz1BeEprfAADGbPQ8G04yCkPx2n18SoJmUjuGIOdXcnFwy
 RtzQu0dPNxmZf7jbF1ggEiEQAzzqo4D+u1fcRJCMpfh/rDYvIoRIRP3Gh35DutEdu7h07KsOw8x
 6YMhYn5SRH2Eq65GMZBnfFpcsIvzjtA1KwsptIAM/B5GqZyL23ff58A7O/N3Mxpcck5SkvFGKB6
 q0pFiGiRUzJi+KlzYSdGTtk7HS/ohIhU6m9zS3NCTklwcu8W3h7r3/K4yOK6lL7y/2mi8ne+4fZ
 01vgfEh64EY3X2MO4e29yjGO8wbFcOe7mpzLC/+n2z9EYGVoeon5Km2OmlVyFbCMxgg1lLJo28k
 3pxWOxam3Qr06x2E2QoKY4HKokLA4tyBoDMxhi85oL5QvY2ZOqZlkVg2TgtgTa+GD3RkcdarTwG
 YmOmh6lOm++/4PaGKPa4xP4uku3QUxMmYtZSuo2YHkQvUlVJAQoc4YfvnWD6U8V2gMKFU+mEIgP
 fPf2m1g5yzWHGhVIdK1pHD7GED3bMDDlQ5t7
X-Received: by 2002:a05:600c:4e4d:b0:4bb:69b2:d3df with SMTP id
 5b1f17b1804b1-4bb7da362e1mr37695525e9.25.1794995045518; 
 Wed, 18 Nov 2026 01:44:05 -0800 (PST)
Received: from [192.168.1.109] ([176.114.240.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f8154sm142945595e9.4.2026.11.18.01.44.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 01:44:04 -0800 (PST)
Message-ID: <95f53982-eb13-4b4e-b377-2f9708facf52@suse.com>
Date: Wed, 18 Nov 2026 10:44:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wake Liu <wakel@google.com>, ltp@lists.linux.it
References: <20261117125658.1743505-1-wakel@google.com>
Content-Language: en-US
In-Reply-To: <20261117125658.1743505-1-wakel@google.com>
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] inode01: Drop redundant 512MB dev_min_size
 requirement
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>

Thanks,
Avinesh


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
