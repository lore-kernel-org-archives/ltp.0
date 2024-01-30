Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B363C46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 09:29:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BC793CF96B
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 10:29:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29B993CE0F5
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 10:28:53 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 813CA601F6D
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 10:28:51 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EBEC21F83B;
 Tue, 30 Jan 2024 09:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706606931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lXkmlAgrukxizhV9OefOuTdoN/uNnC0ajveWcIV1o/I=;
 b=wedJhN1ZmY/9gjJi9mqqEPvHv3nTjTGJtVxYWRj9CN0TSCiRbNa9x7wBUGqU+kYl4ngARC
 h8z4dpNHQ66e988lRgR3ihMS4EFLrlJZpNtENol6m7TQQTpq9bPGsD3svaPOYVuJGPM6Nh
 vKNhRz0NsB2qHoWx1AoyM/AcBRQ9OQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706606931;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lXkmlAgrukxizhV9OefOuTdoN/uNnC0ajveWcIV1o/I=;
 b=QQMnedtY10BUzzxDOqMHwIjNIaIy1T3KK+Osy+kM9535+qv6awtZchQoS9QN7sDd+CNEEX
 a8Cy/K4XTfbZpwBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706606930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lXkmlAgrukxizhV9OefOuTdoN/uNnC0ajveWcIV1o/I=;
 b=F4C7P2nMv1648k+jNscx/9Eq1uuWIt4rVBX3haCzjp81pKdkmGO5SrPT53RvwCM9vimakL
 0ymdlfDiZes3LrWZQRX99AeOwzRK1lSLlKYp6MmSB3/NbgmQbqJM7Jws9rQw27WgCwMbIL
 axS9L2gz5/hoEui/BKl94zg+kX4woXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706606930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lXkmlAgrukxizhV9OefOuTdoN/uNnC0ajveWcIV1o/I=;
 b=XgFyZM7pFov2k5/rgkDRVPSZieLIidt5pLrbgoIHXADdNexVcBGLqgoS02EcTq4STnZKBt
 N5NC4LAxR5DmWnCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 90EA713462;
 Tue, 30 Jan 2024 09:28:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id Tx+RHlLBuGUgagAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jan 2024 09:28:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Jan 2024 10:28:44 +0100
Message-ID: <20240130092845.684493-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.45 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-1.15)[88.71%]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] hugemmap24: Postpone free()
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

VGhpcyBmaXhlcyB3YXJuaW5nOiBwb2ludGVyIOKAmGhlYXDigJkgdXNlZCBhZnRlciDigJhmcmVl
4oCZLgpQb2ludGVyIGlzIG5vdCB1c2VkIGFueXdheSwgYnV0IGJldHRlciB0byBhdm9pZCB3YXJu
aW5nLgoKU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Ci0tLQogdGVz
dGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDI0LmMgfCAzICsrLQog
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAyNC5jIGIv
dGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDI0LmMKaW5kZXgg
NDMxZGMxYmJmLi4zYmEwOTg1ZGMgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1
Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAyNC5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1
Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAyNC5jCkBAIC00Miw3ICs0Miw2IEBAIHN0YXRpYyBpbnQg
aW5pdF9zbGljZV9ib3VuZGFyeShpbnQgZmQpCiAKIAkvKiBkdW1teSBtYWxsb2Mgc28gd2Uga25v
dyB3aGVyZSBpcyBoZWFwICovCiAJaGVhcCA9IG1hbGxvYygxKTsKLQlmcmVlKGhlYXApOwogCiAJ
IC8qIEF2b2lkIHVuZGVyZmxvdyBvbiBzeXN0ZW1zIHdpdGggbGFyZ2UgaHVnZSBwYWdlcy4KIAkg
ICogVGhlIGFkZGl0aW9uYWxseSBwbHVzIGhlYXAgYWRkcmVzcyBpcyB0byByZWR1Y2UgdGhlIHBv
c3NpYmlsaXR5CkBAIC01MSw2ICs1MCw4IEBAIHN0YXRpYyBpbnQgaW5pdF9zbGljZV9ib3VuZGFy
eShpbnQgZmQpCiAJd2hpbGUgKHNsaWNlX2JvdW5kYXJ5ICsgc2xpY2Vfc2l6ZSA8ICh1bnNpZ25l
ZCBsb25nKWhlYXAgKyAyKmhwYWdlX3NpemUpCiAJCXNsaWNlX2JvdW5kYXJ5ICs9IHNsaWNlX3Np
emU7CiAKKwlmcmVlKGhlYXApOworCiAJLyogRmluZCAyIG5laWdoYm91ciBzbGljZXMgd2l0aCBj
b3VwbGUgaHVnZSBwYWdlcyBmcmVlCiAJICogYXJvdW5kIHNsaWNlIGJvdW5kYXJ5LgogCSAqIDE2
IGlzIHRoZSBtYXhpbXVtIG51bWJlciBvZiBzbGljZXMgKGxvdy9oaWdoKQotLSAKMi40My4wCgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
