Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873E5CD4F52
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 08:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779180905; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=ktB/REtqiPW+Rg5g1OySA2ctWoDGHFuiaOv3oZBRWuUlKxRjbwBq9yPEtDTB/hvQXOGrq
 YYGykY5XNbzGrfv/oBjiEd0uy7a9txCieiq3I4pbRygclEsja6UQbv3VmXer9LYwaPyPoLa
 Jx2nbAaMFQiukeLcAsi9ukqzree48tg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B5B53C6F3A
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 10:55:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F02EE3C0848
 for <ltp@lists.linux.it>; Tue, 19 May 2026 10:54:42 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 90E79600110
 for <ltp@lists.linux.it>; Tue, 19 May 2026 10:54:42 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488b150559bso25182945e9.1
 for <ltp@lists.linux.it>; Tue, 19 May 2026 01:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779180882; x=1779785682; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=TqSq3YP1uasOM8Tn72C6Zv3lr7Fe062eVljJ4f4q4GoqrcJfP3lXS4kg9JZ4uEPss7
 trrl47S/TRQOPWxgJa8ICThIPrAS0xAODSMBRouRvDZ+xmO+M06ZPPmvG0T8rR+DHMRf
 ELEj0U1uZMmJMAdjInzYpidarOMFIL41Y+voCpIdAHyeaUjJBbykO9PPjWDk7tQHcBqN
 UVcdynSqAfT/dHPqweBGVQNVzxtPF9vXzOmqTihCk5vB0i5O4mZsqAUxZfAqrnisgLPk
 2x8y/sjJh5tNMiMrvEgRAoW5zhvnUBhxCpaJis6PweXsvnHdYxi8w5vBXSIbjl5mVsnK
 VByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779180882; x=1779785682;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Z2MthWjAHAqgTU61O/ZTIg+8DtKr6RQF4F7rzfEtC+lDRgqRvTuVqc4zSbMGpeXf4r
 xkgsrviAq0inHT/yAwKn2fXokMTuH8NvICD3gjrzxs/8qmbGLrzZWhU3Nr/hzHvB5ghf
 la3OFetSNt1HpuqJ04JLTJhmLXyvocU8pFQM9VaqNvJzDZrn5PT3e8Xg49zOuyhiyVsn
 pQifa8SiNa7xs7v+o7OrISb4yY6Zeb/B1YQ68xILLV84Y8jbgkfe2/zIPTIoOHhNkK3w
 5LTh92m2vOhDlBHnQy6hSWOmJraN+4Q0ecskuKxgqhbTd7ye3Li8K79oBOpfQpwWJpxz
 6++w==
X-Gm-Message-State: AOJu0YzCCFa5j7n2loGZRKi0BlQtQlHLg0t3aibk/nFHgm06LeNkMlKU
 zRncDL9QQYNLoT1EKb20qveoBO2ty4tMeHfEdlM+1tric/Kn9P/Y/ps/aCqquZmeRyEGUmX3Csl
 evxuF/ow4vE3l
X-Gm-Gg: Acq92OFtH4qyxRRkxtZfjgfxUeO48Se/LTRwk/bYQBMYcd0m67t3oYp/7aJqHH1DN10
 ue4D6azvPKSv17hCww9jMirxvnGo7UOvwDskq/G+B6bvQcn6AfCloK3d7KqEPjyRXtABD1ssglW
 zKiUNvNheAXNtPAS5ZNc3mkOGi07tg3tBDMh5cOI3r/IGtsSu9lClikbvfDoI5uJ9H0+rqHmGMo
 cUSAoAPBUwQrM+QvZFzPFv2uEwejyzs7r+R4taQhB0rIlMuptlA1Rv5JIazF2D1AcCezGG4N5AM
 rv/aUnCAEXu/eaA8GFx7LMMYYEg3QjqlnuE/edKZLcvOYsuxxoARGYJeTwt8ox1T0TBIypkzRfe
 xTvM2qFP7Kid2up6SHz1NmKr8CxzReXbGvsqHTXjEMAWVD394xr0f5peJtSueZHMrE288SqsF8D
 912vqwmRWKxCyZqTCIfbVziuP957ibfmUhjjMZLgcNsLYisem56awy05oVIOXjMw==
X-Received: by 2002:a05:600c:a406:b0:48a:97b6:7420 with SMTP id
 5b1f17b1804b1-48fe6329938mr226724775e9.24.1779180881732; 
 Tue, 19 May 2026 01:54:41 -0700 (PDT)
Received: from localhost.localdomain (wl.mlade.cb.wlnet.cz. [193.165.72.195])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed2f738sm42986379f8f.16.2026.05.19.01.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:54:41 -0700 (PDT)
Message-ID: <6a0c2551.b901126a.194f46.720b@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260515133613.31249-1-pvorel@suse.cz>
Date: Tue, 19 May 2026 08:54:40 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_net.sh: tst_rhost_run(): Go to LTP
 temporary directory first
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
