Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA54D6AB10
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 20:56:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 019B43E4E96
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 22:56:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F5523E5494
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 22:55:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C3F4B1400C54
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 22:55:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 40F445BD57;
 Thu,  2 Apr 2026 20:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775163343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2TFUL8BtnVUqovRGbiMdxWZ/dZiIM+gZ6TFuNyDv6L0=;
 b=UwIvP7CPcpBQxUAMJI1KgQjgL5OXc8BiRvANs+jPnnMiGJEpuodpSmmsUEWoQNPdqzJSlL
 wJI3ToZK1xjkbivLNfLGwdBK37Ef75Ng5r58sOA4xymPSBQkNGHffMlse+eFPCffWYhE18
 ABD2G1o8E9BnHuQWcb4h+DiUBLEvtZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775163343;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2TFUL8BtnVUqovRGbiMdxWZ/dZiIM+gZ6TFuNyDv6L0=;
 b=SdncbBWx3hzSC06CxTmkemqqWO3zCGvJnsV2r60rvz3iQKvL1kIBW0SVbJ5h0lxY6IHFTc
 qGF+zRy25S4lRvBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775163343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2TFUL8BtnVUqovRGbiMdxWZ/dZiIM+gZ6TFuNyDv6L0=;
 b=UwIvP7CPcpBQxUAMJI1KgQjgL5OXc8BiRvANs+jPnnMiGJEpuodpSmmsUEWoQNPdqzJSlL
 wJI3ToZK1xjkbivLNfLGwdBK37Ef75Ng5r58sOA4xymPSBQkNGHffMlse+eFPCffWYhE18
 ABD2G1o8E9BnHuQWcb4h+DiUBLEvtZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775163343;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2TFUL8BtnVUqovRGbiMdxWZ/dZiIM+gZ6TFuNyDv6L0=;
 b=SdncbBWx3hzSC06CxTmkemqqWO3zCGvJnsV2r60rvz3iQKvL1kIBW0SVbJ5h0lxY6IHFTc
 qGF+zRy25S4lRvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55EB24A0B0;
 Thu,  2 Apr 2026 20:55:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8OuTDc7XzmkJHAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 02 Apr 2026 20:55:42 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  2 Apr 2026 22:55:33 +0200
Message-ID: <20260402205534.224141-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402205534.224141-1-pvorel@suse.cz>
References: <20260402205534.224141-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] tst_atomic: Add tst_atomic_return_add()
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
Cc: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Combine atomic loading and adding.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
https://lore.kernel.org/ltp/acqLzcXEo0uU0aSD@yuki.lan/

 include/tst_atomic.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/tst_atomic.h b/include/tst_atomic.h
index 9d255bc448..196399db31 100644
--- a/include/tst_atomic.h
+++ b/include/tst_atomic.h
@@ -30,6 +30,11 @@ static inline void tst_atomic_store(int32_t i, tst_atomic_t *v)
 	__atomic_store_n(v, i, __ATOMIC_SEQ_CST);
 }
 
+static inline int tst_atomic_return_add(int32_t i, tst_atomic_t *v)
+{
+	return __atomic_fetch_add(v, i, __ATOMIC_SEQ_CST);
+}
+
 #elif HAVE_SYNC_ADD_AND_FETCH == 1
 
 /* Use __sync built-ins (GCC >= 4.1), with explicit memory barriers. */
@@ -56,6 +61,11 @@ static inline void tst_atomic_store(int32_t i, tst_atomic_t *v)
 	__sync_synchronize();
 }
 
+static inline int tst_atomic_return_add(int32_t i, tst_atomic_t *v)
+{
+	return __sync_fetch_and_add(v, i);
+}
+
 #else
 # error "Your compiler does not support atomic operations (__atomic or __sync)"
 #endif
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
