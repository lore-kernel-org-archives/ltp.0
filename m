Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF81C4167B
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 09:07:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C5103CD945
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 10:07:02 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A71713CB9AB
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 10:06:52 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DFDF0206C2F
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 10:06:51 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B05C91FC26;
 Thu, 30 Nov 2023 09:06:50 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EE9B138E5;
 Thu, 30 Nov 2023 09:06:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id FimHJqpQaGW5IAAAn2gu4w
 (envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 09:06:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 1A655A07DC; Thu, 30 Nov 2023 10:06:50 +0100 (CET)
Date: Thu, 30 Nov 2023 10:06:50 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20231130090650.kxo5pwe4umvso77t@quack3>
References: <20231129114617.12660-1-jack@suse.cz>
 <20231129115440.19100-2-jack@suse.cz>
 <CAOQ4uxjZ3mfz7FR38ynStaJb=m_STS_ZEYqkveFAWHSeNJwgug@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjZ3mfz7FR38ynStaJb=m_STS_ZEYqkveFAWHSeNJwgug@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: B05C91FC26
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] fanotify: Provide
 fanotify_mark_supported_on_fs()
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkIDI5LTExLTIzIDE2OjQ3OjU2LCBBbWlyIEdvbGRzdGVpbiB3cm90ZToKPiBPbiBXZWQs
IE5vdiAyOSwgMjAyMyBhdCAxOjU04oCvUE0gSmFuIEthcmEgPGphY2tAc3VzZS5jej4gd3JvdGU6
Cj4gPgo+ID4gUHJvdmlkZSBoZWxwZXIgY2hlY2tpbmcgd2hldGhlciBhIG1hcmsgaXMgc3VwcG9y
dGVkIG9uIGEgZmlsZXN5c3RlbQo+ID4gc2luY2Ugc29tZSBtYXJrcyBuZWVkIG5vdCBiZSBhdmFp
bGFibGUgb24gYWxsIGZpbGVzeXN0ZW1zIChlLmcuIGJ0cmZzCj4gPiBzdWJ2b2x1bWVzKS4gQWxz
byBjb252ZXJ0IFJFUVVJUkVfTUFSS19UWVBFX1NVUFBPUlRFRF9CWV9LRVJORUwoKSBhbmQKPiA+
IGl0cyBvbmx5IHVzZXIgdG8gdXNlIHRoaXMgbmV3IGZ1bmN0aW9uLgo+ID4KPiA+IFNpZ25lZC1v
ZmYtYnk6IEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+Ci4uLgo+ID4gK3N0YXRpYyBpbmxpbmUgaW50
IGZhbm90aWZ5X21hcmtfc3VwcG9ydGVkX29uX2ZzKHVpbnQ2NF90IGZsYWcsIGNvbnN0IGNoYXIg
KmZuYW1lKQo+ID4gK3sKPiA+ICsgICAgICAgcmV0dXJuIGZhbm90aWZ5X2ZsYWdzX3N1cHBvcnRl
ZF9vbl9mcyhGQU5fQ0xBU1NfQ09OVEVOVCwgZmxhZywgRkFOX0FDQ0VTUywgZm5hbWUpOwo+IAo+
IFdoeSBub3QgRkFOX0NMQVNTX05PVElGPwoKQ3V0J24ncGFzdGUgZnJvbSBzb21ld2hlcmUgOykg
Rml4ZWQuIFRoYW5rcyEKCgkJCQkJCQkJSG9uemEKLS0gCkphbiBLYXJhIDxqYWNrQHN1c2UuY29t
PgpTVVNFIExhYnMsIENSCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
