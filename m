Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6638AC47422
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 10:55:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 724DB3CFABA
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 11:55:15 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1AA23CFA89
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 11:55:00 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0FF8C601AC4
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 11:54:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D985322034;
 Fri, 26 Jan 2024 10:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706266499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1KaZHuIMB0LTJ8dQCu8h4tgZDWeWNiVakH3Af3YELP0=;
 b=tm/n1ThRrPbokqNAysH6TRQD9ZB9mHmcnUZnGL4OumhqY7D6M15rkI3HCsJlL6BWG4sF/4
 sSSbxTRPksIkMuc2HTcJUskORXyEdlU+FzibiqfDl0PBjl4svhMP+hDF7xi963UeURcnNl
 INAvlLT241d+bR47TMqVVTkpAMIAK/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706266499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1KaZHuIMB0LTJ8dQCu8h4tgZDWeWNiVakH3Af3YELP0=;
 b=/1E9TR40cSvh1rEjHizDM3odz8gN/ea0qbO70oQXeYuBAejmdndaNqcT/kHvfeMixfopfF
 19XL2XgdCngs65DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706266498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1KaZHuIMB0LTJ8dQCu8h4tgZDWeWNiVakH3Af3YELP0=;
 b=XUXrgvlN3Dkyc1lkbG/35HABg8KtE3qxedzC7dLvuWRKvIBF7XdJS43/tkbD8WS2vTMjZm
 o3I6q1ZxBOIe8QE/daR+cN4Mi4iLwx1edWBBr2/7FBfC2WjFPeqH0/05LagYf8HX7wUndJ
 sUI7hK7DLdRr93QouKHgE5N/TD0iEm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706266498;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1KaZHuIMB0LTJ8dQCu8h4tgZDWeWNiVakH3Af3YELP0=;
 b=8kpyEaCFbbDYFvLEq0OzemBLY3mrWlqHGq5ncEvXTyvn+gcp+WOg55wdlq7DL7JOwIHIaE
 CBiA8KyRUaq3KLDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9E1C13A22;
 Fri, 26 Jan 2024 10:54:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sAAmLIKPs2UaKgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Jan 2024 10:54:58 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 26 Jan 2024 11:54:55 +0100
Message-ID: <20240126105455.487510-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XUXrgvlN;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8kpyEaCF
X-Spamd-Result: default: False [-2.81 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.cz:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[39.83%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D985322034
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lib: Fix compilation on old toolchains
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

U29tZSBvbGQgdG9vbGNoYWlucyByZXF1aXJlIHRvIGFkZCA8bGludXgvdHlwZXMuaD4gdG8gZml4
OgoKdHN0X3NhZmVfaW9fdXJpbmcuYzogSW4gZnVuY3Rpb24g4oCYc2FmZV9pb191cmluZ19pbml0
4oCZOgp0c3Rfc2FmZV9pb191cmluZy5jOjM0OjQ1OiBlcnJvcjog4oCYX191MzLigJkgdW5kZWNs
YXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCiAgIDM0IHwgICAgICAgICAgICAgICAg
IHBhcmFtcy0+c3FfZW50cmllcyAqIHNpemVvZihfX3UzMik7CiAgICAgIHwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fgoKRml4ZXM6IDNmMmZmNTQzMSAo
IkFkZCBzYWZlIGZ1bmN0aW9ucyBmb3IgaW9fdXJpbmcgdG8gTFRQIGxpYnJhcnkiKQpTaWduZWQt
b2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KLS0tCiBsaWIvdHN0X3NhZmVfaW9f
dXJpbmcuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9saWIvdHN0X3NhZmVfaW9fdXJpbmcuYyBiL2xpYi90c3Rfc2FmZV9pb191cmluZy5jCmlu
ZGV4IGRlNjg2OWY1MC4uOTgyYTEwYmQ0IDEwMDY0NAotLS0gYS9saWIvdHN0X3NhZmVfaW9fdXJp
bmcuYworKysgYi9saWIvdHN0X3NhZmVfaW9fdXJpbmcuYwpAQCAtNCw2ICs0LDggQEAKICAqLwog
CiAjZGVmaW5lIFRTVF9OT19ERUZBVUxUX01BSU4KKworI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+
CiAjaW5jbHVkZSAidHN0X3Rlc3QuaCIKICNpbmNsdWRlICJ0c3Rfc2FmZV9pb191cmluZy5oIgog
Ci0tIAoyLjQzLjAKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
