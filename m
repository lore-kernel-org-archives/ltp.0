Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A56C3ABDD
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 11:35:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E4213CC757
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 13:35:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F9FD3CC6F9
 for <ltp@lists.linux.it>; Tue, 20 May 2025 13:35:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9F97110009DB
 for <ltp@lists.linux.it>; Tue, 20 May 2025 13:35:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ABD0220624;
 Tue, 20 May 2025 11:35:05 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C9B913A3E;
 Tue, 20 May 2025 11:35:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QpNsJeloLGgcegAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Tue, 20 May 2025 11:35:05 +0000
Message-ID: <13b3679f-ca6f-43ee-a56d-865544c2474b@suse.cz>
Date: Tue, 20 May 2025 13:34:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>,
 Andrea Cervesato <andrea.cervesato@suse.com>
References: <20250520-fixes-modify_ldt-v3-1-a78c79341d0c@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20250520-fixes-modify_ldt-v3-1-a78c79341d0c@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: ABD0220624
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ldt.h: Add workaround for x86_64
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCnNhZmVfbW9kaWZ5X2xkdCgpIHNob3VsZCBub3QgYWxsb3cgYW55IGVycm9ycy4gTGV0J3Mg
bWVyZ2UgdjIuCgpPbiAyMC4gMDUuIDI1IDEzOjI5LCBSaWNhcmRvIEIuIE1hcmxpw6hyZSB3cm90
ZToKPiBGcm9tOiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgo+IAo+IFRoZSBj
b21taXQgYmUwYWFjYTJmNzQyICgic3lzY2FsbHMvbW9kaWZ5X2xkdDogQWRkIGxhcGkvbGR0Lmgi
KSBsZWZ0IGJlaGluZAo+IGFuIGltcG9ydGFudCBmYWN0b3Igb2YgbW9kaWZ5X2xkdCgpOiB0aGUg
a2VybmVsIGludGVudGlvbmFsbHkgY2FzdHMgdGhlCj4gcmV0dXJuIHZhbHVlIHRvIHVuc2lnbmVk
IGludC4gVGhpcyB3YXMgaGFuZGxlZCBpbgo+IHRlc3RjYXNlcy9jdmUvY3ZlLTIwMTUtMzI5MC5j
IGJ1dCB3YXMgcmVtb3ZlZC4gQWRkIGl0IGJhY2sgdG8gdGhlIHJlbGV2YW50Cj4gZmlsZS4KPiAK
PiBSZXBvcnRlZC1ieTogTWFydGluIERvdWNoYSA8bWRvdWNoYUBzdXNlLmN6Pgo+IFJldmlld2Vk
LWJ5OiBNYXJ0aW4gRG91Y2hhIDxtZG91Y2hhQHN1c2UuY3o+Cj4gU2lnbmVkLW9mZi1ieTogUmlj
YXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KPiAtLS0KPiBDaGFuZ2VzIGluIHYzOgo+
IC0gRURJVE1FOiBkZXNjcmliZSB3aGF0IGlzIG5ldyBpbiB0aGlzIHNlcmllcyByZXZpc2lvbi4K
PiAtIEVESVRNRTogdXNlIGJ1bGxldHBvaW50cyBhbmQgdGVyc2UgZGVzY3JpcHRpb25zLgo+IC0g
TGluayB0byB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDUxMi1maXhlcy1tb2Rp
ZnlfbGR0LXYyLTEtZWFlZjU1NzdlNDRlQHN1c2UuY29tCj4gCj4gQ2hhbmdlcyBpbiB2MjoKPiAt
IEFkZGVkIFRCUk9LIGZvciBhbnkgcmV0ICE9IDAgaW4gbW9kaWZ5X2xkdCBjYWxsIGluIGN2ZS0y
MDE1LTMyOTAuYwo+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1
MDUwNy1maXhlcy1tb2RpZnlfbGR0LXYxLTEtNzBhMjY5NGNmZGRjQHN1c2UuY29tCj4gLS0tCj4g
ICBpbmNsdWRlL2xhcGkvbGR0LmggfCAzMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGFwaS9sZHQuaCBiL2luY2x1ZGUvbGFwaS9sZHQuaAo+IGlu
ZGV4IDZiNWEyZDU5Y2I0MWJmYzI0ZWI1YWMyNmMzZDQ3ZDQ5ZmI4ZmY3OGYuLjI1MzNlNTBiOWMw
MmE5NzQ5NDdjNjYyOGU5ZmEyMGM5YzYyNmFhMzQgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9sYXBp
L2xkdC5oCj4gKysrIGIvaW5jbHVkZS9sYXBpL2xkdC5oCj4gQEAgLTMxLDcgKzMxLDI3IEBAIHN0
cnVjdCB1c2VyX2Rlc2Mgewo+ICAgc3RhdGljIGlubGluZSBpbnQgbW9kaWZ5X2xkdChpbnQgZnVu
YywgY29uc3Qgc3RydWN0IHVzZXJfZGVzYyAqcHRyLAo+ICAgCQkJICAgICB1bnNpZ25lZCBsb25n
IGJ5dGVjb3VudCkKPiAgIHsKPiAtCXJldHVybiB0c3Rfc3lzY2FsbChfX05SX21vZGlmeV9sZHQs
IGZ1bmMsIHB0ciwgYnl0ZWNvdW50KTsKPiArCWxvbmcgcnZhbDsKPiArCj4gKwllcnJubyA9IDA7
Cj4gKwlydmFsID0gdHN0X3N5c2NhbGwoX19OUl9tb2RpZnlfbGR0LCBmdW5jLCBwdHIsIGJ5dGVj
b3VudCk7Cj4gKwo+ICsjaWZkZWYgX194ODZfNjRfXwo+ICsJLyoKPiArCSAqIFRoZSBrZXJuZWwg
aW50ZW50aW9uYWxseSBjYXN0cyBtb2RpZnlfbGR0KCkgcmV0dXJuIHZhbHVlCj4gKwkgKiB0byB1
bnNpZ25lZCBpbnQgdG8gcHJldmVudCBzaWduIGV4dGVuc2lvbiB0byA2NCBiaXRzLiBUaGlzIG1h
eQo+ICsJICogcmVzdWx0IGluIHN5c2NhbGwoKSByZXR1cm5pbmcgdGhlIHZhbHVlIGFzIGlzIGlu
c3RlYWQgb2Ygc2V0dGluZwo+ICsJICogZXJybm8gYW5kIHJldHVybmluZyAtMS4KPiArCSAqLwo+
ICsJaWYgKHJ2YWwgPiAwICYmIChpbnQpcnZhbCA8IDApIHsKPiArCQl0c3RfcmVzKFRJTkZPLAo+
ICsJCQkiV0FSTklORzogTGliYyBtaXNoYW5kbGVkIG1vZGlmeV9sZHQoKSByZXR1cm4gdmFsdWUi
KTsKPiArCQllcnJubyA9IC0oaW50KWVycm5vOwo+ICsJCXJ2YWwgPSAtMTsKPiArCX0KPiArI2Vu
ZGlmIC8qIF9feDg2XzY0X18gKi8KPiArCj4gKwlyZXR1cm4gcnZhbDsKPiAgIH0KPiAgIAo+ICAg
c3RhdGljIGlubGluZSBpbnQgc2FmZV9tb2RpZnlfbGR0KGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0
IGludCBsaW5lbm8sIGludCBmdW5jLAo+IEBAIC00MCw3ICs2MCwxNSBAQCBzdGF0aWMgaW5saW5l
IGludCBzYWZlX21vZGlmeV9sZHQoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywg
aW50IGZ1bmMsCj4gICB7Cj4gICAJaW50IHJ2YWw7Cj4gICAKPiArCWVycm5vID0gMDsKPiAgIAly
dmFsID0gbW9kaWZ5X2xkdChmdW5jLCBwdHIsIGJ5dGVjb3VudCk7Cj4gKyNpZmRlZiBfX3g4Nl82
NF9fCj4gKwlpZiAocnZhbCA9PSAtMSAmJiBlcnJubyA9PSBFSU5WQUwpIHsKPiArCQl0c3RfYnJr
XyhmaWxlLCBsaW5lbm8sIFRDT05GIHwgVFRFUlJOTywKPiArCQkJICJtb2RpZnlfbGR0KCVkLCAl
cCwgJWx1KTogMTYtYml0IGRhdGEgc2VnbWVudHMgYXJlIHByb2JhYmx5IGRpc2FibGVkIiwKPiAr
CQkJIGZ1bmMsIHB0ciwgYnl0ZWNvdW50KTsKPiArCX0KPiArI2VuZGlmCj4gICAJaWYgKHJ2YWwg
PT0gLTEpIHsKPiAgIAkJdHN0X2Jya18oZmlsZSwgbGluZW5vLCBUQlJPSyB8IFRFUlJOTywKPiAg
IAkJCSAibW9kaWZ5X2xkdCglZCwgJXAsICVsdSkiLCBmdW5jLCBwdHIsIGJ5dGVjb3VudCk7Cj4g
Cj4gLS0tCj4gYmFzZS1jb21taXQ6IGIwNzBhNTY5MmUwMzVlYzEyYzNkM2M3YTdlOWU5N2MyNzBm
ZDRkN2QKPiBjaGFuZ2UtaWQ6IDIwMjUwNTA3LWZpeGVzLW1vZGlmeV9sZHQtZWJjZmRkMmE3ZDMw
Cj4gCj4gQmVzdCByZWdhcmRzLAoKCi0tIApNYXJ0aW4gRG91Y2hhICAgbWRvdWNoYUBzdXNlLmN6
ClNXIFF1YWxpdHkgRW5naW5lZXIKU1VTRSBMSU5VWCwgcy5yLm8uCkNPUlNPIElJYQpLcml6aWtv
dmEgMTQ4LzM0CjE4NiAwMCBQcmFndWUgOApDemVjaCBSZXB1YmxpYwoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
