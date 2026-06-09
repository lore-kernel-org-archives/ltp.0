Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8406CD8CA4
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 12:39:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 202A13E6EFB
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 14:39:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAB333C1C1F
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 14:39:08 +0200 (CEST)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 104151A000A2
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 14:39:08 +0200 (CEST)
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-5177945a22eso37314241cf.1
 for <ltp@lists.linux.it>; Tue, 09 Jun 2026 05:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781008747; x=1781613547; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=weRod0WgKOEzpQ10BFL4Azd6CsYbib7gVcYl6bXmDD8=;
 b=VLalZl7U5+50OqIpv8wkconHjLXrLyjouhn14FMmOOF602Hjtaxjcg8veV9IkHsbqy
 ICGRBmaFiNehBnCmntEWeUKULp3Ls1V4O6vaoEGL9pcDAFhsjCKnHLujOW0KmAG+HfaD
 +wwD6SDxQryNqhXkNTQ+cKX27l2DjbbCR5dnJSmTzgXUffBxgufeNwoQwux7uhH59BuO
 Ggk8M4NAlmUqIKpFyX+oIfEJtYa7fAAtUpCO9nJPjMu3pkPNJ0pQV/25aNYUpzbEUs19
 /r481XsDIBbYqPWzUsM9qHMcydEmitWfzPqmv3d53eQkmB977gxakzP1JEHBIX6erB20
 voSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781008747; x=1781613547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=weRod0WgKOEzpQ10BFL4Azd6CsYbib7gVcYl6bXmDD8=;
 b=lO5iXSP+B+Jsgf7+XlSswxKx5VT+0l9X1d32SgEQ9qgNy0ilmojYrIBNzcozDkjK2/
 Vm2wVOv4gcgUs0vLjF6xCbxVQHjJ27ZVIp6N3X855PmxKfwWLBF70rsJG6rduxaGSfOU
 QA+M4+3MYeB6UlcwnirUNzo4xg9cVQGG4gtOKcjtho9lTnV7HMote1//BvqobfxQuZJm
 KYGXO9iR2zveKJ/ANo1QXC34PaaezmRkUpLuaQaCvUG3l40TCkagtswAHDzMFCmE59l3
 G/VyQrFp9jjAWygtUzdOMElhN1ITtYmIkLz8FOqkW42ONA3E5wFMF2gf1egqP9mINv0c
 VAHw==
X-Gm-Message-State: AOJu0YxG6rLuKZtibhLaYKLYpLYHrj+93aCKOpMNsYOTqTmfZVZE5NK/
 BAuhAmHnN81T8Uj9q/U5hIb4g6cECXx43fiXxZ+ALNYHaBB0qUGTcbtf
X-Gm-Gg: Acq92OEzWyVVgRUhXpwH7d6iOZeD6GvuJ+eq2K1L6U3aw8F2ccAE+fmyEphF9yoHyuq
 t7DrbeFCuiYDTpG5igNyS7eSTMFm5FYsj+BKfvUfJag/Z8fQbs9Ud5Xr9zym/0c0Ljps76oubE9
 usQsz36W8Ja0Y3nI+xJYxtCdU/0AQrcFxZGKq2j4px5hdoVrap6HeLb4Rq2CwU4abpfxRAX8rJ6
 VpaKnBODKlh7xC+QYigcY7vqxgfc6OuyoeorcS8xhGg7pPsGyuN3QCq7AZZfVzIGhSKVHQfCvy2
 vpI3cHcUkWEyVpD0ATzE2ydbJGqq/XBn2tNPPtlUC1tKmyHfAeUyvA77v5bShcWuqvazl1wj0PY
 8oowtBtdwCxsG/bD+oRbrIDpgmwpEKSTcB8iuWO8g8wMMDeUPjEflDIHZrra6FLdbfnyYVJjgFd
 BMUDPxB85oLKbbnPWD0WIxeyMj2/imOXOtsS69tIaY7FhX9o5sYravmCgypvCMmAvfZEA++gJ9p
 jAhwJtBwK2a3UKzBNwVY0qx3dQ42gi2zNbwYpvK3RMzEPR0Zw==
X-Received: by 2002:ac8:4815:0:b0:50e:62ba:3ff7 with SMTP id
 d75a77b69052e-51796953383mr195018121cf.26.1781008746588; 
 Tue, 09 Jun 2026 05:39:06 -0700 (PDT)
Received: from
 runnervm3jyl0.2t524bbebovutlbh3yi03vovrh.bx.internal.cloudapp.net
 ([4.246.135.164]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775c2e2casm184121851cf.9.2026.06.09.05.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 05:39:06 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue,  9 Jun 2026 12:39:05 +0000
Message-ID: <20260609123905.3947-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609-clone10_remove_checkpoint_leftover-v1-1-a2a99f71ba9f@suse.com>
References: <20260609-clone10_remove_checkpoint_leftover-v1-1-a2a99f71ba9f@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] clone10: remove needs_checkpoints leftover
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

On Tue, 9 Jun 2026 11:57:31 +0200, Andrea Cervesato wrote:
> clone10: remove needs_checkpoints leftover

Verdict: Reviewed

Pre-existing issues (not introduced by this patch):

The doc comment at the top of clone10.c has a typo on line 9:
"writtes" should be "writes". The same sentence also reads
"to a thread local variables" which should be
"to thread-local variables".

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
