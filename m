Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B61FC3DA49
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 09:57:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EDBF3D1C00
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 11:57:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62D243D0F94
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 11:56:01 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AEB5F600D05
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 11:56:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 75C2B1F892;
 Fri, 26 Jul 2024 09:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721987759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0UydkX4pyMb2tSD+ZEHBJ8Ob54vwVjrpk8+vE/AJySY=;
 b=AzzJFQni3fFUaSIYKFI3Pp2wQRfAQP+OVV1MqDpOKHyVkFwK0+fOME9R8TNA47dmc4l63+
 nNb1w4EOYUMavf19FAF/8m3RzOz8Gjo/r6AmI1ymuSyH6r9HtOqNge8YQij35mQ8w+ToUn
 +o6XqeSRlrtGcQzW3FW9/fG51Z5PaI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721987759;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0UydkX4pyMb2tSD+ZEHBJ8Ob54vwVjrpk8+vE/AJySY=;
 b=2wPtrgt5eZ+BTmL0c9RnzfDBjzaMl++3hUoiVzRz4F396CKXwiiFFh8ilPc7NwkTiqzDCr
 rHdkzcuRLJZsogAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721987759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0UydkX4pyMb2tSD+ZEHBJ8Ob54vwVjrpk8+vE/AJySY=;
 b=AzzJFQni3fFUaSIYKFI3Pp2wQRfAQP+OVV1MqDpOKHyVkFwK0+fOME9R8TNA47dmc4l63+
 nNb1w4EOYUMavf19FAF/8m3RzOz8Gjo/r6AmI1ymuSyH6r9HtOqNge8YQij35mQ8w+ToUn
 +o6XqeSRlrtGcQzW3FW9/fG51Z5PaI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721987759;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0UydkX4pyMb2tSD+ZEHBJ8Ob54vwVjrpk8+vE/AJySY=;
 b=2wPtrgt5eZ+BTmL0c9RnzfDBjzaMl++3hUoiVzRz4F396CKXwiiFFh8ilPc7NwkTiqzDCr
 rHdkzcuRLJZsogAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42A421396E;
 Fri, 26 Jul 2024 09:55:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Z8GUDq9yo2anTQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Jul 2024 09:55:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 26 Jul 2024 11:55:43 +0200
Message-ID: <20240726095546.1041726-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.60 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] lib: print kernel version
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

Hi,

a follow up of 5cabf2bea7 ("tst_tmpdir: Print used temporary dir and its
filesystem") which should help debugging of LTP failure reports.

Kind regards,
Petr

Petr Vorel (3):
  lib: Print tested kernel and arch
  tst_test.sh: lib: Print tested kernel and arch
  tst_test: Print used temporary dir and its filesystem

 lib/tst_test.c            | 6 ++++++
 testcases/lib/tst_test.sh | 2 ++
 2 files changed, 8 insertions(+)

-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
