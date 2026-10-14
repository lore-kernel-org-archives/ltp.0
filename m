Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8F0CC6B1A
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 07:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791962762; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=kYvbmCnp6cuzoofFJUPbY+vpjMFKq77UrE5sXUodT4WqV/Zni2OCGHMroAaF86S6FKk7/
 bDEpxUMKtNtEp0GOfhm6OQgntPcaNtewlig4SFOUE144MlUGBwywj5Psa7LT1VnCsg3TgB1
 ltD6/qZxw6/SeVmPUFv+8Q+4mveuEwA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77E663E2E48
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 09:26:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 211C23E2396
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 09:25:41 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 64C142009F6
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 09:25:40 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48de72fc832so82862f8f.1
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 00:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791962740; x=1792567540; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=LnyM0gtpp8g+k+qZjHcMgBYp1qTXRpK6S2uXcMQUtuGD0AzQqANNk1onBobGAT7MIG
 E6Qam5LAGXqna9FG+1DywyybjYXwN37sHu6FLjPrJOTo6JkMPjlcVqaqZSV4hcR53Q07
 XSrCa9FGn0AcMmw5B5mGdfpfK8Jj9SL+VMO3E5lUOjQtdGgqHzjBhCO9IgfJ9Gn94JQ2
 6iF3GkslmAd9JcTwsj8u7cP/XLQ/UBogNxg1g3kSZY9bRCRfcOW7oHyQ9oC/modDWdww
 tSYwZu2m8p3r45jk56eziUPUF78bn+nkAZJ0hrj74++39ReFo0GaaQ8dhDpMifL4+fzA
 FzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791962740; x=1792567540;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=WzkxyM79AQYDf10tWmgyCtyGdtJrDrgt/Pmx+qqyJsRjV/32EVh+hSJOMTjrJZPi2j
 fNJgLWs5nDvQ6HWJO0H2QwMKTVKkQc2NyEQF3ZP1BZYyzldli6425wRNmWUKAQt/n6dx
 YzaFfpzi529quaE1+TJ9dBhgRvaCFOPtfGUx09bIMUp5MqoqdMv0HwJK7izZks2aB7hK
 PrdYVkAFfqEeYFzYqtWxshUV3crJOM6XMONYyyp2RJ7+sNm/aoms4enGrqiZ56VN3Rvr
 hrYJvaatc6JUYODkgwS/lCvkNQfK3DTvgo6OvEl0jPhbf0zWh9ZByV1bcRwbBcW43Xq3
 oKmw==
X-Gm-Message-State: AFq9FYLn7WJtw6zGDnfNZqc97NVyaA+LOt/NyGOJl9w+79iblty6OhYj
 UKaBm6Wn/gINa10S8ONpru4aDOck3uSzaR6ZeaLQAXJZQAjK8X0U9Z1o9FfPxSmUAkM=
X-Gm-Gg: AYBFou1zztmcUGl6Nkx342B8FFcMQl/l+qi49Jv5MmHogJFu1YL6iL5zQONwZGpk4pM
 /ijOep7GQ13k0261oGiPunw+iCmJxCBOOQ3v4EkJMOR9EEgb4QUiRzObY9aUjfnxVWstLcXGPkf
 TTJE7sntv+Rsv1x++1hM8ZG23YR7KjOYuVOnRki39zXqqSl0Qc9TkLUkPT9INwQ/+S9e8tcOjy0
 56oJ2ZXGXtq4iiGd+2VY3/N5Ni8rkm3ClM42zOzAT+vcwGQgF9V7p+WFwy0tE4bs+iVYCaM3n0x
 Uf6Wb5Ml9xa35jSmEqG8g0qu2WyvdyHgNdkFeFrpGXYjqhnEqZ+T0HOUJnD3OJ+B1cLOEGzxiPv
 Dks84fFKJxoEgFAPfskmGIKcv+XKMRTx57NQsd9AkngZ6Eh4rg+/+OoGdX3ow2Gt48CElMEThGY
 wK3x4Rp2Big4FM+cFL1eLkw+5i6mXjFJ9klHugY/1GlGwpg8ofHF+TgXpBhDYVfO+mSd5fkYgll
 +nNbuzNy29Z7ha27hBeaeqc17Rnvp3dLHweRvrvJWwoVcAIzJqYtkrVxawQSbgbNBhxlF+gCm/u
 AA==
X-Received: by 2002:a05:6000:46d3:b0:48c:45ed:2425 with SMTP id
 ffacd0b85a97d-48dba789373mr18424190f8f.4.1791962739553; 
 Wed, 14 Oct 2026 00:25:39 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de09693c7sm12376813f8f.4.2026.10.14.00.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 00:25:39 -0700 (PDT)
Message-ID: <kshmrjSHNe4wZO1Q8e9E92KuNL3CVzPo7Odw@localhost.localdomain>
To: "Darren Chang" <chihsheng@google.com>
In-Reply-To: <20261014060212.1081388-1-chihsheng@google.com>
Date: Wed, 14 Oct 2026 07:25:38 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] process_vm_writev02: Fix stack overflow with
 large buffer size
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
