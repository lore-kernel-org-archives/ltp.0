Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10082C44508
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 18:07:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4351A3E1E71
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 20:07:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C62573E1693
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 20:07:35 +0200 (CEST)
Received: from mail-pj2-x04.google.com (mail-pj2-x04.google.com
 [IPv6:2607:f8b0:4864:39::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3548114004FD
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 20:07:35 +0200 (CEST)
Received: by mail-pj2-x04.google.com with SMTP id
 d9443c01a7336-2cabf1f1051so3961415ad.0
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784052453; x=1784657253; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H+XFXlIlEfHLzy3N+IXzMYNpDJpBO2aXlJw35LCRSSM=;
 b=Jf3cWHzpVnXZSK387Ph67fj+Y3elNQGzHHMVmV7/JMpeyW2WktX2UAY14rma3jY7AH
 eW5RBYYoqARSR12KS9DFGsbODy0zJkWBeDd0J3/EZx3+UZSpsDhoCj7G36m5XtDtHXc6
 3IN356oAhdv7RTUbZpmcF5KBsJ57TpTGU3/5oEfWo17DgIafhuhB6unjY05TLHI4ZfGy
 6DXbBDKJSKLPE3ScUqiZ5VLaxFKZmw4eB3mokxeUjw3+GQvz9qV7gI1l/hxIr0dbtY9i
 vqez6Rndut3krZtuNsZaMx1BB7xl0bS6gwdGU4EooVCe5LAr+cauYVG0fnlYRAwXUT6I
 j34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784052453; x=1784657253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H+XFXlIlEfHLzy3N+IXzMYNpDJpBO2aXlJw35LCRSSM=;
 b=Cj2+vkjxqh8TRq6AD81c45hm0rPed3ozQXjFOhtBl9FybLlOtaU6qcIKvH3K1K5wB0
 uspAFdwuwnYKW8/LyNhQJzL9vWwilQfWU5jVHf/DaYAvPaj/W7thErriP4qiDwKpeVTQ
 5Jx3pUwNoFwvithYeUu82Bzt7S8JDLs74VaE2fsHzkQWS1iBHboc+NkBv0TDvGzrhGDS
 IoIay7eCfN8A3p6AdjOtxaRZDsrY05rXshAR7rqmJ0cbig1cYyDcTFfhax4qL+yJ4JK+
 WySUmyXnP7svXCtgkOlHNxihiOwu7Ur+UWkE/oBB9T6+hgWJD81j3bnP0v9SJs3q3MDX
 1OdA==
X-Gm-Message-State: AOJu0YyDLhzuQNjhaTDAuZdGAwTXAXc5nqghXjGxIBySj8reeaP3dRSG
 wMXKi3VWzHxk2defJOXj/N7/ATP9GEZFWfQEJLulSx05OheI44rCLsw4U/EzwVwP
X-Gm-Gg: AfdE7cnmJpS+nZ62nX9FND+llJDGaz8WF5d+FSezII4TXgcG+/I0YcMWmgKrFK/WTzZ
 NWiRMJYTlgXbmL1UEQhyin57BRhNo65SfMCCb4W371IbrCM7Y5ddUM/6v4ap2iwdNhLwWq4XLmT
 1U9l13Pr/NyOp5DnnojaqQSkYzhAdJKdUCJpK42e7ZCdSc4CJaJV5DOEojzXXdeqCPibUSEv+gw
 dzGRAVNz85ueo7YLzWocbJnIoZDHo8lTznJ308yx3ntBQx2DLdqWASWP8Dvr7DsUNhKr31rTj3L
 cMZdm6buw1IUvGSyfBFYM7TY35DWDu9nEw0pf9zYjdsF4JpSumGwiyZQaRM8mJDFmueiKN5EG1n
 kspjkPHSoPhiVQs/oTb9zO3erzhLuvvsMcHYFA6E8CRjYc5mEK7L4c9kh/gwlodCmxvRoJtWacd
 0EvZU0fixRONv7j+tEKv6tH5arTYjKAEENxpK0/4UNNY7xC+ve5NP/2jrK7/cYI1QKbh4XkkOaR
 B5LObYStxsKKTouuPqfUwONdXj+RlkB
X-Received: by 2002:a05:6a20:3d19:b0:3bf:866b:b74a with SMTP id
 adf61e73a8af0-3c110b1e418mr18562749637.35.1784052453219; 
 Tue, 14 Jul 2026 11:07:33 -0700 (PDT)
Received: from
 runnervm5mmn9.hoabpu31hpaupmk2ycwfr0t0ee.phxx.internal.cloudapp.net
 ([172.182.244.81]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm148805997c88.14.2026.07.14.11.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 11:07:32 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Benjamin Wheeler <benjamin.wheeler@canonical.com>
Date: Tue, 14 Jul 2026 18:07:31 +0000
Message-ID: <20260714180732.3800-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714162834.47191-1-benjamin.wheeler@canonical.com>
References: <20260714162834.47191-1-benjamin.wheeler@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cpuhotplug03.sh: Poll for CPU migration instead of
 sleeping
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

Hi Benjamin,

On Tue, 14 Jul 2026 12:28:34 -0400, Benjamin Wheeler wrote:
> cpuhotplug03.sh: Poll for CPU migration instead of sleeping

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
