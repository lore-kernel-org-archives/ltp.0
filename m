Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69693C54E5D
	for <ltp@archiver.kernel.org>; Tue, 12 Mar 2024 13:10:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C67E03CFD66
	for <ltp@archiver.kernel.org>; Tue, 12 Mar 2024 14:10:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C61C3C8217
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 14:10:28 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9191B208D28
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 14:10:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DB6CE5D523;
 Tue, 12 Mar 2024 13:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710249025;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J8GkMaJ86AM7W1xSMjJJEwppvE0ELtA6J+k06yh08Vg=;
 b=rGGP1ptjNA7wcGWYgZ/dGlc/DpWzRp1dIWBGkmGd0FOpbrzz1uNNov6pPPQhcGylhh0Bhr
 V782B1A16InMr5upLwi/3PsbJR7YvLPl2jAQy34B6N4IiHR+9gG1FCj6qC4nCDNeVehy0a
 hsL1zHViI2lKB5TbjkMCjli3vewb5DY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710249025;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J8GkMaJ86AM7W1xSMjJJEwppvE0ELtA6J+k06yh08Vg=;
 b=jjB1GxfW5ogH9galI2MAqX3fKEFV3FNQeBK68cdQJj3N4rnmE/FLhHnj+PP9rxDq/fhljR
 qzaUy8yvan20ecBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710249025;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J8GkMaJ86AM7W1xSMjJJEwppvE0ELtA6J+k06yh08Vg=;
 b=rGGP1ptjNA7wcGWYgZ/dGlc/DpWzRp1dIWBGkmGd0FOpbrzz1uNNov6pPPQhcGylhh0Bhr
 V782B1A16InMr5upLwi/3PsbJR7YvLPl2jAQy34B6N4IiHR+9gG1FCj6qC4nCDNeVehy0a
 hsL1zHViI2lKB5TbjkMCjli3vewb5DY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710249025;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J8GkMaJ86AM7W1xSMjJJEwppvE0ELtA6J+k06yh08Vg=;
 b=jjB1GxfW5ogH9galI2MAqX3fKEFV3FNQeBK68cdQJj3N4rnmE/FLhHnj+PP9rxDq/fhljR
 qzaUy8yvan20ecBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C1C31364F;
 Tue, 12 Mar 2024 13:10:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VzEqJEFU8GUaBgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 12 Mar 2024 13:10:25 +0000
