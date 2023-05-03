Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B75C77B78
	for <ltp@archiver.kernel.org>; Wed,  3 May 2023 12:42:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F0763CC872
	for <ltp@archiver.kernel.org>; Wed,  3 May 2023 14:42:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BA5E3CB84B
 for <ltp@lists.linux.it>; Wed,  3 May 2023 14:42:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0CC641400200
 for <ltp@lists.linux.it>; Wed,  3 May 2023 14:42:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EFB3C227AF;
 Wed,  3 May 2023 12:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683117746;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/pHugXZCJS8XYixzC4ipH8zYIALT+StGE2nP+eyoe/0=;
 b=LGxEZZJaxJSmsYhhfgFVdeyrolLmk3TvtlupGyAgNy8PKxajD8Qc8QFWTYCg8LrRXf5q5c
 rdpfKTY7lErSiwgFUiL1RIlwpQMs/dAz2PYS+7GMS5lWYdeZOrHjYXSczuX3X7gmNEBX5M
 NINeQUhHlqlx2y27gXRaeR4NJC8yFOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683117746;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/pHugXZCJS8XYixzC4ipH8zYIALT+StGE2nP+eyoe/0=;
 b=XvcdUHDAyS5XnPMQL6U8KUKswplBNspZOVJ4juSdJshm1Ceg8P0uNUf+CwTuwkKGUge68t
 /uoEBhptln2MOwAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB7461331F;
 Wed,  3 May 2023 12:42:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FO1lLLJWUmRSBgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 03 May 2023 12:42:26 +0000
Date: Wed, 3 May 2023 14:42:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
Message-ID: <20230503124240.GA3738345@pevik>
References: <20230421145746.5704-1-mdoucha@suse.cz>
 <20230421145746.5704-5-mdoucha@suse.cz>
 <422cfce1-3ca7-3aca-ee98-ebfe96e60bec@suse.cz>
 <20230502143207.GE3666374@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230502143207.GE3666374@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] Add test for CVE 2021-3653
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Nicolai Stange <nstange@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTWFydGluLAoKYmVjYXVzZSBOaWNvbGFpIGlzIGJ1c3ksIHBhdGNoZXMgbG9va3MgZ29vZCBh
bmQgQ3lyaWwgYWxzbyBhY2tlZCB0aGVtIFsxXSwgSQptZXJnZSBmaXJzdCBmb3VyIHBhdGNoZXMu
CgpUaGUgdGVzdCBpdHNlbGYgaW50cm9kdWNlcyB3YXJuaW5ncy4gQ291bGQgeW91IHBsZWFzZSBo
YXZlIGxvb2sgaWYgdGhleSBjb3VsZCBiZQplYXNpbHkgZml4ZWQ/Cgprdm1fc3ZtMDEuYzogSW4g
ZnVuY3Rpb24g4oCYZ3Vlc3RfbWFpbuKAmToKa3ZtX3N2bTAxLmM6NDI6MTM6IHdhcm5pbmc6IGFy
cmF5IHN1YnNjcmlwdCAwIGlzIG91dHNpZGUgYXJyYXkgYm91bmRzIG9mIOKAmHVpbnQzMl90WzBd
4oCZIHtha2Eg4oCYdW5zaWduZWQgaW50W13igJl9IFstV2FycmF5LWJvdW5kc10KICAgNDIgfCAg
ICAgICAgIGlmICgqYXZpY19wdHIgIT0gMHhhYWFhYWFhYSkKICAgICAgfCAgICAgICAgICAgICBe
fn5+fn5+fn4Ka3ZtX3N2bTAxLmM6NDU6OTogd2FybmluZzogYXJyYXkgc3Vic2NyaXB0IDAgaXMg
b3V0c2lkZSBhcnJheSBib3VuZHMgb2Yg4oCYdWludDMyX3RbMF3igJkge2FrYSDigJh1bnNpZ25l
ZCBpbnRbXeKAmX0gWy1XYXJyYXktYm91bmRzXQogICA0NSB8ICAgICAgICAgKmF2aWNfcHRyID0g
QVZJQ19URVNUX1ZBTDsKICAgICAgfCAgICAgICAgIF5+fn5+fn5+fgprdm1fc3ZtMDEuYzogSW4g
ZnVuY3Rpb24g4oCYbWFpbuKAmToKa3ZtX3N2bTAxLmM6OTM6MTM6IHdhcm5pbmc6IGFycmF5IHN1
YnNjcmlwdCAwIGlzIG91dHNpZGUgYXJyYXkgYm91bmRzIG9mIOKAmHVpbnQzMl90WzBd4oCZIHth
a2Eg4oCYdW5zaWduZWQgaW50W13igJl9IFstV2FycmF5LWJvdW5kc10KICAgOTMgfCAgICAgICAg
IGlmICgqYXZpY19wdHIgIT0gQVZJQ19URVNUX1ZBTCkgewoKS2luZCByZWdhcmRzLApQZXRyCgpb
MV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwL1pGSXA0U3VsY3kyMEdXa2NAcmVpLwoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
