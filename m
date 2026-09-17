Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA95C88E72
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 09:37:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E683C3E756E
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 11:37:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A7463C062E
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 11:37:30 +0200 (CEST)
Received: from mta0.migadu.com (out-40.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2DDD0600445
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 11:37:29 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=Lg9PA1h0nzM6WwhZP67tQGOun+0whPqzO+97t62fKkc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789637848; v=1; x=1790242648;
 b=e1ee+NPrWMDvM5T99Qg1l0kZ+YqmqsmrzkvpHRcaI0fnpK4X2nXrc6HLkv33N1IG9EBtY0sD
 r28jKdyXIg4FM22c/Ahm+NHhCltdMtNh0/JVxuh699xb69NLSNCTtcR/lRt31s6Jp5CVqfh1K4G
 g+cimaIoiOTuELiyyRw6xXVE=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id dd5ea110a5b56ba2;
 Thu, 17 Sep 2026 09:37:28 +0000
X-Mizu-Trace-ID: dd5ea110a5b56ba2
X-Migadu-Flow: FLOW_OUT
Date: Thu, 17 Sep 2026 17:37:24 +0800
From: Li Wang <li.wang@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aqu01Jt5VWOH6X7T@linux.dev>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
 Andrea Cervesato <andrea.cervesato@suse.com>,
 Cyril Hrubis <chrubis@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
 <20260916140402.1797325-14-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260916140402.1797325-14-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 13/36] keyctl19: Test KEYCTL_MOVE with same
 source and destination
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

> +static void run(void)
> +{
> +	TST_EXP_PASS(keyctl(KEYCTL_MOVE, key, ring, ring, 0));
> +
> +	TST_EXP_EQ_LI(keyctl(KEYCTL_SEARCH, ring, "user", KEY_DESC), key);

This line should be:
    TST_EXP_EQ_LI(keyctl(KEYCTL_SEARCH, ring, "user", KEY_DESC, 0), key);

Otherwise test failed:
  keyctl19.c:36: TFAIL: keyctl(KEYCTL_SEARCH, ring, "user", KEY_DESC) (-1) != key (966511877)

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
