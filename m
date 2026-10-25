Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576C0606A31A
	for <ltp@archiver.kernel.org>; Sun, 25 Oct 2026 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ifqzrDXp;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6+nQTgT1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ifqzrDXp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6+nQTgT1
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0BAC3DDF55
	for <ltp@archiver.kernel.org>; Sun, 25 Oct 2026 09:35:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D83E13C7A3B
 for <ltp@lists.linux.it>; Sun, 25 Oct 2026 09:35:25 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EEC73600199
 for <ltp@lists.linux.it>; Sun, 25 Oct 2026 09:35:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5624E1F390;
 Sun, 25 Oct 2026 08:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792917324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WcW7sUT+XXThW1UEumhW7q7+ELtmKCYrBEHd1YFdRDI=;
 b=ifqzrDXp38g3VIwuItzo5G12l4mS5tI6a7/M+wp/nGfAD0HIsDwTj3IyuD3fkdYAGCEXr2
 wqW3F69P0YGyIaiQFeXvry2Hs5aP0mEwDrcVGQman9b4oifC1rNRIBfCXvAOY9qB4WvHu8
 hB8GrCj0xu1bzhPOGby0LtXxCWZ8YW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792917324;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WcW7sUT+XXThW1UEumhW7q7+ELtmKCYrBEHd1YFdRDI=;
 b=6+nQTgT1i0kPa892A88LRjZgA8ZcRMCZ7kZzolXLvoj5s4QfZ5XnY9iNDHal7wTvwNGnA/
 vDkzC3IzFvGBbDDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792917324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WcW7sUT+XXThW1UEumhW7q7+ELtmKCYrBEHd1YFdRDI=;
 b=ifqzrDXp38g3VIwuItzo5G12l4mS5tI6a7/M+wp/nGfAD0HIsDwTj3IyuD3fkdYAGCEXr2
 wqW3F69P0YGyIaiQFeXvry2Hs5aP0mEwDrcVGQman9b4oifC1rNRIBfCXvAOY9qB4WvHu8
 hB8GrCj0xu1bzhPOGby0LtXxCWZ8YW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792917324;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WcW7sUT+XXThW1UEumhW7q7+ELtmKCYrBEHd1YFdRDI=;
 b=6+nQTgT1i0kPa892A88LRjZgA8ZcRMCZ7kZzolXLvoj5s4QfZ5XnY9iNDHal7wTvwNGnA/
 vDkzC3IzFvGBbDDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A7C713314;
 Sun, 25 Oct 2026 08:35:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B7SgN0u/3WogGAAAD6G6ig
 (envelope-from <rbranco@suse.de>); Sun, 25 Oct 2026 08:35:24 +0000
Message-ID: <924450a4-c674-46b0-b631-f1f93102349a@suse.de>
Date: Sun, 25 Oct 2026 09:35:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linuxtestproject.agent@gmail.com
References: <20261024180654.623705-1-rbranco@suse.de>
 <20261024202205.9296-1-linuxtestproject.agent@gmail.com>
