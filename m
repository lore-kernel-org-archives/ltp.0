Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5276DCA1012
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 18:27:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B9C53CD4CD
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 20:27:24 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6B1B3CD3F3
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 20:27:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 32F42600878
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 20:27:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AC75861293;
 Thu,  4 Sep 2025 18:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757010424;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yLDfk6f0Mun6Xc2DH2nFAaqeZu/6hNZh3/9Ngs2FycU=;
 b=SM/mYJSFnw+PSgZVMeXaZhLUzvLgAnlkDGflU3PUhROHJS0ahhW4KZI+GxYq2zoiuz8+It
 ueayzrKnOlz+n1GhDxLfrBVSgllJ0pzM5vtpwdYH/T8AIYZDA3KVBxMwsX8CNZqXscvZjo
 tV39N0FqDMTkn2VTk7CY8k03s93V934=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757010424;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yLDfk6f0Mun6Xc2DH2nFAaqeZu/6hNZh3/9Ngs2FycU=;
 b=IfiUIbH6arAZK/rJ0mlAVNWZpsezqkDK6gD2Ud8hRoajNPf0rsI5ht+UKFamkNSI0BUdyU
 rZgXiFeDKQMPAzBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757010424;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yLDfk6f0Mun6Xc2DH2nFAaqeZu/6hNZh3/9Ngs2FycU=;
 b=SM/mYJSFnw+PSgZVMeXaZhLUzvLgAnlkDGflU3PUhROHJS0ahhW4KZI+GxYq2zoiuz8+It
 ueayzrKnOlz+n1GhDxLfrBVSgllJ0pzM5vtpwdYH/T8AIYZDA3KVBxMwsX8CNZqXscvZjo
 tV39N0FqDMTkn2VTk7CY8k03s93V934=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757010424;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yLDfk6f0Mun6Xc2DH2nFAaqeZu/6hNZh3/9Ngs2FycU=;
 b=IfiUIbH6arAZK/rJ0mlAVNWZpsezqkDK6gD2Ud8hRoajNPf0rsI5ht+UKFamkNSI0BUdyU
 rZgXiFeDKQMPAzBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88E1013675;
 Thu,  4 Sep 2025 18:27:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dnlNIPjZuWgWPgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 04 Sep 2025 18:27:04 +0000
Date: Thu, 4 Sep 2025 20:26:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250904182659.GA4056@pevik>
References: <20250904102609.133359-1-liwang@redhat.com>
 <20250904110018.GA56668@pevik> <aLl7ConfYPBglqhx@rei.lan>
 <CAEemH2f=6MRZTk95ZctgPG-MKdyw5oK9WNgh3Tm8WNHQ9NcW_g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2f=6MRZTk95ZctgPG-MKdyw5oK9WNgh3Tm8WNHQ9NcW_g@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sched_football: synchronize with kickoff flag
 to reduce skew
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

