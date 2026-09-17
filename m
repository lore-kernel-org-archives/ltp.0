Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6176FC88E72
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 09:51:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D98183E74FF
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 11:51:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45D3D3C062E
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 11:51:11 +0200 (CEST)
Received: from mta0.migadu.com (out-238.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ee])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8EBE3600728
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 11:51:09 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=NrQGV2zmRR3KJKRdOkuCN4UBeO3mYbmXcamKo6Np0gE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789638669; v=1; x=1790243469;
 b=uwQPiOo5YIcLRhTj0tinFsUizve7VqRm5p586z/wzIBsHVQJMXoJCvSeJy9uYHzUOVrbF5CE
 H+2NNrCRrsyA9T4ZaEOnKRVBrAsy+pJdTB8uqzXiKtYCsRbd3XXWXqFGlKFVNX8TLTLH3lDMlmw
 V1mk45mPW/sSwqrJ3Yu1hB7M=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 39b91acbb4810739;
 Thu, 17 Sep 2026 09:51:09 +0000
X-Mizu-Trace-ID: 39b91acbb4810739
X-Migadu-Flow: FLOW_OUT
Date: Thu, 17 Sep 2026 17:51:01 +0800
From: Li Wang <li.wang@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aqu4BVO2kNQN9oQJ@linux.dev>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
 Andrea Cervesato <andrea.cervesato@suse.com>,
 Cyril Hrubis <chrubis@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
 <20260916140402.1797325-13-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260916140402.1797325-13-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 12/36] keyctl18: Test basic KEYCTL_MOVE
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
> +	SAFE_KEYCTL(KEYCTL_LINK, key, ring_a, 0, 0);
> +	TST_EXP_PASS(keyctl(KEYCTL_MOVE, key, ring_a, ring_b, 0));
> +	if (!TST_PASS)
> +		return;
> +
> +	TST_EXP_EQ_LI(keyctl(KEYCTL_SEARCH, ring_b, "user", KEY_DESC), key);
> +
> +	TST_EXP_FAIL2(keyctl(KEYCTL_SEARCH, ring_a, "user", KEY_DESC), ENOKEY,
> +		      "key no longer found in the source keyring");
> +}

To fix the KEYCTL_SEARCH args number:

--- a/testcases/kernel/syscalls/keyctl/keyctl18.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl18.c
@@ -38,9 +38,9 @@ static void run(void)
        if (!TST_PASS)
                return;

-       TST_EXP_EQ_LI(keyctl(KEYCTL_SEARCH, ring_b, "user", KEY_DESC), key);
+       TST_EXP_EQ_LI(keyctl(KEYCTL_SEARCH, ring_b, "user", KEY_DESC, 0), key);

-       TST_EXP_FAIL2(keyctl(KEYCTL_SEARCH, ring_a, "user", KEY_DESC), ENOKEY,
+       TST_EXP_FAIL2(keyctl(KEYCTL_SEARCH, ring_a, "user", KEY_DESC, 0), ENOKEY,
                      "key no longer found in the source keyring");
 }


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
