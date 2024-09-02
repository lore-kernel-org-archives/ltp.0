Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6655CD13CF
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 08:04:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F14933C3237
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 10:04:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 285103C0CA7
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 10:03:46 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B9ABC1A00EBA
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 10:03:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BDE241FB9E;
 Mon,  2 Sep 2024 08:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725264222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SuM3wIdJSDN0saCiLNlO07vC0P+DFDvwNt+oa1cLosI=;
 b=COJuuIdFRmwreLx+gmLS9SPRlJ6Xo+paWrElegJ31MeE3yfWiYN9xonIOx7MB/AhOMBkvE
 ql/eFBktfFtYHs4yA7pFZTGzPADvcmL+yIHkqHVZBudVKD6NgsrAUvC+CKIEs1E97kSoGg
 PmjBy270ZShE71chSJDLwgZQ1Z1E4QU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725264222;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SuM3wIdJSDN0saCiLNlO07vC0P+DFDvwNt+oa1cLosI=;
 b=8pKXaB9gq3O0cK5Z9R52CiPcXEhOCo+eGxx+nBKIBEvvprL/tYFimKQ0KuefpVCPZL5X37
 NmxHrquwccpedGBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=COJuuIdF;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8pKXaB9g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725264222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SuM3wIdJSDN0saCiLNlO07vC0P+DFDvwNt+oa1cLosI=;
 b=COJuuIdFRmwreLx+gmLS9SPRlJ6Xo+paWrElegJ31MeE3yfWiYN9xonIOx7MB/AhOMBkvE
 ql/eFBktfFtYHs4yA7pFZTGzPADvcmL+yIHkqHVZBudVKD6NgsrAUvC+CKIEs1E97kSoGg
 PmjBy270ZShE71chSJDLwgZQ1Z1E4QU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725264222;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SuM3wIdJSDN0saCiLNlO07vC0P+DFDvwNt+oa1cLosI=;
 b=8pKXaB9gq3O0cK5Z9R52CiPcXEhOCo+eGxx+nBKIBEvvprL/tYFimKQ0KuefpVCPZL5X37
 NmxHrquwccpedGBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38B2113AE5;
 Mon,  2 Sep 2024 08:03:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m4bqDF5x1Wb0OAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 02 Sep 2024 08:03:42 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  2 Sep 2024 10:03:29 +0200
Message-ID: <20240902080330.356551-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: BDE241FB9E
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/1] metaparse: mntpoint implies needs_tmpdir
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

