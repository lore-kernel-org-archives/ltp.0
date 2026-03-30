Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4692A1061B05
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 14:42:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A14093E5C22
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 16:42:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A85B83E4F24
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 16:42:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2AA74200919
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 16:42:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C3B365BD10;
 Mon, 30 Mar 2026 14:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774881737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qQAJfIFDNVqUESDg+f8g6/UvP80azg3tV82wVAUZjzQ=;
 b=0i7Hlm4IzzEg9UuOrd65uN3KDt4J1XCjGlaPIw8dyAFREeT1XDGZSovQYahzSiRrpT9Uam
 hRB/v3xkpiIY89NoYUIN/O1EZkCeGlYgATtNP2vVGbWWvkk5zDOVuk+rAHRW2lV4hiN8QV
 sssPMfZ/Uglxq9u3I2PtqBYz3wiIypE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774881737;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qQAJfIFDNVqUESDg+f8g6/UvP80azg3tV82wVAUZjzQ=;
 b=oqq+XCupw580h07E7r0gn/oMVr+0mVmVnYY7ef8zQ13cbks09aKfbHRsxYVAQ3BBUHw9rF
 gokHd4WJ3KuNMtCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774881737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qQAJfIFDNVqUESDg+f8g6/UvP80azg3tV82wVAUZjzQ=;
 b=0i7Hlm4IzzEg9UuOrd65uN3KDt4J1XCjGlaPIw8dyAFREeT1XDGZSovQYahzSiRrpT9Uam
 hRB/v3xkpiIY89NoYUIN/O1EZkCeGlYgATtNP2vVGbWWvkk5zDOVuk+rAHRW2lV4hiN8QV
 sssPMfZ/Uglxq9u3I2PtqBYz3wiIypE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774881737;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qQAJfIFDNVqUESDg+f8g6/UvP80azg3tV82wVAUZjzQ=;
 b=oqq+XCupw580h07E7r0gn/oMVr+0mVmVnYY7ef8zQ13cbks09aKfbHRsxYVAQ3BBUHw9rF
 gokHd4WJ3KuNMtCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC2014A0A2;
 Mon, 30 Mar 2026 14:42:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HPqbKMmLymm0aAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 30 Mar 2026 14:42:17 +0000
Date: Mon, 30 Mar 2026 16:42:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <acqLzcXEo0uU0aSD@yuki.lan>
References: <20260330100750.858390-1-vasileios.almpanis@virtuozzo.com>
 <20260330133304.GA93779@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260330133304.GA93779@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pidns32: fix PID namespace nesting depth
 off-by-one
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
Cc: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > The 2023 refactor used tst_atomic_inc() before clone with a zero-initial
> > counter, which only performed 31 CLONE_NEWPID nests while still expecting
> > MAXNEST (32). Compare the level to MAXNEST first, then increment and clone,
> > so the shared counter runs 0..32 and the chain reaches 32 nested namespaces
> > again.
> 
> Indeed, good catch.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Given that we no longer have to implement atomic operations in assembly
and can rely on compiler we can easily add post increment as well.

Should be as easy as:

diff --git a/include/tst_atomic.h b/include/tst_atomic.h
index 9d255bc44..9433291ca 100644
--- a/include/tst_atomic.h
+++ b/include/tst_atomic.h
@@ -30,6 +30,11 @@ static inline void tst_atomic_store(int32_t i, tst_atomic_t *v)
        __atomic_store_n(v, i, __ATOMIC_SEQ_CST);
 }
 
+static inline tst_atomic_return_add(int32_t i, tst_atomic_t *v)
+{
+       return __atomic_fetch_add(v, i, __ATOMIC_SEQ_CST);
+}
+
 #elif HAVE_SYNC_ADD_AND_FETCH == 1
 
 /* Use __sync built-ins (GCC >= 4.1), with explicit memory barriers. */
@@ -39,6 +44,11 @@ static inline int tst_atomic_add_return(int32_t i, tst_atomic_t *v)
        return __sync_add_and_fetch(v, i);
 }
 
+static inline tst_atomic_return_add(int32_t i, tst_atomic_t *v)
+{
+       return __sync_fetch_and_add(v, i);
+}


Then we can do tst_atomic_return_add(1, &level) instead of two different
atomic operations.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