Date: Tue, 12 Mar 2024 14:10:24 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20240312131024.GA472499@pevik>
References: <20240307092603.16269-1-meted@linux.ibm.com>
 <CAOQ4uxhFB2Gv2+8N-sc9a1+Kz1KqW+bniJe0JhVSHsaMWnxrmQ@mail.gmail.com>
 <3700d7c9-2f7e-4946-be27-87f500ccb6dd@linux.ibm.com>
 <CAOQ4uxgrGwiwpsLinWvVER-2W3AJxA0tR3qox-V4rxnt=OTTig@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgrGwiwpsLinWvVER-2W3AJxA0tR3qox-V4rxnt=OTTig@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fanotify14: fix anonymous pipe testcases
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
Cc: Mete Durlu <meted@linux.ibm.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTWV0ZSwgQW1pciwgTGksCgpbIENjIExpIHdobyBrbm93cyBtb3JlIGFib3V0IFNFTGludXgg
OikgXQoKPiBPbiBNb24sIE1hciAxMSwgMjAyNCBhdCA0OjUz4oCvUE0gTWV0ZSBEdXJsdSA8bWV0
ZWRAbGludXguaWJtLmNvbT4gd3JvdGU6Cgo+ID4gT24gMy84LzI0IDE0OjM5LCBBbWlyIEdvbGRz
dGVpbiB3cm90ZToKPiA+ID4gT24gRnJpLCBNYXIgOCwgMjAyNCBhdCAyOjQz4oCvUE0gTWV0ZSBE
dXJsdSA8bWV0ZWRAbGludXguaWJtLmNvbT4gd3JvdGU6Cgo+ID4gPj4gV2hlbiBTRWxpbnV4IGlz
IGNvbmZpZ3VyZWQgKGNvbWVzIG91dCBvZiB0aGUgYm94IG9uIG1vc3QgZGlzdHJvcykgYW5kCj4g
PiA+PiBpcyBjb25maWd1cmVkIHRvIGVuZm9yY2luZyAodGhlIGRlZmF1bHQgY29uZmlndXJhdGlv
biksIHRlc3RzIHJlbGF0ZWQKPiA+ID4+IHRvIGFub255bW91cyBwaXBlcyByZXR1cm4gRUFDQ0VT
IGluc3RlYWQgb2YgdGhlIGV4cGVjdGVkIGVycm5vIEVJTlZBTC4KPiA+ID4+IEZpeCB0aGUgZmFp
bHVyZXMgY2F1c2VkIGJ5IHRoZSBhYm92ZSBjb25kaXRpb24gYnkgY2hlY2tpbmcgdGhlIFNFbGlu
dXgKPiA+ID4+IGNvbmZpZ3VyYXRpb24gYW5kIGFkanVzdGluZyB0aGUgZXJybm8gYWNjb3JkaW5n
bHkuCgo+ID4gPiBIaSBNZXRlLAoKPiA+ID4gSXNuJ3QgdGhlIG91dGNvbWUgb2YgdGhlIHRlc3Qg
ZGVwZW5kZW50IG9uIHRoZSBTRXBvbGljeSBydWxlcz8KPiA+ID4gTm90IG9ubHkgaWYgaXQgaXMg
ZW5mb3JjZWQ/Cgo+ID4gPiBTb3JyeSBJIGhhdmUgdmVyeSBsaXR0bGUgZXhwZXJpZW5jZSB3aXRo
IFNFTGludXguCgoKPiA+IEhpIEFtaXIsCgo+ID4gSSBkb24ndCBoYXZlIFNFbGludXggZXhwZXJp
ZW5jZSBlaXRoZXIsIG9uIG15IHByb3Bvc2VkIHBhdGNoIEkgb25seQo+ID4gY29uc2lkZXJlZCB0
aGUgZGVmYXVsdCBiZWhhdmlvciBidXQgeW91IGFyZSByaWdodCBkaWZmZXJlbnQgU0VsaW51eAo+
ID4gY29uZmlndXJhdGlvbnMgbWF5IGxlYWQgdG8gZGlmZmVyZW50IG91dGNvbWVzLiBJIHNraW1t
ZWQgb3ZlciBTRWxpbnV4Cj4gPiB3aWtpIGEgbGl0dGxlIGFuZCBub3cgSSB0aGluayB0cnlpbmcg
dG8gdmVyaWZ5IHRoZSBTRWxpbnV4IHBvbGljeSB3b3VsZAo+ID4gYmUgdG9vIGN1bWJlcnNvbWUu
IEluc3RlYWQgSSBwcm9wb3NlIHR3byBkaWZmZXJlbnQgc29sdXRpb25zLgoKPiA+IDEuIFdlIGNh
biBza2lwIHRoZSBhbm9ueW1vdXMgcGlwZSB0ZXN0IGNhc2VzIHdoZW4gU0VsaW51eCBpcyBpbgo+
ID4gICAgIGVuZm9yY2luZyBzdGF0ZS4KCj4gPiBvcgoKPiA+IDIuIFdlIGNhbiBhY2NlcHQgYm90
aCBFQUNFU1MgYW5kIEVJTlZBTCBhcyB2YWxpZCBlcnJub3Mgd2hlbiBTRWxpbnV4IGlzCj4gPiAg
ICAgaW4gZW5mb3JjaW5nIHN0YXRlLgoKPiA+IFBlcnNvbmFsbHkgb3B0aW9uIDIgc291bmRzIGJl
dHRlciB0byBtZSBzaW5jZSB3ZSB3b3VsZCBnZXQgbW9yZSBjb3ZlcmFnZQo+ID4gdGhhdCB3YXku
IElmIGVpdGhlciB3YXkgc291bmRzIGdvb2QgSSBjYW4gc2VuZCBhIHYyIHJpZ2h0IGF3YXkuIEhv
dyBkb2VzCj4gPiB0aGF0IHNvdW5kPwoKPiBvcHRpb24gMiBzb3VuZHMgZ29vZCB0byBtZS4KClll
cywgRUFDRVNTIGZvciBlbmZvcmNlZCBTRUxpbnV4IGlzIHdoYXQgd2Ugd2FudC4KCk1ldGUsIHRo
YW5rIHlvdSBmb3IgaGFuZGxpbmcgdGhpcy4gSSBjYW4gY29uZmlybSBpdCdzIGEgcHJvYmxlbSBv
biBTRUxpbnV4CmVuZm9yY2VkLiBBbmQgSSBzdXBwb3NlIHRoZSBjdXJyZW50IGNvZGUgd29ya3Ms
IGJ1dCB3ZSBuZWVkIHNvbWUgbW9kaWZpY2F0aW9ucwoocGxlYXNlIGxldCBtZSBrbm93IGlmIHlv
dSBkb24ndCBoYXZlIHRpbWUgZm9yIHYyKToKCiogUHV0IHRzdF9zZWxpbnV4X2VuZm9yY2luZygp
IGZ1bmN0aW9uIGludG8gTFRQIGxpYnJhcnk6IHlvdSBuZWVkIHRvIGNyZWF0ZQpsaWIvdHN0X3Nl
bGludXguYyBhbmQgaW5jbHVkZS90c3Rfc2VsaW51eC5jLiBGb3IgaW5zcGlyYXRpb24gaGF2ZSBs
b29rIGF0CmxpYi90c3RfbG9ja2Rvd24uYyB2diBpbmNsdWRlL3RzdF9sb2NrZG93bi5oLiBUaGUg
cmVhc29uIGlzIG9idmlvdXM6IHNvb25lciBvcgpsYXRlciB3ZSB3aWxsIHJldXNlIHRoaXMgZnVu
Y3Rpb25hbGl0eS4KCiogdXNlIGFjY2VzcygpLCBwcmludCBhbHNvIFRJTkZPIChzaW1pbGFybHkg
dG8gbGliL3RzdF9sb2NrZG93bi5jKQoKKiAvc3lzL2ZzL3NlbGludXggdnMuIC9zZWxpbnV4LCBz
ZWxpbnV4PTEgdnMuIHNlY3VyaXR5PXNlbGludXggKC9wcm9jL2NtZGxpbmUpCkBMaTogVEw7RFI6
IHJlYWRpbmcganVzdCAvc3lzL2ZzL3NlbGludXgvZW5mb3JjZSBMR1RNLCBidXQgcGxlYXNlIGNo
ZWNrCgpJIHN1cHBvc2Ugd2UgY2FuIHJlbHkgb24gc2VsaW51eGZzIGJlaW5nIG1vdW50ZWQgb24g
L3N5cy9mcy9zZWxpbnV4OgoKJCBtb3VudCB8IGdyZXAgLWkgc2VsaW51eApzZWxpbnV4ZnMgb24g
L3N5cy9mcy9zZWxpbnV4IHR5cGUgc2VsaW51eGZzIChydyxub3N1aWQsbm9leGVjLHJlbGF0aW1l
KQoKTG9uZyB0aW1lIGFnbyB0aGUgZGlyZWN0b3J5IHdhcyBqdXN0IC9zZWxpbnV4IChSSEVMIDUg
b3IgNj8pLCB0aGF0J3Mgd2h5IGl0J3MKc3RpbGwgY2hlY2tlZCBpbiBzaGVsbCBBUEkgdGVzdGNh
c2VzL2xpYi90c3Rfc2VjdXJpdHkuc2guIFRoZXNlIHN5c3RlbXMgYXJlCnF1aXRlIG9sZCB0byBy
dW4gbmV3ZXN0IExUUCwgcmlnaHQ/IEZyb20gZDQxNDE1ZWI1ZWRhZSBbMV0gSSBzZWUgaXQgd2Fz
IGtlcm5lbAozLjAgPT4gd2F5IHRvbyBvbGQgdG8gY29uc2lkZXIuCgpJIGd1ZXNzIHdlIGNhbm5v
dCByZWx5IG9uIHNlbGludXg9MSBvciBzZWN1cml0eT1zZWxpbnV4IHRvIGRldGVjdCBlbmZvcmNl
IG1vZGUuClRoZXJlIGlzIFNFQ1VSSVRZX1NFTElOVVhfQk9PVFBBUkFNLCB3aGVuIGRpc2FibGVk
IHRodXMgdGhlcmUgaXMgbm8gc2VsaW51eD0xCnZhcmlhYmxlIGluIC9wcm9jL2NtZGxpbmUsIHRo
dXMgd2UgY2Fubm90IHJlbHkgb24gaXQgKGluc3RlYWQgb2YgdXNpbmcKL3N5cy9mcy9zZWxpbnV4
KS4KCkFsc28sIGtlcm5lbCA8IHY1LjEgaGFkIFNFQ1VSSVRZX1NFTElOVVhfQk9PVFBBUkFNX1ZB
TFVFIChyZW1vdmVkIGluCmJlNmVjODhmNDFiYTk0IGluIHY1LjEgWzJdKSwgYW5vdGhlciByZWFz
b24gbm90IHRvIHJlbHkgb24gc2VsaW51eCBpbgovcHJvYy9jbWRsaW5lLgoKTk9URTogYXMgSSBu
b3RlZCBwcmV2aW91c2x5IHdlIGhhdmUgc3VwcG9ydCBmb3IgU0VMaW51eCAoYW5kIEFwcEFybW9y
KSBkZXRlY3Rpb24KaW4gc2hlbGwgQVBJIHRlc3RjYXNlcy9saWIvdHN0X3NlY3VyaXR5LnNoLCB3
ZSBtaWdodCBsYXRlciBjcmVhdGUgc2ltcGxlIEMKYmluYXJ5IGluIHRlc3RjYXNlcy9saWIvIHdo
aWNoIHdpbGwgY2FsbCBmdW5jdGlvbiB5b3UgY3JlYXRlIGluIEMgQVBJIChzaW1pbGFybHkKdG8g
dGVzdGNhc2VzL2xpYi90c3RfbG9ja2Rvd25fZW5hYmxlZC5jKSwgYnV0IHdlIGNhbiBpZ25vcmUg
aXQgbm93LgoKS2luZCByZWdhcmRzLApQZXRyCgpbMV0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9ZDQx
NDE1ZWI1ZWRhZQpbMl0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9YmU2ZWM4OGY0MWJhOTQKCj4gVGhh
bmtzLAo+IEFtaXIuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
