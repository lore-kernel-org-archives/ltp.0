Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C552C433EF
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 13:52:20 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B78A61547
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 13:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B78A61547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B588A3C8BB8
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 14:52:16 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D87C3C1DFA
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 14:52:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 397CF1A003D2
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 14:52:05 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5641C1FD3E;
 Fri, 19 Nov 2021 13:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637329925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HB6UkC/m3Jhk4g15wkmgoM5cRL/6/CfVL9JQXqwekx0=;
 b=v5hP+oeYFKnDrjcewqtMjcMsjrUYzueHaN11r7c6Q9Vj/fU25rUusLbzS+JlJwN5GDfkwM
 K8TWsQgEFDOp6YxSJ5CmXk1bjUDBRLis4XA5/xZy9py27/hIhMDUawUZhCqZZBbPXRkhP7
 P/VNtdX2AFTipqYe9jozmcO8DTSPLlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637329925;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HB6UkC/m3Jhk4g15wkmgoM5cRL/6/CfVL9JQXqwekx0=;
 b=sZoOGTeYkWKgeu4QUeKM0Lkrs86DkG8/FWc3x1JdL2tyDikWc2RA+Fohk6uvsu7yiC6tDV
 gsVHvvcvRVQC4KAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42BB513B40;
 Fri, 19 Nov 2021 13:52:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MxIJDwWsl2HqcAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 19 Nov 2021 13:52:05 +0000
Date: Fri, 19 Nov 2021 14:53:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Florian Weimer <fweimer@redhat.com>
Message-ID: <YZesRs3/tyZY12BN@yuki>
References: <YZearmiVEw9/eor9@yuki> <877dd4cmsw.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <877dd4cmsw.fsf@oldenburg.str.redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] asm-generic/int-ll64.h wrongly used on x86_64?
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
Cc: linux-api@vger.kernel.org, libc-alpha@sourceware.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> The correct format depends on whether you use struct statx from the
> glibc headers or the Linux UAPI headers.  glibc uses uint64_t, Linux
> uses __u64.  uint64_t in glibc prefers unsigned long if the type is
> 64-bit, Linux uses unsigned long long unconditionally.
> 
> One solution is to use %ju and cast to (uintmax_t).  Other cast-based
> approaches are possible as well.
> 
> I'm not happy with the situation because those casts reduce type safety
> and may suppress relevant compiler warnings.

I still do not get why can't the kernel __u64 match the uint64_t at
least in userspace. It should be as easy as:

diff --git a/include/uapi/asm-generic/types.h b/include/uapi/asm-generic/types.h
index dfaa50d99d8f..3c9a1fc5d5c3 100644
--- a/include/uapi/asm-generic/types.h
+++ b/include/uapi/asm-generic/types.h
@@ -2,8 +2,12 @@
 #ifndef _ASM_GENERIC_TYPES_H
 #define _ASM_GENERIC_TYPES_H
 /*
- * int-ll64 is used everywhere now.
+ * int-ll64 is used everywhere in kernel now.
  */
-#include <asm-generic/int-ll64.h>
+#if __BITS_PER_LONG == 64 && !__KERNEL__
+# include <asm-generic/int-l64.h>
+#else
+# include <asm-generic/int-ll64.h>
+#if

 #endif /* _ASM_GENERIC_TYPES_H */


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
