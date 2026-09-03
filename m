Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6352BC61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 13:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788440794; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=OLDVOUkU0zpf7K84Egr27r7ZA9+i/VdooJ1cZMWGZdUQS+DpH2rFrtWGOMcR5NEtUrd7n
 qmre7uJV7co/PtWLWg1bXAPlRuTnVDVtzRF5A9QzwLM9l3R2p/DMNAK01Nyjsfz1d2+P7z/
 79t/7gmzRaP2kw0Hyyo3KwEe0Np792A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D07C3E97F2
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 15:06:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C1D53CDED8
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:06:12 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E26A0600A89
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:06:11 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49cd77e0f95so23729255e9.3
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 06:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788440771; x=1789045571; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=WPI9wVw7tdUz3rEZihVOBnIyv4Gw3635ugZ+aiffGul9Cq2nwr4zeq78jBmTC5j+1A
 Yf2q3i0WhjnTzbRCfzMB33sjybG+cQ8bLm3XjggYGs9cMmvfpL7EpmRNTmolktyKy5IK
 0u8KXv1vaSPFteJu9yUL61Fa0YgsxJsmi9hzuvgt/fqQKBPquotuW5VF/+GoSGy0jsSO
 YovWcb6Or49qQkwvxqmOyOuhf8zILnmPZ3HHYWybqYD0BOXVvImNHximOGsQ8vTrUH9J
 Nz/zRimNuJ+2woYCbXEfB70u/s3VL9IjvpGr9kX2l7DX3pASNyWt33UZa9oakWm/Dkg5
 c66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788440771; x=1789045571;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=WOqKN7pqlwTxrniIaS5hWw0NkqgIDm6j81ho9EDpCOnovrVgNx/Z15A2fzYqPTAibd
 ihZtH1qPa9WUHJl3si3iejNH5cufaudDEOGib/VW/LV0T9lJbJIHIg8ZLs2Yvplyalpx
 rv1Pe93cboqekBngNx6ONBEhmxWrxUVuHQvnHCIIpJjeKJdTLb2bC11OJSlql8s7B+V1
 jF7Q4c7XYv9i8X8Yk9VMrbuj4UkdfnnBQA9V6SNEg6UJ3o+N1RYQ52FSpngfx4Aj6fQ4
 cTmGmDvhIgUPOCgU6OtAofEpAGLgekRh7F5DURskNfT8cKxkPy1UboYYW7kM3B0q8j4d
 WKiA==
X-Gm-Message-State: AFuF++ksJLr6GRTL86jWHN13af+AqUrnJj3WrPDYLDZUEdrgjobzgKiV
 W3bm8psdfg2cZLx1z0qhU6NTNMW1MfJ4Ti7zH3Qk8rKuqu2kf6FEXDsvKnhop1vRNguKFsY5AZm
 4/LmlTsZjrw==
X-Gm-Gg: AYBFou0PyaoeoKeGehN50lx7NZTw2YxC4RrjQRXTWzHtYgZc4XSzXfyz9cjc40AZQjZ
 lxz3D/q7ez+LFxgLP0K0poAJF8oczc4mVvcYz4YUiAck/0An6W5zBhnvX0ZT9FS4M+pSSYXYsk6
 dwwyLM+IpM9tJIULxBMIJGChEsjWg8VBof0r6TtH9L+ihSjvDRqxzu0Uu5PEJOwpQpDJZPresOi
 gjxjo+XDYJGpCzp4oK8/sKmHRerCmQ8n3ORpO4XbvyxyOoAZjDZhF8/VADugxuLiHPw0Ml6qpnu
 c6EIz/Wa9nD0aAe/ymKGtR1iKIoYQ94MuAq3NOON70qoSygiRQILj5OwzTBZRXxyxRnj5PA08zn
 0VR/vYlOx/oxoYc0kVDJ5fkQrUanmmHLupaQCfeGSpq3ZXTJ2ZtRLAYsojms5HQmloe0+qR5BwL
 ksjJK/tr6zpaFTRbtSEdpljwDZWoDDd2f4CqKXG98YHAEwppggxpr4loVlDOhdzLMuf3In0TIJL
 WuZw2wYHbbg
X-Received: by 2002:a05:600c:4f0b:b0:493:bd2a:93be with SMTP id
 5b1f17b1804b1-49ce581316dmr183454295e9.6.1788440771346; 
 Thu, 03 Sep 2026 06:06:11 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee6023edsm68395395e9.7.2026.09.03.06.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:06:10 -0700 (PDT)
Message-ID: <6a9970c2.a9b7157b.33e135.c4fc@mx.google.com>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <20260902134019.163296-1-avinesh.kumar@suse.com>
Date: Thu, 03 Sep 2026 13:06:09 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/ioctl03: add IFF_BACKPRESSURE flag
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
