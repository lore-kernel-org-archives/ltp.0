Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B729C606A322
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=LMr1ZQGz;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VnOSzmzA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795509818; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=6rvMHfZHx3gNyQ5uaRkn0Bu6xiB6M4KuaQx757DwHkk=;
 b=LMr1ZQGzVsN3PD9zUpjGWiJTnafZaqbq3Np7trNMt+nTu4VJGvJo9K8sK/PJKVLYejQdd
 WK32xMpu1kvLbp//ne53MXYYrQHkxdC+pjyO5X9wgwuBSN5Z8RhxtlrRi3GTi1/HTCq/eyx
 tpo8vVl+eIvfihnNk+QyVHD4hcAQdkQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 425373E91BC
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 09:43:38 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01D513E928B
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 09:42:46 +0100 (CET)
Received: from mail-pf1-x445.google.com (mail-pf1-x445.google.com
 [IPv6:2607:f8b0:4864:20::445])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BE7721400770
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 09:42:45 +0100 (CET)
Received: by mail-pf1-x445.google.com with SMTP id
 d2e1a72fcca58-8b69d1f2a18so2952678b3a.1
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 00:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795509764; x=1796114564; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lJeZ3UAm4P3u/Vm7cCxun3mf049dYPbGAsJ12ohJ5zI=;
 b=VnOSzmzAvPFo3AE2qcodOZsEvUGZSBL35CUa6fhn4S1K9d5BWaKt4ZiUs+ZFJh/En9
 W1jYUmWJtHSfUmib3+pwBMXEAALj8LAkxlyF7V1r0cUtMS3f8OPTpeuxs1gv0jJGe5wt
 OAkZt0PJ14JU+e43W+FNtCBsEMTsA36pC4JkyRSW1VMi0rGZGtskxsoZBuHHRx6/0IvU
 jHDWWS6vw9MyP/OCOw6UcHcripWTYo/fRmQxcCDSeYY/Pu9SQofXx3e+2Okda+IeuYtR
 swnDgHPkLOBne/d3loxlMF7lXofeju+F4nEctK8nOaqzYhhCenh87HsP6ShcPS9mx4HH
 8XBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795509764; x=1796114564;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lJeZ3UAm4P3u/Vm7cCxun3mf049dYPbGAsJ12ohJ5zI=;
 b=ZnI9VvoRPyJ8fAfvHVLxoo0+iQmPCVfo/2boYh+e9uLl1ozaWe2vD97PM5HmzlbbDh
 4RI712I+Qet8JkAMIa+ays+cY4ApFoGLMa4Iig2ewmKzuTK6ybuoggVHrcio+IUk9bT8
 WOTPCJZEHMbN1TuJo27FkvffGItMS3R1Lk1rGd2m1Vsa/+Vyt+AL3A5GhQyFEhP3CVox
 phYQOx+dz41C+Pbs8DE+JLmUh+0hafAGlbIKgn2/z1igg0mryHwZqWE7zAvfXn+NsfeZ
 hixZJ/JNBt0T6DV0VSuZbv/l0aZAKemJryImZA9Z2A/kUPjk4zZFRIxPuxvcoKKC3SCp
 cHCw==
X-Gm-Message-State: APuU4Z914CL8FoFQm5OVqlCZok+OqQVESTVqWNHwPbJXe5FEysbkxUfx
 6Twoooz/P2KS7MA7aZKGXSODUzNr9014LlfvTxElmWetQl9oHb1jlu5iCpk52rWEw+3464ntoUI
 wQmrAEEyaCgz3iwmT/29p0ega6sCWYNl2fKqQNjmbqFKsyZhZXca8D1YNCVkgCrqEzadAhz/3dJ
 Y22HYR5gGWff7faXC0s7H4tT5Pig==
X-Received: from pfbfa6.prod.google.com ([2002:a05:6a00:2d06:b0:8a0:3cd8:22d6])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:891:b0:8a0:465d:38ba
 with SMTP id d2e1a72fcca58-8c7dd9d67d6mr10035907b3a.24.1795509763450; Tue, 24
 Nov 2026 00:42:43 -0800 (PST)
Date: Tue, 24 Nov 2026 08:42:40 +0000
In-Reply-To: <20261113134113.2822581-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261113134113.2822581-1-wakel@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124084240.2967915-1-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_test_macros: Avoid re-evaluating arguments in
 TST_EXP_{EQ, LE}_*()
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, Andrea, Petr,

Gentle ping on this patch:
https://patchwork.kernel.org/project/ltp/patch/20261113134113.2822581-1-wakel@google.com/

Please let me know if you have any comments.

Thanks,
Wake

On Fri, Nov 13, 2026 at 01:41:13PM +0000, Wake Liu wrote:
> Commit 1759ad9f3f0b ("Add silent macros for TST_EXP_EQ_*") split the
> TPASS message out of TST_EXP_EQ_SILENT_() and printed VAL_A directly in
> TST_EXP_EQ_LI(), TST_EXP_EQ_LU(), TST_EXP_EQ_SZ() and TST_EXP_EQ_SSZ()
> because tst_tmp_a__ was no longer in scope. As a result, VAL_A is
> evaluated a second time whenever the check passes. Commit 1b0395338108
> ("tst_test_macros: Add TST_EXP_LE_LU*()") followed the same pattern and
> evaluates both VAL_A and VAL_B a second time on TPASS.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
