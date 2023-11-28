Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237ABC4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 16:51:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D68B3CFA72
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 17:51:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 934753CD9DD
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 17:51:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 929FB60071D
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 17:51:37 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0B75F1F899;
 Tue, 28 Nov 2023 16:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701190295;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PQpBwf7aRZ7lwl0TCI+2eHpTa52Fp4ME7dR2NN2+mUQ=;
 b=Jb2teBF2pL8O7JSdSkxkjSkrN3NLA6mbgeVVnJyeefzotGz9FQZtV91guECkQrIuD1ovuF
 0STwvx9js+ETZd0xux7zvjvwRgytrN/0ZNwU7f4FbaxaJ8RQ1TWGHFzyxUkHw/9ezIUKIG
 veZpKOciYnwGn4lVZT3gIQZ7hNve6qI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701190295;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PQpBwf7aRZ7lwl0TCI+2eHpTa52Fp4ME7dR2NN2+mUQ=;
 b=F/50VQ+YDATuuz2vXHLftlF0/EcpvgzAT7JVJlJ5yVTLYMhs7wkrqi6FYdoyIR/ah7T3w1
 jWyIgaxPTeZVPzBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C19F6139FC;
 Tue, 28 Nov 2023 16:51:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id HUozLpYaZmVfXwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 28 Nov 2023 16:51:34 +0000
Date: Tue, 28 Nov 2023 17:51:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20231128165132.GA406520@pevik>
References: <20231127174517.2369593-1-shr@devkernel.io>
 <20231128074626.GA298624@pevik>
 <CAEemH2dQDVg+nLD4cTjgReoUaZ+FU7TFEsg=Vc8h6sdV-VqLpg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dQDVg+nLD4cTjgReoUaZ+FU7TFEsg=Vc8h6sdV-VqLpg@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-7.50 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mem: disable KSM smart scan for ksm tests
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
Cc: david@redhat.com, Stefan Roesch <shr@devkernel.io>, linux-mm@kvack.org,
 oliver.sang@intel.com, kernel-team@fb.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgU3RlZmFuLCBMaSwKCj4gSGkgU3RlZmFuLCBQZXRyLAoKPiBPbiBUdWUsIE5vdiAyOCwgMjAy
