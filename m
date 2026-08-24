Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BE8C5DF81
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 14:42:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22D6B3C8B79
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 16:42:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11E793C6EDD
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 16:42:39 +0200 (CEST)
Received: from mail-oa2-x01.google.com (mail-oa2-x01.google.com
 [IPv6:2607:f8b0:4864:30::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B35CE20076B
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 16:42:38 +0200 (CEST)
Received: by mail-oa2-x01.google.com with SMTP id
 586e51a60fabf-455efbd6e96so1347839fac.1
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 07:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787582557; x=1788187357; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P2UA4UsTfgEyuzGOrzXLxDofkDzW7o9/bRDSQqsCjYE=;
 b=ALDADhk0sg2KrfsXa7fdnvkn0MI3aZvlagYJhggv/rkZWKlxXK66dXzk+oj+V0KvlW
 bjSTcddi6/dKN/ukFGq9A2v6awRKM7lJMUhdL/sncMDqmkHC2v7liAP+9O7qmeCsIbhg
 SAM77j3uLVUTGfdL752IiMl2B3A7aLQ5D7uNQ2e476S/RdO1tx7If8TRLtDLWZ2WfN1B
 t5aKYwJxmfzBVonY5005K3PEzqxVN/llv7Nofno1fxhZjWGeWLhc+4mw77rn1D2Q3ZJK
 n96LrMpaKMMrcXetNVBoCy3LocfqjoTs0WVJLJ0WHf7imygOTdkKqHtEIB2o5J2L8sVn
 oKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787582557; x=1788187357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P2UA4UsTfgEyuzGOrzXLxDofkDzW7o9/bRDSQqsCjYE=;
 b=ijR+OkYixrItpA1i6D7DEwD+YXXJ3C04UvpgGcM/1i+Y6SpTOXXdUcf5BgUL7TZe2H
 P/7nS6ybrjeJ89+1EWaNsRTId9arhzn2kjnY6Kd/ObJl6mJJHPL4kd+/cref0DACizsO
 teYGlb7KHrVkc6ChHo5lQGIndeoeiIHCWxxEbJzJNLH4I+kwAkbWMVR1vfmlJjDa+Y2o
 rVyNZEBXcJm4p5nWHqfeZSJhESnksQz5UjHgato7Pga4QJBmKRuWo98gNbRc+SThmH6Q
 E/yz+RhBAUOlL4Zw6/wU/W+q6LHyIKjf6icC1ymr7sB5ArrICC20MTZT3DjiapD23ODL
 miyw==
X-Gm-Message-State: AFuF++m5TbRBQZFLTnySzdM4T/7afQmqvreaMUCG6s39bLOA05ohmHMt
 L3x8fZNLZ3po+Ui5Mdiup64zajLqSGJ+m+iZ/1TrrKc+2DImtPDPUiBETsoIxJ/e
X-Gm-Gg: AR+sD11/y8Skxqfcjw2WVJEyPC4SBkob3Jg77uf7XXdEnCtkFJCrpqDvhKmIHmDkiek
 Xm5ddqKFnXUeiHCE9SmwAyrD182J+kbleJmOeg6rHeZbGJ23y7dQNCahmavCrzAhSREkoTLrB42
 cf8kWgykSnMaqvbsDYRltRK6pRrWnNaebE4UuK2uCJ33TyV35n7KS+NYaHIky3FS22VsKFd1mpV
 G/A3Ulv7EFdJHuFWrtgUz0NOGVAuJj6KY5urTuuc5PiL6doZHK0Ld7t+cTbe57WCC3B1oqVMDsU
 0+zhEqz6oqtG8F23/TinnnTPfDPeAngRuA9YyDvf/wUkN8f0fO3EKsG9E38ptny0H8jqOz8vGXr
 CbfeZM22jQJuW6si4jBd09OPNkDlwWRuQY7MeI9Ko/RxHC6hXXcVWL5LdFGHszSYRCWVdGEvHlN
 Xm5Wcg6ST0MZvzOaGhXVQ4t82UdzMHx7kkMbN56jff55RvAtLq8N6i33M8xTlID1JvzPsmMNogI
 JpThZsWS6LFhda1G4KHsMpNQKnP5WAgLfQVxexy+uizWGYR8csbKNpwkdfsctHBIzIBMQmHOePN
 qUM=
X-Received: by 2002:a05:6820:150c:b0:6ac:b6c0:2bf6 with SMTP id
 006d021491bc7-6b15919e707mr27008447eaf.5.1787582557261; 
 Mon, 24 Aug 2026 07:42:37 -0700 (PDT)
Received: from
 runnervm76f27.zk2kbquirwzuplotho0qlaekwb.gx.internal.cloudapp.net
 ([172.212.157.203]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4638313340dsm5151404fac.2.2026.08.24.07.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 07:42:37 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Mon, 24 Aug 2026 14:42:35 +0000
Message-ID: <20260824144235.4081-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824135722.200152-1-avinesh.kumar@suse.com>
References: <20260824135722.200152-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] landlock04: Fix false TFAIL in _test_truncate() deny path
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

Hi Avinesh,

On Mon, Aug 24, 2026, Avinesh Kumar wrote:
> landlock04: Fix false TFAIL in _test_truncate() deny path

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
