Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591B2C55174
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 09:50:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B94013E2D6D
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 11:50:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B89C63C713B
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 11:49:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D990E600A0E
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 11:49:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C49A1401B;
 Wed,  5 Aug 2026 09:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785923383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pklvDi+EqDkgOVcMzR95eaTlXh8zIKStWq4qe3wHTqg=;
 b=wEYLviDIJ12qvqrcgWGee6+eZF1Xl5Omb/IbWW46LC2BZCh811vSpHu78RSDDTD9Hsc7Yx
 1MrOYz/EAWkG0Z8jDLWsKqWl1eqWJpPWc9cqfYCjDipMRTDTO5lz7NtQyiFsmsjLFT50WC
 b1hF8r4hHUqahXrdShZ8gHFhL62Qhk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785923383;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pklvDi+EqDkgOVcMzR95eaTlXh8zIKStWq4qe3wHTqg=;
 b=8qR9DdcY2N90y4YXdBypdM3dfEjfGPyvRk+RYJI0eTkgt7Q/TayQwAq+80/VNpr0FvOGTM
 IHb1nF5hiLfkEgCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PUOnKl7I;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+HHOu6ym
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785923379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pklvDi+EqDkgOVcMzR95eaTlXh8zIKStWq4qe3wHTqg=;
 b=PUOnKl7IqhAixdx8IljXXGKkbb+skxfOnIjlIl9JQWQ3ViUHesis8H511EHVB/S7u8nPxo
 cnqsrZU3nGDD3qudkfdTZgvfremJkuy0lTCr1wGSTmr6a5yns8S1XiurbTDeSSezEMFbbd
 V+sBy97wc3nDySyvnsKRdEaYcFeIHgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785923379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pklvDi+EqDkgOVcMzR95eaTlXh8zIKStWq4qe3wHTqg=;
 b=+HHOu6ymf/IiJcMcvBCSCM3Tf1m8afRe3yTSkiZBlbXAsED1eRmeOj+nUVc/jBXlxadF0+
 Z6QJqRZciyBvlfDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4CC3779B6;
 Wed,  5 Aug 2026 09:49:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BZJRJzMHc2rvSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Aug 2026 09:49:39 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  5 Aug 2026 11:49:31 +0200
Message-ID: <20260805094935.448896-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C49A1401B
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[readthedocs.org:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] readthedocs: Update to Ubuntu 26.04, Sphinx 8.2.3
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

Hi Andrea, all,

FYI I tested this in readthedocs.org. Therefore I pushed this branch as
readthedocs-ubuntu-26.04 to our upstream git repo [1]. Build worked [2]:

	Collecting sphinx==8.2.3 (from -r doc/requirements.txt (line 3))
	  Downloading sphinx-8.2.3-py3-none-any.whl.metadata (7.0 kB)
	Collecting sphinx-rtd-theme==3.1.0 (from -r doc/requirements.txt (line 4))
	  Downloading sphinx_rtd_theme-3.1.0-py2.py3-none-any.whl.metadata (4.5 kB)
	Collecting linuxdoc==20260504 (from -r doc/requirements.txt (line 6))
	  Downloading linuxdoc-20260504-py3-none-any.whl.metadata (5.3 kB)
	Collecting sphinxcontrib-spelling==8.0.2 (from -r doc/requirements.txt (line 7))
	  Downloading sphinxcontrib_spelling-8.0.2-py3-none-any.whl.metadata (2.9 kB)
	...
	Successfully installed docutils-0.21.2 fspath-20230629
	linuxdoc-20260504 pyenchant-3.3.0 roman-numerals-py-4.1.0 six-1.17.0
	sphinx-8.2.3 sphinx-rtd-theme-3.1.0 sphinxcontrib-jquery-4.1
	sphinxcontrib-spelling-8.0.2

I of course restore back the master branch and going to delete branch
readthedocs-ubuntu-26.04 after you have look at it.

We could also delete dependabot/pip/doc/setuptools-83.0.0 (branch bot
created without even asking, huh!), because CVE-2026-59890 (score 6.1)
is handled by 3rd commit.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/tree/readthedocs-ubuntu-26.04
[2] https://app.readthedocs.org/projects/linux-test-project/builds/33923113/
[3] https://github.com/linux-test-project/ltp/tree/dependabot/pip/doc/setuptools-83.0.0

Petr Vorel (4):
  readthedocs: Update to Ubuntu 26.04, Sphinx 8.2.3
  doc: Reduce default sphinx verbosity with -q
  doc: Update linuxdoc, sphinxcontrib-spelling
  tst_kvercmp.h: Further links to manpage

 .readthedocs.yml      |  2 +-
 doc/Makefile          | 11 +++++++++--
 doc/requirements.txt  | 11 ++++-------
 include/tst_kvercmp.h | 13 +++++++------
 4 files changed, 21 insertions(+), 16 deletions(-)

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
