Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411CCC02194
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 14:35:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 993BE3C9297
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 15:35:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79F1F3C12C2
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:34:47 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9F395661604
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:34:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 381001F381;
 Thu,  6 Feb 2025 14:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738852486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n0+uryVO8zW1qfY4uZ6p+bqg1xkI8bdb7bW4DrcjGgI=;
 b=i4ujZfg+4LoUOu2PDrWK6pZ8c4DVPC+H8myk4zZ3xFjmaEXRvIFZM9U42rdGXnaUy/KEDe
 EYP6JjBuyqcrpjNvVRLYB+lmRUK3MLDZzmbiSWWomNCXM2+IH6VCjf9fZK7Xfq/DPTawJi
 laKQUyuqyF/SvgV+H+1Og2vFQRq/1nU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738852486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n0+uryVO8zW1qfY4uZ6p+bqg1xkI8bdb7bW4DrcjGgI=;
 b=ztk+51uHUj3MKPC712dGsLutVl8gyKCqnKf6lhhCH7sMIVtY+ZydES5voPzKRLNOlMZ5U+
 /HKP8WMDbc3zepCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738852486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n0+uryVO8zW1qfY4uZ6p+bqg1xkI8bdb7bW4DrcjGgI=;
 b=i4ujZfg+4LoUOu2PDrWK6pZ8c4DVPC+H8myk4zZ3xFjmaEXRvIFZM9U42rdGXnaUy/KEDe
 EYP6JjBuyqcrpjNvVRLYB+lmRUK3MLDZzmbiSWWomNCXM2+IH6VCjf9fZK7Xfq/DPTawJi
 laKQUyuqyF/SvgV+H+1Og2vFQRq/1nU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738852486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n0+uryVO8zW1qfY4uZ6p+bqg1xkI8bdb7bW4DrcjGgI=;
 b=ztk+51uHUj3MKPC712dGsLutVl8gyKCqnKf6lhhCH7sMIVtY+ZydES5voPzKRLNOlMZ5U+
 /HKP8WMDbc3zepCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D33CD13694;
 Thu,  6 Feb 2025 14:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id INfYL4XIpGfvJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Feb 2025 14:34:45 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  6 Feb 2025 15:34:17 +0100
Message-ID: <20250206143421.1571918-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250206143421.1571918-1-pvorel@suse.cz>
References: <20250206143421.1571918-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.78 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-2.98)[99.89%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/7] doc/Makefile: Improve make targets
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

* add _static/syscalls.rst into clean target)
* add targets:
  - .venv
  - distclean target (for .venv)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/Makefile | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/doc/Makefile b/doc/Makefile
index e536e95db6..0f67721ef5 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -1,8 +1,20 @@
-all:
-	sphinx-build -b html . html
+PYTHON := python3
+
+# install sphinx only if needed
+INSTALL_SPHINX := $(shell $(PYTHON) -c "import sphinx" 2>/dev/null && echo "true" || echo "pip install sphinx")
+
+.venv:
+	$(PYTHON) -m virtualenv .venv
+	. .venv/bin/activate && pip install -r requirements.txt && $(INSTALL_SPHINX)
+
+all: .venv
+	. .venv/bin/activate && sphinx-build -b html . html
 
 spelling:
-	sphinx-build -b spelling -d build/doctree . build/spelling
+	. .venv/bin/activate && sphinx-build -b spelling -d build/doctree . build/spelling
 
 clean:
-	rm -rf html/
+	rm -rf html/ _static/syscalls.rst
+
+distclean: clean
+	rm -rf .venv/
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
