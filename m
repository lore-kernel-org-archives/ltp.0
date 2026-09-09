Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1E5C88E40
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 17:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788974646; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=vnIepxDRkKpMcQML747VOgA2Gd3pyIeggIZKuuz6L9w=;
 b=p15v4XxyWV42MbLU9kjtckStrWAY78Y9DSfhfoA0288lCYuyrHUArUphV5VNYts2T/GCK
 vupIqsDZsjiRzzGVotIo9fDg5dR6GohPl3Unx0PHi3NETyKHzDm201+ZaG2oI5xWlfRWuNh
 ztviqdiOq4Ch2ZjlAJs5w4D8BT4mx8k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB4913E93D3
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 19:24:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81FD83C064D
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 19:23:43 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1931514004E1
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 19:23:43 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49ccfbe062eso60170365e9.3
 for <ltp@lists.linux.it>; Wed, 09 Sep 2026 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788974622; x=1789579422; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=utvGAphZ5qVh3mS0tH8XCNnFSYU4fXOJE0WUNNd+8uE=;
 b=Io3XkjOD5Ik1tLx1JdNla1xK8IBi81pWHIWFG/oB1en6uXvGxO5lSiHLhL0e6mOn57
 X000YlCUaj6+lPNd5ayDaINRFox04128yC9xwPC1sylLps1/WYF3BXPEy7Z2DC3JsUwW
 uX0i7N9E3f51KYMbp81q2/tMi2vi02rZ4ADHglSCNvGdM5OUWK0ymJTiLq9AmY9wE/p2
 ujCG8cnjgbzsNynk5JTAF8jimeg8oIJ2lhRtRzY8YCjBkL0SmEFSjHd/Pg+0J975yr7g
 B0tRTR2Kv0kJZO0BAa8w66JhriwxvzecwvV/a93ddnE5hlGlLIsRjc43a+4PD617l+mT
 lQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788974622; x=1789579422;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=utvGAphZ5qVh3mS0tH8XCNnFSYU4fXOJE0WUNNd+8uE=;
 b=efBRRElMMleGIUHuaX8Ft6B5RBSWOwlvOymn2EC0OVR6RwmRbRYW7gOPIqts+30PTk
 t/gV9WdRtFMTxZaEU0LGJodVyzN0vnjTcj2YkxcWQiEslv5PpcRJOnhA39sSAlTmSYlZ
 3wxyEGfBx2QM4LSMzQL3JJrRhBLTvGQHqRGNcGLv8ohYsKuPVjYD8XJrUx0qV/xkAaLK
 yJ+iQFQUjDJkquG+K9BQR3wbtroa55XharYm3lZpWV6ldlQvuxcy+ax2a5WfWjZrN5BG
 zVaKyocA1dFP6LcKjPUbpTPMrFhgLY0NQrIph/2WkxTcQyYHw0evcuBKFXoLGQ+fPUI4
 JgGA==
X-Gm-Message-State: AFuF++nyzfLBRugGszNu2qwbIsySRk+lW0o7mAjLEXH1clA6uOV5CF0Z
 0LH0XTK1Q5cNlKwxLVPPEeANQStOpF3+KVHId+5sRxgNX2NHSr2oJSklyqZYq1AyMRc=
X-Gm-Gg: AYBFou06VpjdQGMWZaCa0bEREmjkQZqv6qYABmQwjU3rnmcamRSkYJKJKN9RKyDtB4/
 ucN+NVBIZx9cbOr4omgROwDw79Qdvro9uzJFEYCjZPMtZ2iak52Va8X0e2EAKN5AioXRPLIZhbd
 Q+NXYdxELkOUUA84xyYctaiVF3nLCZpHC+ahQGv1cc76JHwNO5H8CeiwxOqmpRrnz/UShznRu1C
 Yvv0LWXhyZPd2uc6VF83ql0EE7lLCgQn6RA4Rdke3T3jILwj9uFnpMTxjLnyY+hTMVryhOvlIJp
 flEq8LcrgkzBKn/cScQitv9AvhK1KhpSCAx1I4oIZXq7VC+2YwqXOsvkWHtfKiIflwlRz4iwRc9
 KTzP+XjT7O/tW+MEg97+ShEA9UC0z4pTlC0XRhDjFlxb8tw9DJy37n5ZOpPROA10lUBFIb41roh
 otLIJ4+92VoJhRLKtY5BIiwOpWFsSf4tz1OSICSo7V0lD3z3GiX9UeOgDpPodCcYsi+ENRpC1tj
 bdRD5fm+Dlgf/VQ9SL9Y8WlPc4/gl0vta47iQFx1MKp0JTy/RdrBAkM8vQ6zl75GPqwourmwSVs
 vZYpPg==
X-Received: by 2002:a05:600c:1d1c:b0:49d:91d:d192 with SMTP id
 5b1f17b1804b1-49d091dd358mr256108315e9.5.1788974622231; 
 Wed, 09 Sep 2026 10:23:42 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26bc08edsm3480835e9.3.2026.09.09.10.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 10:23:41 -0700 (PDT)
Message-ID: <6aa1961d.f007bc26.24ee53.1c5e@mx.google.com>
To: "Jan Polensky" <japo@linux.ibm.com>
In-Reply-To: <20260908165430.251897-1-japo@linux.ibm.com>
Date: Wed, 09 Sep 2026 17:23:41 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 0/3] Handle FORCE_PTRACE in thp04 and add
 ptrace coverage
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

Hi Jan,

the whole patchset is failing to compile. Can you please send a new
version?

https://github.com/linux-test-project/ltp/actions/runs/34259935546

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
