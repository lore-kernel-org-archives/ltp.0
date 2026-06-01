Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E61CCD5BD1
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 13:21:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFE013E56D5
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 15:21:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 093343E48BB
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 15:21:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9F99B600806
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 15:21:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A3E96BB46
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 13:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780320060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3FMNe+hDzUOvXFoTf7P+P3sPn+QZ0onM04dksNzcCmU=;
 b=diF5eHxRyMeQxnp/8RjnCekwwZVnBrgiF0+SPjJdf5UVwSwh5Npd13cKYVoAaW2VBRrPAS
 kqo/CdF6faujhCzA+AUCvMtZptH4fpW3RoL5orWgyiNZ/ufVf+KJ4x6d/MFrnOFaUCBrXW
 9KQkKY0WaWNsByNWQPcFrCwUYy2nW7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780320060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3FMNe+hDzUOvXFoTf7P+P3sPn+QZ0onM04dksNzcCmU=;
 b=13F1dbA5hsXMQTlZt09WG7r75PjfAIUCrEdon2RoPKhiaEo+O8LzP8es+muDgJbM/hKEXR
 OkUhw7vQeOgRopBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780320060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3FMNe+hDzUOvXFoTf7P+P3sPn+QZ0onM04dksNzcCmU=;
 b=diF5eHxRyMeQxnp/8RjnCekwwZVnBrgiF0+SPjJdf5UVwSwh5Npd13cKYVoAaW2VBRrPAS
 kqo/CdF6faujhCzA+AUCvMtZptH4fpW3RoL5orWgyiNZ/ufVf+KJ4x6d/MFrnOFaUCBrXW
 9KQkKY0WaWNsByNWQPcFrCwUYy2nW7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780320060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3FMNe+hDzUOvXFoTf7P+P3sPn+QZ0onM04dksNzcCmU=;
 b=13F1dbA5hsXMQTlZt09WG7r75PjfAIUCrEdon2RoPKhiaEo+O8LzP8es+muDgJbM/hKEXR
 OkUhw7vQeOgRopBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1165E779A7
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 13:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uufvAzyHHWp2OwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 13:21:00 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  1 Jun 2026 15:20:45 +0200
Message-ID: <20260601132055.58728-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/6] Configure XFRM encryption using direct netlink
 requests
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

Rewrite xfrm encryption setup using direct netlink calls instead of executing
the external ip utility. This allows the tests to detect whether the necessary
features are supported by the kernel and exit with TCONF if the support is
missing. Some kernels lack XFRM support even though kernel config claims
the necessary modules should be available.

Martin Doucha (6):
  lapi/xfrm.h: Include system XFRM header
  xfrm01: Use NETDEV_SET_STATE() to activate loopback
  xfrm01: Configure xfrm using direct netlink request
  lapi/udp.h: Add fallback constant for ESP-in-TCP
  xfrm02: Configure xfrm using direct netlink request
  xfrm03: Configure xfrm using direct netlink request

 include/lapi/udp.h                 |  4 ++
 include/lapi/xfrm.h                |  3 +
 testcases/network/sockets/xfrm01.c | 99 ++++++++++++++++++++----------
 testcases/network/sockets/xfrm02.c | 91 +++++++++++++++++++--------
 testcases/network/sockets/xfrm03.c | 91 ++++++++++++++++++---------
 5 files changed, 200 insertions(+), 88 deletions(-)

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
