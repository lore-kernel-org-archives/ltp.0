Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A53C02180
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 11:16:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B7B83C7B7C
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 12:16:34 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 77AFA3C7A70
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 12:16:17 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 882B2101AF1A
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 12:16:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7E6D82128E
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 11:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736939775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qwk0fZKTBd5lqAtPTaw2qBXQVMkTZRhjCIx5uK6uxVQ=;
 b=cnwhE7q2+NVqHhduGgkI0UJ9Fyi3qouhayalGjVzij8IEyvKt5vqnu/htgl/VN2gh6lmLy
 Z5OzLCaMWO05+xRgN3226MzhPuceziSpWXDpKj28Tm9UULHGWZnxr42W+UHN+pHfEePJWQ
 gjZlIicOCaterxBIINQZyn36XMrnGGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736939775;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qwk0fZKTBd5lqAtPTaw2qBXQVMkTZRhjCIx5uK6uxVQ=;
 b=6atDttiQgqj9hAp0O03n+qsFyInsC/0SE/XtG9knS4ZfNBuiRnEAHLWS200RLHz3lh2r/4
 1+eCUndN12UGwGAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736939775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qwk0fZKTBd5lqAtPTaw2qBXQVMkTZRhjCIx5uK6uxVQ=;
 b=cnwhE7q2+NVqHhduGgkI0UJ9Fyi3qouhayalGjVzij8IEyvKt5vqnu/htgl/VN2gh6lmLy
 Z5OzLCaMWO05+xRgN3226MzhPuceziSpWXDpKj28Tm9UULHGWZnxr42W+UHN+pHfEePJWQ
 gjZlIicOCaterxBIINQZyn36XMrnGGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736939775;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qwk0fZKTBd5lqAtPTaw2qBXQVMkTZRhjCIx5uK6uxVQ=;
 b=6atDttiQgqj9hAp0O03n+qsFyInsC/0SE/XtG9knS4ZfNBuiRnEAHLWS200RLHz3lh2r/4
 1+eCUndN12UGwGAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6663813A6F
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 11:16:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sFPoEv+Yh2f6NgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 11:16:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 15 Jan 2025 12:16:11 +0100
MIME-Version: 1.0
Message-Id: <20250115-maintainers_check-v1-1-1d2546c26d69@suse.com>
X-B4-Tracking: v=1; b=H4sIAPqYh2cC/x2MTQqAIBQGryJvnZCR/V0lIsq+6hFZaEQQ3j1pM
 YtZzLzk4RieGvGSw82eDxtFJYLMOtgFkqfolKWZTpXSch/YXhE435sVZpN1NRoUeYWpVBS702H
 m53+2XQgfRk++PGMAAAA=
X-Change-ID: 20250115-maintainers_check-98bce648ed71
To: ltp@lists.linux.it
Cc: 
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736939775; l=1582;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=pRD+16PG1JVx+Eo3ALBQVhT2NPpQIvBx7X32jj8S0jY=;
 b=zdZL5efA5Sp3VpjuU74XqrATZ1Rq/h7fN7Mcsisa7O07YhdHvlsrCdGDZKIbz8WMLoLGA3EA6
 U3viIOBNwgEBymR4pxv2ZRePxYc4vT8B8p3gG0Uo2E9qXourJ1BjDCH
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email, checkpatch.pl:url]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Ignore files paths change during make check
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

checkpatch.pl script doesn't need to be run with FILE_PATH_CHANGES,
since it's used to sync with MAINTAINERS file, not provided by LTP.
Its usage may lead to a false positive during `make check` command.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/mk/env_post.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
index 0bbbc37052fbb2fc221626889b75783bc89b4c42..4dd3f1e2d7cb8aef68b42631ee2d3855ef865bb7 100644
--- a/include/mk/env_post.mk
+++ b/include/mk/env_post.mk
@@ -90,7 +90,7 @@ CHECK_TARGETS			?= $(addprefix check-,$(notdir $(patsubst %.c,%,$(sort $(wildcar
 CHECK_TARGETS			:= $(filter-out $(addprefix check-, $(FILTER_OUT_MAKE_TARGETS)), $(CHECK_TARGETS))
 CHECK_HEADER_TARGETS		?= $(addprefix check-,$(notdir $(sort $(wildcard $(abs_srcdir)/*.h))))
 CHECK				?= $(abs_top_srcdir)/tools/sparse/sparse-ltp
-CHECK_NOFLAGS			?= $(abs_top_srcdir)/scripts/checkpatch.pl -f --no-tree --terse --no-summary --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING
+CHECK_NOFLAGS			?= $(abs_top_srcdir)/scripts/checkpatch.pl -f --no-tree --terse --no-summary --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING,FILE_PATH_CHANGES
 SHELL_CHECK			?= $(abs_top_srcdir)/scripts/checkbashisms.pl --force --extra
 SHELL_CHECK_TARGETS		?= $(addprefix check-,$(notdir $(sort $(wildcard $(abs_srcdir)/*.sh))))
 

---
base-commit: 0e5727a412c2447b5dc1c45479b75e0f014d6f3d
change-id: 20250115-maintainers_check-98bce648ed71

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
