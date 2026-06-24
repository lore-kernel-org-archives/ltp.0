Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E56CDB479
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 10:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782297552; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=c86x2rfkKY65kZRR+qL6da4TjautPzhpiWf/LL9c9ktuIGDH6vWwpTw3Wx/aRDsyRkUjU
 YJNCEiIBASbV4kSX96UHtcr8HPgrHE0RLF2LmZlGm4FIoIlhMs/BQwrWlphaC/erjp3amQv
 NsGezoGuoqRWBfAIIvkH2jcgwzvhrTk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4AA83E6237
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 12:39:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7EAF3E1AAC
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 12:38:54 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B8ECB1A003D9
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 12:38:53 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49249072f03so4983515e9.0
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 03:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782297533; x=1782902333; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=XsEQhaNNn/JEu1V5Gd0cl0shq5T9+ifz7oeyuoiSpPgFh+VQgwLE/igTHGxzH67c+B
 jnX0akfjvylprBfSOHjb5v3F90z2dsVR3yt67LaRF+i4r5H2bG42LqJV0bF/VwmzeiZZ
 oJkCTrdN+IFa+9c+MdOWvRX+bqYcJOvUj9IXR87eQZBv9cKkE3gFLVv1vjPe1TRvfeqP
 Mt3XlEc9Rq+N5uu9puS+6xH/u8+86Qkex5Y+3gxFTCVD5XaIjWFTUlmHooyMq//iAaGv
 5zU42oo8oPzHe4gNgWXQt9qmFUmAdZyOf1exuOOOI3BKLtQ7BF8hWnlSF4wWhZTMuFNR
 +jUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782297533; x=1782902333;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=aNMXTjh9VcUI8KOSiTpIupLplKj/aRCD0kC8qbA+fOv/Eoiatac2hvtuqSC92n8gIl
 gJwoKYRGUd5hGEwrVVLnS9/JqVNID7bpVK/cFYdMdsk6vO0v3R7DbVj7QZHKxamTIK1f
 uxYA7Ry0epcT4NklQWGzHyR+QzyZJxJBya92qW6XC/BMlAbNtiwNEV0DEoLtQkh6LLrl
 2wWsYKOOfo0TT1yiQF4M2K51Cot+d81sAkw0djye/qU5uqYn0D2dPwVLbaYLHi41L4sm
 pj8xOR638eSLCUigUYd0JCoiCyYqsu4oIP6y1HrDCvvl5SzXKcP6CtR/3NK0oMn5WScL
 rbQw==
X-Gm-Message-State: AOJu0YzG/deUr1VDXbmRNY6nHHHWoWnPI6ehVKsXzBUebYOmzMtupX0n
 GYveVft9HgCBCgtx6wLJ8Zv0nhVmzaklzx9haJdbXhyognQRcqeR9gXo2fsr8j9Q0X4OYuJvYKV
 IoVHbF9A1zw==
X-Gm-Gg: AfdE7clnT8X8PI0brpilQmXSCzMLP+hMrQE8vI/A3YF6xbNnzftGIrKXsl55pWGkSgt
 77X2nTsW4Zt6QC5cdV9YwkHk4y9Jq7Q8WZpXA5k4hTMSxq+pqTZoaGn828wwAytLGiknPhzovFN
 ijkQ7pIOw2c6IrQGsVtFXsm1yyJR3p8PF1dBUpeE/6ng9OnJfW76KKuVIb0nsGcwW+OSXQudzuW
 8dI0JdELzT37aJWIYLU0idwLv3fxxuOcpMfUCNwDnEdk5/9qjxW0sn5hj9JaQKHDj/WxYQpA47o
 /iOG5AFjiACzU6Qc8nM947d0onEGCBD8z0sx9atEfKnqyfUC/qFeIGFXrSVNiJS8FOKgQ3Xcd2q
 uzCckVIy2/zQE+t6xcu1Ocofhsy2qUUHIhZaGvqV+2U88DJSmD3l5pFOexwD+Bh2QfA44VnK0YI
 X/j32TVTlKpJAKIeiIORR/Rl7VshZM7R+wRl6ZoCLE8ll/7YO7c0c4YcIdjmzgiGGo2A/EHoLum
 QMoQqQdPvOmvVvr6Z08vHup6EsssW66eToY/bzrAX71xbGQKOrkrllHulGz/0QoYzg=
X-Received: by 2002:a05:600c:8506:b0:490:b724:5085 with SMTP id
 5b1f17b1804b1-4926087f25amr36376065e9.33.1782297533134; 
 Wed, 24 Jun 2026 03:38:53 -0700 (PDT)
Received: from p200300ef2f13eb007ed17b715703ca11.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee01c6csm5984140f8f.14.2026.06.24.03.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 03:38:52 -0700 (PDT)
Message-ID: <6a3bb3bc.283787d8.200e76.4105@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260624091900.4107041-4-chrubis@suse.cz>
Date: Wed, 24 Jun 2026 10:38:52 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 03/13] keyctl01.sh: Remove the keyctl subcommand
 check
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
