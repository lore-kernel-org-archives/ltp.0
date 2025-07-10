Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30394C83F1A
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 08:20:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E4543CAEE3
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 10:20:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A343C3C65DA
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 10:20:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8659E600663
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 10:20:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2A3C21F451;
 Thu, 10 Jul 2025 08:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752135601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MP6uqUiUH28HEFrpXnIMcUm5Yjgt/sK/7G7c3IkaacA=;
 b=nvOBwEuClXqp8ONDNDjkvu0T53IFKf1ShVj6v7JdNVGjOPTZi6n4IJ//JwctLM8+4rf5r+
 fLW2Shkoet5aV4lV4Y4eF7wjVkjGXyYVeAZgOSIsjt8F+6N9LMwcpMi08iq4+hFDMszUPC
 DAX0fU4oCPm21O+qOm8r5hb1HviF2q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752135601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MP6uqUiUH28HEFrpXnIMcUm5Yjgt/sK/7G7c3IkaacA=;
 b=nI7ZIBRzudAN63cUPtmyAILUU7KH/3btZBGLVYVIFQ4ig8PItMYZZY+O/viiSWG/AYGEvV
 l6ym71g6FwNZ5OCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752135601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MP6uqUiUH28HEFrpXnIMcUm5Yjgt/sK/7G7c3IkaacA=;
 b=nvOBwEuClXqp8ONDNDjkvu0T53IFKf1ShVj6v7JdNVGjOPTZi6n4IJ//JwctLM8+4rf5r+
 fLW2Shkoet5aV4lV4Y4eF7wjVkjGXyYVeAZgOSIsjt8F+6N9LMwcpMi08iq4+hFDMszUPC
 DAX0fU4oCPm21O+qOm8r5hb1HviF2q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752135601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MP6uqUiUH28HEFrpXnIMcUm5Yjgt/sK/7G7c3IkaacA=;
 b=nI7ZIBRzudAN63cUPtmyAILUU7KH/3btZBGLVYVIFQ4ig8PItMYZZY+O/viiSWG/AYGEvV
 l6ym71g6FwNZ5OCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F9A5136CB;
 Thu, 10 Jul 2025 08:20:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K+C1B7F3b2h4NQAAD6G6ig
 (envelope-from <akumar@suse.de>); Thu, 10 Jul 2025 08:20:01 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 10 Jul 2025 10:17:09 +0200
Message-ID: <20250710082000.11641-1-akumar@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:helo,
 suse.de:mid, suse.de:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cgroup_regression_test: Use unique names for
 hierarchies in each test
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
Cc: mkoutny@suse.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

