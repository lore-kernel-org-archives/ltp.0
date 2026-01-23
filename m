Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D5FD7237B
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 11:53:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BF7A3CB6F9
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 12:53:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40ABE3CB421
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 12:53:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 87B0B2005F6
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 12:53:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3A222337C4;
 Fri, 23 Jan 2026 11:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769169199;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FRmXP15hUc9NHg2X5SyD8XE1+KthF3QHOmtHd9NiVLQ=;
 b=2ZvFwZgzB9ZIJy3sjmwyY/Vj6qDLtNMCmrViLVU593Q/TaIOdT0aDicFkaqETDD3JiT045
 vR7tzSeJCCqZ/RenDYfe8Gew1o2KUf62eT9q0kDX0g2d9ingViriskYOThN51aox9VzS2a
 Cq2DZWcrIXKxImwNDlLPH6lcyn/kNZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769169199;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FRmXP15hUc9NHg2X5SyD8XE1+KthF3QHOmtHd9NiVLQ=;
 b=4RiCQZg1sN03zaI+bsZAn/vo2IU0wS+GI6G399zdW1zFpBBQWRZ2zYbzhCqmbrLpf7RNID
 9Qw8iLp8cR/7UbAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769169199;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FRmXP15hUc9NHg2X5SyD8XE1+KthF3QHOmtHd9NiVLQ=;
 b=2ZvFwZgzB9ZIJy3sjmwyY/Vj6qDLtNMCmrViLVU593Q/TaIOdT0aDicFkaqETDD3JiT045
 vR7tzSeJCCqZ/RenDYfe8Gew1o2KUf62eT9q0kDX0g2d9ingViriskYOThN51aox9VzS2a
 Cq2DZWcrIXKxImwNDlLPH6lcyn/kNZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769169199;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FRmXP15hUc9NHg2X5SyD8XE1+KthF3QHOmtHd9NiVLQ=;
 b=4RiCQZg1sN03zaI+bsZAn/vo2IU0wS+GI6G399zdW1zFpBBQWRZ2zYbzhCqmbrLpf7RNID
 9Qw8iLp8cR/7UbAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F096136AA;
 Fri, 23 Jan 2026 11:53:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3d25Ai9hc2lrCwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 23 Jan 2026 11:53:19 +0000