Content-Language: en-US
From: Ricardo Branco <rbranco@suse.de>
In-Reply-To: <20261024202205.9296-1-linuxtestproject.agent@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-0.999];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] userfaultfd: Add tests for UFFDIO_RWPROTECT and
 UFFDIO_SET_MODE
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgpPbiAxMC8yNC8yNiAxMDoyMiBQTSwgbGludXh0ZXN0cHJvamVjdC5hZ2VudEBnbWFpbC5jb20g
d3JvdGU6Cj4gSGkgUmljYXJkbywKPgo+IE9uIDI0IE9jdCAyMDI2LCBSaWNhcmRvIEJyYW5jbyB3
cm90ZToKPj4gdXNlcmZhdWx0ZmQ6IEFkZCB0ZXN0cyBmb3IgVUZGRElPX1JXUFJPVEVDVCBhbmQg
VUZGRElPX1NFVF9NT0RFCj4+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdXNlcmZh
dWx0ZmQvdXNlcmZhdWx0ZmQwOC5jCj4+ICsJQ0hFQ0tfVUZGRF9GRUFUVVJFKFVGRkRfRkVBVFVS
RV9SV1ApOwo+PiArCXVmZmQgPSBTQUZFX1VTRVJGQVVMVEZEKE9fQ0xPRVhFQyB8IE9fTk9OQkxP
Q0ssIGZhbHNlKTsKPj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91c2VyZmF1bHRm
ZC91c2VyZmF1bHRmZDA5LmMKPj4gKwlDSEVDS19VRkZEX0ZFQVRVUkUoVUZGRF9GRUFUVVJFX1JX
UCk7Cj4+ICsJQ0hFQ0tfVUZGRF9GRUFUVVJFKFVGRkRfRkVBVFVSRV9SV1BfQVNZTkMpOwo+PiAr
CXVmZmQgPSBTQUZFX1VTRVJGQVVMVEZEKE9fQ0xPRVhFQyB8IE9fTk9OQkxPQ0ssIGZhbHNlKTsK
PiBNZWRpdW06IFdpdGggdm0udW5wcml2aWxlZ2VkX3VzZXJmYXVsdGZkPTAgYW5kIG5vIENBUF9T
WVNfUFRSQUNFLCBib3RoCj4gdGVzdHMgcmVwb3J0IFRDT05GIGV2ZW4gd2hlbiBSV1AgaXMgc3Vw
cG9ydGVkLCBiZWNhdXNlIENIRUNLX1VGRkRfRkVBVFVSRSgpCj4gYW5kIHJ1bigpIHJlcXVlc3Qg
a2VybmVsLWZhdWx0LWNhcGFibGUgZGVzY3JpcHRvcnMuCj4gVGhlc2UgdGVzdHMgb25seSBuZWVk
IHVzZXJzcGFjZSBmYXVsdHM7IHVzZSBVRkZEX1VTRVJfTU9ERV9PTkxZIG9yIGVuYWJsZQo+IHRo
ZSBleGlzdGluZyBFUEVSTSByZXRyeSBpbiBib3RoIHRoZSBmZWF0dXJlIHByb2JlIGFuZCB0ZXN0
IGRlc2NyaXB0b3IKPiBjcmVhdGlvbi4KPgo+IFZlcmRpY3QgLSBOZWVkcyByZXZpc2lvbgoKIMKg
IFRoaXMgaXMgaW50ZW50aW9uYWwuIFRoZSBleGlzdGluZyB1c2VyZmF1bHRmZCB0ZXN0cyAodXNl
cmZhdWx0ZmQwMS0wNykKIMKgIGFsbCBjcmVhdGUgdGhlIGZkIHdpdGggcmV0cnk9ZmFsc2UgYW5k
IFRDT05GIGluIHRoaXMgY29uZmlndXJhdGlvbiwgc28KIMKgIHRoZSBuZXcgdGVzdHMgYmVoYXZl
IHRoZSBzYW1lIHdheS4KCiDCoCBFbmFibGluZyB0aGUgcmV0cnkgaW4gdGhlIHNoYXJlZCBjaGVj
a191ZmZkX2ZlYXR1cmUoKSB3YXMgdHJpZWQgaW4gYW4KIMKgIGVhcmxpZXIgcmV2aXNpb24gYW5k
IGRyb3BwZWQuIE9uIExpbnV4IDUuMi01LjEwLCB3aXRob3V0CiDCoCBDQVBfU1lTX1BUUkFDRSwg
dGhlIHJldHJ5IGFkZHMgVUZGRF9VU0VSX01PREVfT05MWSwgd2hpY2ggdGhhdCBrZXJuZWwKIMKg
IGRvZXNuJ3Qgc3VwcG9ydC4gVGhlIGNhbGwgdGhlbiBmYWlscyB3aXRoIEVJTlZBTCwgc28gdGhl
IHRlc3QgcmVwb3J0cwogwqAgVEJST0sgaW5zdGVhZCBvZiBUQ09ORi4gVGhhdCB3b3VsZCBhbHNv
IHJlZ3Jlc3MgdGhlIGV4aXN0aW5nIGNhbGxlcnMuCgogwqAgSGFuZGxpbmcgdW5wcml2aWxlZ2Vk
IHVzZXJmYXVsdGZkIHByb3Blcmx5IGFjcm9zcyBhbGwgdGhlIHRlc3RzIHdvdWxkCiDCoCBiZSBh
IHNlcGFyYXRlIGNoYW5nZSB0byB0aGUgc2hhcmVkIGhlbHBlciwgYW5kIGRvZXNuJ3QgYmVsb25n
IGluIHRoaXMKIMKgIHNlcmllcy4KCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
