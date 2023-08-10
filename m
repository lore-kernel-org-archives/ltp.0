Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82F0C41513
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 14:25:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F40A3CD080
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 16:25:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFA4E3C4BC7
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 16:25:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 51CD61400F49
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 16:25:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2D7171F45B;
 Thu, 10 Aug 2023 14:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691677525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KF1ViBUJaKaU7XbUXk1yqyR5Z5trB9ou7+ImX+7HCEE=;
 b=KJFDgICJDhUksOkNgH5yFVOBifl3XmvT9xZQppaQmwhjjYBhdaKzgDnHbgbiMU+1CeA1yz
 B2550i2s7Z7GWrhjnL9erd+Nuq/5wRlQjZtbxykcJM+azvkSykLg1XmFTMFDfLtFXQsEPj
 V2h8g/3aYK76MGhVakz+ZxoOXpBRMqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691677525;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KF1ViBUJaKaU7XbUXk1yqyR5Z5trB9ou7+ImX+7HCEE=;
 b=nN5prffpCxZoRAHQ7KVbKRapqbFnLU5PpiPKzu1uydivq4L06QQB1Hld5s1Zzpl1Y+VAl4
 cAev88VDSkb2toCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EB94138E0;
 Thu, 10 Aug 2023 14:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id B852B1Xz1GRWBAAAMHmgww
 (envelope-from <jack@suse.cz>); Thu, 10 Aug 2023 14:25:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 82665A076F; Thu, 10 Aug 2023 16:25:24 +0200 (CEST)
