Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A9606A31A
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bRaykwTA;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NlCNHB14;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bRaykwTA;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NlCNHB14
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8838B3EA610
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 12:37:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 075753E6145
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:37:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4D25A100023D
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:37:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BA6EE1F388;
 Tue, 20 Oct 2026 10:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792492650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/JwZVQPMyXyevCH/q9Mp7o8Rw0TE7tbp6Q71dweJ0Fk=;
 b=bRaykwTA+3aQmuvhh2VfAXLfJKRvUb46k11RejLIocEKcHyXRK78yK56H9smO+v1lqOOMQ
 AGfpbZHVPtueqDWu6XBLpfaOR9UUrzFlo3uctAuZLXqKrBJ9qszPXbpbPAvg+bslWIcWyt
 uS2LECbeOU+JJ15cnjG4qLx8Tf825eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792492650;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/JwZVQPMyXyevCH/q9Mp7o8Rw0TE7tbp6Q71dweJ0Fk=;
 b=NlCNHB149dac1AxgkC552H9Cmqnz3BBS6RzER3PrBLphO9aJx+K3adPTqzE3UAY221LpAh
 IKsKffddfI4CJKCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792492650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/JwZVQPMyXyevCH/q9Mp7o8Rw0TE7tbp6Q71dweJ0Fk=;
 b=bRaykwTA+3aQmuvhh2VfAXLfJKRvUb46k11RejLIocEKcHyXRK78yK56H9smO+v1lqOOMQ
 AGfpbZHVPtueqDWu6XBLpfaOR9UUrzFlo3uctAuZLXqKrBJ9qszPXbpbPAvg+bslWIcWyt
 uS2LECbeOU+JJ15cnjG4qLx8Tf825eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792492650;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/JwZVQPMyXyevCH/q9Mp7o8Rw0TE7tbp6Q71dweJ0Fk=;
 b=NlCNHB149dac1AxgkC552H9Cmqnz3BBS6RzER3PrBLphO9aJx+K3adPTqzE3UAY221LpAh
 IKsKffddfI4CJKCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81B6C136CC;
 Tue, 20 Oct 2026 10:37:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wwr3FWpE12rQSAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Oct 2026 10:37:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 12:37:28 +0200
Message-Id: <20261020-fix_process_vm_writev_permissions-v3-0-1e92d7a29aef@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGhE12oC/5WOQQ6CMBREr2K6tqatUMCV9zCmgfIrNYGSfqgaw
 t1tceOW5SQz781CELwFJJfDQjwEi9YNMZyPB6K7engAtW3MRDAhOeMZNfatRu80IKrQq5e3EwQ
 1gu8tpjFSaXQt86psK9OQyBk9xNHmuN1/GefmCXpK4NToLE7Of7YTgafeHl/glFNZGwMg2rrMq
 yvOCCftepJ0QewGigjkRcGZKTLJpP4Druv6BdWKgx40AQAA
X-Change-ID: 20261014-fix_process_vm_writev_permissions-6fca6598d9fb
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792492650; l=1352;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=a6BvyStO06s9fhUlHtz1MDMKjesNTBygt4mj3jyRX0U=;
 b=MZ7tSKZ6dBvPAv6RKSOUuUifzsj34NkQngXQv6pnBID6CkpKt9vEaug6/daNLIzBmO0Q0q0P+
 rQXPJciGoPGATUAjuc4BFpYHTFqujfwBS4uiseIn/m9HOtGA+zMSdTS
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Fix cma testing suite permissions
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The cma testing suite started to fail on modern systems enabling YAMA.
Unfortunately, using CAP_PTRACE capability for users is not enough to
avoid an EPERM. For this reason, it's better to require root and fix the
whole suite in one shot.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- add CAP_SYS_PTRACE fallback in lapi/capability.h
- Link to v2: https://lore.kernel.org/20261014-fix_process_vm_writev_permissions-v2-1-17710f74606c@suse.com

Changes in v2:
- consider mode 1, 2, 3 and user
- Link to v1: https://lore.kernel.org/20261014-fix_process_vm_writev_permissions-v1-1-6affee2da859@suse.com

---
Andrea Cervesato (2):
      lapi/capability.h: Add CAP_SYS_PTRACE fallback
      syscalls/cma: Handle Yama ptrace_scope in tests

 include/lapi/capability.h                          |  4 +++
 testcases/kernel/syscalls/cma/cma.h                | 38 ++++++++++++++++++++++
 testcases/kernel/syscalls/cma/process_vm_readv02.c |  5 +++
 testcases/kernel/syscalls/cma/process_vm_readv03.c |  5 +++
 .../kernel/syscalls/cma/process_vm_writev02.c      |  5 +++
 5 files changed, 57 insertions(+)
---
base-commit: 1aae0e4d9d1e2e7818fda773b372cee8fb856de7
change-id: 20261014-fix_process_vm_writev_permissions-6fca6598d9fb

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
