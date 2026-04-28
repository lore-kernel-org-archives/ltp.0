Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4400FF885D
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 07:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777361833; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=VC/6yYO6kR0jN5qZ/OOMaRwle+GMh4rfQfVcSZxjDXNg563r5neH8XF45a6cyliw5hRw5
 gMF9/FNuE3Oifa+RPRi5OqOTIUSYvBrgnuAju3vSiCm2um+Sua5QQvNzTNnMu7QKrSvk3bv
 T+GHms8AIfBwa02b9j5ivrhxxk5S0bA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4021E3E2536
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 09:37:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 782BF3C66CA
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:36:48 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1BE1B600733
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:36:48 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488b0046078so100271255e9.1
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 00:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777361807; x=1777966607; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=WDzjs+uaDLy03vykUUMxHBGJkDxdWQCwG2wRBR2dOB5rwxY6iVDDLouiJB+cluXcmt
 3Sb2j1vShtBkB8hRxMSFZvKdMfKwPwhIXIu/YfiwNKV4ZJHycHsdn657vCRujriDCd6+
 nLLanxUWg90SchbhhLanfyafJ0Q/7IoL9N0aANh4I3WZZKEgX06XFnB2cXkmFdmftszV
 jrku7HBrFWYdjdclom+HCAACOk7aFhoGxlYq+y+gKHWnTvzKaCPbkC2hUl/I3alF8Yer
 9G/oj+gRonC6QFic3KlDky3NK/XeQVC6ikv0YxhF3p8oRHUr0Mlko1cBE9PkJ3zCtjUW
 xaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777361807; x=1777966607;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=MW+r+/UPenEqp0MM8OrBasQrQZBPGYj5BL1ctxPqVw48+YYfNhhvt0Ikui5H8jH6LS
 Mnmy0T8zmgShQiCVjNam3IHoFcT7pljZwraN1tEoCVxdQalV9NjT3GLbuHCUXHjD8bbJ
 fiv0oMBTbFt8bGif+2G3VymH9yqpgB1jYUOi4W0C9kn/17xdAlE0gMM1YdXngI99j9be
 qgJDGT89+ZKI7CMgt9mGVMu/WiNaKP0wUX+eMbWJmKTpOh7i0UPn0QLFYfH5Tyt9SNCG
 7MuXBFJvY/MpCd0znHGbW9mB7Y4/gHDhDONTWWT5hca+V00h8i1MF4Dcmck6zS180jwI
 3fbA==
X-Gm-Message-State: AOJu0YwoMi93Vsz96cGqGwoieENyU8ZHrgMq+aMuOjbbWINVFuyacz7A
 0NIE/y9+36k04wpdKRNYH4VLewI+9ixpUxiwXQyZ8hN/O/0t0crDKKR+UbvKWU31Z9rJjdkPs8G
 D2INrL7s=
X-Gm-Gg: AeBDietG9Q9DntiKVqT8OJOmrrvy3fVuF/foOI6Jbm/jimDJVddy3tAFahaWvmtGrky
 QJ2m3evGIqCRrj1cyosPp3SfQMVXH/ay9vUGXKSoKc+aa9NHCtiZ/HpYpg315mnAM64rPGjaH8q
 32y0HfK9TCS56ebwydkrkZzl2aB8GYZ/SC1DPyQXV7kO+ap0ET1mX0gHz3pFCXDJOTN2GWeu0tc
 bHe+2sq6E4Gi5FdkogTWVT74KhZt3bBnXLdqQF5S+soJCtY8yVathX4ZXd1My6NecKtzJPMJ3sx
 Vk1NIxkex4EHU//ugcwAl6cVQTnUg5KDDzdO0ODBF2VFLXmUhlRlU1+ajxD5zHkOiT3Wd/dvRKS
 /84xQbveW9wabS0r1Zz/02hA4qT/It0t1MPn66bqw5KLRQRl+5RRfsPuhHhoNgeh8qw2OfgtCfD
 b9EQM6t0xeJjy58nb9/FSAg0e0LViR8Lr9LD3eIRV1LXt3o8zrmg20
X-Received: by 2002:a05:600c:4f11:b0:48a:76a3:2b9b with SMTP id
 5b1f17b1804b1-48a77b19bbcmr30859185e9.17.1777361807464; 
 Tue, 28 Apr 2026 00:36:47 -0700 (PDT)
Received: from localhost.localdomain ([37.162.207.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463fb7e609sm4075111f8f.32.2026.04.28.00.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:36:47 -0700 (PDT)
Message-ID: <69f0638f.5d0a0220.34f887.3ecc@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260423120309.18049-4-chrubis@suse.cz>
Date: Tue, 28 Apr 2026 07:36:44 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/8] syscalls: Add epoll_wait09
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
