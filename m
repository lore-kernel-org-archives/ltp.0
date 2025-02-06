Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BDFC02198
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 15:35:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D4653C9288
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 16:35:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3699F3C04A5
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 16:34:43 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A1951601541
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 16:34:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8C12E1F397;
 Thu,  6 Feb 2025 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738856081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JF0Lo0bhx1HbfWSJT7PTpMFbRsfX/BY1Ae97IJAyLjI=;
 b=BO1D71QmFDTH/jkFwFsjBnetI9pjojUzF1st/HeJS76TSHR75wCQhLdmNQLW8w60RA4i50
 Ha8U+/WNsfwMyaXfJf5NieicEFUnWiCjRNvt4ByoSx2ApJujDbdVR3bvfTJ0dxiSmDdQsZ
 d3JJsweYKtRB0Vwu/KaWN62pLZ9CwZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738856081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JF0Lo0bhx1HbfWSJT7PTpMFbRsfX/BY1Ae97IJAyLjI=;
 b=1c/evzzF6KlnGdp4ky/G1Y/w0C6Wn7DgKel39ItbENHVh7wblYXtuN3yOPfwjG1Spr/j5R
 4AX2jmQpc2GvxJCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738856081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JF0Lo0bhx1HbfWSJT7PTpMFbRsfX/BY1Ae97IJAyLjI=;
 b=BO1D71QmFDTH/jkFwFsjBnetI9pjojUzF1st/HeJS76TSHR75wCQhLdmNQLW8w60RA4i50
 Ha8U+/WNsfwMyaXfJf5NieicEFUnWiCjRNvt4ByoSx2ApJujDbdVR3bvfTJ0dxiSmDdQsZ
 d3JJsweYKtRB0Vwu/KaWN62pLZ9CwZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738856081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JF0Lo0bhx1HbfWSJT7PTpMFbRsfX/BY1Ae97IJAyLjI=;
 b=1c/evzzF6KlnGdp4ky/G1Y/w0C6Wn7DgKel39ItbENHVh7wblYXtuN3yOPfwjG1Spr/j5R
 4AX2jmQpc2GvxJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6029C13697;
 Thu,  6 Feb 2025 15:34:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KKFhFpHWpGcUOwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Feb 2025 15:34:41 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  6 Feb 2025 16:34:33 +0100
Message-ID: <20250206153435.1602181-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250206153435.1602181-1-pvorel@suse.cz>
References: <20250206153435.1602181-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/5] doc: documentation.rst: Update build
 instructions
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

Now we depend on autotools to compile metadata/ dependency.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/developers/documentation.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/developers/documentation.rst b/doc/developers/documentation.rst
index 0cd3173fa7..27c847e125 100644
--- a/doc/developers/documentation.rst
+++ b/doc/developers/documentation.rst
@@ -11,13 +11,13 @@ and it's built on top of `Sphinx <https://www.sphinx-doc.org/en/master/>`_.
 Building documentation
 ~~~~~~~~~~~~~~~~~~~~~~
 
-First of all, to build the documentation we must be sure that all dependencies
-have been installed (please check :master:`doc/requirements.txt` file). Sometimes the
-Linux distros are providing them, but the best way is to use ``virtualenv``
-command as following:
+Before building, make sure you have python3 ``virtualenv`` module installed.
 
 .. code-block:: bash
 
+    # run configure to be able to compile doc dependencies in metadata/
+    make autotools
+    ./configure
     cd doc
 
     # prepare virtual environment
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
