Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F93C982D9
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 10:59:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1FE63E74F3
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 12:59:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B9093CE49F
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 12:59:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 23A1F6008F0
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 12:59:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 426CB1FE3B;
 Fri, 18 Sep 2026 10:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789729153;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=brcJN9n67tTIgwGvwsxYhz95+9LPeDTibtcIIXwVpy0=;
 b=mfzrnxXpz92zy9JP5NIKdk74gZgvJj4bxWZTkEmTmWPBvqcSXlfbW/katECOYy4dyCu4I6
 ms0686f6RzcL1e1hNVoERQIhKj1Nf0EjgC7ks63JJqGo+qUeDePI8x8BgkmuxFtbsWb2wV
 ivDZqmxFNzULElxtHjFW0WnCL8VP29k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789729153;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=brcJN9n67tTIgwGvwsxYhz95+9LPeDTibtcIIXwVpy0=;
 b=eDGb4JhWEzu+3jV5Nejplrmjx8TvotHyGoJNazyi8Mpkze7BG7ub+sz+1OCBuXKs7nDoqB
 mQCOZNn0g53l3LCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789729149;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=brcJN9n67tTIgwGvwsxYhz95+9LPeDTibtcIIXwVpy0=;
 b=BFiQWol2o17QBrZDJVAZKVScDJzq4mVe1IHPXM5U8NphVi2OEq6Haujp9bOD+JA8wf3wTx
 n1yA5uKnz8xFi2hMwM69VSSuSXaeVqH8McVZuelblhQV8NFtr+ZeZllRK2AYScoVHcCa27
 H294jpKk92+k2X8I2tvGRsJhYqbu8qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789729149;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=brcJN9n67tTIgwGvwsxYhz95+9LPeDTibtcIIXwVpy0=;
 b=QhElkVUBJD2/tU4aMEEABAFuaUFxW+18LeMQXMZMaC56wXXOeze6vu9zx7ZX7sjklbfLsu
 TlolDwUGfwnvPVBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03A2C1348F;
 Fri, 18 Sep 2026 10:59:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UrkvM3wZrWo1HAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 18 Sep 2026 10:59:08 +0000
Date: Fri, 18 Sep 2026 12:59:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260918105907.GA1906114@pevik>
References: <20260916140402.1797325-1-pvorel@suse.cz>
 <20260916140402.1797325-10-pvorel@suse.cz>
 <aququIx31-BBNlnq@linux.dev> <aqvUDzAjzoEibVXu@yuki.lan>
 <aqzFnANKxWCFLRe5@linux.dev> <aq0JVHj3Y0k2_aJ9@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aq0JVHj3Y0k2_aJ9@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li Cyril,

> > > 	if (rc == 0) {
> > > 		tst_res(TFAIL, "empty security label not NUL terminated");
> > > 		return;
> > > 	}

> > > 	if (rc > sizeof(buf)) {
> > > 		tst_res(TFAIL, "buffer too small");
> > > 		return;
> > > 	}

> > My only concern is whether the TFAIL is correct when truncation
> > occurs. Shouldn't the test allocate a larger buffer instead?

> Well we can always allocate large enough buffer in the test setup.

Do you agree with these changes?
BTW it'd be nice to get this merged before git freeze, but that's today night.

Kind regards,
Petr

+++ testcases/kernel/syscalls/keyctl/keyctl15.c
@@ -12,15 +12,16 @@
  *
  * [Algorithm]
  *
- * - read the label of a valid key into a large buffer, verify the return
- *   value is at least 1 and an empty string is returned when no label is set
+ * - read the label of a valid key into a large buffer
+ * - verify the return value is at least 1 and an empty string is returned when
+ *   no label is set
  */
 
 #include "keyctl_common.h"
 
 #define KEY_DESC	"ltpkeyctl15"
 #define PAYLOAD		"payload"
-#define BUF_SIZE	128
+#define BUF_SIZE	256
 
 static key_serial_t key;
 static char buf[BUF_SIZE];
@@ -42,20 +43,17 @@ static void run(void)
 
 	rc = SAFE_KEYCTL(KEYCTL_GET_SECURITY, key, (unsigned long)buf, sizeof(buf), 0);
 
-	if (buf[0] != '\0')
-		tst_res(TFAIL, "empty label is not NUL terminated");
-
-	if (rc < 1) {
-		tst_res(TFAIL, "returned %d, expected >= 1", rc);
+	if (rc == 0) {
+		tst_res(TFAIL, "empty security label not NUL terminated");
 		return;
 	}
 
-	if (rc == 1) {
-		tst_res(TPASS, "no label set, empty string returned");
+	if (buf[rc-1] != '\0') {
+		tst_res(TFAIL, "security label not NUL terminated");
 		return;
 	}
 
-	tst_res(TPASS, "security label returned, full length %d", rc);
+	tst_res(TPASS, "Security label was NUL terminated");
 }
 
 static struct tst_test test = {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
