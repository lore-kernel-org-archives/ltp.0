Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A94CA1015
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 06:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756967569; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=RKt0v3ptGzG5fYIxuO2rzMERQQqFWwnAgrwZI6fITx0=;
 b=eS3Zt+nWubLUas48FyRxkIQMYJ6oC0vM31brBM3YgwtJgmfPP2y5mSyGs9DAKFD5xH0s1
 6/HjJfMHlBqUvTIzURSKd/Ysq8tvzy/iuPziLYpiWpXKMTOu7eVF8aY/OVEPlC1FQ7xNu8g
 nxGYiQJecMpFC/5qk5+Rezk/MVSJLqc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D3B13CD3ED
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 08:32:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 281E23CA14B
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 08:32:27 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7801F60008A
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 08:32:26 +0200 (CEST)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b02c719a117so118865466b.1
 for <ltp@lists.linux.it>; Wed, 03 Sep 2025 23:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756967546; x=1757572346; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eWPHi+lyQeTtidbbSjP4twQYohfx/pM5h3tyBKwjDeQ=;
 b=dpCi04K5pFRiLcy1azPgHTkhIW0g0suznZ4yu9LZr30ew9/aT/0gcpqPU177txsFd+
 zgLxkiOtYZuTG/7f4uPv+WathGyGk1FKqLD6e5gbceWljU+GRXyamqwJRS0Qarq9LbzK
 LZmQlesL4OpZIVF/nJPr6DCIgwWrY8twoLPNnXBF4yXp7+BjWVR85PHXbrHEdq1oRm9t
 bFse+djciP/4QCW2kDZzb3bPKYq5zjXo1eqYXv4YHcEzG1fmo3L8nDdw/v9zVHtHv32c
 WQTDD6fKoL9RbQadxFsdBKs+42qwKW8xyw5y5tNb0jUZwDTmYHphGkejbzrV5Sz3BG7S
 8yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756967546; x=1757572346;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eWPHi+lyQeTtidbbSjP4twQYohfx/pM5h3tyBKwjDeQ=;
 b=cGUhTedvcI9TrIlEphNCRJdjEEHPZkwaQGazhyL/zPbJaoCtmO0ww8fkEn/xpw/o7R
 wklo7pJBzYdRjq5sxOEX9vsNMH6AtVBw1vdM7lpGwrRy8Gq9UzRLu0Z5cJ5h4W/JyT0w
 /M5SIBpq7byrzkkaLo+LsD7muO/8wonWIyEEJJ6Dh182XDc2yDR7bMNmEDBIDdsWqUQt
 LJCuvUS52p3CAKCkVfiqqqMovAUPhtARDtyHI4MR+SIiW7M71xuWWpt7F42V71fZrbtz
 04XH2V0ZHmkczfgufS5Nb2a769f6SRyYlQCckNdoeAwAQY0WYXR+DxFFEXLVafLaVeqv
 x/SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPL9r7IYB93FsYSsfqJLDlWp1se5ycBwXmhWi2k7FOZ2x6fFk4MNMSH0hZQ+bPfN8GFpc=@lists.linux.it
X-Gm-Message-State: AOJu0Yww9KTZ+b4MTBS7OTjnC8K7xnQ0YgWfgaXa9lOojMo66Dd3e+J8
 E9UNyaxAN4V/CDTZpN0G1vUndiRnVdsiKPaDMnl7cYnBuht7V7/zlgp7AXFz6xhvXdY=
X-Gm-Gg: ASbGnct7dEHf1JSBTz5qFGTWsgN6PXIlTSYYQqeOjF5DqD+yCnbLieNRD9Da4DDuSQa
 zpzzNPNb5dU7CP/kfdEFZV9CqKXk6/QYocd5ebPwJNNDZqP8vCKINTfVzJphQeHVlsOySzwYFU9
 oYvzqe+TZCp1SZYZVaAKip6cDlAL+20cqt5WuM6x61HcJKGfvTaYWIfgmUaJJJJkmSB3U82iq2i
 b/bgOihOOMjnaZqIRDDQc5rmw+we5VMK/yhNls0vRzsNn9H7n23P5ReMoTNYq7fasJkzvzIdMyE
 UUFEV/pQov+sSJGBRisao4OSm25keFfzu+/e2209DvdyD3dQ/AGUYnl7XwvWpsSksM6QqYRa5a8
 XNur9J+mV1/pqB+mKDqcTx5AQr6i60ol533tTVYw3LxbnLUUtx3CwmNN3IC6a8dx4x1Z0NDLGMQ
 B6z56HEIgKjJj/XFCp
X-Google-Smtp-Source: AGHT+IHcMSvqXRWHPueVeICHslJUviYsOywhDYwc2LetftVvvm/TQ0XK8qKiAfFFVEqpGJJhAdeVAg==
X-Received: by 2002:a17:906:4fca:b0:b04:6546:347e with SMTP id
 a640c23a62f3a-b0465463a5bmr561040566b.51.1756967545783; 
 Wed, 03 Sep 2025 23:32:25 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b04709b3effsm263979266b.5.2025.09.03.23.32.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 23:32:25 -0700 (PDT)
Message-ID: <a612977e-59b4-41f5-a7eb-8fed2bb86f3b@suse.com>
Date: Thu, 4 Sep 2025 08:32:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>
References: <aLVzVyaVhr4IHkyd@yuki.lan>
 <f014f48a-294c-4205-b147-e20074a8da48@suse.com> <aLgxmUJ7e05X1seP@yuki.lan>
 <aLhAj_-gzjmzvOoX@yuki.lan>
 <CAEemH2dzju5n1FZ8TyG0=YBJY-A80VD7Sv1PLJZuj_AYNERYvg@mail.gmail.com>
 <CAEemH2dPTgYX3LZ4Ux6YUZ3vuddNsOSoGw=eN-dD=-qOodkLzg@mail.gmail.com>
 <a991f7b9-0493-46e4-b0e2-a3ec284b3e13@suse.com>
 <CAEemH2cuVP5n0HuMQBZjXjyL0BLv4=2AfZU+8Y7DtMjRyPx0KA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2cuVP5n0HuMQBZjXjyL0BLv4=2AfZU+8Y7DtMjRyPx0KA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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

On 9/4/25 8:29 AM, Li Wang wrote:
> Yes, I will send a strengthened patch based on Cyril's method.

Thank you! Looking forward :)

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
