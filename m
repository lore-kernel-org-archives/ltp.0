Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C59C54E94
	for <ltp@archiver.kernel.org>; Wed, 25 Jan 2023 23:28:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC2E03CD3CC
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 00:28:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3CD53CB38E
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 00:27:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F20EC1400C64
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 00:27:58 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8B37921C1B;
 Wed, 25 Jan 2023 23:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674689276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=X4uanqjTkbipFM3dDxv4HLO3krEHCiTK4T2iBD1G5R8=;
 b=mlSppxEFU6Aym6+CPXbqZS+SieG4JTUTUxsUtE6o4h/1xJdwXt3nGf5oJrqShYuMa9SFoP
 D3Cn0m+uPSpuJCOzIrIuF6cpp6FBXtHpLQH19viVtfCp+tp3cjepr2Rud/hUb5GGYSCQk2
 tdgOdps4F+e4sf2VPcUZcG8brrHk06I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674689276;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=X4uanqjTkbipFM3dDxv4HLO3krEHCiTK4T2iBD1G5R8=;
 b=KZLNJXZHYA+FiNeZhsRDuIjbNlgTCcSEExxL5aWlNlpqWJ65YxzfZfGVwr4qLUBFCMpezE
 U4No/yE8RKCV+fAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 279C81358F;
 Wed, 25 Jan 2023 23:27:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xJLdBPy60WPNTwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Jan 2023 23:27:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 26 Jan 2023 00:27:51 +0100
Message-Id: <20230125232751.31809-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] fanotify.h: Include <linux/types.h>
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
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>,
 Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

dG8gYWRkIGtlcm5lbCB0eXBlcyAoX19zMzIsIF9fdTMyLCAuLi4pLgoKVGhpcyBmaXhlcyBidWls
ZCBvbiB2YXJpb3VzIEJ1aWxkcm9vdCB0b29sY2hhaW5zOgoKSW4gZmlsZSBpbmNsdWRlZCBmcm9t
IGZhbm90aWZ5Lmg6MTQsCiAgICAgICAgICAgICAgICAgZnJvbSBmYW5vdGlmeTA0LmM6MjU6Ci4u
Ly4uLy4uLy4uL2luY2x1ZGUvbGFwaS9mYW5vdGlmeS5oOjE5ODoyOiBlcnJvcjogdW5rbm93biB0
eXBlIG5hbWUg4oCYX19zMzLigJkKICAxOTggfCAgX19zMzIgZXJyb3I7CiAgICAgIHwgIF5+fn5+
Ci4uLy4uLy4uLy4uL2luY2x1ZGUvbGFwaS9mYW5vdGlmeS5oOjE5OToyOiBlcnJvcjogdW5rbm93
biB0eXBlIG5hbWUg4oCYX191MzLigJkKICAxOTkgfCAgX191MzIgZXJyb3JfY291bnQ7CiAgICAg
IHwgIF5+fn5+CgpOT1RFOiBIaXN0b3JpY2FsbHkgd2UgdHJpZWQgdG8gbWluaW1pemUgbnVtYmVy
IG9mIGxpbnV4IGluY2x1ZGVzLApiZWNhdXNlIGl0IHdvdWxkIG9mdGVuIGxlYWQgdG8gYnJva2Vu
IGJ1aWxkcy4gSGVhZGVycyBnb3QgYmV0dGVyIG92ZXIKdGltZSBhbmQgTFRQIGFsc28gZHJvcHBl
ZCBzdXBwb3J0IGZvciBhcmNoYWljIGtlcm5lbHMgb3ZlciB0aW1lLgpUaGVyZWZvcmUgd2UgY2Fu
IGtlZXAgb3JpZ2luYWwga2VybmVsIHR5cGVzIGhlcmUuCgpGaXhlczogNjcwNjlmYzQ2YSAoInN5
c2NhbGxzL2Zhbm90aWZ5MjI6IFZhbGlkYXRlIHRoZSBnZW5lcmljIGVycm9yIGluZm8iKQoKU2ln
bmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cGV0ci52b3JlbEBnbWFpbC5jb20+Ci0tLQogdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeS5oIHwgMSArCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2Zhbm90aWZ5L2Zhbm90aWZ5LmggYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90
aWZ5L2Zhbm90aWZ5LmgKaW5kZXggNTEwNzgxMDNlYi4uZGE3ODc4ODM3OCAxMDA2NDQKLS0tIGEv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeS5oCisrKyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkuaApAQCAtMTEsNiArMTEsNyBA
QAogI2luY2x1ZGUgPHN5cy90eXBlcy5oPgogI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CiAjaW5jbHVk
ZSA8ZXJybm8uaD4KKyNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgogI2luY2x1ZGUgImxhcGkvZmFu
b3RpZnkuaCIKICNpbmNsdWRlICJsYXBpL2ZjbnRsLmgiCiAKLS0gCjIuMzkuMQoKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
