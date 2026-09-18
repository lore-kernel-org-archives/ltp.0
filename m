Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4FBC982D2
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 05:02:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDD1A3E61CD
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 07:02:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D38443E4C14
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 07:02:11 +0200 (CEST)
Received: from mta0.migadu.com (out-12.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E2C951A00FF3
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 07:02:08 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=pLNO7xlRFoU9OByj8fjmnfVaIVlQy5FIGdpQOMXBBgQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789707726; v=1; x=1790312526;
 b=sWFkgHaw3Wed+lflsf8BrLPQEuGVS8k0xQJAFshNPg96rOUzzeMRHYZJMBuKnLslBnPOzUFS
 6EzN+Sf3myAIx4d3TVNKuHUgpLRzfwPjzR2AOLcj8nxJj/5hvi2WZXJvaHb1ZoI7+qx27GiLEmo
 fHp06r9uEWVvDjZ+D5mpl+xU=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 042df902054028f5;
 Fri, 18 Sep 2026 05:02:06 +0000
X-Mizu-Trace-ID: 042df902054028f5
X-Migadu-Flow: FLOW_OUT
Date: Fri, 18 Sep 2026 13:01:54 +0800
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aqzFnANKxWCFLRe5@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>,
 Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
 Andrea Cervesato <andrea.cervesato@suse.com>
References: <20260916140402.1797325-1-pvorel@suse.cz>
 <20260916140402.1797325-10-pvorel@suse.cz>
 <aququIx31-BBNlnq@linux.dev> <aqvUDzAjzoEibVXu@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aqvUDzAjzoEibVXu@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 09/36] keyctl15: Test KEYCTL_GET_SECURITY label
 retrieval
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

On Thu, Sep 17, 2026 at 01:50:39PM +0200, Cyril Hrubis wrote:
> Hi!
> > Maybe refine it like below:
> > 
> > static void run(void)
> > {
> > 	int rc;
> > 
> > 	memset(buf, 0, sizeof(buf));
> > 
> > 	rc = SAFE_KEYCTL(KEYCTL_GET_SECURITY, key, (unsigned long)buf, sizeof(buf), 0);
> > 
> > 	if (rc < 1) {
> > 		tst_res(TFAIL, "returned %d, expected >= 1", rc);
> > 		return;
> > 	}
> > 
> > 	if (rc == 1) {
> > 		if (buf[0] != '\0')
> > 			tst_res(TFAIL, "empty label is not NUL terminated");
> > 		else
> > 			tst_res(TPASS, "no label set, empty string returned");
> > 		return;
> > 	}
> > 
> > 	if (buf[0] == '\0')
> > 		tst_res(TFAIL, "non-empty label is NUL terminated");
> > 	else
> > 		tst_res(TPASS, "security label returned, full length %d", rc);
> > }
> 
> Shouldn't we check that the security label is NUL terminated as well?
> 
> The algorithm description in the doc comment actually says what should
> be done:

Yes, you're right.

> 
> 	if (rc == 0) {
> 		tst_res(TFAIL, "empty security label not NUL terminated");
> 		return;
> 	}
> 
> 	if (rc > sizeof(buf)) {
> 		tst_res(TFAIL, "buffer too small");
> 		return;
> 	}

My only concern is whether the TFAIL is correct when truncation
occurs. Shouldn't the test allocate a larger buffer instead?

The rest looks good.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