Date: Fri, 23 Jan 2026 12:53:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260123115317.GA117991@pevik>
References: <20260123054056.131992-1-liwang@redhat.com>
 <20260123094538.GA113458@pevik>
 <CAEemH2c2pzwLcr+70_67oQ4aTqsTE004MnrLEPZgfvk-G1B+pg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2c2pzwLcr+70_67oQ4aTqsTE004MnrLEPZgfvk-G1B+pg@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] userfaultfd05: handle kernels rejecting WP
 feature in UFFDIO_API
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
Cc: Ricardo Branco <rbranco@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiA+ID4gICAgICAgaWYgKGlvY3RsKHVmZmQsIFVGRkRJT19BUEksICZ1ZmZkaW9fYXBpKSA8IDAp
IHsKPiA+ID4gLSAgICAgICAgICAgICBpZiAoISh1ZmZkaW9fYXBpLmZlYXR1cmVzICYgVUZGRF9G
RUFUVVJFX1BBR0VGQVVMVF9GTEFHX1dQKSkKPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgIHRz
dF9icmsoVENPTkYsICJVRkZEIHdyaXRlLXByb3RlY3QgdW5zdXBwb3J0ZWQiKTsKPiA+ID4gKyAg
ICAgICAgICAgICBpbnQgZXJyID0gZXJybm87Cj4gPiA+ICsgICAgICAgICAgICAgaWYgKGVyciA9
PSBFSU5WQUwpIHsKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIHVmZmRpb19hcGkuYXBpID0g
VUZGRF9BUEk7Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICB1ZmZkaW9fYXBpLmZlYXR1cmVz
ID0gMDsKPiA+ID4gKwo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgaWYgKGlvY3RsKHVmZmQs
IFVGRkRJT19BUEksICZ1ZmZkaW9fYXBpKSA9PSAwKQo+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB0c3RfYnJrKFRDT05GLCAiVUZGRCB3cml0ZS1wcm90ZWN0IHVuc3VwcG9ydGVk
Iik7Cj4gPiA+ICsgICAgICAgICAgICAgfQoKPiA+IFdvdWxkbid0IGJlIGJldHRlciBpbiB0aGlz
IGNhc2UgdG8gY2hlY2sga2NvbmZpZyBmb3IKPiA+IENPTkZJR19IQVZFX0FSQ0hfVVNFUkZBVUxU
RkRfV1AgKHVudGVzdGVkLCBidXQgaXQgc2hvdWxkIHdvcmsKCj4gVGhhdCdzIHRydWUsIGl0IHdv
dWxkIGJlIHNpbXBsZXIsIGxldCdzIGdvIHdpdGggdGhpcyBtZXRob2QuCgo+ID4gQmFjayB0byBv
dXIgZGlzY3Vzc2lvbiBhYm91dCBob3cgb2Z0ZW4gdXNpbmcga2NvbmZpZyBbMV0uIFdoaWxlIEkg
cHJlZmVyIHRvCj4gPiBhdm9pZCB1c2luZyBpdCBmb3IgdHJpc3RhdGUgKGtlcm5lbCBtaWdodCBi
ZSBjb25maWd1cmVkIGJ1dCBtb2R1bGUgbWlzc2luZyksIGJ1dAo+ID4gaGVyZSBpcyBqdXN0IGEg
ZmVhdHVyZS4KCj4gPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwL0NBQVNhRjZ3T1N2
aSswN1BxNU82K2YxSGtycTZXV01ncENhb29KeFdyTzl1T3ZSTTNwd0BtYWlsLmdtYWlsLmNvbS8K
Cj4gSSBkb27igJl0IHRoaW5rIHRoZXJlIGlzIGEgc2luZ2xlIOKAnHN0YW5kYXJk4oCdIGFuc3dl
ciBmb3IgZmVhdHVyZSBkZXRlY3Rpb247Cj4gaXQgcmVhbGx5IGRlcGVuZHMgb24gdGhlIHNwZWNp
ZmljIHNpdHVhdGlvbi4KCj4gRm9yIHRoZSBVRkZELVdQIGZlYXR1cmUgdGhlIHNpdHVhdGlvbiBp
czogdGhlcmUgaXNu4oCZdCByZWFsbHkgYSBib290Cj4gcGFyYW1ldGVyIG9yIHJ1bnRpbWUga25v
YiB0aGF0IGRpc2FibGVzIFVGRkQtV1AgaW5kZXBlbmRlbnRseSBvbmNlIHRoZQo+IGludGVyZmFj
ZSBpcyBwcmVzZW50LiBHaXZlbiB0aGF0LCBhIHNpbXBsZXIgYXBwcm9hY2ggaXMgdG8gcmVseSBv
biBLY29uZmlnCj4gY2hlY2tzLgoKPiBUaGlzIGlzIGVzcGVjaWFsbHkgcmVsZXZhbnQgaGVyZSBi
ZWNhdXNlIGRpZmZlcmVudCBrZXJuZWxzIHJlcG9ydCDigJxXUAo+IHVuc3VwcG9ydGVk4oCdIGRp
ZmZlcmVudGx5IChlLmcuIHJldHVybiAtMS9FSU5WQUwgdnMgcmV0dXJuIDAgd2l0aCBhCj4gZGlm
ZmVyZW50IGZlYXR1cmUgbWFzayksIHdoaWNoIG1ha2VzIHJ1bnRpbWUtYmFzZWQgZGV0ZWN0aW9u
IG1vcmUKPiBjb21wbGljYXRlZC4KClllcywgZm9yIHRoZSBkaXNjdXNzaW9uIHdoZW4gdG8gdXNl
IEknZCBwcm9wb3NlIHRvICpub3QqIHVzZSBrY29uZmlnIGlmOgoqIGJvb3QgcGFyYW1ldGVyIHRv
IGVuYWJsZS9kaXNhYmxlIGV4aXN0CiogY2hlY2sgZm9yIHRyaXN0YXRlIChmdW5jdGlvbmFsaXR5
IHdoaWNoIGNhbiBiZSBjb21waWxlZCBhcyBtb2R1bGUpCioga2VybmVsIG5ldyBmdW5jdGlvbmFs
aXR5IHdoaWNoIGlzIHVubGlrZWx5IHRvIGJlIGJhY2twb3J0ZWQgKHVzZSAubWluX2t2ZXIgaW5z
dGVhZCkKClVubGVzcyBzb21lIG9iamVjdGlvbiwgSSdsbCBwb3N0IGEgcGF0Y2ggZm9yIGdyb3Vu
ZCBydWxlcy4KCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
