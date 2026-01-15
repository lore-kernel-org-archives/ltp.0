Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C9DD44C79
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 16:21:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D1493CA1FF
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 17:21:19 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0B4B3CA094
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 17:21:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C13A21A00A5D
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 17:20:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1BF1A5BD4C;
 Thu, 15 Jan 2026 16:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768494053;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I8gsd/7PP9wibBewEBzZPSwxveZcuhCIVR9YjroN4W4=;
 b=k5H3pUJdNZPbfajrk3yR37Sdnr7THWmrlOUk03kKuqAxbjCHvsfDuYnuMSrtfdRc6J5hBn
 YiJCjxCLbLj9NvSF+xQ89RZ5z/Ij6nDzsc+ZwYs+VfiH+0qjhmvAzejhOzqwCKFTGImzUj
 WhmwmOwyJbxXAk8GKobA2VXbGhamdCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768494053;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I8gsd/7PP9wibBewEBzZPSwxveZcuhCIVR9YjroN4W4=;
 b=a4z9ZKKhcqa/K7sddfa+B7bJb5NcK5ghvZ0qqmr3zWz0l9FUM6onUZ/ASBBUn8qcIz7sJ6
 D7/dEgl9+U3bejAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=k5H3pUJd;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=a4z9ZKKh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768494053;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I8gsd/7PP9wibBewEBzZPSwxveZcuhCIVR9YjroN4W4=;
 b=k5H3pUJdNZPbfajrk3yR37Sdnr7THWmrlOUk03kKuqAxbjCHvsfDuYnuMSrtfdRc6J5hBn
 YiJCjxCLbLj9NvSF+xQ89RZ5z/Ij6nDzsc+ZwYs+VfiH+0qjhmvAzejhOzqwCKFTGImzUj
 WhmwmOwyJbxXAk8GKobA2VXbGhamdCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768494053;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I8gsd/7PP9wibBewEBzZPSwxveZcuhCIVR9YjroN4W4=;
 b=a4z9ZKKhcqa/K7sddfa+B7bJb5NcK5ghvZ0qqmr3zWz0l9FUM6onUZ/ASBBUn8qcIz7sJ6
 D7/dEgl9+U3bejAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFAA53EA63;
 Thu, 15 Jan 2026 16:20:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rGJVNeQTaWnLUwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 15 Jan 2026 16:20:52 +0000
