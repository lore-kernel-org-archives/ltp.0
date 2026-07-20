Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474E2C44520
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 15:54:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 504F63E76A5
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 17:54:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E80823E62B6
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 17:53:56 +0200 (CEST)
Received: from mail-qk2-x0b.google.com (mail-qk2-x0b.google.com
 [IPv6:2607:f8b0:4864:34::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A63021400445
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 17:53:55 +0200 (CEST)
Received: by mail-qk2-x0b.google.com with SMTP id
 af79cd13be357-930914e4fc3so234369385a.0
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 08:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784562834; x=1785167634; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G3TDzvoXwBTv6OzbPEwU+9ttJfs/R0EUWmUvXV30mRY=;
 b=d7lznWJtigY2hQuyiTcDSptPKt5LxWTa9FHAkHHeFC+tfcywwPDCriDjuyJckcimFP
 kn/oIgNswNzfhc2pfHo5ie6aZSrWWqoBWbISl2M3RMSJrkKaY40kdd/H5l64Yx1/vew1
 C702fAsIamaTryqhpHm87Nc8EaHILKiU4Lk9GWL+CAFurmlciqucqzQ2J81FjOUjShE6
 +zuoheIaVsZX6Pk72hvfmiRL3NhYnAE04CAxVTUBxOnX4rhVx2TFHgZQDZltLhG7StMd
 iNpU/kJrKAgQfmRHhpIySmV1fCS7fDfo1j1wLmHG4DFhcMXJcdsCPgBynEjeht79g+eP
 Sc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784562834; x=1785167634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=G3TDzvoXwBTv6OzbPEwU+9ttJfs/R0EUWmUvXV30mRY=;
 b=BLJO+AvwjreXc64pyA68EtRNcBA+FoPLGkaWF40GPBZM12hl9ifJNoAZzuUJIMDvag
 /XXhk7igdh0+pWSgDskzn7HeUyKG+kX+gfH6R+kfvAXKPoq+c/OUWXuuFUhH7oIEKjjt
 +Ou4OmHmvs/XeeI+AoD5SSLKqMe6latlV8nIT7Jl/hY8yLqJwJ3mGhEiZba467Tycpcn
 uGiicEDstPK63VEOFRRZPCi1Nd0zYyB9XHPvsuDTlGAd3Ps4UZwe1+4Hm+v/q87sZkaK
 xRvJvhysnoorlsCQ698Th11lUIb4YmoWcDXIbhryBKz07Lj6UR+Vivc12Xk6Z3V1t+qI
 D74w==
X-Gm-Message-State: AOJu0YwKY5FaxHfiHkNtr1B3LNlokdwRGBGx8E9ABJ2YErl0IHz4r2eM
 /sStNqkzfGyXepk/0pHozqFt4my0YpWonK0alt6rG/bKLZPsUsSp0gu9PZH8UXM8
X-Gm-Gg: AfdE7ckM0fy3amybX+PKaSbbGEEvDMmnnk9gZqfc8FBdoUSSMAdCMJN+RFM+hdjgQdL
 azoMn6aTHXZWxAgS5B9gRQzwAFcyIpUvh7TmVl93+TgPjoVmFkBbe7nD3+mRpuNBQjWnPg7S0gK
 741MJqwU8MwU0ZB80gZGltYrLPH5ToW/RRlpZpvdwwJsax7csvEITPr+yuYUnf8+q/w9vwe4LcY
 5zkD5hh3khrs6G44sXhm40NeM9YWZ6I1eiLYcKrzKz/jYtAr+p9gz8TLgy73XalLmMs2XHqhrDF
 E0jmqwpixBrrofDMgQEywlo+ZHu96i3HVZZk5KW2mXEV25ePYCZ8LwGRoq9bRD07bGUVZax7L+I
 QbRKE0t0mpaw2H9+Ss0gttwlQDE9w5TxIUZRyIRmJc34qFaWvFab940tcbiRUxxggqMdXxbL0Q1
 SS/VTy4bN3yvPhX/50P0DWyM4QasiFuohZBNKxFMnrpkf2S6pJEs7GvvXmWsGX81j+Ttw0bZn13
 SWmfQb8M2mfBVzw3/xd
X-Received: by 2002:a05:620a:7088:b0:930:a263:7593 with SMTP id
 af79cd13be357-930b434ca56mr1459880285a.85.1784562834146; 
 Mon, 20 Jul 2026 08:53:54 -0700 (PDT)
Received: from
 runnervm3jd5f.pfe21i0rikauph5zkfwnlcew1b.ex.internal.cloudapp.net
 ([135.232.177.180]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930b52fc745sm914058385a.14.2026.07.20.08.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 08:53:53 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 20 Jul 2026 15:53:51 +0000
Message-ID: <20260720155351.4024-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720140925.86664-1-mdoucha@suse.cz>
References: <20260720140925.86664-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] setsockopt10: Bind test sockets to any free port
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

On Mon, Jul 20, 2026 at 16:09:22 +0200, Martin Doucha wrote:
> setsockopt10: Bind test sockets to any free port

> +	tcp0_sk = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
> +	tcp1_sk = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
>  	SAFE_BIND(tcp0_sk, (struct sockaddr *)&tcp0_addr, sizeof(tcp0_addr));
>  	SAFE_BIND(tcp1_sk, (struct sockaddr *)&tcp1_addr, sizeof(tcp1_addr));
> -	const pid_t child_pid = SAFE_FORK();
> +	child_pid = SAFE_FORK();
>  
>  	if (child_pid == 0) {
>  		child();
>  		return;
>  	}
>  
> +	addrlen = tst_get_connect_address(tcp0_sk, &sockaddr);
> +	SAFE_CLOSE(tcp0_sk);

This moves tcp0_sk creation into run() before SAFE_FORK(), which means
the parent now holds a live fd in tcp0_sk when SAFE_CLOSE() is called
here.

SAFE_CLOSE() closes the fd but leaves the tcp0_sk variable unchanged.
In the original code, tcp0_sk was only assigned inside child(), in the
child process, so the parent's tcp0_sk was always 0 and cleanup() skipped
it. Now cleanup() sees tcp0_sk > 0 and calls SAFE_CLOSE() on an already
closed fd, causing EBADF and a TBROK on every test run.

Setting tcp0_sk = -1 (or 0) after the SAFE_CLOSE() here should fix it.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
