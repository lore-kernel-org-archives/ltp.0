Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D44CA9ED5
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 07:24:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E2CA3E6A6E
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 09:24:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E25EC3E2D2A
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 09:24:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E68AD140033C
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 09:24:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8F42F21E71;
 Mon, 12 Oct 2026 07:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791789864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KvDXsXcKHAK+bK6tzBHrgo+hh+4AcgJGxk8/ZFGwyeM=;
 b=xkrnt9IXcECaO4y6h3Zyg6LmrP9imPgY3Ra5arB7fymPSSGJa7gk3FDIc5hM6AGa5cBztm
 Z3o5CxRbD/u2zBbrjXID4z50Pm8VaVpASTAsxcADOXD7PP5FO+iVzkk4U6FDjuJTLeFusq
 AwGEaFAcWx9A0G4rW+QKFe42XN5jZM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791789864;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KvDXsXcKHAK+bK6tzBHrgo+hh+4AcgJGxk8/ZFGwyeM=;
 b=uXipIBqg4lcNYSUBxVOpW4KcT+Ke0U3ZOLn5WGUHb+zYva5kP1FH6JZjunSP8k5zLAfAyF
 75gNAqY7unsuf5Cg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xkrnt9IX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uXipIBqg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791789864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KvDXsXcKHAK+bK6tzBHrgo+hh+4AcgJGxk8/ZFGwyeM=;
 b=xkrnt9IXcECaO4y6h3Zyg6LmrP9imPgY3Ra5arB7fymPSSGJa7gk3FDIc5hM6AGa5cBztm
 Z3o5CxRbD/u2zBbrjXID4z50Pm8VaVpASTAsxcADOXD7PP5FO+iVzkk4U6FDjuJTLeFusq
 AwGEaFAcWx9A0G4rW+QKFe42XN5jZM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791789864;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KvDXsXcKHAK+bK6tzBHrgo+hh+4AcgJGxk8/ZFGwyeM=;
 b=uXipIBqg4lcNYSUBxVOpW4KcT+Ke0U3ZOLn5WGUHb+zYva5kP1FH6JZjunSP8k5zLAfAyF
 75gNAqY7unsuf5Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 968D013314;
 Mon, 12 Oct 2026 07:24:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id P4gPDCeLzGpFXAAAD6G6ig
 (envelope-from <gpathak@suse.de>); Mon, 12 Oct 2026 07:24:23 +0000
From: Gaurav Pathak <gpathak@suse.de>
To: ltp@lists.linux.it
Date: Mon, 12 Oct 2026 12:53:07 +0530
Message-ID: <20261012072403.77119-1-gpathak@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260917111533.8907-1-linuxtestproject.agent@gmail.com>
References: <20260917111533.8907-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 8F42F21E71
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/1] syscalls/statx13: Add basic test for
 STATX_WRITE_ATOMIC on regular file
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
Cc: Gaurav Pathak <gaurav.pathak@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RnJvbTogR2F1cmF2IFBhdGhhayA8Z2F1cmF2LnBhdGhha0BzdXNlLmNvbT4KCkhpLAoKVGhhbmsg
eW91IGZvciB0aGUgZGV0YWlsZWQgZmVlZGJhY2suIEkgaGF2ZSBhZGRyZXNzZWQgYWxsIHRoZSBp
c3N1ZXMgcG9pbnRlZCBvdXQKYnkgdGhlIExUUCBBSSBSZXZpZXdlcuKAlGluY2x1ZGluZyBmaXhp
bmcgdGhlIG1lbW9yeSBsZWFrLCBjb3JyZWN0aW5nIHRoZSBzdGF0eApzdHJ1Y3QgYWxsb2NhdGlv
biwgbW92aW5nIHRoZSBmZWF0dXJlIGd1YXJkcyB0byBsYXBpL3N0YXQuaCwgYW5kIGZpeGluZyB0
aGUKY29tbWl0IHJlZmVyZW5jZSBmb3JtYXQuCgpQbGVhc2UgZmluZCB0aGUgcmV2aXNlZCB2NCBw
YXRjaC4KCkdhdXJhdiBQYXRoYWsgKDEpOgogIHN5c2NhbGxzL3N0YXR4MTM6IEFkZCBiYXNpYyB0
ZXN0IGZvciBTVEFUWF9XUklURV9BVE9NSUMgb24gcmVndWxhcgogICAgZmlsZQoKIGNvbmZpZ3Vy
ZS5hYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCArLQogaW5jbHVkZS9sYXBp
L3N0YXQuaCAgICAgICAgICAgICAgICAgICAgICAgIHwgIDE3ICsrLQogcnVudGVzdC9zeXNjYWxs
cyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsKIHRlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvc3RhdHgvLmdpdGlnbm9yZSB8ICAgMSArCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3N0YXR4L3N0YXR4MTMuYyAgfCAxMzkgKysrKysrKysrKysrKysrKysrKysrCiA1IGZpbGVzIGNo
YW5nZWQsIDE2MCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAw
NjQ0IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3RhdHgvc3RhdHgxMy5jCgotLSAKMi41MS4w
CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
