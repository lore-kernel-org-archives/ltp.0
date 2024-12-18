Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3B5E77187
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 19:00:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDC4D3ED62B
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 20:00:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67E573ED5E9
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:00:31 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5DEE6142215C
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:00:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 348381F396;
 Wed, 18 Dec 2024 19:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nXG1zihD//Oqljz+KcgUfcqF4JsPU7DcaV74pOpcswc=;
 b=ylnfImwjPR6NT1TXGS/GtwTQLE9qnG6918OgA701Jd7ZZ+8i2xb4AqaWtgtjdmLD+naLek
 uXSANANPEOKoBs7W+j+d0b5E+zeklN1+GU7+BVoM3UNCTb7NSDPEOhl1u+H5LbyPIdFlSc
 lPuGZ3xiiW2M+kKJG00IjHJmie/DRAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nXG1zihD//Oqljz+KcgUfcqF4JsPU7DcaV74pOpcswc=;
 b=7xdvZR3qm6Zc1nManAUSYjbKtqY7GTHWBiuyQQHnSw+fnAurv+IbXLxmAnaZ7juN0MYomz
 bzhvzsF71FSApLCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ylnfImwj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7xdvZR3q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nXG1zihD//Oqljz+KcgUfcqF4JsPU7DcaV74pOpcswc=;
 b=ylnfImwjPR6NT1TXGS/GtwTQLE9qnG6918OgA701Jd7ZZ+8i2xb4AqaWtgtjdmLD+naLek
 uXSANANPEOKoBs7W+j+d0b5E+zeklN1+GU7+BVoM3UNCTb7NSDPEOhl1u+H5LbyPIdFlSc
 lPuGZ3xiiW2M+kKJG00IjHJmie/DRAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nXG1zihD//Oqljz+KcgUfcqF4JsPU7DcaV74pOpcswc=;
 b=7xdvZR3qm6Zc1nManAUSYjbKtqY7GTHWBiuyQQHnSw+fnAurv+IbXLxmAnaZ7juN0MYomz
 bzhvzsF71FSApLCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 123F4132EA;
 Wed, 18 Dec 2024 19:00:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZAG5AM0bY2fAdQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 18 Dec 2024 19:00:29 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Dec 2024 20:00:20 +0100
Message-ID: <20241218190029.15015-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 348381F396
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_EQ_ENVFROM(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/9] Metadata parser fixes
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

This fixes a few metadata parser bugs, mostly array and structure
initializers. After this patchset the .save_restore entries should be
well formatted and we can make the shell version 1:1 with the C parsed
metadata.

The TODO is the filesystem parsing which uses named initializers (e.g.
.fs_type = "ext3") and the structure field names end up in the result
verbatim. Rather than that the parser should make it a JSON object
instead. I will fix that later on.

Cyril Hrubis (9):
  metadata: metaparse: Parse operators *, +, and | properly
  metadata: metaparse: Implement recursive include
  metadata: metaparse: Apply macros in arrays.
  metadata: data_storage: Add JSON null type
  metadata: data_storage: Add two array functions
  metadata: metaparse: Better array parsing.
  metadata: metaparse: Ignore ',' in array inside parenthesis
  metadata: metaparse: Add a few pre-defined macros
  metadata: parse.sh: Add -Itestcases/kernel/include

 metadata/data_storage.h |  53 ++++++++++-
 metadata/metaparse.c    | 195 ++++++++++++++++++++++++++++++++++------
 metadata/parse.sh       |   2 +-
 3 files changed, 221 insertions(+), 29 deletions(-)

-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
