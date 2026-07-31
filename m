Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A831AC5516D
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 14:28:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1ED653E71D9
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 16:28:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E85D3CADA7
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 16:28:15 +0200 (CEST)
Received: from mail-qk2-x09.google.com (mail-qk2-x09.google.com
 [IPv6:2607:f8b0:4864:34::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 162E51000A13
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 16:28:15 +0200 (CEST)
Received: by mail-qk2-x09.google.com with SMTP id
 d75a77b69052e-5281c4c55e6so364081cf.1
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 07:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785508094; x=1786112894; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/5C87WrOsTs+JlKsw1CvqdZrr0k0of286SGbzoja/s0=;
 b=TLzjN9cZ283R2lahMc1DFTbfdN7rNJh8/AOejeKM7u4pgeB25llBzfOrD7lrxQgT/J
 J4E37Sa/XpSlYpTYSwBRtflDr3RKRm1utamO6Au6JfcNrM64D9h/4KRnn7cO7rAVviKW
 5vLbLpa12TGuvv89JcTV9OYQnRFA86g0E/+SSK52YMgtU8y8Cn+RWc/eAbLntZwYAiB/
 v9/6KqDfpF65VrSRGRxyX9U/Zz3hEdFbAbUbl4+sJoUGmysU1n2OWpCxm+Mev5nhq4Zo
 6xix2ppYKhMd8aVX6kL7G1lnsH/M8V2+LjpCvc2DFmRqWgL+BdOlgr5K52qFy8RjXXa5
 zkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785508094; x=1786112894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/5C87WrOsTs+JlKsw1CvqdZrr0k0of286SGbzoja/s0=;
 b=HXNt3zqZqrZisFBJu6IzHiJ7iLF8vjJnJR7+ZYWVaC25AwRCohjdYdP37eRVzt//Hv
 qCHgbVohiNnbcbREvaK7I9sTuQEvOaFhswuet/HrVIwAwNgA4GwMgfwRsOc6ShlkAS0/
 wW3T84IHfm9oAtkCIiuc2CwbIkf42YIw+bnM1JWpa/YGHuFmp3jDjcidZTN2qa0H1F/d
 kEZVAPI684eRlCZCdHMhzg9ZwaWO7bciNWTBJNco/80koKpHVRvCS04qN16/ze1nd9Vn
 SCOuJWejrtX60OXrf+n97LzBVaHyB8DtYFCBuIEfVIv8DNyDtVLQFSpoZgWXe6exE3GA
 BVpw==
X-Gm-Message-State: AOJu0Yxdxy1rzxBNr/uKB1IVyWH3+zpJyYES28SMPsztnuRetpR3Ty6y
 j2B5vW/VUCoTJcYqhvTHMTe1RDw3Qv7+J17qoHawp1SBF2Iy7iSCPFj2
X-Gm-Gg: AR+sD10H0wwLHFToYxmNRRCt72iDGs6lE6KGeB6qUEIrCEFZcgG1BRbDCuHraNFeoia
 l6SB4h4gownPj8vIPxoTMk4St3LHwk4i+nkEyBJhMr7JTrnPKbuDNs/kQOHVof5bHJOmQ5XQz8q
 iJd4+JBNEgcQHX6W6UTwpbXPh5q+ovomxoEpi7NNHKLcr+SiAtHlbtuxxi31/7oYWxLpUQUej6q
 b5O117ZZG8DftvYPZ3zhnBRFKs/ftPMzlTQVAzj7ikTdZB0wDW7Fj5VrQ51kR4dfxld/WwLgwhB
 Mhk1q66JD64EnoeDLZnIPl6Is+PBKxdsvicGCrIjGegQ9PkOlUFvP27HlewkXaMuxRag5gsLB4I
 qCMQi6iBmBtZ0FRYVuIt1bMxkvLMQivOqflf2MSwYIJFuZASUBY8RrbLiUqSfPRzn+1c9zmvcVs
 qndOc+v7+Q6HDuY76KOQvwN3ZC4+fQvVCuLqYwDhR5Uf235Vkn0UK0Ukh+fVwjM9LMZr0KpaXNi
 kI72XiLnwyPbhz4NX+a5KhSqqEAZ4T8gmri8lI91IJwdI4yfyZzqedhE0bmQ6nFULocgU56iw8x
X-Received: by 2002:ac8:574d:0:b0:519:89b6:78b4 with SMTP id
 d75a77b69052e-52b567dab59mr5377721cf.40.1785508093749; 
 Fri, 31 Jul 2026 07:28:13 -0700 (PDT)
Received: from
 runnervmvrwv9.a2vcrsad2ipe3ff0h3vahymc3h.cx.internal.cloudapp.net
 ([172.200.23.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908435b609csm11150146d6.26.2026.07.31.07.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 07:28:13 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
Date: Fri, 31 Jul 2026 14:28:12 +0000
Message-ID: <20260731142812.3998-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730203912.69588-1-yeswanth@linux.ibm.com>
References: <20260730203912.69588-1-yeswanth@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cgroup/cgroup_core03: convert to new LTP API with
 parameterised subtests
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

Hi Yeswanth,

On Fri, 31 Jul 2026, Yeswanth Krishna Tellakula wrote:
> cgroup/cgroup_core03: convert to new LTP API with parameterised subtests

> 	if (n == 0) {
> 		*data_ptr = 0;
> 		num_pids = PID_NUM;
>
> 		for (i = 0; i < num_pids; i++)
> 			pids[i] = cg_run_nowait(cg_child);
>
> 		TST_CHECKPOINT_WAIT(0);
> 	}

High: How can subtest 0 return while these children remain paused? After each
.test callback, the LTP framework calls tst_reap_children(). It will block
waiting for the children before run(1) can write to cgroup.kill, so the test
always times out after subtest 0. Could the dependent sequence remain in one
.test_all callback instead?

> The test used the old .test_all single-function style. Convert it to
> the new parameterised .test/.tcnt API
>
> No functional behaviour change.

Medium: Could this rationale be corrected? .test_all is already part of the
new API, and changing to .test materially changes execution because the
framework reaps children after every callback.

>  * [Description]

Low: Could this deprecated header be removed? LTP test descriptions must not
use [Description].

> 	.needs_root = 1,

Low: Could the test description explain why root privileges are required, as
required for tests setting .needs_root?

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
