Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB76CD4851
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 09:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779183372; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=hBLaCdEgADQXFgkT9WXTGOMcLvw2drkQ7nzkQHlhqXc=;
 b=KXjRmucFzfB52gJv4QdVjhKRCCpWKE/oMFVZ06IhVoVU7qJRttfIAVDfgjFsBPAKpHpuv
 GivrHCcQG0U4tAipYhSimCeIA4f9Uw3afFcgOP6g/n1lkRhap3ob5/RYp/ZzAksrZn5G1ad
 tg+ufaWckGff3RnOFtsAg+3lGEUB8fQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7B603C6F6E
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 11:36:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FE9E3C66C1
 for <ltp@lists.linux.it>; Tue, 19 May 2026 11:35:49 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EC1DA2009B6
 for <ltp@lists.linux.it>; Tue, 19 May 2026 11:35:48 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso34178915e9.3
 for <ltp@lists.linux.it>; Tue, 19 May 2026 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779183348; x=1779788148; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=BNyVu6CLnwLxU0MiLIgy50wtmxbNK3fHLNDpc1fk+Uc=;
 b=ZhHsXWvwnUWyZqmVy9SL2WBefMF8bSIR0a8Dfsj7xj+7NELFGKW6LUKHHefqKpKmYe
 Q+KjGnHa26vnA0fcpfoFtYr7cBRbqg+eP98q8vuy1Du/Du86JACqfYqIr2BrelYEmAli
 lxZXzg2rmzENYwUiTV9l0V1eMxPlXHbD0/K2U+Vw6amwa1fEvaZ3QdkJftaX8aIWmmdn
 c853omSWBnU4kPxyo7RH5JMtys6yHyU5yrG75ub3sWyKzfwwMvMjBABGmfWnPsdIi3g8
 W51JCpYavJ8q0N3NvLWPhwOQc9Q92YWflYbzz7sIn9y8FLnUkdclp8njZnny2GhvHyAU
 V8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779183348; x=1779788148;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNyVu6CLnwLxU0MiLIgy50wtmxbNK3fHLNDpc1fk+Uc=;
 b=oa6tdlSdNR8eK/v6etds6gxgZk5colmm629DDaOvowcVCint98sV5GTajcEU/o0zgV
 PFnlpUlB9GjcphQXXPXtiHTnAGi6jFLY8Ard9q+N+nE6NpR7bAJgFnOlDEYFLof62OxC
 1sU5DRqF0mO6evZ3XBm0KQxoiFTgqJpx3s3Eyh6mFaFkdhk92OBSoMuxX/fTZOKGcT7h
 7pMmpsG8zyv+Lp5NTxnps4I5hbP3W+STdLJG/UptLBm3xNl5X8fFm7jicy/Ujv4DHYwH
 5tkyGcqfbkMic8CU7gK6uFkesZfqbBRHZfjfkItxuqbDXdXfmEMgv5rPQezh4pJ9kyqP
 mgmw==
X-Gm-Message-State: AOJu0Yy/fV/p3HyyNRXJPj8OAWeN3oyT25BVcz0KYEw2W2gNBDRMQ7XB
 aue64mKWEsvx72boGhlmkL8Py9JX9K6TMLBEjpE7kQhiDJQPWaAcUiEdolQS0bPRQk+8vgxhjkn
 +whwyO4h0Be+W
X-Gm-Gg: Acq92OEMSxPSykftWkXY9IPbOO/DYqXW+2q09u2vm6JrEPFV/eTlUo7z31i9cCrfSct
 UK5umOx6ZgTEtB8dHviDRzfGmyZtM/l2uhninbfm9BXxpk7wLjKC8q8dQfIeI5wf8t36+JFeiJ2
 e4mOwajxD/Gx3NnDFzum9KDaoXxNYSbSQdL2ba1Baiwa9w0v+15v47Tk/ee8X77IKe9ukwdr940
 MD2gxk/vBzbal8iMx2kCkofjR+N9Xm2I6fJYgnOHeMvLg6e5O3N/T7zrX/s6cDUmdYwZsw3Iyhl
 ctb1CFf1caTlSGdFccQbhekR9vxcU/zH1rb1zruyxE+N9xmcccUfUK99/na1TX1oy6suecpjGMk
 GQuXKC+g/GieSYjT584jS0z/OE6iYwOm7xvsHiqAG33J+1S2xU1c5ibH1QtriTrfGI2lJwPRUZr
 A8NXYwE/M5AwQkrIvKHGZzAXYVP+zC01QHzKWaE50r7Hf6D6wUL95I6nbXdOsoxw==
X-Received: by 2002:a05:600c:8b05:b0:48f:be94:d82c with SMTP id
 5b1f17b1804b1-48fe632518cmr345971635e9.19.1779183348235; 
 Tue, 19 May 2026 02:35:48 -0700 (PDT)
Received: from localhost.localdomain (wl.mlade.cb.wlnet.cz. [193.165.72.195])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c833fcsm314841465e9.2.2026.05.19.02.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 02:35:47 -0700 (PDT)
Message-ID: <6a0c2ef3.117c96fe.215aea.ef9b@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <7401d774-559c-43b3-ba56-fb857fedc81d@suse.cz>
Date: Tue, 19 May 2026 09:35:47 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] af_alg08: Allow EINVAL when calling recv()
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
Cc: Wei Gao via ltp <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> On 5/19/26 10:53, Andrea Cervesato via ltp wrote:
> > Sorry I didn't double check the CI. Can you please send a new
> > version fixing the patch applying issue?
> > https://github.com/linux-test-project/ltp/actions/runs/26086543445
> 
> The patch fails to apply because the issue has already been fixed:
> https://github.com/linux-test-project/ltp/commit/88b249e6bdf3086cb402c2aab324b200c3d0c2ea

thanks for double checking.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
