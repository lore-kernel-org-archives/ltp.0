Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA5BC71155
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 13:59:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C0083CC08E
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 15:59:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4057C3CBCDD
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 15:59:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3420860084A
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 15:59:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A38C211C8;
 Mon, 16 Jun 2025 13:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750082352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hBXE2Jwx/8On/zV+B5kDa6ZAdeISf+4YjlF9QEMMKy0=;
 b=Wgk974v127XzPaRwm4JWL22qyKX3e4IGQH9FfYP9zCEztzdVyATfumKMllGZzxcyYP3e1Y
 32giRWkr/Ci8CTqwjadankSIxr5kQxWPeLF7QWx1WGPVgckUfBmjPxhOoy2GN6Td4RHqdU
 3cWjGVpbc+loSSvzUMxOJGGeSAKvbcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750082352;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hBXE2Jwx/8On/zV+B5kDa6ZAdeISf+4YjlF9QEMMKy0=;
 b=KPxVeyuKLGlxlosBV3zNRiFpgGdXbunNpqAltpHIH2CUwmoTNq5d5zjiXsl7bRsBY9tBal
 MMoVUSeTYaN91MDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XZzcgXrZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xoq9WeAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750082347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hBXE2Jwx/8On/zV+B5kDa6ZAdeISf+4YjlF9QEMMKy0=;
 b=XZzcgXrZ1xvOpCQYpkqX66Fd7pO9ggjy0RiiaLXONJxiwwnBsA7NN4IRryOV1G8G8zHcY6
 LttxRgD8o25seBA19gKdnL+7XV02scECNFBpF83LZQi9BrDXgsC4MxrZM/WAeLJLmdeWKy
 OuVGkcPPwN8SVq/3lxGhB2yPkz737Ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750082347;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hBXE2Jwx/8On/zV+B5kDa6ZAdeISf+4YjlF9QEMMKy0=;
 b=xoq9WeAECgU7vq04ClnLd2kDYXizKbu/aq29oKCMp1fvdwU2ri0yBOHNvAH7cknwoZTe/t
 vvycyo8MVWrFooCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09E7D13A6D;
 Mon, 16 Jun 2025 13:59:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rdMDASYjUGj9PAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 16 Jun 2025 13:59:02 +0000
