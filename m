Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07C01061B37
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 12:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774960163; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=W+x7omX46WOkgX9XmL9e8qaatcItOMFBVgxttQO9bT4=;
 b=IPZUzmZiU4J2ztmK2XyQ5aj9fSHdkYdZxDl4XYeoVtl46Rgj+BVqx+A9mnQipmtlDYJxa
 5AmNt9AxNA3TRXhmKzwvlz70H+WcvTTQ/wkewgSxAfmDuGG9jyiDZE85OBSMKOgEKCR7FH+
 zBHjphMK4euJvC8vuLPtjBMRrHwS2VE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 893183C054A
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 14:29:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05F583C0372
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 14:28:59 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7E0F76010E0
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 14:28:59 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43cfac48bc7so1438853f8f.0
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 05:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774960139; x=1775564939; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=urPbJ679GWuvUDedoUOM3oZXsrlcVzJrDXMXVmszBf4=;
 b=Ak0oIBzWhqS+EWe0Fx0Ve9IBouuYeHxDJ6vD+83SGbE2Thffz8FhjVAopOu25ceUxR
 V8Kya2rdG0cY/IO7zPBb9ZXykWQP9CFg6mOptpnc81NaSISzn0xl2JHLPE7dgUoTdZXe
 czw+DwSOzYQCF5RHp32kp778LmUt56eAomSE3HY+X08Ed5f1+X74DJErH/KBh0r7x/UD
 ikB7DRU6q0B7Uii/tvf0e/nhpV4DiNQ1uQ+8LQi+BtzOuNHE9tug7SpYgWL7+kstn0Zv
 3LsteGibDiJ1QIOa6bdUgZfX3XBHDWmhyr3vjOu9pjVVOHS68mkA72fqNkh9PDwh+5zS
 X9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774960139; x=1775564939;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=urPbJ679GWuvUDedoUOM3oZXsrlcVzJrDXMXVmszBf4=;
 b=AZK2pboCOyXmSfE5Q1EGHMG9gI2xe6RwjLIOsws+vF7Dm3FhncBmDvuqUy20CdzQaD
 2S9dA4XO9xzB0a07g88P0D+uL5l93thw0GcIjngsqhxo0PXGWPMOKbYidaj4wPEsT452
 GKxL+m8fBZy9CUHVMI0knUFy+acYCvgLHLzKl+bCjpmTFbBnrDRO9E47flHrx8XLZVy3
 9RYp3wbusoR79Gz5ivz+HYcxajOBsMLATxYuQZV4mE7PxzGRXmmUh7NzbdkKabguGyfA
 XTtGG9EhMvq23D3X+zrRij6HuRynuv4d/OidN5LdIuT6X0Dw/UvLaN1QWH5hgvBYenJn
 ZjwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4K7hrYX4Ia8nMlAA9sGX18uM9nkgoEGE9siXgUBaQJLjX77FeEGEYV7o4Ta9UFncoqVQ=@lists.linux.it
X-Gm-Message-State: AOJu0YzbjfNGf700zErUhqEwKe51Iq5ZTknTEudMgAwQ6H7bZioPALS/
 a+8ojd7fqM5QpBVrr9ph5+Z6NUxmmbn9KM6RkW2baSf+Lwlroc6JvWEqMQ6E71DoFyI=
X-Gm-Gg: ATEYQzzG9EL0qopKGO7ATdCPe7DAw2M/NjhbbtnUlObo7upv53KFCtEfQgUfJzRZEE8
 05BdNLjBHXLEnJfVAQVwYuihLFCTL3Yj6ws0qmc1eNJHJdkw+5+IoZdhpCK4lXgGHkQEZePCBjz
 Sj2tyPAKlQ4QJRFscEPcuu2py/AxSmSr0UeFJo5Ed9aiqPmRN6QGAk8iN70clfHyTuyjQhf+QCy
 UHN6UrT+9QkstGlPP2XtH/P9ctB9zkl4HADVSa90sHthzQ5H+nSPSLTcXwUIgkyEwe8Eyuq9bUh
 iKa4g+7FQkrxgaQHdpRImtwwbwh151h421Rebsbvszoq4F42haLhaMNDXcDH36PyKsoXxAUAP4J
 eA/V1GQKChT79oYIkgyZ6ZzleObromnb7L5lrIzaH6xE/gbfnUcDR3FaFHmlFNctmw4iXXp/zx2
 aJb2tQd41HO020d3Fz2wbiqirF90kIUH36fAVJxldYtHcwp6cF1oR/+c5o3YfZzhdhtkvw9UzEW
 TMBcsjT9JvbAPpF15HbrjdkgEDwFx6nkgn4/l1GBWpwqsXYfJseEISvftKlpmzkF0FFTSXgmzc=
X-Received: by 2002:a05:6000:18a9:b0:43d:29a:e42a with SMTP id
 ffacd0b85a97d-43d029ae49bmr10620941f8f.29.1774960138827; 
 Tue, 31 Mar 2026 05:28:58 -0700 (PDT)
Received: from p200300ff0f0853018c5be4aef36ba14f.dip0.t-ipconnect.de
 (p200300ff0f08530146115d0b2dc6d03f.dip0.t-ipconnect.de.
 [2003:ff:f08:5301:4611:5d0b:2dc6:d03f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf2580168sm27545907f8f.36.2026.03.31.05.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 05:28:58 -0700 (PDT)
Message-ID: <69cbbe0a.df0a0220.9a4c5.f9b2@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <acu8uWUcHi-ecXLv@yuki.lan>
Date: Tue, 31 Mar 2026 12:28:57 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nanosleep: Use CLOCK_MONOTONIC for elapsed time
 measurement
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Maybe we can can print a hint that we are falling back to CLOCK_REALTIME
> in case that CLOCK_MONOTNIC is not there and proceed with the test.

Ok, I will also gate the CLOCK_MONOTONIC part in the patch for
clock_settime since it's having the same issue.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