Date: Thu, 10 Aug 2023 16:25:24 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20230810142524.xmrf4xfplxe7hv2e@quack3>
References: <20230810131012.13026-1-jack@suse.cz>
 <CAOQ4uxiY3Qajthb_kVhzGbuzqzJvUWXdF4HRW=YtaojQ1Ys3DA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiY3Qajthb_kVhzGbuzqzJvUWXdF4HRW=YtaojQ1Ys3DA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify23: Make evictable marks tests more
 reliable
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it, petr.vorel@suse.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1IDEwLTA4LTIzIDE2OjMwOjMyLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToKPiBPbiBUaHUs
IEF1ZyAxMCwgMjAyMyBhdCA0OjEw4oCvUE0gSmFuIEthcmEgPGphY2tAc3VzZS5jej4gd3JvdGU6
Cj4gPgo+ID4gSXQgaGFzIGJlZW4gb2JzZXJ2ZWQgdGhhdCB3aGVuIGZhbm90aWZ5MjMgdGVzdCBp
cyBydW4gaW4gYSBsb29wLCBpdAo+ID4gZXZlbnR1YWxseSBmYWlscyBhczoKPiA+Cj4gPiBmYW5v
dGlmeTIzLmM6MTEyOiBUUEFTUzogRkFOX01BUktfQUREIGZhaWxlZCB3aXRoIEVFWElTVCBhcyBl
eHBlY3RlZCB3aGVuIHRyeWluZyB0byBkb3duZ3JhZGUgdG8gZXZpY3RhYmxlIG1hcmsKPiA+IGZh
bm90aWZ5MjMuYzo3NTogVFBBU1M6IEZBTl9NQVJLX1JFTU9WRSBmYWlsZWQgd2l0aCBFTk9FTlQg
YXMgZXhwZWN0ZWQgYWZ0ZXIgZW1wdHkgbWFzawo+ID4gZmFub3RpZnkyMy5jOjE1NjogVFBBU1M6
IEdvdCBubyBldmVudHMgYXMgZXhwZWN0ZWQKPiA+IGZhbm90aWZ5MjMuYzo4MTogVEZBSUw6IEZB
Tl9NQVJLX1JFTU9WRSBkaWQgbm90IGZhaWwgd2l0aCBFTk9FTlQgYXMgZXhwZWN0ZWQgYWZ0ZXIg
ZHJvcF9jYWNoZXM6IFNVQ0NFU1MgKDApCj4gPgo+ID4gVGhpcyBpcyBiZWNhdXNlIHJlcGVhdGVk
IGV2aWN0aW9ucyBvZiBjYWNoZXMgZG9uZSBieSB0aGUgdGVzdCByZWNsYWltCj4gPiBhbGwgZnJl
ZWFibGUgc2xhYiBvYmplY3RzIGluIHRoZSBzeXN0ZW0uIFNvIHdoZW4gdGhlIHRlc3QgY2FsbHMg
ZHJvcAo+ID4gY2FjaGVzLCBvbmx5IHRoZSBkZW50cnkgYW5kIGlub2RlIG9mIHRoZSB0ZXN0IGZp
bGUgYXJlIHRoZXJlIHRvIHJlY2xhaW0uCj4gPiBCdXQgZm9yIGlub2RlIHRvIGJlIHJlY2xhaW1l
ZCwgZGVudHJ5ICh3aGljaCBob2xkcyBpbm9kZSByZWZlcmVuY2UpIGhhcwo+ID4gdG8gYmUgZnJl
ZWQgZmlyc3QgYW5kIGZvciBkZW50cnkgdG8gYmUgZnJlZWQgaXQgaGFzIHRvIGZpcnN0IGN5Y2xl
Cj4gPiB0aHJvdWdoIHRoZSBMUlUgd2hpY2ggdGFrZXMgdHdvIHNsYWIgcmVjbGFpbSBjYWxscy4K
PiA+Cj4gPiBDYWxsIGRyb3AgY2FjaGVzIHR3aWNlIHRvIG1ha2Ugc3VyZSBkZW50cnkgaGFzIGNo
YW5jZSB0byBwYXNzIHRocm91Z2gKPiA+IHRoZSBMUlUgYW5kIGJlIHJlY2xhaW1lZC4KPiA+Cj4g
PiBTaWduZWQtb2ZmLWJ5OiBKYW4gS2FyYSA8amFja0BzdXNlLmN6Pgo+ID4gLS0tCj4gPiAgdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTIzLmMgfCA3ICsrKysrKy0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPgo+
ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3Rp
ZnkyMy5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTIzLmMK
PiA+IGluZGV4IDg5ZmQ0ZjM2YTA5Yi4uMmQ1MGY3MDU4NWI3IDEwMDY0NAo+ID4gLS0tIGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTIzLmMKPiA+ICsrKyBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyMy5jCj4gPiBAQCAtMTYw
LDEwICsxNjAsMTUgQEAgc3RhdGljIHZvaWQgdGVzdF9mYW5vdGlmeSh2b2lkKQo+ID4gICAgICAg
ICB9Cj4gPgo+ID4gICAgICAgICAvKgo+ID4gLSAgICAgICAgKiBkcm9wX2NhY2hlcyBzaG91bGQg
ZXZpY3QgaW5vZGUgZnJvbSBjYWNoZSBhbmQgcmVtb3ZlIGV2aWN0YWJsZSBtYXJrCj4gPiArICAg
ICAgICAqIGRyb3BfY2FjaGVzIHNob3VsZCBldmljdCBpbm9kZSBmcm9tIGNhY2hlIGFuZCByZW1v
dmUgZXZpY3RhYmxlIG1hcmsuCj4gPiArICAgICAgICAqIFdlIGNhbGwgZHJvcF9jYWNoZXMgdHdp
Y2UgYXMgb25jZSB0aGUgZGVudHJpZXMgd2lsbCBqdXN0IGN5Y2xlCj4gPiArICAgICAgICAqIHRo
cm91Z2ggdGhlIExSVSB3aXRob3V0IGJlaW5nIHJlY2xhaW1lZCBhbmQgaWYgdGhlcmUgYXJlIG5v
IG90aGVyCj4gPiArICAgICAgICAqIG9iamVjdHMgdG8gcmVjbGFpbSwgdGhlIHNsYWIgcmVjbGFp
bSB3aWxsIGp1c3Qgc3RvcCBpbnN0ZWFkIG9mCj4gPiArICAgICAgICAqIHJldHJ5aW5nLgo+ID4g
ICAgICAgICAgKi8KPiA+ICAgICAgICAgZnN5bmNfZmlsZShURVNUX0ZJTEUpOwo+ID4gICAgICAg
ICBTQUZFX0ZJTEVfUFJJTlRGKERST1BfQ0FDSEVTX0ZJTEUsICIzIik7Cj4gPiArICAgICAgIFNB
RkVfRklMRV9QUklOVEYoRFJPUF9DQUNIRVNfRklMRSwgIjMiKTsKPiA+Cj4gPiAgICAgICAgIHZl
cmlmeV9tYXJrX3JlbW92ZWQoVEVTVF9GSUxFLCAiYWZ0ZXIgZHJvcF9jYWNoZXMiKTsKPiAKPiBJ
ZiB0aGlzIGltcHJvdmVzIHRoZSByZWxpYWJpbGl0eSBvZiB0aGUgdGVzdCwgSSBoYXZlIG5vIHBy
b2JsZW0gd2l0aAo+IHRoZSBzb2x1dGlvbiwKClllcywgaXQgZml4ZXMgdGhlIHByb2JsZW0gYXQg
bGVhc3QgZm9yIG1lIDopCgo+IGJ1dCBJIGFtIGEgYml0IHVuZWFzeSB3aXRoIHRoZSBmYWN0IHRo
YXQgZmFub3RpeTEwIGFuZCBmYW5vdGlmeTIzIGhhdmUgdHdvCj4gZGlmZmVyZW50IG1pdGlnYXRp
b25zLgoKSSBrbm93IGFuZCBJIHdhcyB0aGlua2luZyBhYm91dCB0aGF0IGEgYml0LiBJIGNvdWxk
IGltcGxlbWVudCBzb21ldGhpbmcKc2ltaWxhciBhcyBmYW5vdGlmeTEwIGRvZXMgZm9yIGZhbm90
aWZ5MjMgYnV0IGl0IHNlZW1lZCB0byBiZSBhIGJpdCBvZiBhbgpvdmVya2lsbCBzbyBJIHdlbnQg
Zm9yIHRoZSBvbmUtbGluZXIuCgo+IEFueXdheSwgSSB0aGluayB0aGF0IHRoZSBleHBsYW5hdGlv
biBhYm92ZSBpcyB0cnVlIGZvciBzb21lIGZzIGJ1dCB4ZnMKPiBpbm9kZSBsaWZldGltZSBhbmQg
c2hyaW5rZXJzIGZvciBleGFtcGxlIGFuZCBtb3JlIGNvbXBsZXgsIHNvIGl0IGRvZXMKPiBub3Qg
aG9sZC4gUmlnaHQ/CgpTbyB0aGUgZXhwbGFuYXRpb24gaXMgdXNpbmcgaW50ZXJuYWwga25vd2xl
ZGdlIG9mIHBydW5lX2ljYWNoZV9zYigpCmltcGxlbWVudGF0aW9uLiBYRlMgaGFzIGl0cyBvd24g
cnVsZXMgZm9yIGFnaW5nIGlub2RlcyBzbyBpdCB3aWxsCm5vdCBob2xkIHRoZXJlIC0gaXQgaGFz
IHRoaXMgImluYWN0aXZhdGlvbiIgYWN0aW9uIHdoaWNoIHJlbGVhc2VzIHRoZSBsYXN0Cmlub2Rl
IHJlZmVyZW5jZSBhbmQgQUZBSUNTIGRyb3BfY2FjaGVzIHJlc3VsdHMgb25seSBpbiBwaW5naW5n
IGJhY2tncm91bmQKdGhyZWFkcyB0byBkbyB3b3JrIGJ1dCBkb2Vzbid0IHJlYWxseSB3YWl0IGZv
ciBpbm9kZXMgdG8gYmUgaW5hY3RpdmF0ZWQsCmxldCBhbG9uZSBmcmVlZC4KCj4gTWVhbmluZyB0
aGF0IHRoZSBleHBsYW5hdGlvbiBpcyB0cnVlIGJlY2F1c2UgZmFub3RpZnkxMCBoYXM6Cj4gCj4g
ICAgICAgICAvKiBTaHJpbmtlcnMgb24gb3RoZXIgZnMgZG8gbm90IHdvcmsgcmVsaWFibHkgZW5v
dWdoIHRvCj4gZ3VhcmFudGVlIG1hcmsgZXZpY3Rpb24gb24gZHJvcF9jYWNoZXMgKi8KPiAgICAg
ICAgIC5kZXZfZnNfdHlwZSA9ICJleHQyIiwKPiAKPiBNYXliZSB0aGF0IHNob3VsZCBiZSBzcGVs
bGVkIG91dD8KCkkgZ3Vlc3MgeW91IHNwZWFrIGFib3V0IGZhbm90aWZ5MjMgbm93IGJ1dCB5ZXMs
IHRoaXMgcGF0Y2ggZGVwZW5kcyBvbiB0aGUKZmFjdCB0aGF0IHdlIGFyZSBsaW1pdGVkIHRvIGV4
dDIuIFBlcmhhcHMgSSBjYW4gYWRkIHRoYXQgdG8gdGhlIGNvbW1lbnQgYnV0Cml0IGFscmVhZHkg
aXMgbWVudGlvbmVkIGluIHRoZSB0ZXN0IGFzIHlvdSBzaG93IGFib3ZlLi4uCgoJCQkJCQkJCUhv
bnphCi0tIApKYW4gS2FyYSA8amFja0BzdXNlLmNvbT4KU1VTRSBMYWJzLCBDUgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