Date: Thu, 15 Jan 2026 17:20:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260115162047.GA463199@pevik>
References: <20260115153439.13337-1-chrubis@suse.cz>
 <20260115153439.13337-3-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260115153439.13337-3-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1BF1A5BD4C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] doc: Add ground rules page
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKNCB0eXBvcyBiZWxvdy4gV2l0aCB0aGF0IGZpeGVkIGJlZm9yZSBtZXJnZToKUmV2
aWV3ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgoKRmV3IHNtYWxsIG1pbm9yIHRo
aW5ncyBiZWxvdy4KLi4uCj4gK0Fsd2F5cyBjbGVhbiB1cCwgZXZlbiBvbiBmYWlsdXJlCj4gKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gKwo+ICtFdmVyeSB0ZXN0IHNob3VsZCBs
ZWF2ZSB0aGUgc3lzdGVtIGFzIGl0IGZvdW5kIGl0OiB1bm1vdW50LCByZXN0b3JlIHN5c2N0bHMs
Cj4gK2RlbGV0ZSB0ZW1wIGZpbGVzL2RpcnMsIGtpbGwgc3Bhd25lZCBwcm9jZXNzZXMsIHJlbW92
ZSBjZ3JvdXBzL25hbWVzcGFjZXMsCj4gK2RldGFjaCBsb29wIGRldmljZXMsIHJlc3RvcmUgdWxp
bWl0cywgZXRjLiBDbGVhbnVwIG11c3QgcnVuIG9uIGVhcmx5LWV4aXQKPiArcGF0aHMgdG9vLgoK
VGhlcmUgaXMgYW4gZXhjZXB0aW9uIG9uIGNsZWFudXAgZHluYW1pYyBtZW1vcnkgYWxsb2NhdGlv
biBiZWZvcmUgdHN0X2JyaygpLApyaWdodD8gSSBrZWVwIGZvcmdldHRpbmcgdGhpcywgYnV0IGl0
J3MgMSkgaXQncyBhIEMgbWVtb3J5IGNsZWFudXAgKG5vdCBhIHN5c3RlbQpjbGVhbnVwKSAyKSBh
IGNvcm5lciBjYXNlIChwcm9iYWJseSBub3QgbmVlZGVkIHRvIG1lbnRpb24pLgoKPiArCj4gK1Ro
ZSB0ZXN0IGxpYnJhcnkgY2FuIHNpbXBsaWZ5IGNsZWFudXAgZ3JlYXRseSBhcyB0aGVyZSBhcmUg
dmFyaW91cyBoZWxwZXJzIHN1Y2ggYXM6Cj4gKwo+ICstIDpjOnR5cGU6YHRzdF90ZXN0Lm5lZWRz
X3RtcGRpciA8dHN0X3Rlc3Q+YCB0aGF0IGNyZWF0ZXMgYW5kIGRlbGV0ZXMgYSB0ZW1wb3Jhcnkg
ZGlyZWN0b3J5IGZvciB0aGUgdGVzdAoKSG93IGFib3V0IHVzZSBzeW50YXggd2hpY2ggcGVvcGxl
IGFjdHVhbGx5IHVzZSBpbiB0aGUgY29kZT8KLSA6Yzp0eXBlOmAubmVlZHNfdG1wZGlyID0gMSA8
dHN0X3Rlc3Q+YCB0aGF0IGNyZWF0ZXMgYW5kIGRlbGV0ZXMgYSB0ZW1wb3JhcnkgZGlyZWN0b3J5
IGZvciB0aGUgdGVzdAoKPiArLSA6Yzp0eXBlOmB0c3RfdGVzdC5zYXZlX3Jlc3RvcmUgPHRzdF90
ZXN0PmAgdGhhdCBzYXZlcyBhbmQgcmVzdG9yZXMgL3N5cy8gYW5kIC9wcm9jLyBmaWxlcwo+ICst
IDpjOnR5cGU6YHRzdF90ZXN0Lm5lZWRzX2RldmljZSA8dHN0X3Rlc3Q+YCBzZXRzIHVwIGFuZCB0
ZWFycyBkb3duIGEgYmxvY2sgZGV2aWNlIGZvciB0aGUgdGVzdAo+ICstIDpjOnR5cGU6YHRzdF90
ZXN0LnJlc3RvcmVfd2FsbGNsb2NrIDx0c3RfdGVzdD5gIHRoYXQgcmVzdG9yZXMgd2FsbCBjbG9j
ayBhZnRlciB0aGUgdGVzdAo+ICstIDpjOnR5cGU6YHRzdF90ZXN0Lm5lZWRzX2Nncm91cF9jdHJs
cyA8dHN0X3Rlc3Q+YCBzZXRzIHVwIGFuZCBjbGVhbnMgdXAgY2dyb3VwcyBmb3IgdGhlIHRlc3QK
PiArLSAuLi4KTWF5YmUgaW5zdGVhZCAiLi4uIiB1c2U6ICJBbmQgbWFueSBtb3JlIj8KCkFsc28g
KE9UKCBJJ20gZ2V0dGluZyBjb252aW5jZWQgdGhhdCBldmVuIHdlIHRyYW5zZm9ybSBhbGwgaGVh
ZGVycyBpbnRvCmtlcm5lbGRvYyBjb21tZW50cyBhbmQgdXNlIGV4YW1wbGVzIGZyb20gdGhlIG9s
ZCBkb2MgWzFdIHdlIHdpbGwgcHJvYmFibHkgbmVlZApzb21lIGhpZ2hsZXZlbCBkb2N1bWVudCBz
aW1pbGFyIHRvIHRoZSBvbGQgZG9jIChzb21ldGhpbmcgc2hvcnRlciB0aGFuIHRoZSBvbGQKZG9j
LCB3aXRoIGxpbmtzIHBvaW50aW5nIHRvIHRoZSBoZWFkZXIgZG9jcywgcG9pbnRpbmcgb3V0IHRo
ZSBtb3N0IGltcG9ydGFudAp0aGluZ3MpLgoKWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10
ZXN0LXByb2plY3QvbHRwL2Jsb2IvbWFzdGVyL2RvYy9vbGQvQy1UZXN0LUFQSS5hc2NpaWRvYwoK
PiArCj4gKwo+ICtXcml0ZSBwb3J0YWJsZSBjb2RlCj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0KPiAr
Cj4gK0F2b2lkIG5vbnN0YW5kYXJkIGxpYmMgQVBJcyB3aGVuIGEgcG9ydGFibGUgZXF1aXZhbGVu
dCBleGlzdHM7IGRvbuKAmXQgYXNzdW1lCj4gKzY0LWJpdCwgcGFnZSBzaXplLCBlbmRpYW5uZXNz
LCBvciBwYXJ0aWN1bGFyIHRvb2wgdmVyc2lvbnMuCj4gKwo+ICtJZiB0aGUgdGVzdCBpcyBzcGVj
aWZpYyB0byBhIGNlcnRhaW4gYXJjaGl0ZWN0dXJlLCBtYWtlIHN1cmUgdGhhdCBpdCBhdCBsZWFz
dAo+ICtjb21waWxlcyBhdCB0aGUgcmVzdCBvZiBhcmNoaXRlY3R1cmVzIGFuZCBzZXQgdGhlCj4g
KzpjOnR5cGU6YHRzdF90ZXN0LnN1cHBvcnRlZF9hcmNocyA8dHN0X3Rlc3Q+YC4KPiArCj4gK1Ro
aXMgYWxzbyBhcHBsaWVzIHRvIHNoZWxsIGNvZGUgd2hlcmUgaXQncyBlYXN5IHRvIHVzZSBiYXNo
IGZlYXR1cmVzIHRoYXQgYXJlCj4gK25vdCBhdmFpbGFibGUgb24gb3RoZXIgc2hlbGwgaW1wbGVt
ZW50YXRpb25zLCBlLmcuIGRhc2ggb3IgYnVzeWJveC4gTWFrZSBzdXJlCj4gK3RvIHN0aWNrIHRv
IHBvcnRhYmxlIFBPU0lYIHNoZWxsIHdoZW5ldmVyIHBvc3NpYmxlLgo+ICsKPiArWW91IGNhbiBj
aGVjayBmb3IgY29tbW9uIG1pc3Rha2VzLCBub3Qgb25seSBpbiBwb3J0YWJpbGl0eSwgd2l0aCBv
dXIKPiArJ21ha2UgY2hlY2snIHRvb2xpbmcuCm5pdDogYGBtYWtlIGNoZWNrYGAgdG9vbGluZy4K
PiArCj4gKwo+ICtTcGxpdCBjaGFuZ2VkIGludG8gd2VsbCBkZWZpbmVkIGNodW5rcwo+ICstLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICsKPiArV2hlbiBzdWJtaXR0aW5n
IHBhdGNoZXMgbWFrZSBzdXJlIHRvIHNwbGl0IHRoZSB3b3JrIGludG8gc21hbGwgd2VsbC1kZWZp
bmVkCj4gK2NodW5rcy4gUGF0Y2hlcyB0aGF0IHRvdWNoIG1hbnkgZmlsZXMgb3IgbWl4IHVucmVs
YXRlZCBjaGFuZ2VzIGFuZCBmZWF0dXJlcyBhcmUKPiArZGlmZmljdWlsdCB0byByZXZpZXcgYW5k
IGFyZSBsaWtlbHkgdG8gYmUgZGV0YWx5ZWQgb3IgZXZlbiBpZ25vcmVkLgp0eXBvOiBkaWZmaWN1
aWx0ID0+IGRpZmZpY3VsdCwgZGV0YWx5ZWQgPT4gZGVsYXllZCAoPykKCj4gKwo+ICtBaW0gZm9y
IGEgc2luZ2xlIGxvZ2ljYWwgY2hhbmdlIHBlciBwYXRjaC4gU3BsaXQgbW9yZSBjb21wbGV4IHdv
cmtzIGludG8gYQo+ICtwYXRjaCBzZXJpZXMgd2hlcmUgZWFjaCBwYXRjaDoKPiArCj4gKyAgLSBi
dWlsZHMvY29tcGlsZXMgc3VjY2Vzc2Z1bGx5Lgo+ICsgIC0ga2VlcHMgdGVzdHMgYW5kIHRvb2xp
bmcgZnVuY3Rpb25hbC4KPiArICAtIGRvZXMgbm90IGludHJvZHVjZSBpbnRlcm1lZGlhdGUgYnJl
YWthZ2UuCj4gKyAgLSBoYXMgYSBjbGVhciBjb21taXQgbWVzc2FnZSB0byBleHBsYWluIHRoZSBj
aGFuZ2UuCj4gKyAgLSBTaWduaWZpY2FudCBjaGFuZ2VzIG5lZWQgdG8gYmUgZGV0YWlsZWQgaW4g
dGhlIGNvdmVyIGxldHRlci4KPiArCj4gKwo+ICtCZSBjYXJlZnVsIHdoZW4gdXNpbmcgQUkgdG9v
bHMKPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gKwo+ICtBSSB0b29scyBjYW4g
YmUgdXNlZnVsIGZvciBleGVjdXRpbmcsIHN1bW1hcml6aW5nLCBvciBzdWdnZXN0aW5nIGFwcHJv
YWNoZXMsCj4gK2J1dCB0aGV5IGNhbiBhbHNvIGJlIGNvbmZpZGVudGx5IHdyb25nIGFuZCBnaXZl
IGFuIGlsbHVzaW9uIG9mIGNvcnJlY3RuZXNzLgo+ICtUcmVhdCBBSSBvdXRwdXQgYXMgdW50cnVz
dGVkOiB2ZXJpZnkgY2xhaW1zIGFnYWluc3QgdGhlIGNvZGUsIGRvY3VtZW50YXRpb24sCj4gK2Fu
ZCBhY3R1YWwgYmVoYXZpb3Igb24gYSByZXByb2R1Y2VyLgo+ICsKPiArRG8gbm90IHNlbmQgQUkt
Z2VuZXJhdGVkIGNoYW5nZXMgYXMgcmF3IHBhdGNoZXMuIEFJLWdlbmVyYXRlZCBkaWZmcyBvZnRl
bgo+ICtjb250YWluIGlycmVsZXZhbnQgY2h1cm4sIGluY29ycmVjdCBhc3N1bXB0aW9ucywgaW5j
b25zaXN0ZW50IHN0eWxlLCBvciBzdWJ0bGUKPiArYnVncywgd2hpY2ggY3JlYXRlcyBhZGRpdGlv
bmFsIGJ1cmRlbiBmb3IgbWFpbnRhaW5lcnMgdG8gcmV2aWV3IGFuZCBmaXguCj4gKwo+ICtCZXN0
IHByYWN0aWNlIGlzIHRvIHdyaXRlIHlvdXIgb3duIHBhdGNoZXMgYW5kIGhhdmUgdGhlbSByZXZp
ZXdlZCBieSBBSSBiZWZvcmUKPiArc3VibWl0dGluZyB0aGVtLCB3aGljaCBoZWxwcyBhZGQgYmVu
ZWZpY2lhbCBpbXByb3ZlbWVudHMgdG8geW91ciB3b3JrLgo+ICsKPiArCj4gK0tlcm5lbCBmZWF0
dXJlcyBhbmQgUkNzCj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gKwo+ICtMVFAgdGVzdHMg
b3IgZml4ZXMgZm9yIGtlcm5lbCBjaGFuZ2VzIHRoYXQgaGF2ZSBub3QgeWV0IGJlZW4gcmVsZWFz
ZWQgbWF5IGJlCj4gK3Bvc3RlZCB0byB0aGUgTFRQIGxpc3QgZm9yIGEgcmV2aWV3IGJ1dCB0aGV5
IHdpbGwgbm90IGJlIGJlIGFjY2VwdGVkIHVudGlsCj4gK3Jlc3BlY3RpdmUga2VybmVsIGNoYW5n
ZXMgYXJlIHJlbGVhc2VkLiBSZXZpZXcgb2Ygc3VjaCBjaGFuZ2VzIGlzIGFsc28KPiArY29uc2lk
ZXJlZCB0byBiZSBsb3dlciBwcmlvcml0eSB0aGFuIHJlc3Qgb2YgdGhlIGNoYW5nZXMuIFRoaXMg
aXMgYmVjYXVzZQo+ICtrZXJuZWwgY2hhbmdlcyBlc3BlY2lhbGx5IGluIHRoZSBlYXJseSBSQyBw
aGFzZSBhcmUgdm9sYXRpbGUgYW5kIGNvdWxkIGJlCj4gK2NoYW5nZWQgb3IgcmV2ZXJ0ZWQuCj4g
Kwo+ICtUaGVzZSBwYXRjaHNlcyBzaG91bGQgYWxzbyBhZGQgYSBbU1RBR0lOR10ga2V5d29yZCBp
bnRvIHRoZSBwYXRjaCBzdWJqZWN0LCBlLmcuCnR5cG86IHBhdGNoc2VzID0+IHBhdGNoZXMKCj4g
KyJTdWJqZWN0OiBbUEFUQ0ggdjFdW1NUQUdJTkddIGZhbm90aWZ5OiBhZGQgdGVzdCBmb3IgPGZl
YXR1cmU+IChyZXF1aXJlcyB2Ni4xOS1yYzMpIgo+ICsKPiArSW4gYSBjYXNlIHRoYXQgYSB0ZXN0
IGZvciB1bnJlbGFzZWQga2VybmVsIGlzIHJlYWxseSBuZWVkZWQgdG8gYmUgbWVyZ2VkIHdlIGRv
CnR5cG86IHVucmVsYXNlZCA9PiB1bnJlbGVhc2VkCgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