MyBhdCAzOjQ24oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+IEhp
IFN0ZWZhbiwKCj4gPiA+IFRoaXMgZGlzYWJsZXMgdGhlICJzbWFydCBzY2FuIiBLU00gZmVhdHVy
ZSB0byBtYWtlIHN1cmUgdGhhdCB0aGUgdm9sYXRpbGUKPiA+ID4gY291bnQgcmVtYWlucyBhdCAw
LgoKPiA+ID4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIFJvZXNjaCA8ZGV2a2VybmVsLmlvPgo+ID4g
bml0OiB5b3UgZm9yZ290ICdzaHJAJwo+ID4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIFJvZXNjaCA8
c2hyQGRldmtlcm5lbC5pbz4KCj4gPiA+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8
b2xpdmVyLnNhbmdAaW50ZWwuY29tPgo+ID4gPiBDbG9zZXM6Cj4gPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9vZS1sa3AvMjAyMzExMTYxMTMyLjEzZDhjZTVhLW9saXZlci5zYW5nQGludGVsLmNv
bQo+ID4gPiAtLS0KPiA+ID4gIHRlc3RjYXNlcy9rZXJuZWwvbWVtL2xpYi9tZW0uYyB8IDQgKysr
Kwo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKPiA+ID4gZGlmZiAtLWdp
dCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2xpYi9tZW0uYwo+ID4gYi90ZXN0Y2FzZXMva2VybmVs
L21lbS9saWIvbWVtLmMKPiA+ID4gaW5kZXggZmJmZWVmMDI2Li5lZjI3NGEzYWMgMTAwNjQ0Cj4g
PiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2xpYi9tZW0uYwo+ID4gPiArKysgYi90ZXN0
Y2FzZXMva2VybmVsL21lbS9saWIvbWVtLmMKPiA+ID4gQEAgLTQ1NCw2ICs0NTQsOSBAQCB2b2lk
IGNyZWF0ZV9zYW1lX21lbW9yeShpbnQgc2l6ZSwgaW50IG51bSwgaW50IHVuaXQpCj4gPiA+ICAg
ICAgICAgICAgICB7J2EnLCBzaXplKk1CfSwgeydhJywgc2l6ZSpNQn0sIHsnZCcsIHNpemUqTUJ9
LCB7J2QnLAo+ID4gc2l6ZSpNQn0sCj4gPiA+ICAgICAgIH07Cgo+ID4gPiArICAvKiBEaXNhYmxl
IHNtYXJ0IHNjYW4gZm9yIGNvcnJlY3Qgdm9sYXRpbGUgY291bnRzLiAqLwo+ID4gPiArICBTQUZF
X0ZJTEVfUFJJTlRGKFBBVEhfS1NNICJzbWFydF9zY2FuIiwgIjAiKTsKPiA+IE5PVEUsIHRoaXMg
ZmFpbHMgb24gdGhlIHN5c3RlbXMgd2l0aG91dCAvc3lzL2tlcm5lbC9tbS9rc20vc21hcnRfc2Nh
bjoKCj4gPiBtZW0uYzo0NTg6IFRCUk9LOiBGYWlsZWQgdG8gb3BlbiBGSUxFICcvc3lzL2tlcm5l
bC9tbS9rc20vc21hcnRfc2NhbicgZm9yCj4gPiB3cml0aW5nOiBFQUNDRVMgKDEzKQoKPiA+IE5P
VEUsIHdlIG5vcm1hbGx5IGhhbmRsZSB0aGUgc2V0dXAgbGlrZSB0aGlzIGluIHRlc3Qgc2V0dXAg
ZnVuY3Rpb24uCgo+ID4gQnV0IG5ldyBBUEkgaGFzIC5zYXZlX3Jlc3RvcmUgd2hpY2ggaXMgbW9y
ZSByb2J1c3QgZm9yIHRhc2tzICBsaWtlIHRoaXMuCj4gPiBJdCdzIGFscmVhZHkgdXNlZCBpbiBr
c20wMS5jLCB5b3UgbmVlZCBqdXN0IHRvIGFkZCB0aGlzIGxpbmU6Cj4gPiAgICAgICAgIHsiL3N5
cy9rZXJuZWwvbW0va3NtL3NtYXJ0X3NjYW4iLCAiMCIsIFRTVF9TUl9TS0lQfSwKCgo+IEkgZ3Vl
c3Mgd2UgbmVlZCB0byBzZXQgJ1RTVF9TUl9TS0lQX01JU1NJTkcgfCBUU1RfU1JfVEJST0tfUk8n
Cj4gYXMgdGhlIGxhc3QgZmllbGQuIEJlY2F1c2UgVFNUX1NSX1NLSVAgd2lsbCBjb250aW51ZSB0
aGUgdGVzdCB3aXRob3V0Cj4gd3JpdGluZyAnMCcgdG8gdGhlIHNtYXJ0X3NjYW4gZmlsZSwgdGhh
dCdzIG5vdCBjb3JyZWN0IGlmIHRoZSBmaWxlIGV4aXN0cy4KPiBJdCB3aWxsCj4gaWdub3JlIGEg
a2VybmVsIGJ1ZyAoc21hcnRfc2NhbiBjYW4ndCBiZSB3cml0dGVuKSBieSB0aGF0IGNvbmZpZy4K
Cj4gUGVyIHRoZSBEb2MgUGV0ciBwb2ludGVkIGJlbG93Ogo+ICAgVFNUX1NSX1NLSVBfTUlTU0lO
RyDigJMgQ29udGludWUgd2l0aG91dCBzYXZpbmcgdGhlIGZpbGUgaWYgaXQgZG9lcyBub3QKPiBl
eGlzdAo+ICAgVFNUX1NSX1RCUk9LX1JPIOKAkyBFbmQgdGVzdCB3aXRoIFRCUk9LIGlmIHRoZSBm
aWxlIGlzIHJlYWQtb25seQo+ICAgVFNUX1NSX1NLSVBfUk8g4oCTIENvbnRpbnVlIHdpdGhvdXQg
c2F2aW5nIHRoZSBmaWxlIGlmIGl0IGlzIHJlYWQtb25seQo+ICAgVFNUX1NSX1NLSVAg4oCTIEVx
dWl2YWxlbnQgdG8gJ1RTVF9TUl9TS0lQX01JU1NJTkcgfCBUU1RfU1JfU0tJUF9STycKCgoKPiA+
IChpbnN0ZWFkIG9mIGJvdGggU0FGRV9GSUxFX1BSSU5URikKCj4gPiBTZWU6Cgo+ID4gaHR0cHM6
Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvd2lraS9DLVRlc3QtQVBJIzEyNy1z
YXZpbmctLXJlc3RvcmluZy1wcm9jc3lzLXZhbHVlcwoKPiA+IEkgd29uZGVyIGlmIGtzbTAxLmMg
aXMgdGhlIG9ubHkga3NtIHRlc3Qgd2hpY2ggbmVlZHMgdG8gZGlzYWJsZSB0aGlzLgoKCj4gSSB0
aGluayBhbGwgb2YgdGhlIGtzbTAqLmMgdGVzdHMgc2hvdWxkIGRpc2FibGUgaXQgYnkgdGhlIGNv
bmZpZy4gVGhlCj4gc21hcnRfc2Nhbgo+IHdpbGwgaW1wYWN0IGFsbCB0aGUgdGVzdHMgd2l0aCBp
bnZva2Uga2V5IGZ1bmN0aW9uIGNyZWF0ZV9zYW1lX21lbW9yeSgpLgoKa3NtMDUuYyBhbmQga3Nt
MDYuYyBkb2VzIG5vdCB1c2UgY3JlYXRlX3NhbWVfbWVtb3J5KCkuIE9yIGRpZCBJIG92ZXJsb29r
CnNvbWV0aGluZz8KCj4gPiBhbHNvIG5pdDogdGhlcmUgaXMgYSB3cm9uZyBpbmRlbnQgKHNwYWNl
cyBpbnN0ZWFkIG9mIHRhYnMpLCBwbGVhc2UgYmUKPiA+IGNvbnNpc3RlbnQKPiA+IHdpdGggdGhl
IGZpbGUgY29udGVudC4KCj4gPiBOT1RFOiB3aGlsZSB0aGlzIGZpeGVzIHByb2JsZW0gb24gNi43
LjAtcmMxLTIuZzg2ZTQ2YzItZGVmYXVsdCAob3BlblNVU0UpLAo+ID4gaXQgZG9lcyBub3QgZml4
ZXMgb3RoZXIgcHJvYmxlbSBvbiA2LjUuMTAgb24gRGViaWFuICgxNiBlcnJvcnMgbGlrZSB0aGVz
ZQo+ID4gYmVsb3cpOgoKPiA+IG1lbS5jOjI1MjogVEZBSUw6IHBhZ2VzX3NoYXJlZCBpcyBub3Qg
MiBidXQgNTAzOC4KPiA+IG1lbS5jOjI1MjogVEZBSUw6IHBhZ2VzX3NoYXJpbmcgaXMgbm90IDk4
MzAyIGJ1dCA1OTM2MjkuCj4gPiBtZW0uYzoyNTI6IFRGQUlMOiBwYWdlc192b2xhdGlsZSBpcyBu
b3QgMCBidXQgMzkxLgo+ID4gbWVtLmM6MjUyOiBURkFJTDogcGFnZXNfdW5zaGFyZWQgaXMgbm90
IDAgYnV0IDE0OTE1Ny4KCj4gPiBJIGhhdmUgbm8gaWRlYSBpZiB0aGlzIGlzIGEgcmVhbCBidWcg
d2hpY2ggbmVlZHMgdG8gYmUgZml4ZWQgb3IgdGVzdCBmYWxzZQo+ID4gcG9zaXRpdmUgdG8gYmUg
Zml4ZWQsIG9yIHdoZXRoZXIgdGhlIHByb2JsZW0gaGFzIGFscmVhZHkgYmVlbiBmaXhlZCBpbgo+
ID4gbmV3ZXIKPiA+IGtlcm5lbHMuCgoKPiBJdCBpcyBtb3JlIGxpa2UgYSByZWFsIGJ1ZywgdGhl
IERlYmFpbiBrZXJuZWwtNi41LjEwIGRvZXMgbm90IGNvbnRhaW4KPiB0aGlzIHNtYXJ0X3NjYW4g
ZmVhdHVyZS4gT3IgeW91IG1heSB0cnkgdG8gYnVpbGQgdGhlIGxhdGVzdCBrZXJuZWwKPiBvbiB5
b3VyIHBsYXRmb3JtIHRvIHNlZSBpZiBpdCBjYW4gYmUgcmVwcm9kdWNlZCBhcyB3ZWxsLgoKCkkn
bGwgdHJ5IHRvIHJlcHJvZHVjZSB0aGlzIG9uIG1haW5saW5lIGtlcm5lbCA2LjUsIDYuNiBhbmQg
Ni43LgoKCj4gPiA+ICsKPiA+ID4gICAgICAgcHMgPSBzeXNjb25mKF9TQ19QQUdFX1NJWkUpOwo+
ID4gPiAgICAgICBwYWdlcyA9IE1CIC8gcHM7Cgo+ID4gPiBAQCAtNTI2LDYgKzUyOSw3IEBAIHZv
aWQgY3JlYXRlX3NhbWVfbWVtb3J5KGludCBzaXplLCBpbnQgbnVtLCBpbnQgdW5pdCkKCj4gPiA+
ICAgICAgIHRzdF9yZXMoVElORk8sICJzdG9wIEtTTS4iKTsKPiA+ID4gICAgICAgU0FGRV9GSUxF
X1BSSU5URihQQVRIX0tTTSAicnVuIiwgIjAiKTsKPiA+ID4gKyAgU0FGRV9GSUxFX1BSSU5URihQ
QVRIX0tTTSAic21hcnRfc2NhbiIsICIxIik7Cj4gPiBuaXQ6IEFnYWluLCB3cm9uZyBpbmRlbnQu
IFlvdSBjb3VsZCBoYXZlIHNlZW4gaXQgYWxzbyBpbiB0aGUgZ2VuZXJhdGVkCj4gPiBwYXRjaC4K
Cj4gPiBLaW5kIHJlZ2FyZHMsCj4gPiBQZXRyCgo+ID4gPiAgICAgICBmaW5hbF9ncm91cF9jaGVj
aygwLCAwLCAwLCAwLCAwLCAwLCBzaXplICogcGFnZXMgKiBudW0pOwoKPiA+ID4gICAgICAgd2hp
bGUgKHdhaXRwaWQoLTEsICZzdGF0dXMsIDApID4gMCkKCj4gPiA+IGJhc2UtY29tbWl0OiA4Yzg5
ZWYzZDQ1MTA4N2VkNmUxODc1MGJkNWVlZGQxMGU1YWIzZDJlCgoKCj4gT25lIG1vcmUgY29tbWVu
dCBub3QgcmVsYXRlZCB0byB0aGlzIHBhdGNoOgoKPiBAU3RlZmFuLCBkbyB5b3UgaGF2ZSBhIHRl
c3QgKG9yIHBsYW4gdG8pIHZlcmlmeSB0aGUgJ3NtYXJ0X3NjYW4nIGZldHVyZQo+IHdvcmtzPwo+
IEFzIHdlIGRvIGRpc2FibGVzIGl0IGZvciBhbGwga3NtKiB0ZXN0cyBpbiBMVFAsIHNvLCBpdCB3
b3VsZCBiZSBncmVhdCB0bwo+IGhhdmUgb25lCj4gZm9yIHRlc3RpbmcgaW4gZW5hYmxlIG1vZGUu
IFdoYXQgZG8geW91IHRoaW5rPwoKVGhpcyBtYWtlcyBwZXJmZWN0IHNlbnNlIGV2ZW4gaWYgSSdt
IG5vdCB0aGF0IGtzbTA1LmMgYW5kIGtzbTA2LmMgYWxzbyBuZWVkcyB0bwpkaXNhYmxlIHNtYXJ0
X3NjYW4uCgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
