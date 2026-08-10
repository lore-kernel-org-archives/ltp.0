Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70411C5AE5D
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 12:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786364492; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=OEB9dW81ijDTgsfWZbmFtUd5nEX+J9v2VSgxkgblqF7Qg4Q6kGqGZ4AToEdXYoYIhT/pT
 LP3YF5el8k2aLAiQMlVpjeAVK+9EpR/HLJ1C05/UlzTgn5PWb28FbvroFhZKhGeYaEVIHWJ
 t7Mw9IbiUl/wf0q1oAXTIiutv9qzubQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4ECD3CF721
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 14:21:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB5393C93DF
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 14:21:13 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CF8B61A000A0
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 14:21:12 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47ffaa8ebbdso1484327f8f.0
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 05:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786364472; x=1786969272; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=JXsFZlESyzi4IPaKXfl7HfC12eU8R3vsF39uxBdleTGQ6vafiBkjJFV5NBCz9fMQRj
 Mu9Ni81Y8I06utQ99Jl1SOpOJvUe5flDgpyW3z8Db4SdtEgsqSj1+lEYgj6do2/CrpR+
 PENUd/ma9s7YYsxtBjNzJKnxPprrrqK6fx4OlwU3AdoJzAuEflbvISxRaCUEkA8XJ/UA
 gipolFOgUM5IAFn1DlvJyDkkYmA4Mb17iySzRp6IiSuxUwR12ZoOIffGFfLofO2KAxqh
 imJXt3Qkl2M0ltLxLTmfv8Gs7gLv0cyuTMKGeKFqRxclOjwrWCo8qJR5oNf/7XyIIu04
 Heuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786364472; x=1786969272;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=cmnzt+ZXa3V4RKQDZUjDk+Jj4v3gM74c0vWYNZPyLn9OXlNQD6WfMI764MzKPCMQVm
 d8QU2/nr+kN10qKzj+iJbEuR/cHLAA0+cea3HTcrBQdjhGYxfTggS87ZFpvf6Rf4RfCm
 8+7k/dJHOj5dKgCIq5tSIi5CPisZ7zzCKFTSdCR62Z4zY2P5abCc96SFkAmUGEWVznfw
 lsvC5kjGteRpaIItQKQzWSID/Z6lVyQpLiiV1QpMMBgPJyhXdrrNaFdst30Q43S30p52
 Q6j6LhjaPAo+vuQ7H1n3BlDNpgg04Ih3hPMF3pBfkRQAAgIVZcRPUHSzb8bsQ9/rnYD0
 A7gQ==
X-Gm-Message-State: AOJu0YzOQ0j4oa0RjnunmL8LP7gJi6JQSamrDsSBnCvsMoccINXUs41s
 85G/JGef8Sk1ld0kIZSVOzCDZ1ixJVCOfPpoWe9Q1tgOGvWdPhhJT0mG2uI61A6WLJdlzCX4XxW
 D9hZH
X-Gm-Gg: AR+sD111slGncCaGTyABJaaltXh3mgPGdKApvw/+0GEW9nUZsSovBv1ney6eE0ocFAJ
 3Y808IBimF1VASn38sdYH9zmvnMK37WXlT6Swxhek3I8bTJW3k1hwsCsA41PKOGrZOrSCSNScDM
 ueXCtZs+0mxbIOidI2uIupOjTxquG87KIP2LFRrWk7duFC26Jwd3laKatqou7Mp6af9lBk0vJdb
 nX+uTqWs6ZDktCRb808v0w+Lh1M1lfut8HJMyTM49MDPJSccCRQj77DkBdl3SA9ZEpPdOccr+uR
 xEYEKn2+D2emIrwtbTgBgKiOekezgf6uIY7Uo/4TU4q/0Zt/SMs1bMnUBvP969zfbQkx0wAUi3i
 DIJULwdUGdOnyx5YhGM2ey3pS76yxdA8pdjUdEqFqN/AGhFOWHb7lqKfIVFjE7BhgUhwdR2veli
 3uev2+c4yOLL7B8vPyokwFRfPXI57UHwIGM3DqQOa47EUkFxvyM1KZ/7IHQiJ2qXO4ozKfP2M=
X-Received: by 2002:a05:6000:2991:20b0:47f:9ac6:c9bc with SMTP id
 ffacd0b85a97d-47fec4e2905mr56325617f8f.2.1786364472125; 
 Mon, 10 Aug 2026 05:21:12 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021506cbsm35945026f8f.14.2026.08.10.05.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 05:21:11 -0700 (PDT)
Message-ID: <6a79c237.bdd87efd.2818a4.c390@mx.google.com>
To: "Wake Liu via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260807104442.2831991-1-wakel@google.com>
Date: Mon, 10 Aug 2026 12:21:10 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/file_attr01: Fix EOPNOTSUPP expectation
 on tmpfs
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
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it
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
