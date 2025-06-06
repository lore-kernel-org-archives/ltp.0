Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41EAC5B549
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 09:18:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 189393C9AF0
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 11:18:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 133183C9A68
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 11:17:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4FCF31400431
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 11:17:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6D369336D2;
 Fri,  6 Jun 2025 09:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749201470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNx83wblyDHf1PSU3xWeVeTNBTz3QKnzRZaEb6LwIKE=;
 b=d5sW1whRWOiGmotPwgaiYpaim3Cqb2r3vV/GGMPTeuQodHRVk71wcixBIdp5jF2Er2tCFi
 71PA7ZZNXAxMj6sLfN8+WyZFTEWbsbTp4arGo99DBGepQz262TUn02f4Sgc13hlE78+5E0
 8A+uPnfF4A8IGbXdH1qG5eF/0HpGPCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749201470;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNx83wblyDHf1PSU3xWeVeTNBTz3QKnzRZaEb6LwIKE=;
 b=2LIk0p+nH3S3EtmqzVFaYoz6Dd6XdopoxU4esd0Ienqd1o/YhS7PqIp+P2DHHRejU9L4T7
 vBFhZyHDgi2kX3Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749201470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNx83wblyDHf1PSU3xWeVeTNBTz3QKnzRZaEb6LwIKE=;
 b=d5sW1whRWOiGmotPwgaiYpaim3Cqb2r3vV/GGMPTeuQodHRVk71wcixBIdp5jF2Er2tCFi
 71PA7ZZNXAxMj6sLfN8+WyZFTEWbsbTp4arGo99DBGepQz262TUn02f4Sgc13hlE78+5E0
 8A+uPnfF4A8IGbXdH1qG5eF/0HpGPCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749201470;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNx83wblyDHf1PSU3xWeVeTNBTz3QKnzRZaEb6LwIKE=;
 b=2LIk0p+nH3S3EtmqzVFaYoz6Dd6XdopoxU4esd0Ienqd1o/YhS7PqIp+P2DHHRejU9L4T7
 vBFhZyHDgi2kX3Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E3AD1336F;
 Fri,  6 Jun 2025 09:17:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EcinFj6yQmghGAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 06 Jun 2025 09:17:50 +0000
Date: Fri, 6 Jun 2025 11:18:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aEKyXpEg3NoPKLfq@yuki.lan>
References: <20250605120702.213048-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250605120702.213048-1-liwang@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] tst_atomic: drop legacy inline assembly
 and use __atomic or __sync builtins
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gUmVmYWN0b3IgdHN0X2F0b21pYy5oIHRvIHJlbW92ZSBhbGwgbGVnYWN5IGFyY2hpdGVj
dHVyZS1zcGVjaWZpYyBpbmxpbmUKPiBhc3NlbWJseSBhbmQgZmFsbGJhY2sgY29kZSBwYXRocy4g
VGhlIG5ldyBpbXBsZW1lbnRhdGlvbiBzdXBwb3J0cyBvbmx5Cj4gdHdvIHdlbGwtZGVmaW5lZCBp
bnRlcmZhY2VzOiBfX2F0b21pY18qIGJ1aWx0LWlucyAoR0NDIOKJpSA0LjcpIGFuZCBfX3N5bmNf
Kgo+IGJ1aWx0LWlucyAoR0NDIOKJpSA0LjEpLgo+IAo+IFRoaXMgc2ltcGxpZmljYXRpb24gaW1w
cm92ZXMgbWFpbnRhaW5hYmlsaXR5LCBjbGFyaXR5LCBhbmQgcG9ydGFiaWxpdHkKPiBhY3Jvc3Mg
cGxhdGZvcm1zLiBJdCBhbHNvIHVwZGF0ZXMgYWxsIGZ1bmN0aW9uIHNpZ25hdHVyZXMgdG8gdXNl
IGludDMyX3QKPiBmb3IgdHlwZSBjb25zaXN0ZW5jeSB3aGVuIG9wZXJhdGluZyBvbiBhdG9taWMg
Y291bnRlcnMsIHN1Y2ggYXMgdGhvc2UgaW4KPiBzdHJ1Y3QgdHN0X3Jlc3VsdHMuCgpDYW4gd2Ug
cGxlYXNlIHNwbGl0IHRoZSBwYXRjaCBpbnRvIHRoZSByZW1vdmFsIG9mIHRoZSBhc3NlbWJseSBh
bmQKc2VwYXJhdGUgcGF0Y2ggdGhhdCBjaGFuZ2VzIHRoZSB0eXBlcz8KCkFsc28gZG8gd2UgbmVl
ZCB0byB1cGRhdGUgZnV6enkgc3luYyBsaWJyYXJ5IGluIHRoZSBzZWNvbmQgcGF0Y2ggaW4Kb3Jk
ZXIgbm90IHRvIHByb2R1Y2Ugd2FybmluZ3M/CgotLSAKQ3lyaWwgSHJ1YmlzCmNocnViaXNAc3Vz
ZS5jegoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
