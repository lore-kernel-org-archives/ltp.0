Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B826AC43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 11:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783941158; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=o0wfyM4wX1CgGu1aRZfQGO4L3opoeC5noS25gu01Fz3lof/qTEk8Mbkq60s/g3Xn7yiE+
 UdHnMDyI79j/0TG6xGEgStpwEFH2Zc2ELU6asVyzb+6UHgsaZ4wOky0mpmVNSaDymxZ2cej
 exUgUpHhyWz6Ce+ZqIoLNpC3o9YgKCc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA6323E735A
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 13:12:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 766203E5C15
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:12:14 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2011C2005D0
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:12:14 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493e8d4f4dcso23764395e9.0
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 04:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783941133; x=1784545933; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=JgAr+KvXRwWyJmTZ1+KEQCh7AyaT3TYdXDpCuHHgtKQTrDpd9Ewvd4HQDZ01Pxpcji
 1ESFHpMSc+cyeTxy/llR6lGOnmoEc2frE1KTKW9anxB/BPALGbnZmMPDZfxA5FT+6RLZ
 7Gb9cz14wFCyQcDzUWrSQmtxXjXtuwHlIqU3NTDk5zs+BYry31eJsd/3obDLepkEZLNu
 XGr+LjMdQEAWNbM2YVg/+G9k2/AtOdrzMt9HBnK4EUwLR/neswSmj2lxPO5OPbnezGDP
 AxG3w5QwKFKvf6mscl9r7i7hODLLtbBnK0nIMegEI1wlZt7qtXa3/Vl1xb87Kxz9S/52
 4qHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783941133; x=1784545933;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=n/ej8wAPaNoLyuDklaoCCczPMpmMSFfWRBj56BXptgKJLeO82rsLPGCvZzXJYVys7+
 8iMXOFR+g7pxHD81HFYPUeuF7tJGXkR0yZQrB20/BBj7JqcZpPcNrnh9+1GC4VFaHRRh
 YaMNMoQmsHkbR06Nho/cyA/+DK0jPiylQak8xiU/b71JoBrKYEKEpMS7vCIhpeyMbuIe
 +WK/p3PCpsg6pJpSqRlKj4O4Lpe3jDvFSxJX7nW0Sb2NV2gIhn1YB34OWdqXVWF58qbx
 +PocKJPwtlJdCTKp6bK4M+YU1M/vGQgq29Ig7elxXjSdvdy6JWEv0EM+3cqM1AsxAf20
 XDcQ==
X-Gm-Message-State: AOJu0Yxt82LJaZgjGvCG3ilHBt9/csbHkL2mZIC3XY+px+9oY4XRu3H1
 d6qWHvwnHkAsD8v6iz28NrlIUC+oxd8Pwu1fUbpuFX5052qUg1QaiLkQ1jvN/Z9Jq6VnC4gnxJ8
 e8UluEyveog==
X-Gm-Gg: AfdE7ckhBzUVi7qCrO4piRqAdfUJ1dfXaaA+FKcBL7+SGsBVK8UuY7Awpe4qFeyDne8
 ewXRQsyPfurVNElkbfdNKwRjcIeZsCqSObZTvBCTOd0xq6qLYDqATo6vluj3GKlN1fs1oRsdz/R
 0CAzSnpedhEYyG4CEplL6/DMQzacl2RyP/PtTA0ewm7r+8AC3ws/1Du82Hhr0WyjLnkeIJ4ObGS
 0OXze2M8h8Z7j57be0/V5prSIjNfdmrgOUK0xFsnmniQCrncmYmeVSSacGDE5FgzVnD4hxKm/S8
 LTxhzgDmrZB0jyv+xdpfvL1hTCtQ5ep21DmXxdK29Q5PkbQMR93JUCggQmIoP38Qt447LxM5n3C
 XxaL8G6TiWxGbpJ0lu7ATYVwuMcIyQwggqzpUnNvh4YksGs5uw8LNz4WKzau9fkQ4AFzpuwyfft
 4d5g4mbZbIodJcLYtDf+qXnBwRONNeKWbcH9ZtVELfPag=
X-Received: by 2002:a05:600c:45d4:b0:493:a966:d5b5 with SMTP id
 5b1f17b1804b1-493f87dc5d3mr86954235e9.2.1783941133442; 
 Mon, 13 Jul 2026 04:12:13 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f3c42sm349783685e9.1.2026.07.13.04.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 04:12:13 -0700 (PDT)
Message-ID: <6a54c80d.029fe3b5.39a82d.837b@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260710055556.1109220-9-pvorel@suse.cz>
Date: Mon, 13 Jul 2026 11:12:12 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 8/8] ci: Test metadata in docker build testing
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
