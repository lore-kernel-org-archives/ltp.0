Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017D6CD343B
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 15:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778082745; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=n6Ekgk8RnVgzw+5sxVHydmxlSgXnha6BdD7wg+CuDwX52AL/7quyNHUjyl3i+KGl0lS2c
 U5SPcC+Lco0OpUBWE/AlW++E33qBQi/WfpvkEp30KbfFVakjYGk8OSgIA8HF68xQvQ1Q8QB
 aPL0G/kfK6ciKud8nIArJqnHPDFqS/w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AAAF63E2C4D
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 17:52:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA7B53CBC10
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:52:02 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 843FC1000A16
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:52:02 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-44509921fbcso3423036f8f.3
 for <ltp@lists.linux.it>; Wed, 06 May 2026 08:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778082722; x=1778687522; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=IbJHa/Ao2j5egb1fpX1YPQu/iJBLT4HWrpZjHOSDZOdGOF7AIHZYaMt8JHot3Y0Z1C
 d1uI1xFAo5uRBiBDKbhm2HqOiDY/ZuHMH8+p/SAmCq4E3SEflwQcxTrgJzlum/bsCDJP
 oIlecI2Q9NfEM31q6tBl/zy1zEB/HeE8/xav13oqCk8GjhFDoslRjgbvqAUgGtCHPspu
 u++x+mMcwqWh64u0Cg+abc3RdOsYejCXusZ3vor3OO3qdvocaarYt0MYQ5X9iqGTkE8Z
 1ExaJT5qk/NEDz/49/W2G9wz9JxgWTcQ0LY/t1+XiJN7JcJUsX3UVugzQbnefZuwEvRI
 2s0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778082722; x=1778687522;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=K1qcNDqHf4WcOjGXJikqLSWuMDoMOKq0h1pd6n89PyNr57D0o5UEjVFWkRHiB8sSay
 63QJkuubxv3NApAAFZAfoQ6jlMGZuv0zI3YnsqAgFI/Tor2HvIuPqGsQxfDTuDq7u4e/
 lfi/fS42IAK5tPVV2wa73CRQXWXV2kHyHMeX34Jc8nTTtZDIEOagkQvdtfKPZRZcazVZ
 btEt6DdKB9/mlOyoj9Q7n6LrXOcGN43M/dfO9qCKCSxgCEeGBC/KkZOm3xqqdT4OTd2b
 eTi/caQ9NdqCJ6CXqAapHF7VtXqRvuK0PN8tBmRjSUaOm5LSgSLSaLkNPCvfCNq4d7pi
 m4Iw==
X-Gm-Message-State: AOJu0Ywt5I7h04HlxgCRi7076MBWrLqIzWm24Eq9/aLCh2s8vbeC2F4h
 VTtQhEKT9wTgPikqWjgnT0xKWX2covP4dLshJ+NyUhTEV5jo4ousXnehWWx9eecJ+e4=
X-Gm-Gg: AeBDiesZ5eR2I3VxmBADZSEbhU0MS4vaLVa2m5xyaibIroN4kI4uDxd2SZSnOJVz6Lf
 By+FTUcV+uYvCnUvrx4NxbgyOLoVnhFByAa9m5KvL+E4GDUHef5PXF8TctG3MVesbgEm5OL2spO
 4nD7fI1PbxX2CtysSkCeFHzhBV4w5EEf/FTSEurMQOg31wX81FVMqDbYmr4X12VXt8HZPtpAuQA
 1dPM/E2C20eaINJEMv364MUE49cbNs1IltbKWArNvHSkLqLBo9WJxn7iLbReu3VdyKtIxC5L95/
 k2JPxOq3KDSu708WPr0rYLLlcFxZImGKiuqHCEXPuzH0pjJXf58nBh+x/THZ8uDX/oy7u7ocuzJ
 R6j1mkZInvR/nTtslvB6juTldVz9C+XSdladzBPvisoZ4jTQXlvIJYx5fFABi/HrR62B2Zi/WH1
 KE16ygXXn74Ykuw66/bfBhydG7QVkW4rx5smT5Gs575sBOqZfjyN9BxPEzAsIOUzB0Huf8g0Uq+
 n4td2Id4pmzGnvcWg4K94FQ310g0ZAbzaRnDndAMlIaPw==
X-Received: by 2002:a5d:5f90:0:b0:43d:6787:9933 with SMTP id
 ffacd0b85a97d-4515b52450cmr7468896f8f.13.1778082721854; 
 Wed, 06 May 2026 08:52:01 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505558e213sm14267867f8f.25.2026.05.06.08.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:52:01 -0700 (PDT)
Message-ID: <69fb63a1.df0a0220.22cc2d.6165@mx.google.com>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <20260429101244.3309913-1-wakel@google.com>
Date: Wed, 06 May 2026 15:52:00 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/userfaultfd04: Require
 CONFIG_USERFAULTFD=y
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
Cc: rbranco@suse.com, Wake
 Liu <wakel@google.com>, camann@suse.com, ltp@lists.linux.it
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
