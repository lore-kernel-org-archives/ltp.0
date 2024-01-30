Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0311C46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 18:45:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FC523CF973
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 19:45:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFD973CE0E9
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 19:44:54 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4AE3C601BC0
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 19:44:53 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 19B0021C43;
 Tue, 30 Jan 2024 18:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706640293;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1VgZ1q8Q+JL7hE31C4s3WXuvaxrwuK+fKKFDUw1OMIg=;
 b=eHrDO7qrkKh0OLLnntl42Pw6djmzvCC6jCumSjttozDdbdvbbUkq1TlnGFxUZCVKGyXY4a
 zfQNqB/A3+4jbu23Ec0xLoGA9LWqtwvI3J18QnpmKCVeiWogU67IGmO1TOzI0WFAzMn6QN
 IsC1iFPRuRFm5H7wIxbIc/BUNyQ1xno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706640293;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1VgZ1q8Q+JL7hE31C4s3WXuvaxrwuK+fKKFDUw1OMIg=;
 b=dNoX3rFUBMFsS8CF4R3hIUdfn57vyDlmgbn/bwiCBCbwBu3lFvLywKZoB6xbrl7HHaBimR
 csrmhdTS1JQ3dgAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706640293;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1VgZ1q8Q+JL7hE31C4s3WXuvaxrwuK+fKKFDUw1OMIg=;
 b=eHrDO7qrkKh0OLLnntl42Pw6djmzvCC6jCumSjttozDdbdvbbUkq1TlnGFxUZCVKGyXY4a
 zfQNqB/A3+4jbu23Ec0xLoGA9LWqtwvI3J18QnpmKCVeiWogU67IGmO1TOzI0WFAzMn6QN
 IsC1iFPRuRFm5H7wIxbIc/BUNyQ1xno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706640293;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1VgZ1q8Q+JL7hE31C4s3WXuvaxrwuK+fKKFDUw1OMIg=;
 b=dNoX3rFUBMFsS8CF4R3hIUdfn57vyDlmgbn/bwiCBCbwBu3lFvLywKZoB6xbrl7HHaBimR
 csrmhdTS1JQ3dgAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CDBBF13212;
 Tue, 30 Jan 2024 18:44:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id xzhXMKRDuWVYdgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jan 2024 18:44:52 +0000
