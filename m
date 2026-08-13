Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15830C5B572
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 06:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786602588; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=J3Vqi3zJcXwA2vTAIV6r30CH4QDfL8hXKn+c+l21rGuM0KDh3lw3DwHf8T0nuz7T8R0KR
 I7E1Be5pDqsibApJldORFrQ6H913TBbKjAc+R9xCm92xYpDTrEHUlBikSKlLyicyIWGFDdA
 fER9sC1dE1y1KV4dskTZDvU0hH15FWQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1961E3E24FC
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 08:29:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE1E23D8D59
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:29:27 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 40EC31A007EA
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:29:27 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-495590dde14so20894305e9.0
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 23:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786602567; x=1787207367; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=c/nCv0/EuYq3THTWz2TMiCAhTQNEJMFf/MNTcu4Gtgp+4EgzG3ZnuIg9oua8KCaCaW
 IlEzZvRx5zr4OhOtySK7kemIgiJfPiQRUhoSbg2zT8eTRKJ2g5m7yFmzFZ7Ya0zfPWoL
 uN56IWmpd4FbfdhN0DZb9KE9Y90vevUrLnVBu46mYkw4UDEpaJf9vg+dSaGYQ10TeL58
 oR8Qf6uM28ay+k/mhKVKcQ0U1BPCG2zSVV1UXef89Z0tx49E8bHD2tUt+Ka0PbHb6Jv1
 eptS9WNYtC7/JyIRK6vYuSTn2GAXTNWvUbrfiKlF8+li8n8eJ6AXrsubBrNgKd9b+15x
 t6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786602567; x=1787207367;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=XnHxFY/mlH+5HhAVGX7eYXtftIq8NuzZuSBmSBlWLE9bNnTeW8xLvMFkSvCt+09K3y
 fz4D1kZws1I36q37rrVwv54rxhNoLt8iHVeee41veyJhGpNrVzcU5m2ENh/D9aIKL6Cr
 dQ/aUNQcSV46llzYVb792sGZqYKY0WKBMzO9GpbyRUyc1lNovvGDZoaUGv4tv8zbSUI8
 6acJsZukh0n7mHMqkcS619mCvKt2+9wUpJfPLUXxEMCB5XF9Ng1SvEQcYpis3uxdYXc1
 f8BGh1T7ZB6Bj/4rov/TsAxEPPbhUblU+dt2uCAEHcRRa/FYnVtCuNgmr4xINo37y3ha
 PujA==
X-Gm-Message-State: AOJu0YziFr7Eb15rCLL7l6/aZlZMF2d/DfStytAPeCObDL1bnKQsmT+X
 fpBULxhKjdjw4mdjZkvGYOcdrf4iVQmOlNvhgs57xOs6ARs2mA12ftFvWRTGt6ZZFBRClHsmuDS
 SqoO8Dos=
X-Gm-Gg: AR+sD11XP+RPincWr7MwA2TBuGOWHzTw4bXPSrivyxkPzWZOeUQVvady4G9397bgepp
 KXqild2YDbyQsOIB3fkS52/MelnuVyQ8bs7C1oVLkkkpsLqPEueOuRF5uWLHmxNKejm0q0R4vNw
 g0tD8CAHDT26A3V3mjcYBMAjg/Ajt0vyuKg8qMAxQ+/cKOoAt7jUH1nxrgFP0IUITZYA2j65JB6
 cEPvzEyc8jWI+Zf3BA1Tm3mEmOxEcpwEjq7WDP3aKAeSHTnScKn0/DIa5bqe5OEW+M8CEMBv7mZ
 bAbZQvn+aFW0wJHV5pPj2aTeUh2si559DGIVtMNitMi0HZwiflEK94wnMOvRTn3xpuX74C+ZLE9
 GyPHgVj5rDbDeiZoNZD80hW0FjkprYljlgPW1E5WelyDK22MT+M2twEJ8BpXxyYKlLyyPtrDfvE
 MyUp9/lIwYerKr0ndm+7jwsDzCN2olv5DOdRj+1zI7MjpywHgjRpy0zxgdr16+8QzONF9i6qM=
X-Received: by 2002:a05:600c:6995:b0:494:596e:e8c4 with SMTP id
 5b1f17b1804b1-499821bdcadmr37694075e9.17.1786602566612; 
 Wed, 12 Aug 2026 23:29:26 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981e2e266sm30569715e9.2.2026.08.12.23.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 23:29:26 -0700 (PDT)
Message-ID: <6a7d6446.73de60af.39e9b8.0c49@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <20260812152300.64499-1-mdoucha@suse.cz>
Date: Thu, 13 Aug 2026 06:29:25 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] refluxfs: Check kernel reflink support before
 mount
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
