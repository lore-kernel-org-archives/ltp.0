Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C35ECD6E57
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 16:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780416645; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=UKy45/yvQbBGc2xEEe/20lLJZgsVuGtF1m5ECwBPBAQ1y7ic1XXCH7tQavQyF8wnZKH6e
 8JN9tPRAYKbORgPgT0cdBskXNl+R08vtI3rygBr+arD/FZrlVrHnjot4lF1TCvt3ocnRxPa
 sdHQGec7F7yEMax9F4RVwl0+BKYvIgU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DAF3A3E7225
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 18:10:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39CC73E722A
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 18:10:08 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C9BAA6005CC
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 18:10:07 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso17598595e9.1
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 09:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780416607; x=1781021407; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Spthea5WMfwGfzQqpTXeuK13RYvTAJpF0LZDB8b5y+w+c1/hiMpTZ82OlSj5ftZvq4
 tJLwUGZsQ+ASAQo/ZwzMlQG01JTfY8tQdWD0L9enDkytbz//xLJH2Qfp9tODV0S1wIvH
 4hbG7OKx1y9fz3tdLts1GGiRgKWWaoWsZJ6I/hhC1yIXZxaVYQNtx+Cyd3G8/P6xux3P
 m0XWapdQt0hPbljWdEt1kfl3jYovdAFb4SKF6fvYn6H9ITtCLXxDpwXHRnrEstkX7DGh
 emYLIpF9aF4sXniKTy2KV77nsZnskj6RYW6O1DM/yNbwD8L9NLWLnMvQACNT7EdscuHM
 gtkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780416607; x=1781021407;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=rq+YfalJQ6L4IITQEBp2HYHJ+McIHLUK8l2QDP+XgqagVzOl13QcVQ1ZpkDakG4ika
 wqPO/FwMo8cx2BrALmKvOFzJtfkCuqfhGudOlu1335jcZbMotzySisJ0CtmvVD2XAfQh
 Q57ujL7jl6hWJoZHRPofPhdLveYh6y1mZCNZwL85KvGIJx7iCRWjko0tYQqiaMYUGDmI
 tFXXo0ekEtKf6cho9JyqurKCxhjmQZ2mPEUF0LwXrhRE6Xz4cAqDpIJ8xSk2U5sJJGmE
 XHSs96y4fY+56lZq0ctkKvj7PLtj5yENZpDJb2l5/3C4rCWb4vKy/frl9XTVKBi4njol
 b/9A==
X-Gm-Message-State: AOJu0YwKIzM5ReVhP3ijTYUU5tMVT9WAM7zsZMMVM7x/MtwNPlT8amIi
 9wGKO3W/L1HsQhNIkhX1LvXO6ue/jH+PYgtUzIlBcUHQ2np7sGYGNf1xOPRlycS9FBg=
X-Gm-Gg: Acq92OE37oCK2pPMKEolGLYionkYHOgnHPMFsIWBZXAcJnIIk/lB2pRs7jBeCYAXXx6
 hTcqAzE5cDVEqc3WBuF5A/9bjFHSSHJHElLaCMemn/6FtzBKTLrcqtYf5su0Wg5h1t+To0szRgU
 LiLG8XJkph2KucE3/X/LbLHWP/VsYQJbZj9s4lmzFJFwyo7qzm6MwSm8JoDmkGHhCuqTryCYaka
 PHEuIfVRWnGHBLT01Y6roq/NYn+bBOQARx/8TACxFLjxLeFOcU0DvhpExVf8l7r0FfHr9gFFlYP
 CuzwssyuYd9jpsH3++B5Z3Ag5MnGZdXsH0Ots95fYRW9V7KTzEZ4uVDxBDhJf2P+iV3/zAGBVnd
 jM7uoXC0mFBBeyRX08piwT7OmhYrzgnqfDVuyROt6advX5krYwGg6uT2dsz3Y7HuNOxKBd+791S
 9h31xGR04npoaqpir5eKsEwn71xIz64iFKQd7ZoZFKZ/mT2w2YpT0XI5dJB7RWLUMCfcsbfFeo0
 Zk3AFgMr2Y=
X-Received: by 2002:a05:600c:3b03:b0:490:6e12:542d with SMTP id
 5b1f17b1804b1-490b508e760mr5911995e9.19.1780416607071; 
 Tue, 02 Jun 2026 09:10:07 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b0da5ae2sm71471195e9.0.2026.06.02.09.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 09:10:06 -0700 (PDT)
Message-ID: <6a1f005e.174f5ea2.79df6.83b5@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260524161706.3510-2-always.starving0@gmail.com>
Date: Tue, 02 Jun 2026 16:10:06 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] getpid02: Remove unused header and fix
 minor style issue
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
