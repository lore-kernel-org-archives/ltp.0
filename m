Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7E8C55174
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 07:12:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47B393E7079
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 09:12:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E36943E01E7
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 09:11:47 +0200 (CEST)
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com
 [95.215.58.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4EB24600050
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 09:11:42 +0200 (CEST)
Date: Wed, 5 Aug 2026 15:10:50 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785913901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9SseWIkgRwbmltBV0RDhQdLUZNE+W40tdd/hSIaGVdY=;
 b=u+5/WjGaJNzzYXyRYnj+9wjTZgUqCRl+MLGUmaH8isfSJVR536vFrPN6ARufONsDiZc3D5
 HEoWZkDMlEqiEeivaLErPNI5VWi2OMqaljnUmL2J2oYzBkJ+SpNj3dGO+SW4yEAYpyIOfz
 Eg365f+JQGX4LQzxoQJaoMBICRNbTl8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.com>, wakel@google.com
Message-ID: <anLhvtnHhHay5Y93@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.com>,
 wakel@google.com, Wake Liu via ltp <ltp@lists.linux.it>,
 Li Wang <liwang@hygon.cn>
References: <20260805025418.1249003-1-wakel@google.com>
 <6a72de5d.d5b2c389.26c2a.b4e4@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a72de5d.d5b2c389.26c2a.b4e4@mx.google.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] lib: Use backoff polling to wait for loop
 device nodes
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
Cc: Wake Liu via ltp <ltp@lists.linux.it>, Li Wang <liwang@hygon.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Andrea Cervesato via ltp wrote:

> Hi Wake,
> 
> I sent the Reviewed-by tag to the wrong email. @Li the agent review is
> correct and backoff polling is not working with old API. We need to find
> an another way for that.
> 
> As you can see the CI is failing everywhere in v4:
> https://patchwork.kernel.org/project/ltp/patch/20260805025418.1249003-1-wakel@google.com/

Yes, a simple way to fix it is to declare the tst_multiply_timeout()
in tst_common.h directly, then the lib can build successfully.

--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -26,6 +26,8 @@
 #define LTP_ALIGN(x, a)    __LTP_ALIGN_MASK(x, (typeof(x))(a) - 1)
 #define __LTP_ALIGN_MASK(x, mask)  (((x) + (mask)) & ~(mask))

+unsigned int tst_multiply_timeout(unsigned int timeout);
+
 /**
  * TST_RETRY_FUNC() - Repeatedly retry a function with an increasing delay.
  * @FUNC - The function which will be retried


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