U2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Ci0tLQoKSSBzZWUgbGli
L3RzdF90ZXN0LmMKc3RhdGljIGludCBuZWVkc190bXBkaXIodm9pZCkKewoJcmV0dXJuIHRzdF90
ZXN0LT5uZWVkc190bXBkaXIgfHwKCSAgICAgICB0c3RfdGVzdC0+bmVlZHNfZGV2aWNlIHx8Cgkg
ICAgICAgdHN0X3Rlc3QtPm1udHBvaW50IHx8CgkgICAgICAgdHN0X3Rlc3QtPnJlc291cmNlX2Zp
bGVzIHx8CgkgICAgICAgdHN0X3Rlc3QtPm5lZWRzX2NoZWNrcG9pbnRzOwp9CgpCdXQKMSkgSXQg
ZG9lcyBub3QgZGV0ZWN0IGl0LgoyKSAtV2FycmF5LWJvdW5kcyBpcyBpbnRyb2R1Y2VkLgoKV2hh
dCBhbSBJIG1pc3Npbmc/Ckkgb3JpZ2luYWxseSBjb21lIHRvIHRoaXMgdmlhCmh0dHBzOi8vcGF0
Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9sdHAvcGF0Y2gvMjAyNDA4MjkxMTQxMjQuMzAyOTkt
MS13ZWdhb0BzdXNlLmNvbS8KKHdoZXJlIElNSE8gLm5lZWRzX3RtcGRpciA9IDEgaXMgbm90IG5l
ZWRlZCBkdWUgLm1udHBvaW50KQoKS2luZCByZWdhcmRzLApQZXRyCgokIGNhdCA+IGZvby5jIDw8
RU9GCiNkZWZpbmUgTU5UUE9JTlQgIm1udHBvaW50IgojaW5jbHVkZSAidHN0X3Rlc3QuaCIKCnN0
YXRpYyB2b2lkIGRvX3Rlc3Qodm9pZCkKewoJdHN0X3JlcyhUUEFTUywgImZvbyIpOwp9CkVPRgoK
c3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewoJLnRlc3RfYWxsID0gZG9fdGVzdCwKCS5t
bnRwb2ludCA9IE1OVFBPSU5ULAp9OwoKJCBjZCBtZXRhZGF0YTsgbWFrZSBtZXRhcGFyc2UgJiYg
Li9tZXRhcGFyc2UgLUkuLi9pbmNsdWRlIC1JLi4vdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91
dGlscy8gLi4vZm9vLmMKSW4gZmlsZSBpbmNsdWRlZCBmcm9tIG1ldGFwYXJzZS5jOjE3OgpJbiBm
dW5jdGlvbiDigJhkYXRhX25vZGVfc3RyaW5n4oCZLAogICAgaW5saW5lZCBmcm9tIOKAmG1haW7i
gJkgYXQgbWV0YXBhcnNlLmM6ODkyOjY6CmRhdGFfc3RvcmFnZS5oOjg0OjIwOiB3YXJuaW5nOiBh
cnJheSBzdWJzY3JpcHQg4oCYc3RydWN0IGRhdGFfbm9kZVswXeKAmSBpcyBwYXJ0bHkgb3V0c2lk
ZSBhcnJheSBib3VuZHMgb2Yg4oCYdW5zaWduZWQgY2hhcls2XeKAmSBbLVdhcnJheS1ib3VuZHM9
XQogICA4NCB8ICAgICAgICAgbm9kZS0+dHlwZSA9IERBVEFfU1RSSU5HOwogICAgICB8ICAgICAg
ICAgfn5+fn5+fn5+fn5efn5+fn5+fn5+fn5+CmRhdGFfc3RvcmFnZS5oOjc5OjM0OiBub3RlOiBv
YmplY3Qgb2Ygc2l6ZSA2IGFsbG9jYXRlZCBieSDigJhtYWxsb2PigJkKICAgNzkgfCAgICAgICAg
IHN0cnVjdCBkYXRhX25vZGUgKm5vZGUgPSBtYWxsb2Moc2l6ZSk7CiAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+CkhPU1RDQyBtZXRhZGF0YS9tZXRh
cGFyc2UKICAiZm9vIjogewogICAiZm5hbWUiOiAiLi4uL2Zvby5jIgoKIG1ldGFkYXRhL21ldGFw
YXJzZS5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQg
YS9tZXRhZGF0YS9tZXRhcGFyc2UuYyBiL21ldGFkYXRhL21ldGFwYXJzZS5jCmluZGV4IDIzODRj
NzNjODYuLjI0YmYwZjA5NjggMTAwNjQ0Ci0tLSBhL21ldGFkYXRhL21ldGFwYXJzZS5jCisrKyBi
L21ldGFkYXRhL21ldGFwYXJzZS5jCkBAIC04MDEsNiArODAxLDcgQEAgc3RhdGljIHN0cnVjdCBp
bXBsaWVzIHsKIAkJTlVMTH19LAogCXsiYWxsX2ZpbGVzeXN0ZW1zIiwgKGNvbnN0IGNoYXIgKltd
KSB7Im5lZWRzX2RldmljZSIsICJuZWVkc190bXBkaXIiLAogCQlOVUxMfX0sCisJeyJtbnRwb2lu
dCIsIChjb25zdCBjaGFyICpbXSkgeyJuZWVkc190bXBkaXIiLCBOVUxMfX0sCiAJeyJuZWVkc19k
ZXZpY2UiLCAoY29uc3QgY2hhciAqW10pIHsibmVlZHNfdG1wZGlyIiwgTlVMTH19LAogCXsibmVl
ZHNfY2hlY2twb2ludHMiLCAoY29uc3QgY2hhciAqW10pIHsibmVlZHNfdG1wZGlyIiwgTlVMTH19
LAogCXsicmVzb3VyY2VfZmlsZXMiLCAoY29uc3QgY2hhciAqW10pIHsibmVlZHNfdG1wZGlyIiwg
TlVMTH19LAotLSAKMi40NS4yCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
