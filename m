Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66E0C7115C
	for <ltp@archiver.kernel.org>; Fri, 20 Jun 2025 15:43:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E3173CC8AC
	for <ltp@archiver.kernel.org>; Fri, 20 Jun 2025 17:43:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1ED5F3CC6F3
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 17:43:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2ECBB60005C
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 17:43:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2B4F62124C;
 Fri, 20 Jun 2025 15:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750434189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kNiiXpdLlcMigUO8G3i5MD8tBNUeRbChKm3qknwd0PQ=;
 b=GFgpaIT50CCStfaNp64sLV1JBkfrogYbV63g45mvv+Wc0G9Qrcc6T4x8NiLPk4lIaCT007
 88yz0TjkuHoEkhe2n7ctF2EVyBmCrjHh2YhHFj/LCmOwOrTsEVCiR70CrYeHQ14g9NSPwL
 fBrWaeH15wJNiB+DaQjsIlmANfgqhDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750434189;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kNiiXpdLlcMigUO8G3i5MD8tBNUeRbChKm3qknwd0PQ=;
 b=1GS9VoTTpV+u+8eLIpngBxdBHNKM79Zt1v6lwO2u8qwUtEwDrictYa6edq3wPMq6Hb1vlO
 7jXJCIrCzWcVofBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750434189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kNiiXpdLlcMigUO8G3i5MD8tBNUeRbChKm3qknwd0PQ=;
 b=GFgpaIT50CCStfaNp64sLV1JBkfrogYbV63g45mvv+Wc0G9Qrcc6T4x8NiLPk4lIaCT007
 88yz0TjkuHoEkhe2n7ctF2EVyBmCrjHh2YhHFj/LCmOwOrTsEVCiR70CrYeHQ14g9NSPwL
 fBrWaeH15wJNiB+DaQjsIlmANfgqhDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750434189;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kNiiXpdLlcMigUO8G3i5MD8tBNUeRbChKm3qknwd0PQ=;
 b=1GS9VoTTpV+u+8eLIpngBxdBHNKM79Zt1v6lwO2u8qwUtEwDrictYa6edq3wPMq6Hb1vlO
 7jXJCIrCzWcVofBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1695F13736;
 Fri, 20 Jun 2025 15:43:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZwRIBI2BVWjHYwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 20 Jun 2025 15:43:09 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 20 Jun 2025 17:43:44 +0200
Message-ID: <20250620154346.19864-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Two more metadata parser fixes
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

This series fixes a metadata parser for the ".filesystems" entry of the
tst_test structure. First patch fixes the data storage to JSON
serialization and second patch changes the parser to convert structure
intialization with only designated initializers into a hash (object)
rather than an arrray.

@Andrea I suppose that the documentation generator needs a fix after
        this is applied.

Cyril Hrubis (2):
  metadata: data_storage: Fix hash to json object serialization
  metaparse: Map arrays with designated initializers to JSON objects

 metadata/data_storage.h |  28 +++++++--
 metadata/metaparse.c    | 134 +++++++++++++++++++++++++++++++++-------
 2 files changed, 135 insertions(+), 27 deletions(-)

-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
