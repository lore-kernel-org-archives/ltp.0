Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8A7CAC5B8
	for <ltp@archiver.kernel.org>; Thu,  2 Oct 2025 08:38:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A1293CE43D
	for <ltp@archiver.kernel.org>; Thu,  2 Oct 2025 10:38:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A85A3CE438
 for <ltp@lists.linux.it>; Thu,  2 Oct 2025 10:37:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DAD5F14000EE
 for <ltp@lists.linux.it>; Thu,  2 Oct 2025 10:37:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5659533846;
 Thu,  2 Oct 2025 08:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759394224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KNwNW8+GpdP3RkB0MEUHO+PnqhML7d+AlfzTXFBKkg8=;
 b=25uo8ZTH1Vv1zGjuCO56kaP1O/s3yRgRCnsiuhAbG8yff4+kXIVLqbSYp3gbA26ezhks3k
 U1MPr/1V8r1Lp2k6XjCBHBU9JgFHbYEVPwaYN0HiOY0i3JQ2Mmf1w5/FjCUm5/xgUK6tPZ
 77keuw0sU/W3Tn0IwqOVb1bKUga6BKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759394224;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KNwNW8+GpdP3RkB0MEUHO+PnqhML7d+AlfzTXFBKkg8=;
 b=5SJ61uoTMBoGzXQNiFA3T820IXhLLWbPTf99U9C9bOV4rBFdDIEydgVFBw/7MJvN8/7A14
 UuAsYDUDrqaaTYBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759394224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KNwNW8+GpdP3RkB0MEUHO+PnqhML7d+AlfzTXFBKkg8=;
 b=25uo8ZTH1Vv1zGjuCO56kaP1O/s3yRgRCnsiuhAbG8yff4+kXIVLqbSYp3gbA26ezhks3k
 U1MPr/1V8r1Lp2k6XjCBHBU9JgFHbYEVPwaYN0HiOY0i3JQ2Mmf1w5/FjCUm5/xgUK6tPZ
 77keuw0sU/W3Tn0IwqOVb1bKUga6BKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759394224;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KNwNW8+GpdP3RkB0MEUHO+PnqhML7d+AlfzTXFBKkg8=;
 b=5SJ61uoTMBoGzXQNiFA3T820IXhLLWbPTf99U9C9bOV4rBFdDIEydgVFBw/7MJvN8/7A14
 UuAsYDUDrqaaTYBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D79B213990;
 Thu,  2 Oct 2025 08:37:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2JM9MK853miCWQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 02 Oct 2025 08:37:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  2 Oct 2025 10:36:57 +0200
Message-ID: <20251002083701.315334-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] ima_{conditionals,measurements}.sh enhancements
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Petr Vorel (4):
  ima_{conditionals,measurements}.sh: Add temporary user
  ima_conditionals.sh: Split test by request
  ima_conditionals.sh: Use 'sg' without 'sudo'
  ima_{conditionals,measurements}.sh: Use 'su' instead of 'sudo'

 runtest/ima                                   |  5 +-
 .../integrity/ima/tests/ima_conditionals.sh   | 81 ++++++++++++-------
 .../integrity/ima/tests/ima_measurements.sh   | 15 ++--
 .../security/integrity/ima/tests/ima_setup.sh | 12 +++
 4 files changed, 71 insertions(+), 42 deletions(-)

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
