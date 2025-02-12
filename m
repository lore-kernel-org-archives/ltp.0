Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E607CC02198
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 13:16:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE43E3C9A39
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 14:16:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25A7C3C66BB
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 14:16:15 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7BC4221F1A6
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 14:16:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 804811FE12
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 13:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739366173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vOVRSbGEWSqT14eGx7eXO2elmBPQUb7f250THdkXi4c=;
 b=uc/Ig1wa6WitsBVQiU/bpCDbiqXgQMh5fIYr7grChcz6BA5CHLu7kq3iIV3nYzc5jkv+pJ
 EVPk1VuCFJiq+NTBeESlUVoOMzVgdiqAin9CpYRdkjKB8w5XjQMarc4mlX2QCxb/LSd+bJ
 TWM6Ywkun/8eRsB0yJbmP/hWyHkrP98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739366173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vOVRSbGEWSqT14eGx7eXO2elmBPQUb7f250THdkXi4c=;
 b=q3Ol9SjnMZ4+CWAs1vv8OT2C9u+qu4dNGSUqLyGvRsuFuYNJ8vgCoYJi4Cbx1pOayhYZYH
 gVZBR+4Wd/HopQDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739366173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vOVRSbGEWSqT14eGx7eXO2elmBPQUb7f250THdkXi4c=;
 b=uc/Ig1wa6WitsBVQiU/bpCDbiqXgQMh5fIYr7grChcz6BA5CHLu7kq3iIV3nYzc5jkv+pJ
 EVPk1VuCFJiq+NTBeESlUVoOMzVgdiqAin9CpYRdkjKB8w5XjQMarc4mlX2QCxb/LSd+bJ
 TWM6Ywkun/8eRsB0yJbmP/hWyHkrP98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739366173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vOVRSbGEWSqT14eGx7eXO2elmBPQUb7f250THdkXi4c=;
 b=q3Ol9SjnMZ4+CWAs1vv8OT2C9u+qu4dNGSUqLyGvRsuFuYNJ8vgCoYJi4Cbx1pOayhYZYH
 gVZBR+4Wd/HopQDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7124B13AEF
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 13:16:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AxPDGh2frGcQGAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 13:16:13 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 12 Feb 2025 14:16:16 +0100
Message-ID: <20250212131618.6810-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.3
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Add shell test metadata parser
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

As promised this adds metadata parser for the shell testcases. In the
end I wrote it in about 100 lines of C because the ekvivalent awk script
would be too complicated.

Cyril Hrubis (2):
  metaparse: Add shell test parser
  metaparse: data_storage: Fix warning

 metadata/.gitignore     |   1 +
 metadata/Makefile       |   4 +-
 metadata/data_storage.h |   2 +-
 metadata/metaparse-sh.c | 127 ++++++++++++++++++++++++++++++++++++++++
 metadata/parse.sh       |  13 ++++
 5 files changed, 144 insertions(+), 3 deletions(-)
 create mode 100644 metadata/metaparse-sh.c

-- 
2.45.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