UmVjZW50bHkgd2Ugc3RhcnRlZCBoYXZpbmcgZmFpbHVyZXMgd2hlcmUgbW91bnRpbmcgY2dyb3Vw
IGluIHF1aWNrCnN1Y2Nlc3Npb24gYWZ0ZXIgdW1vdW50IG9mIHNhbWUgbmFtZWQgaGllcmFyY2h5
IGZhaWxzIHdpdGggRUJVU1kKCmNncm91cF9yZWdyZXNzaW9uX3Rlc3QgMSBUUEFTUzogbm8ga2Vy
bmVsIGJ1ZyB3YXMgZm91bmQKbW91bnQ6IC90bXAvTFRQX2Nncm91cF9yZWdyZXNzaW9uX3Rlc3Qu
WkZ3UzNKa1g0Yy9jZ3JvdXA6IGNncm91cCBhbHJlYWR5IG1vdW50ZWQgb3IgbW91bnQgcG9pbnQg
YnVzeS4KICAgICAgIGRtZXNnKDEpIG1heSBoYXZlIG1vcmUgaW5mb3JtYXRpb24gYWZ0ZXIgZmFp
bGVkIG1vdW50IHN5c3RlbSBjYWxsLgpjZ3JvdXBfcmVncmVzc2lvbl90ZXN0IDIgVEZBSUw6IEZh
aWxlZCB0byBtb3VudCBjZ3JvdXAgZmlsZXN5c3RlbQoKVXBkYXRpbmcgdGVzdCB0byB1c2UgdW5p
cXVlIG5hbWVzIGZvciBjZ3JvdXAgaGllcmFyY2hpZXMgaW4gZWFjaApzdWJ0ZXN0LgoKU3VnZ2Vz
dGVkLWJ5OiBNaWNoYWwgS291dG7DvSA8bWtvdXRueUBzdXNlLmNvbT4KU2lnbmVkLW9mZi1ieTog
QXZpbmVzaCBLdW1hciA8YWt1bWFyQHN1c2UuZGU+Ci0tLQogLi4uL2NvbnRyb2xsZXJzL2Nncm91
cC9jZ3JvdXBfcmVncmVzc2lvbl90ZXN0LnNoICAgICAgIHwgMTAgKysrKystLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90
ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL2Nncm91cC9jZ3JvdXBfcmVncmVzc2lvbl90ZXN0
LnNoIGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jZ3JvdXAvY2dyb3VwX3JlZ3Jlc3Np
b25fdGVzdC5zaAppbmRleCAyNzYyMzFmZTguLmMxYmY0ODEwZiAxMDA3NTUKLS0tIGEvdGVzdGNh
c2VzL2tlcm5lbC9jb250cm9sbGVycy9jZ3JvdXAvY2dyb3VwX3JlZ3Jlc3Npb25fdGVzdC5zaAor
KysgYi90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL2Nncm91cC9jZ3JvdXBfcmVncmVzc2lv
bl90ZXN0LnNoCkBAIC05Myw3ICs5Myw3IEBAIHRlc3QxKCkKIAljZ3JvdXBfcmVncmVzc2lvbl9m
b3JrX3Byb2Nlc3NlcyAmCiAJc2xlZXAgMQogCi0JbW91bnQgLXQgY2dyb3VwIC1vIG5vbmUsbmFt
ZT1mb28gY2dyb3VwIGNncm91cC8KKwltb3VudCAtdCBjZ3JvdXAgLW8gbm9uZSxuYW1lPWZvbzEg
Y2dyb3VwIGNncm91cC8KIAlpZiBbICQ/IC1uZSAwIF07IHRoZW4KIAkJdHN0X3JlcyBURkFJTCAi
ZmFpbGVkIHRvIG1vdW50IGNncm91cCBmaWxlc3lzdGVtIgogCQlraWxsIC1URVJNICQhCkBAIC0x
MTgsNyArMTE4LDcgQEAgdGVzdDIoKQogCWxvY2FsIHZhbDEKIAlsb2NhbCB2YWwyCiAKLQltb3Vu
dCAtdCBjZ3JvdXAgLW8gbm9uZSxuYW1lPWZvbyBjZ3JvdXAgY2dyb3VwLworCW1vdW50IC10IGNn
cm91cCAtbyBub25lLG5hbWU9Zm9vMiBjZ3JvdXAgY2dyb3VwLwogCWlmIFsgJD8gLW5lIDAgXTsg
dGhlbgogCQl0c3RfcmVzIFRGQUlMICJGYWlsZWQgdG8gbW91bnQgY2dyb3VwIGZpbGVzeXN0ZW0i
CiAJCXJldHVybgpAQCAtMjA0LDcgKzIwNCw3IEBAIHRlc3Q0KCkKIAkJcmV0dXJuCiAJZmkKIAot
CW1vdW50IC10IGNncm91cCAtbyBub25lLG5hbWU9Zm9vIGNncm91cCBjZ3JvdXAvCisJbW91bnQg
LXQgY2dyb3VwIC1vIG5vbmUsbmFtZT1mb280IGNncm91cCBjZ3JvdXAvCiAJbWtkaXIgY2dyb3Vw
LzAKIAlybWRpciBjZ3JvdXAvMAogCXRzdF91bW91bnQgJFBXRC9jZ3JvdXAKQEAgLTMwOSw3ICsz
MDksNyBAQCB0ZXN0XzdfMigpCiB7CiAJbG9jYWwgc3Vic3lzPSQxCiAKLQltb3VudCAtdCBjZ3Jv
dXAgLW8gbm9uZSxuYW1lPWZvbyBjZ3JvdXAgY2dyb3VwLworCW1vdW50IC10IGNncm91cCAtbyBu
b25lLG5hbWU9Zm9vNzIgY2dyb3VwIGNncm91cC8KIAlpZiBbICQ/IC1uZSAwIF07IHRoZW4KIAkJ
dHN0X3JlcyBURkFJTCAiZmFpbGVkIHRvIG1vdW50IGNncm91cCIKIAkJcmV0dXJuCkBAIC0zNzAs
NyArMzcwLDcgQEAgdGVzdDcoKQogIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogdGVzdDgoKQogewotCW1v
dW50IC10IGNncm91cCAtbyBub25lLG5hbWU9Zm9vIGNncm91cCBjZ3JvdXAvCisJbW91bnQgLXQg
Y2dyb3VwIC1vIG5vbmUsbmFtZT1mb284IGNncm91cCBjZ3JvdXAvCiAJaWYgWyAkPyAtbmUgMCBd
OyB0aGVuCiAJCXRzdF9yZXMgVEZBSUwgImZhaWxlZCB0byBtb3VudCBjZ3JvdXAgZmlsZXN5c3Rl
bSIKIAkJcmV0dXJuCi0tIAoyLjQzLjAKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
