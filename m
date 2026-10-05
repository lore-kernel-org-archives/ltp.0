Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87371CA5FF0
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 12:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791202118; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=rgROV2GC69yMgya5FEZaAPLyHCRZazzvCPn8TqcQXC1X1YXIUlnMWcbrsO6GnYMXucgKb
 Qlieg3VedvHQ7mPMUXWRDqZKaUrt+cT5ZcdSMYSz+nDKFKUWJ7HIP6US/PAhp0+sVcOgc1/
 L/Lbw73O/4qwoztTVAm6wfT5CZfC/xw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FD9D3E2F5C
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 14:08:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A37D3E2F5C
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 14:08:18 +0200 (CEST)
Received: from mail-wr2-x0d.google.com (mail-wr2-x0d.google.com
 [IPv6:2a00:1450:4864:30::d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 920CC1A0064C
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 14:08:17 +0200 (CEST)
Received: by mail-wr2-x0d.google.com with SMTP id
 ffacd0b85a97d-482f6351831so816441f8f.1
 for <ltp@lists.linux.it>; Mon, 05 Oct 2026 05:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791202097; x=1791806897; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=gmLgg03zBAhjCnTnMHSSytCxd1Dlwdfe40ydEoEA5TxxpnsnLzmU9i1n9lXO7HwOGE
 qyZtj4Z1S7049xsDjccg7fuKFKcoHzEpuSJNfuN8o3Bz7JU81qpa8MAooPSMi3gzr2jG
 N19uCNZzjFk5zq0prSa8bokfFhXJHd1RohgQiXF+SlSsrImiDhpOqU3EdI/qscGwNX+z
 HMDzG1IBUlv0cvie5b9EtQxRy1RD15p6NhiWykMefxW/C1uv3QUR9yKp7uoiHX6HNWaz
 zNZ6NRpFK7+NcSm6YEb21R5jlay5/u1SPRC0OJlkzdYvsB2pzOMJFkRZg0vVrwnSomHO
 Niqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791202097; x=1791806897;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=txjR1lhruEetrugOfJ812s8DKd9WJg9yOcIArawIpcg86BbxCY4rTxIqxVY66LLK6V
 5H3wIzXQ63iw0vehbWRJBuoP+swoQBfVK8nOqMg0A0tva6OVY2uTR1VXG07x3OGB4wKY
 9xU+6ibqTXffd4+pxRVLNF3o4ddLsqyer8/vb9hgwbUS0qZe1GXLnYoXx27yk7COXQws
 L0iCgjQWornYB1dzdyvX3lJtSZtsUDFMM6/3VCgV36cz0nlFzd0F0ng71VBQS9MUXP4Q
 HVwe2wu6RMyJO0s8tjdP83TlohyBeqrwt7dBcilgyv/j9/nhe19IRGkW83jTVKvp+xXn
 Oz0w==
X-Gm-Message-State: AFq9FYIjMMxgIAdGlE2mKEW6HIujXtdPhtHZlhF7jZwWO6TAczLQyC0y
 7B5gdljXQZP5QunSpzGaUGXP0U7o+TE9uSXM2i2s/8B+jv6riQ81jfqhMn9pCU+jfts=
X-Gm-Gg: AYBFou3Voby4QWkvHOia8I1dZW06XN5DSovcmT44JG5t3EJdm8EyuxFqFp3KjDcqGtC
 zWC1tQVr0uw5/7oD3TSqjN2MtUDTm/FfPuzAKgVidI/9mV3clKWTuFnWL0FntCoddKZYDiQCYQJ
 TGuEFPh6lRLE9FKZ7eUpuqqDqvsQLVQLCJur4ZiDSa2Penh4Np08EOtgcyJMLYBEbfQv/WHjqhc
 oXLAr77LXsORxk2hDGLnhoQg8V0eBeXGrwAcP6poiB7sPzkpnYSpfI2KsYO+f53R1bpBXa3KE4D
 wxy7w6fJZVONCxI4eB4UDfCmvgkPIvSKOwyEKEngEkGEwJbFWekgUO44Ng1ZSMlD2vURR5elGcE
 AVhgL1qQ0SLtJitt9lERgtu0l43aC9zXLJOa8pC6HpFptTp9iroytTG6EPq9XonvjSkoQv2v8rW
 a8mW9yRBzZ0oQBraFuk00GmLJqpExhK7p7LJuS+MEusaaS7qufcT5/l4EXwwpvmZsLfJeZA6h5Q
 hJL65+HXk3BUCnf4bV5FjegBSO6YYzzrQ8QKmk6QoZeOCg=
X-Received: by 2002:a05:6000:1a8b:b0:48a:f929:e140 with SMTP id
 ffacd0b85a97d-48b1270ff59mr20246403f8f.10.1791202095184; 
 Mon, 05 Oct 2026 05:08:15 -0700 (PDT)
Received: from localhost.localdomain (p50918b5c.dip0.t-ipconnect.de.
 [80.145.139.92]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6229e0f5sm3747517f8f.30.2026.10.05.05.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 05:08:14 -0700 (PDT)
Message-ID: <6ac3932e.d5b2c389.14d673.04f0@mx.google.com>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <20261004015424.3821821-1-wakel@google.com>
Date: Mon, 05 Oct 2026 12:08:14 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched_{set,
 get}attr: Call the syscalls via tst_syscall()
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
