Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF00CD5858
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 11:10:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0030D3C2CC1
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 12:10:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBFE23C2A49
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 12:10:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 71A0E1000607
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 12:10:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 42B3733D77
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767784230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v4rhUc2wgrjIVr0mV4gj/d1M0oZLyjyZ/IxSzVftSgw=;
 b=js1IMYIlt+jg78u3He+sBRFihWsflX++OBjxCFYMouaYNV4LQLX05HS8BimhmVzkkhLhLI
 cPK8bInMidU2lrnxD/Ps8Ie+mfJNvY297/PUJ5oz7/NTdpkKCO7yBmDepu6aDwDc8fRtEf
 ON+urRRrfr4ay3Qd048atiB7gEHSyts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767784230;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v4rhUc2wgrjIVr0mV4gj/d1M0oZLyjyZ/IxSzVftSgw=;
 b=nQ5aXq1gawF68p3UZvA3LT9ZFg7Bwt7AiJBOp/ZLDhGBF16I/j107m1MHMXV7lXItB37y9
 gZcqig4WSXhj3tDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767784230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v4rhUc2wgrjIVr0mV4gj/d1M0oZLyjyZ/IxSzVftSgw=;
 b=js1IMYIlt+jg78u3He+sBRFihWsflX++OBjxCFYMouaYNV4LQLX05HS8BimhmVzkkhLhLI
 cPK8bInMidU2lrnxD/Ps8Ie+mfJNvY297/PUJ5oz7/NTdpkKCO7yBmDepu6aDwDc8fRtEf
 ON+urRRrfr4ay3Qd048atiB7gEHSyts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767784230;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v4rhUc2wgrjIVr0mV4gj/d1M0oZLyjyZ/IxSzVftSgw=;
 b=nQ5aXq1gawF68p3UZvA3LT9ZFg7Bwt7AiJBOp/ZLDhGBF16I/j107m1MHMXV7lXItB37y9
 gZcqig4WSXhj3tDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3327A3EA63
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 11:10:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id y2hTCyY/XmmKfwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 07 Jan 2026 11:10:30 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  7 Jan 2026 12:11:21 +0100
Message-ID: <20260107111133.27041-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.70 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_SHORT(-0.10)[-0.483]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Add ground rules doc page
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

This is v3 of the patchset the changes are:

- formatting changes (mostly links) from Petr
- grammar fixes from Petr
- added a few more paragraphs by Li

I did various changes and adjustenments to the suggestions. Please make
sure to check the text before acking it.

Cyril Hrubis (2):
  doc: Document process_state
  doc: Add ground rules page

 doc/conf.py                     |   1 +
 doc/developers/api_c_tests.rst  |   5 +
 doc/developers/ground_rules.rst | 167 ++++++++++++++++++++++++++++++++
 doc/index.rst                   |   1 +
 include/tst_process_state.h     |  47 +++++----
 5 files changed, 201 insertions(+), 20 deletions(-)
 create mode 100644 doc/developers/ground_rules.rst

-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