SGksCgoKPiBPbiBUaHUsIFNlcCA0LCAyMDI1IGF0IDc6NDLigK9QTSBDeXJpbCBIcnViaXMgPGNo
cnViaXNAc3VzZS5jej4gd3JvdGU6Cgo+ID4gSGkhCj4gPiA+ID4gIHN0YXRpYyB2b2lkIGRvX3Nl
dHVwKHZvaWQpCj4gPiA+ID4gIHsKPiA+ID4gPiArICAgaWYgKCF0c3RfY2hlY2tfcHJlZW1wdF9y
dCgpKQo+ID4gPiA+ICsgICAgICAgICAgIHRzdF9icmsoVENPTkYsICJUZXN0IHJlcXVpcmVzIHJl
YWwtdGltZSBrZXJuZWwiKTsKCj4gPiA+IEkgdW5kZXJzdG9vZCBDeXJpbCBpcyByZWFsbHkgc3Vn
Z2VzdGluZyB0byBrZWVwIGl0IFsxXS4gSSB3b3VsZCBhbHNvCj4gPiB2b3RlIHRvCj4gPiA+IGtl
ZXAgaXQgKHdlIHN0aWxsIGhhdmUgc29tZSB0aW1lIHRvIHNlZSBpZiBpdCBnb3QgZml4ZWQgYmVm
b3JlIHJlbGVhc2UpLgoKPiA+ID4gSSBrbm93IHdlIGhhZCB0aGlzIGRpc2N1c3Npb24gaW4gdGhl
IHBhc3QgKHNvbWUgb2YgeW91ciBjb2xsZWFndWUKPiA+IHN1Z2dlc3RpbmcgaXQKPiA+ID4gc2hv
dWxkIG5vdCBiZSBydW4gb24gbm9uLVJUIGtlcm5lbCksIHNvIEknbSBub3QgcHVzaGluZyBmb3Ig
aXQuCgo+ID4gSSBzdGlsIGRvIG5vdCB1bmRlcnN0YW5kIHJlYXNvbnMgZm9yIGRpc2FibGluZyB0
aGUgdGVzdC4gVGhlIFBPU0lYCj4gPiByZWFsdGltZSBzY2hlZHVsbGluZyBjbGFzc2VzIGhhdmUg
dG8gd29yayBwcm9wZXJseSByZWdhcmRsZXNzIG9mIHRoZQo+ID4ga2VybmVsIGZsYXZvci4gV2h5
IHNob3VsZCB3ZSB0dXJuIHRoZSB0ZXN0IG9mZiBvbiBub24tcnQga2VybmVsIHRoZW4/CgoKPiBO
byBzcGVjaWFsIHJlYXNvbnMuIEkgc3RpbGwgY2FuIHNwb3JhZGljYWxseSBjYXRjaCB0aGUgZmFp
bHVyZSBvbiBub24tUlQKPiBrZXJuZWwgd2l0aCBldmVuIHNsZWVwIDIgc2Vjb25kcy4KCj4gVGh1
cywgSSB0b29rIHRoaXMgdmVyeSBleHRyZW1lIGFwcHJvYWNoLCBiZWNhdXNlIG9uIG5vbi1SVCBr
ZXJuZWwsIHNsZWVwCj4gbWF5IG5vdCBoYXZlIGEgcGFydGljdWxhcmx5IHBlcmZlY3QgZWZmZWN0
LCBJIGd1ZXNzIHRoZSBzdG9jayBrZXJuZWwgd2l0aAo+IHNjaGVkX3NldHNjaGVkdWxlcigsIFND
SEVEX0ZJRk8sICkgaXMgc3RpbGwgaGFzIHNjaGVkdWxpbmcgc2tldyB3aXRoCj4gd29ya2xvYWQu
Cgo+IEJ1dCB0aGUgUlQga2VybmVsIGlzIG1vcmUgYWdncmVzc2l2ZSBpbiBzY2hlZHVsaW5nLCBh
bmQgaXQgaXMgYWxtb3N0Cj4gaW1wb3NzaWJsZQo+IHRvIGVuY291bnRlciBmYWxzZSBwb3NpdGl2
ZXMgd2l0aCB0aGF0IGVuaGFuY2VtZW50LgoKCj4gLS0tIGEvdGVzdGNhc2VzL3JlYWx0aW1lL2Z1
bmMvc2NoZWRfZm9vdGJhbGwvc2NoZWRfZm9vdGJhbGwuYwo+ICsrKyBiL3Rlc3RjYXNlcy9yZWFs
dGltZS9mdW5jL3NjaGVkX2Zvb3RiYWxsL3NjaGVkX2Zvb3RiYWxsLmMKPiBAQCAtMTMwLDYgKzEz
MCw4IEBAIHZvaWQgcmVmZXJlZShpbnQgZ2FtZV9sZW5ndGgpCj4gICAgICAgICBwdGhyZWFkX2Jh
cnJpZXJfd2FpdCgmc3RhcnRfYmFycmllcik7Cj4gICAgICAgICB0c3RfYXRvbWljX3N0b3JlKDAs
ICZ0aGVfYmFsbCk7Cj4gICAgICAgICB0c3RfYXRvbWljX3N0b3JlKDEsICZraWNrb2ZmX2ZsYWcp
Owo+ICsgICAgICAgdXNsZWVwKDIwMDAwMDApOwoJCj4gKwoKPiAgICAgICAgIC8qIFdhdGNoIHRo
ZSBnYW1lICovCj4gICAgICAgICB3aGlsZSAoKG5vdy50dl9zZWMgLSBzdGFydC50dl9zZWMpIDwg
Z2FtZV9sZW5ndGgpIHsKPiBAQCAtMTk5LDkgKzIwMSw2IEBAIHN0YXRpYyB2b2lkIGRvX3Rlc3Qo
dm9pZCkKCj4gIHN0YXRpYyB2b2lkIGRvX3NldHVwKHZvaWQpCj4gIHsKPiAtICAgICAgIGlmICgh
dHN0X2NoZWNrX3ByZWVtcHRfcnQoKSkKPiAtICAgICAgICAgICAgICAgdHN0X2JyayhUQ09ORiwg
IlRlc3QgcmVxdWlyZXMgcmVhbC10aW1lIGtlcm5lbCIpOwo+IC0KPiAgICAgICAgIGlmICh0c3Rf
cGFyc2VfaW50KHN0cl9nYW1lX2xlbmd0aCwgJmdhbWVfbGVuZ3RoLCAxLCBJTlRfTUFYKSkKPiAg
ICAgICAgICAgICAgICAgdHN0X2JyayhUQlJPSywgIkludmFsaWQgZ2FtZSBsZW5ndGggJyVzJyIs
IHN0cl9nYW1lX2xlbmd0aCk7Cgo+ICMgLi9zY2hlZF9mb290YmFsbAo+IHRzdF90ZXN0LmM6MjAw
NDogVElORk86IExUUCB2ZXJzaW9uOiAyMDI1MDUzMAo+IHRzdF90ZXN0LmM6MjAwNzogVElORk86
IFRlc3RlZCBrZXJuZWw6IDYuMTIuMC01NS4yOS4xLmVsMTBfMC54ODZfNjQKPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIzEgU01QIFBSRUVNUFRfRFlOQU1JQyBNb24gQXVnIDE4
Cj4gMDU6Mzc6MjQgRURUIDIwMjUgeDg2XzY0Cj4gdHN0X2tjb25maWcuYzo4ODogVElORk86IFBh
cnNpbmcga2VybmVsIGNvbmZpZwo+ICcvbGliL21vZHVsZXMvNi4xMi4wLTU1LjI5LjEuZWwxMF8w
Lng4Nl82NC9jb25maWcnCj4gdHN0X3Rlc3QuYzoxODI1OiBUSU5GTzogT3ZlcmFsbCB0aW1lb3V0
IHBlciBydW4gaXMgMGggMDBtIDMwcwo+IHNjaGVkX2Zvb3RiYWxsLmM6MTYyOiBUSU5GTzogcGxh
eWVyc19wZXJfdGVhbTogMzIgZ2FtZV9sZW5ndGg6IDUKPiBzY2hlZF9mb290YmFsbC5jOjE3ODog
VElORk86IFN0YXJ0aW5nIDMyIG9mZmVuc2UgdGhyZWFkcyBhdCBwcmlvcml0eSAxNQo+IHNjaGVk
X2Zvb3RiYWxsLmM6MTg1OiBUSU5GTzogU3RhcnRpbmcgMzIgZGVmZW5zZSB0aHJlYWRzIGF0IHBy
aW9yaXR5IDMwCj4gc2NoZWRfZm9vdGJhbGwuYzoxOTI6IFRJTkZPOiBTdGFydGluZyA2NCBjcmF6
eS1mYW4gdGhyZWFkcyBhdCBwcmlvcml0eSA1MAo+IHNjaGVkX2Zvb3RiYWxsLmM6MTE4OiBUSU5G
TzogU3RhcnRpbmcgcmVmZXJlZSB0aHJlYWQKPiBzY2hlZF9mb290YmFsbC5jOjEyMTogVElORk86
IFN0YXJ0aW5nIHRoZSBnYW1lICg1IHNlYykKPiBzY2hlZF9mb290YmFsbC5jOjE0NDogVElORk86
IEZpbmFsIGJhbGwgcG9zaXRpb246IDE2NzYxCj4gc2NoZWRfZm9vdGJhbGwuYzoxNTA6IFRGQUlM
OiBFeHBlY3Q6IGZpbmFsX2JhbGwgPT0gMAoKT0sgZXZlbiAyIHMgc2xlZXAgZG9lcyBub3Qgd29y
ay4gSSdtIG91dCBvZiBpZGVhcyB3aGF0IGluIHRoZSB0ZXN0IGlzIHdyb25nLgoKS2luZCByZWdh
cmRzLApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
