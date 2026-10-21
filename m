Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B100606A31B
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=CWEtRkXK;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=KFulIGdE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792570009; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=83upN1lituNvT9FcFBquOz8q0Rd2dSKGt9Vj6YrJXjQ=;
 b=CWEtRkXKDfNNulyOoVek0Ld0DYldyJWXLyItygIObewEm2ahzDLUzBgibhXK8Hrx/o+YO
 4TtJLQZ46vajUuOIuKYc9Jgaaahkjygr3EDSehaOXJpVtj0LbkMJU9ibLCeDwQCjKTRwwch
 wsTCucv+86LrawW6UzIYDQv7hNWbk/Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B34353C05D7
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 10:06:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97F323C01A8
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 10:06:31 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1ED73200043
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 10:06:31 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so299315f8f.3
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 01:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792569990; x=1793174790; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VaOX3VJo3oPiGMA0Ofqy6GfiTYzYkpcqgCzsqOEpxX0=;
 b=KFulIGdEF07G7RyrRRTzxy618+utY99NdAiA3j0nuslTKiDWBnjXwcwz7sWrhFDvmg
 7NRmKdnDDyUV3P7kV2rALQqJdI4TA+jXRbtTe5VSEUvGXH8WIDD9nbUpPtinEJEbWPsG
 q5dBFBBk8f8cYPAg43PBA8I/yIUxZm7FbHr4z4WBrtlKXBEUxBTewyruc6PzsP9mcqJF
 LagmdBiWyUqKcBKuBtktzKUlZT4MpxSBcUf2bF6F9k2UL0wEVaUJKw/cWp8TtcnJcsVA
 xKtPtBAKN/gZSp9tZq399/xNge0CzK8V78LE4E9xrjDkdaIGVQOaTZUkLliM0Yi9tlHG
 6SCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792569990; x=1793174790;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VaOX3VJo3oPiGMA0Ofqy6GfiTYzYkpcqgCzsqOEpxX0=;
 b=QTMNRAub8lzo1sg2NQ+tKKpoSzr/36qvmHZs+CHPqcSBz+hSfMXxQ6Vwyyta0MyqKz
 4ujB+wPyuZn4aAEYQoi41Jt636r99xWi2/fMhh6ZPInvoW13vWT/p6N7jHzxp0OaXVMq
 lb6qbhbF2nm3Ysn+sm4togUM7rfV5nLXGXSN2kI8N5jw9yLnkMH8aetlMotqm5YPL9f3
 rzY8FIej71zLPurssIB0JjOTtAwchtNKIWlEHUM3jTIrmM8rONz3m+kVGZuruid1MMBO
 vkCOojp1jvZ6YYtew7qt+8DFv2bc/VbRmIOj5id3xCydlqmRb8DJ5oQb5mAwxYZgmT0P
 Oj2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwROlsPp1YbqXh8jt2ndt6PDba5d/GpdvZCMEdnxdHOK2jE+QFWXSe9EdrAA6kN4en3qhM=@lists.linux.it
X-Gm-Message-State: AFq9FYL20Pj6cnN5MqQmnftt6P7ZRRSVPZ651j+mo0d4D5+BbyVcyLJQ
 BCYVUViUQIiBoIT3Ap9dW+KJOJD225QjhJUZQGeUrqYMpR4X5m41qn8ei3BHTPKR/9k=
X-Gm-Gg: AYBFou27v3w7ZuIy0Rqun7dpVaSnUzQoi8O4GLBJmLi970JWcvb4hle4pnNNkBr5+qg
 H+tZ1TZ4v/MyzKGNNpsBLbcdm3mCV5+hS+7BOAPsKdjxQUGVt+J1HE9Le7STWbDaJNHiKBWORWr
 BElay3kIRyz93AFmbgDuWKMa/PBtr4HTy2sZkyJgLR5LIMGIaiggb3/nDb/MRCuaOgsv1smRfau
 HJ2vOict/aDfDYEAgrGusJohJ3uoRAmndMaSlSJ2h2/Rcw9ZC8Tjg8zd0zmieMCGsbfbd810etJ
 esr4qFK2U3bQY5qxpR/WD7kKg+fQdocLU8tnSDmxBoK29rI5VCe6gM6kG2uoUq2eIOcByBv3eQR
 LNHhzSJnmGWZ2PQ2C/44bISgvgfBw/+xo061EplYrJlMeYXHXwmizgK/q4XfT7IVL76uAUzbi9B
 3fUrC9xCvY6OeEtLVxMyCbqGAa/gnSuVfG/+VrXtbVA2FSgYxifKe6V/ExrkdDxBzCLJ1t1ehEI
 3pFZ7pO7mUfCAIR5AAKZdgjEVrP4YvqsSUV4ocYTSKvDD5l7770SrN7JE0MDRBte3dLL3wm2aA+
 dUExQjEmtlAeR+dFniHGkQpnKt5g+V9Dgl8grYYdWbFnonfF551+R2vinlTyyN5Q10ceuGlOTwE
 ESQAw
X-Received: by 2002:a05:6000:71c:b0:48c:4d74:d7d2 with SMTP id
 ffacd0b85a97d-48e264a1ce3mr2314048f8f.12.1792569990362; 
 Wed, 21 Oct 2026 01:06:30 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2584afe1sm4142028f8f.56.2026.10.21.01.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 01:06:30 -0700 (PDT)
Message-ID: <EPvab57CtkZLXoP7Sk3thzPnDwJdsojXAOW5@localhost.localdomain>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20261020190450.17534-1-linuxtestproject.agent@gmail.com>
Date: Wed, 21 Oct 2026 08:06:29 +0000
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] build: Fix library prerequisites in testcases.mk
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Andrea,
> 
> On 20 October 2026, Andrea Cervesato wrote:
> > [PATCH 1/3] build: Fix library prerequisites in testcases.mk
> 
> --- [PATCH 2/3] ---
> 
> > diff --git a/include/mk/generic_trunk_target.inc b/include/mk/generic_trunk_target.inc
> > +MAKE_DEPS += $(abs_top_builddir)/lib/libltp.a $(abs_top_builddir)/libs-all
> 
> Medium: testcases/lib already has a per-library ujson prerequisite, so
> when ujson needs rebuilding, make -j4 -C testcases/lib tst_run_shell
> launches that builder alongside libs-all's ujson builder. Both write the
> same objects and libujson.a concurrently, allowing a corrupt archive or
> a failed link. Serialize or deduplicate these prerequisite paths so each
> library has only one builder.

Valid, I will fix it

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
