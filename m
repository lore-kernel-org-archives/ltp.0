Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CEFC369A3
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 14:24:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A80E83CAF77
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 16:24:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5265E3C9E40
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 16:24:01 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B18272009A2
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 16:24:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7CBC61F388
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744035839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/lCcz/n97jPYC6gJ8rxCRHCN6ddwFpolOlyT9Bg5FKs=;
 b=hZuHdq3nY3/Tp1RRYkatU0qNF0J5mH8guIpvEtreu+WQe/K0VLt+VCeilOXKwtxLeFTY9o
 SKvbd5VhrWwiOF/0V6rdzPiQiNbbp74ICObY5iZHr+eLghfgs/mAZVq42C+JuQjPXmZRdI
 FJMnR1749oWwfRwGd4wK8Qr6NnjgKjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744035839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/lCcz/n97jPYC6gJ8rxCRHCN6ddwFpolOlyT9Bg5FKs=;
 b=eEkESlnzsLvg+SYyWH6baf1yk6dg1DS/UnxX3KMd3OCcEV7qY+4DnG775lOg1Pf6CZWu1q
 k+Yo/Cc0okSyV7DQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hZuHdq3n;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eEkESlnz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744035839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/lCcz/n97jPYC6gJ8rxCRHCN6ddwFpolOlyT9Bg5FKs=;
 b=hZuHdq3nY3/Tp1RRYkatU0qNF0J5mH8guIpvEtreu+WQe/K0VLt+VCeilOXKwtxLeFTY9o
 SKvbd5VhrWwiOF/0V6rdzPiQiNbbp74ICObY5iZHr+eLghfgs/mAZVq42C+JuQjPXmZRdI
 FJMnR1749oWwfRwGd4wK8Qr6NnjgKjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744035839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/lCcz/n97jPYC6gJ8rxCRHCN6ddwFpolOlyT9Bg5FKs=;
 b=eEkESlnzsLvg+SYyWH6baf1yk6dg1DS/UnxX3KMd3OCcEV7qY+4DnG775lOg1Pf6CZWu1q
 k+Yo/Cc0okSyV7DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7452D13691
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id V6AqHP/f82e5KAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 07 Apr 2025 14:23:59 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  7 Apr 2025 16:23:44 +0200
Message-ID: <20250407142351.25900-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7CBC61F388
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/5] KVM test for Intel VMX vAPIC
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

We already have a CVE test for AMD SVM which checks that access to virtual
APIC in nested VMs is correctly redirected to the backing page allocated
by the parent VM. Add a similar test for Intel VMX.

Martin Doucha (5):
  kvm_vmx01: Fix 32bit compiler warnings
  KVM: Add kvm_vmx01 to the runtest file
  KVM: Simplify reading VMX control field masks
  KVM: Add constants for Intel VMX vAPIC control
  Add test for Intel VMX virtualized APIC

 runtest/kvm                                |   2 +
 testcases/kernel/kvm/.gitignore            |   1 +
 testcases/kernel/kvm/include/kvm_x86_vmx.h |  22 ++-
 testcases/kernel/kvm/kvm_vmx01.c           |  15 +-
 testcases/kernel/kvm/kvm_vmx02.c           | 193 +++++++++++++++++++++
 testcases/kernel/kvm/lib_x86.c             |  48 +++--
 6 files changed, 260 insertions(+), 21 deletions(-)
 create mode 100644 testcases/kernel/kvm/kvm_vmx02.c

-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
