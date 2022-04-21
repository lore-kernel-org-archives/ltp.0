Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A2FC433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 13:05:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F16D3CA6E1
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 15:05:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AF283C0058
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 15:05:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1AE006008C7
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 15:05:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 297C91F748;
 Thu, 21 Apr 2022 13:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650546318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BZn5eO/mA9y1FIQxe2tLrVQDoKU9nqBREtqastAPxDM=;
 b=LaoxCtvzApiAJRJbKNnvISMjm0F+TNPR6eO0b+9ODx266Jgi4iIN10auGzHkTwFAsn3/+F
 Hjjp4aQaSVY47PxqgBczxvp5mHb8L/sLOdFd2dbTQCSbDRuX+rYWUVDUZ5PfjlYXlnzMTJ
 bClvqn5zQWpXzoUvAatTu2lSH6Xm/8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650546318;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BZn5eO/mA9y1FIQxe2tLrVQDoKU9nqBREtqastAPxDM=;
 b=WGUTiSN8oEM9L8iGVyV7Sy+j7DFZk3nVSGEhm+6k6TzvTAarwjUgpgkZB3bQ71bt12MNns
 9kZSUkWMwhw6QuBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12ABA13446;
 Thu, 21 Apr 2022 13:05:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SoqcAo5WYWJFKQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 21 Apr 2022 13:05:18 +0000
Date: Thu, 21 Apr 2022 15:07:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YmFXFpjUoFfOEPo8@yuki>
References: <20220421123351.17645-1-mdoucha@suse.cz>
 <20220421123351.17645-2-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220421123351.17645-2-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] KVM test infrastructure
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

Hi!
Pushed with two minor whitespace fixes, thanks.

Indentation for include directives should be done with spaces after the
hash + removed whitespace before the #define for ARRAY_SIZE().

Full diff:

diff --git a/testcases/kernel/kvm/include/kvm_guest.h b/testcases/kernel/kvm/include/kvm_guest.h
index 8b19f2811..ec13c5845 100644
--- a/testcases/kernel/kvm/include/kvm_guest.h
+++ b/testcases/kernel/kvm/include/kvm_guest.h
@@ -17,7 +17,7 @@
 #define TST_TEST_TCONF(message) \
 	void main(void) { tst_brk(TCONF, message); }
 
-# define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 
 /* Round x up to the next multiple of a.
  * a must be a power of 2.
diff --git a/testcases/kernel/kvm/include/kvm_test.h b/testcases/kernel/kvm/include/kvm_test.h
index 55989eaa5..4d67adc95 100644
--- a/testcases/kernel/kvm/include/kvm_test.h
+++ b/testcases/kernel/kvm/include/kvm_test.h
@@ -9,15 +9,11 @@
 #define KVM_TEST_H_
 
 #ifdef COMPILE_PAYLOAD
-
-  #include "kvm_guest.h"
-  #include "kvm_common.h"
-
+# include "kvm_guest.h"
+# include "kvm_common.h"
 #else
-
-  #include "tst_test.h"
-  #include "kvm_host.h"
-
+# include "tst_test.h"
+# include "kvm_host.h"
 #endif /* COMPILE_PAYLOAD */
 
 #endif /* KVM_TEST_H_ */

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
