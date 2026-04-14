Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA298F9D0DA
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 17:33:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A9943E5E11
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 19:33:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7B223CDC78
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 19:33:15 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6D53620009D
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 19:33:15 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-8cb3bae8d3eso507674185a.1
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 10:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776187994; x=1776792794; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h3hwDURvdQbOeDqTVRDjGMTmlxdanNJ1Neoatl3ghGg=;
 b=aT7R8bUE0BFMNA41gt0juFbMRu/AYi3/fPYg1fDHojkJkhE5Hx02iWWqjN3z/Ht89D
 XxG6jzwLM9aa40VbWQT9yNT0l6d/iTqGa0NqLS2iEPvvuviADsNE0YMcbUTc5Gb27JhB
 IkNufFdPSseCDOSKdNOevBDVXWtqjN/RxGJM8fKJK9yUg8zuT8ZvsIMYGgHErHYO6vP9
 qbtbZPGqpeDHs2OnIC+4Wsfk4aY31H2VCFyfkPJK7vwWl9uZNUi+Cmlwvu2vF7kOI+Oq
 FA3wAaB9F3qwjXXdeNQ6KrDCr87j+CkLVhntj50QVUP42TqYXhWqC9hHVr19kgzZ11p6
 B3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776187994; x=1776792794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h3hwDURvdQbOeDqTVRDjGMTmlxdanNJ1Neoatl3ghGg=;
 b=cHzyUU7tKEjVu+zO4WVMUqrbDPiw5o+WGj6tNTs05yDYIdvB54485yZniBvBYU2EEE
 ujMlohVmCrs3XJhnVOdOXEVe1cve2cL/Xr2YH2TMpq5ES34Sz/KUxhs1Jbljm+u6g/sB
 526BwaeqnoCtAd/LAMlqMcWSgCsqHC5bYHs0asMX9nKJ3eUyu0hRmgtFVYjPBUqXAjKu
 B6OmdTFEigJDizmXfOUin/1jyZcRgWXMrlsAQhUfrY//CGdkvdqx9Opqwg0SIBVNibia
 QcRFRb3OqkN8VEYwJP+JmXvzd0VV7kxo7vqelLKdUp35hvJt9NanYeg2JPfo3BQYEalc
 pilQ==
X-Gm-Message-State: AOJu0Yxw8RENkijDQJS+WOtIkR0eWyZiLZR16iBa3sm64m/4oPpqEy00
 BeF/LS4nh1BILKhvDVXCB/zGwg0ztk/4x3nfGsDjgPUSDnzQxbGo1gBY
X-Gm-Gg: AeBDietoOI9G8INueXQOQhMTwrl0mmgGbcf1VZ7tYLp0AlU9CBi5o+MsPo0bnrGfdjh
 +2+eMBUq/j3dCiZ6+0LNHB+0AmUMJrOCv1FjNcyNxIrzjGwJCc2vSjTcgPCKxvge7OF/GB+u65t
 NyCvkK1dXHsTmyMOVqS3+snb7CiITibRNaV0JM/ZkuwDqG5JHr8BhKiL6ghP9J1MqhaJIZeFP/f
 Nu6wJ6umZbzB5TM8wzG7p9ttVjTdWZhs8QpRlHGYa0uBW3WX8wNbUcfab4AkFuzFMrVZ2yJD1xk
 RrD6uSe9NE4+v9VpN+aBse6oa5ChI7bR8197Kmd8ul7njjgeFr0Eh5qBEzsAfOMKiV3evr3loGX
 lSrwzF5rI1UBygzST1KNM43CAWYqPfnA9XZrSZ3sSry9k0/VYDa5mAwycxbAWK0g+pTMuYzS6u4
 s+mhgaWAC5CD2InsKDqu0twsKBt9qOG+v85Gv0/99OcyDJ3FntnCCaKoDdNww/gY3t752Tw+fmJ
 /VI9LEACiJ1WQsQLHuHQIqRllwLQryzec0dew==
X-Received: by 2002:a05:620a:4155:b0:8cd:923a:87a0 with SMTP id
 af79cd13be357-8ddcd6fcfc0mr2767366285a.21.1776187993269; 
 Tue, 14 Apr 2026 10:33:13 -0700 (PDT)
Received: from
 runnervm35a4x.d25eko5qp01u1c5angi00huzxc.ex.internal.cloudapp.net
 ([135.232.208.146]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ddb934d8e9sm1165448385a.35.2026.04.14.10.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 10:33:12 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Tue, 14 Apr 2026 17:33:11 +0000
Message-ID: <20260414173311.3911-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414165117.843270-1-sbertram@redhat.com>
References: <20260414165117.843270-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] semctl: use IPC_PRIVATE to minimize interference.
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

Hi Stephen,

On Tue, 14 Apr 2026 12:51:14 -0400, Stephen Bertram wrote:
> semctl: use IPC_PRIVATE to minimize interference.

> This update solves previous issues when tests were
> run in parallel with multiple workers in tmt.

Since you describe this as fixing a bug, a Fixes: tag is expected. Please
add one pointing to the commit that introduced the named-key usage. If
that commit predates LTP's git history, mention it in the cover letter.

---
Note:

Our agent completed the review of the patch. The agent can sometimes
produce false positives although often its findings are genuine. If you
find issues with the review, please comment this email or ignore the
suggestions.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