Date: Tue, 30 Jan 2024 19:44:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20240130184451.GA873803@pevik>
References: <20240125110510.751445-1-amir73il@gmail.com>
 <20240130130712.GB778733@pevik>
 <CAOQ4uxi+0us5cq5BhoLoPDCbZgeqhtWiK4UCDV5HaZ+aZQwCLw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi+0us5cq5BhoLoPDCbZgeqhtWiK4UCDV5HaZ+aZQwCLw@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify01: Test setting two marks on different
 filesystems
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW1pciwKCj4gT24gVHVlLCBKYW4gMzAsIDIwMjQgYXQgMzowN+KAr1BNIFBldHIgVm9yZWwg
PHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gPiBIaSBBbWlyLCBKYW4sCgo+ID4gSSB3YXMgZ29p
bmcgdG8gbWVyZ2UsIGJ1dCBJIHN1c3BlY3QgdGhpcyBkb2VzIG5vdCB3b3JrIG9uIFRNUERJUiBv
biBidHJmcy4KCgo+IFRoaXMgaXMgYSBwcm9ibGVtIGJlY2F1c2UgdGhlIHRlc3QgcmVzdWx0IGRl
cGVuZHMgb24gdGhlIHR5cGUgb2YgVE1QRElSLgo+IFRoZSBmYWlsdXJlIGluIHlvdXIgY2FzZSBp
cyBiZWNhdXNlIFRNUERJUiBpcyBub3Qgb25seSBidHJmcywgYnV0IGEKPiBidHJmcyBzdWJ2b2wu
Cj4gSmFuIGhhcyBkZWFsdCB3aXRoIHNldmVyYWwgcmVsYXRlZCBmYW5vdGlmeSB0ZXN0cyBmYWls
dXJlcyBsYXRlbHkuCgo+ID4gVGVzdGVkIG9uIFNMRSAxNS1TUDYgKGtlcm5lbCA2LjQpLCBvbiAx
NS1TUDQgKGtlcm5lbCA1LjE0KSwgVHVtYmxld2VlZCAoa2VybmVsCj4gPiA2LjguMC1yYzEpLCBB
bHBpbmUgTGludXggKGtlcm5lbCA2LjQpIEkgZ2V0OgoKPiA+IGZhbm90aWZ5MDEuYzozNDE6IFRG
QUlMOiBmYW5vdGlmeV9tYXJrKGZkX25vdGlmeSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAwOCwgLTEw
MCwgIi4iKSBmYWlsZWQ6IEVYREVWICgxOCkKCj4gPiBmb3IgdGVzdHMgIzMsICM0IGFuZCAjNSBv
biBhbGwgZmlsZXN5c3RlbXMuCgo+ID4gVGVzdGluZyBvbiBvdGhlciBvbiBvdGhlciBmaWxlc3lz
dGVtIGl0IHdvcmtzOiBEZWJpYW4ga2VybmVsIDUuMTAsIDYuMSBvbiBleHQ0LAo+ID4gQWxwaW5l
IExpbnV4IGtlcm5lbCA2LjQgb24gdG1wZnMsIFR1bWJsZXdlZWQga2VybmVsIDYuOC4wLXJjMSBv
biB0bXBmcy4KCj4gPiBTaG91bGQgYmUgYnRyZnMgaGFuZGxlZCBkaWZmZXJlbnRseSBvciBza2lw
cGVkPyAoYmVsb3cpCj4gPiBPciB0ZXN0IEVYREVWIGZvciAjMywgIzQgYW5kICM1PyAobm90IHN1
cmUgaG93IGhhbmRsZSBqdXN0IGhhbGYgb2YgdGhlIHRlc3RzIG9uCj4gPiBidHJmcyBkaWZmZXJl
bnRseSkuCgo+ID4gS2luZCByZWdhcmRzLAo+ID4gUGV0cgoKPiA+IGRpZmYgLS1naXQgdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTAxLmMgdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTAxLmMKPiA+IGluZGV4IGJhMDlmMzA5ZC4uOTdh
ZGUxODI5IDEwMDY0NAo+ID4gLS0tIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkv
ZmFub3RpZnkwMS5jCj4gPiArKysgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9m
YW5vdGlmeTAxLmMKPiA+IEBAIC0zMzUsOCArMzM1LDE1IEBAIHBhc3M6Cj4gPiAgICAgICAgICAq
IGRpZmZlcmVudCBmaWxlc3lzdGVtcyBhcmUgc3VwcG9ydGVkLgo+ID4gICAgICAgICAgKiBXaGVu
IHRlc3RlZCBmcyBoYXMgemVybyBmc2lkIChlLmcuIGZ1c2UpIGFuZCBldmVudHMgYXJlIHJlcG9y
dGVkCj4gPiAgICAgICAgICAqIHdpdGggZnNpZCtmaWQsIHdhdGNoaW5nIGRpZmZlcmVudCBmaWxl
c3lzdGVtcyBpcyBub3Qgc3VwcG9ydGVkLgo+ID4gKyAgICAgICAgKiBOb3Qgc3VwcG9ydGVkIG9u
IEJ0cmZzLgo+ID4gICAgICAgICAgKi8KPiA+ICsgICAgICAgaWYgKHRzdF9mc190eXBlKCIuIikg
PT0gVFNUX0JUUkZTX01BR0lDKSB7Cj4gPiArICAgICAgICAgICAgICAgdHN0X3JlcyhUQ09ORiwg
InNraXBwZWQgb24gQnRyZnMiKTsKPiA+ICsgICAgICAgICAgICAgICByZXR1cm47Cj4gPiArICAg
ICAgIH0KPiA+ICsKCj4gTm90ZSB0aGF0IGJ0cmZzIGlzIG5vdCB0aGUgRlMgdW5kZXIgdGVzdC4g
SXQgaXMgdGhlIEZTIG9mIFRNUEZTLAo+IHNvIGV2ZW4gaWYgeW91IGRpZCBza2lwLCB0aGlzIG1l
c3NhZ2Ugd291bGQgaGF2ZSBiZWVuIHdyb25nLgoKPiBQbGVhc2UgdHJ5IHRoZSBwYXRjaCBiZWxv
dy4KCkdyZWF0LCB3b3JrcyBhcyBleHBlY3RlZC4KCkkgY2FuIG1lcmdlIGFtZW5kZWQgY29tbWl0
IFsxXSwgb3IgZmVlbCBmcmVlIHRvIHNlbmQgdjIgaWYgeW91IHdhbnQgdG8gbWVudGlvbgpidHJm
cyBzdWJ2b2wgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLgoKS2luZCByZWdhcmRzLApQZXRyCgpbMV0g
aHR0cHM6Ly9naXRodWIuY29tL3BldmlrL2x0cC9jb21taXQvMzU5MDQ3Yzk3MTUxZDg3YjRlNzA5
YmJhYmFhYTUyOWEzMWJjYzUwYgoKPiBUaGFua3MsCj4gQW1pci4KCj4gLS0tIGEvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTAxLmMKPiArKysgYi90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MDEuYwo+IEBAIC0zNjQsMTIgKzM2NCwx
OSBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ICAgICAgICAgbW91bnRfbWFya19maWRfdW5z
dXBwb3J0ZWQgPQo+IGZhbm90aWZ5X2ZsYWdzX3N1cHBvcnRlZF9vbl9mcyhGQU5fUkVQT1JUX0ZJ
RCwKCj4gRkFOX01BUktfTU9VTlQsCgo+IEZBTl9PUEVOLCBmbmFtZSk7Cj4gLSAgICAgICAvKiBX
aGVuIG1vdW50IG1hcmsgaXMgbm90IHN1cHBvcnRlZCBkdWUgdG8gemVybyBmc2lkLCBtdWx0aSBm
cwo+IGlub2RlIG1hcmtzIGFyZSBub3Qgc3VwcG9ydGVkICovCj4gKyAgICAgICAvKgo+ICsgICAg
ICAgICogV2hlbiBtb3VudCBtYXJrIGlzIG5vdCBzdXBwb3J0ZWQgZHVlIHRvIHplcm8gZnNpZCAo
ZS5nLgo+IGZ1c2UpIG9yIGlmIFRNUERJUiBoYXMgbm9uLXVuaWZvcm0KPiArICAgICAgICAqIGZz
aWQgKGUuZy4gYnRyZnMgc3Vidm9sKSwgbXVsdGkgZnMgaW5vZGUgbWFya3MgYXJlIG5vdCBzdXBw
b3J0ZWQuCj4gKyAgICAgICAgKi8KPiAgICAgICAgIGlmIChtb3VudF9tYXJrX2ZpZF91bnN1cHBv
cnRlZCAmJiBlcnJubyA9PSBFTk9ERVYpIHsKPiAgICAgICAgICAgICAgICAgdHN0X3JlcyhUSU5G
TywgImZpbGVzeXN0ZW0gJXMgZG9lcyBub3Qgc3VwcG9ydAo+IHJlcG9ydGluZyBldmVudHMgd2l0
aCBmaWQgZnJvbSBtdWx0aSBmcyIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0
c3RfZGV2aWNlLT5mc190eXBlKTsKPiAgICAgICAgICAgICAgICAgaW5vZGVfbWFya19maWRfeGRl
diA9IEVYREVWOwo+ICAgICAgICAgfQo+ICsgICAgICAgaWYgKGZhbm90aWZ5X2ZsYWdzX3N1cHBv
cnRlZF9vbl9mcyhGQU5fUkVQT1JUX0ZJRCwKPiBGQU5fTUFSS19NT1VOVCwgRkFOX09QRU4sICIu
IikpIHsKPiArICAgICAgICAgICAgICAgaW5vZGVfbWFya19maWRfeGRldiA9IGVycm5vOwo+ICsg
ICAgICAgICAgICAgICB0c3RfcmVzKFRJTkZPLCAiVE1QRElSIGRvZXMgbm90IHN1cHBvcnQgcmVw
b3J0aW5nCj4gZXZlbnRzIHdpdGggZmlkIGZyb20gbXVsdGkgZnMiKTsKPiArICAgICAgIH0KPiAg
fQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