Date: Mon, 16 Jun 2025 15:59:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aFAjSsKYqpp774Jr@yuki.lan>
References: <20250610104538.15687-1-chrubis@suse.cz>
 <CAEemH2fAyGeni-DLizvG38AnuR0ZfFCFz50K9jJf6vHZAw_RJw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fAyGeni-DLizvG38AnuR0ZfFCFz50K9jJf6vHZAw_RJw@mail.gmail.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1A38C211C8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RSPAMD_URIBL_FAIL(0.00)[suse.cz:query timed out];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[];
 ASN_FAIL(0.00)[7.9.0.0.4.6.0.0.0.5.1.0.0.1.0.0.4.0.1.0.1.8.2.b.0.4.e.d.7.0.a.2.asn6.rspamd.com:server
 fail]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RSPAMD_EMAILBL_FAIL(0.00)[chrubis.suse.cz:query timed out];
 MISSING_XM_UA(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:dkim, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: Add testers guide
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

SGkhCj4gVGhlIHBhcmFncmFwaCBhYm92ZSBzZWVtcyBhIGJpdCB2YWd1ZSBvciBtaXNsZWFkaW5n
LCBlc3BlY2lhbGx5IGdpdmVuIHRoYXQKPiB0aGUgdXBzdHJlYW0ga2VybmVsIGl0c2VsZiBpcyB0
ZXN0ZWQgd2l0aCBMVFAgYW5kIG1hbnkgb3RoZXIgdGVzdCBzdWl0ZXMuCgpJJ3ZlIHB1c2hlZCB0
aGUgcGF0Y2ggd2l0aCBtb3JlIHR5cG9zIGZpeGVkIGFuZCBzbGlnaHRseSBhZGp1c3RlZCB2ZXJz
aW9uOgoKZGlmZiAtLWdpdCBhL2RvYy91c2Vycy90ZXN0ZXJzX2d1aWRlLnJzdCBiL2RvYy91c2Vy
cy90ZXN0ZXJzX2d1aWRlLnJzdAppbmRleCBmZWY4Yzk2OTcuLjgyY2U5MDdhMiAxMDA2NDQKLS0t
IGEvZG9jL3VzZXJzL3Rlc3RlcnNfZ3VpZGUucnN0CisrKyBiL2RvYy91c2Vycy90ZXN0ZXJzX2d1
aWRlLnJzdApAQCAtMTksMTUgKzE5LDE1IEBAIHRoYXQgdXBzdHJlYW0gcmVsZWFzZXMgZ2VuZXJh
bGx5IGdvIHRocm91Z2ggZXh0ZW5zaXZlIHZhbGlkYXRpb24sIGluY2x1ZGluZwogdGVzdCBzdWl0
ZXMgbGlrZSBMVFAsIHN0YWJpbGl0eSBpcyBvbmx5IGd1YXJhbnRlZWQgd2hlbiB5b3UgdXNlIHRo
ZSB1cHN0cmVhbQoga2VybmVsIHNvdXJjZXMgYW5kIGNvbmZpZ3VyYXRpb24gZXhhY3RseSBhcyBy
ZWxlYXNlZC4KCi1Ib3dldmVyLCB0aGlzIGFzc3VtcHRpb24gYnJlYWtzIGRvd24gb25jZSB5b3Ug
YXBwbHkgYW55IGNoYW5nZXM6IHdoZXRoZXIgdGhhdCdzCitUaGlzIGFzc3VtcHRpb24gaG93ZXZl
ciBkb3duIG9uY2UgeW91IGFwcGx5IGFueSBjaGFuZ2VzOiB3aGV0aGVyIHRoYXQncwogbW9kaWZ5
aW5nIHRoZSBzb3VyY2UgY29kZSwgZW5hYmxpbmcvZGlzYWJsaW5nIGRpZmZlcmVudCBgLmNvbmZp
Z2Agb3B0aW9ucywgb3IKLWJhY2twb3J0aW5nIHBhdGNoZXMuIFN1Y2ggZGV2aWF0aW9ucyBjYW4g
aW50cm9kdWNlIHN1YnRsZSBidWdzIG9yIHVuaW50ZW5kZWQKK2JhY2twb3J0aW5nIHBhdGNoZXMu
IFN1Y2ggY2hhbmdlcyBjYW4gaW50cm9kdWNlIHN1YnRsZSBidWdzIG9yIHVuaW50ZW5kZWQKIGJl
aGF2aW9yLCBldmVuIGlmIHRoZSB1cHN0cmVhbSBrZXJuZWwgaXMgc3RhYmxlLgoKIEZvciBleGFt
cGxlLCBiYWNrcG9ydGluZyBwYXRjaGVzIHdpdGhvdXQgdGhlaXIgZnVsbCBkZXBlbmRlbmN5IGNo
YWluIGNhbiBsZWFkCiB0byB1bmV4cGVjdGVkIHJlZ3Jlc3Npb25zLiBUaGVyZWZvcmUsIGl04oCZ
cyBjcnVjaWFsIHRvIHRlc3QgeW91ciBvd24ga2VybmVsCiBidWlsZHMgaW4gdGhlIGVudmlyb25t
ZW50IHdoZXJlIHRoZXkgd2lsbCBhY3R1YWxseSBydW4sIHVzaW5nIHRvb2xzIGxpa2UgTFRQIHRv
Ci1oZWxwIGNhdGNoIGlzc3VlcyB0aGF0IHVwc3RyZWFtIHRlc3RpbmcgbWlnaHQgbm90IGNvdmVy
IGluIHlvdXIgc3BlY2lmaWMKK2NhdGNoIGlzc3VlcyB0aGF0IGRvZXMgbm90IGV4aXN0cyBvciBh
cmUgbm90IHRyaWdnZXJlZCBpbiB0aGUgdXBzdHJlYW0KIGNvbmZpZ3VyYXRpb24uCgoKVGhhbmtz
IGV2ZXJ5b25lIGZvciB0aGUgZml4ZXMgYW5kIHN1Z2dlc3Rpb25zIQoKLS0gCkN5cmlsIEhydWJp
cwpjaHJ1YmlzQHN1c2UuY3oKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
