Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE7D606A334
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 17:49:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F6D43C0565
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 18:49:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA2413C0224
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 18:49:02 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4988D200C88
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 18:49:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 10A0E223B4;
 Fri, 30 Oct 2026 17:49:01 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C637813625;
 Fri, 30 Oct 2026 17:49:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fymgJYzY5Go7aQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 30 Oct 2026 17:49:00 +0000
Date: Fri, 30 Oct 2026 18:48:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20261030174855.GA53338@pevik>
References: <20261029210701.80050-1-dennylin0707@gmail.com>
 <CAOQ4uxho=0DZTHieLYYxDXqmSxfq0yMj6gLWUtpK-YDvVoyk+g@mail.gmail.com>
 <20261030170603.GA31132@pevik>
 <CAOQ4uxjsf=6Do-uNEOS9R61M8jXcmExY1jnrLNY9ex=doNn3wA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjsf=6Do-uNEOS9R61M8jXcmExY1jnrLNY9ex=doNn3wA@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 10A0E223B4
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] inotify13: check rename cookie pairing after
 adjacent moves
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Hungyu Lin <dennylin0707@gmail.com>,
 jack@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBGcmksIE9jdCAzMCwgMjAyNiBhdCA2OjA24oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+ID4gT24gVGh1LCBPY3QgMjksIDIwMjYgYXQgMTA6MDfigK9QTSBI
dW5neXUgTGluIDxkZW5ueWxpbjA3MDdAZ21haWwuY29tPiB3cm90ZToKCj4gPiA+ID4gUXVldWUg
YW4gdW5wYWlyZWQgSU5fTU9WRURfRlJPTSBldmVudCwgZm9sbG93ZWQgYnkgYW4gSU5fTU9WRURf
RlJPTSBhbmQKPiA+ID4gPiBJTl9NT1ZFRF9UTyBwYWlyIHdpdGggdGhlIHNhbWUgc291cmNlIHdh
dGNoIGRlc2NyaXB0b3IgYW5kIG5hbWUgYXMgdGhlCj4gPiA+ID4gZmlyc3QgZXZlbnQuIFdhdGNo
IG9ubHkgSU5fTU9WRSBzbyBjcmVhdGlvbiBvZiB0aGUgcmVwbGFjZW1lbnQgZW50cnkKPiA+ID4g
PiBkb2VzIG5vdCBzZXBhcmF0ZSB0aGUgdHdvIElOX01PVkVEX0ZST00gZXZlbnRzIGluIHRoZSBx
dWV1ZS4KCj4gPiA+ID4gQWZmZWN0ZWQga2VybmVscyBjb2FsZXNjZSB0aGUgc2Vjb25kIElOX01P
VkVEX0ZST00gaW50byB0aGUgZmlyc3QsCj4gPiA+ID4gbGVhdmluZyB0aGUgSU5fTU9WRURfVE8g
Y29va2llIHdpdGhvdXQgYSBtYXRjaGluZyBJTl9NT1ZFRF9GUk9NIGNvb2tpZS4KPiA+ID4gPiBD
aGVjayB0aGF0IGFsbCB0aHJlZSBldmVudHMgYXJlIHJldGFpbmVkLCB0aGUgdHdvIG1vdmVzIGhh
dmUgZGlzdGluY3QKPiA+ID4gPiBjb29raWVzLCBhbmQgdGhlIHNlY29uZCBJTl9NT1ZFRF9GUk9N
IG1hdGNoZXMgdGhlIElOX01PVkVEX1RPIGNvb2tpZS4KPiA+ID4gPiBDb3ZlciBib3RoIHJlZ3Vs
YXIgZmlsZXMgYW5kIGRpcmVjdG9yaWVzLgoKPiA+ID4gPiBTdWdnZXN0ZWQtYnk6IEFtaXIgR29s
ZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSHVuZ3l1
IExpbiA8ZGVubnlsaW4wNzA3QGdtYWlsLmNvbT4KCj4gPiA+IFRoYW5rIHlvdSBmb3IgeW91ciBw
YXRpZW5jZSB3aXRoIG15IHJldmlldwoKPiA+ID4gUmV2aWV3ZWQtYnk6IEFtaXIgR29sZHN0ZWlu
IDxhbWlyNzNpbEBnbWFpbC5jb20+Cgo+ID4gVGhhbmsgeW91IQoKPiA+IFJldmlld2VkLWJ5OiBQ
ZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KCj4gPiBJIGhhdmUgbm8gcHJvYmxlbSB0byBmaXgg
dmVyeSBtaW5vciBpc3N1ZXMgcmVwb3J0ZWQgYnkgYWdlbnQgYmVmb3JlIG1lcmdlLAo+ID4gYnV0
IHdoYXQgYm90aGVycyBtZSB0aGVyZSBpcyBubyBrZXJuZWwgZml4IGZvciB0aGUgZmFpbHVyZS4g
IElmIEknbSBub3QKPiA+IG1pc3Rha2VuLCB0aGUgZml4IGluIGtlcm5lbCBbMV0gd2FzIHJldmll
d2VkIFsyXSBidXQgbm90IHlldCBtZXJnZWQgKEkgbG9va2VkIHRvCj4gPiBuZXh0IHRyZWUgYXMg
d2VsbCkuCj4gPiBUaGVyZSBhcmUgb3RoZXIgZml4ZXMgZm9yIDYzYzg4MmEwNTQxNiAoImlub3Rp
Znk6IHJlaW1wbGVtZW50IGlub3RpZnkgdXNpbmcKPiA+IGZzbm90aWZ5IikgaW4gc3RhYmxlLCBl
LmcuIGU0MjI3NzdmZGQ0NzQgKCJmc25vdGlmeTogRml4IHN0YWxlIG9iamVjdCBtYXNrIGFmdGVy
Cj4gPiBjb25jdXJyZW50IG1hcmsgdXBkYXRlcyIpLCBidXQgSSBoYXZlbid0IGZvdW5kIHRoaXMg
b25lLgoKPiA+IE1lcmdpbmcgdGVzdCBoZWxwcyBrZXJuZWwgZGV2ZWxvcGVycyB0byB0ZXN0IGlm
IHRoZSBwcm9ibGVtIHdhcyBmaXhlZCBidXQgYnJlYWsKPiA+IGZvciBpdCBmb3IgYW55Ym9keSB3
aG8gdXNlcyBtYXN0ZXIgZm9yIHJlZ3VsYXIgdGVzdGluZyB3aXRob3V0IGV2ZW4gZXhwbGFpbmlu
Zwo+ID4gZml4IGlzIFdJUC4gQnV0IEkgc3VwcG9zZSBpdCB3aWxsIGJlIHByb2Nlc3NlZCBzb29u
IGJlY2F1c2Ugc3RhYmxlIHdhcyBpbiBDYywKPiA+IHJpZ2h0PwoKPiA+IFdlIGhhdmUgcnVudGVz
dC9zdGFnaW5nLCBidXQgdGhhdCdzIGZvciBuZXcgZnVuY3Rpb25hbGl0eSwgbm90IGZvciB0ZXN0
cyB3aGljaAo+ID4gcmVwcm9kdWNlIHByb2JsZW0gd2hpY2ggd2FzIG5vdCBmaXhlZC4KCj4gPiBA
SmFuIEBBbWlyIGlzIHRoZXJlIGEgZ2l0IGtlcm5lbCB0cmVlIGZvciBmYW5vdGlmeSBhbmQgaW5v
dGlmeT8gSSBmb3VuZCBvbmx5Cj4gPiBWRlMuIElmIHllcywgcGxlYXNlIHVwZGF0ZSBNQUlOVEFJ
TkVSUyBmaWxlLgoKCj4gRlNOT1RJRlk6IEZJTEVTWVNURU0gTk9USUZJQ0FUSU9OIElORlJBU1RS
VUNUVVJFCj4gTTogICAgICBKYW4gS2FyYSA8amFja0BzdXNlLmN6Pgo+IFI6ICAgICAgQW1pciBH
b2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4KPiBMOiAgICAgIGxpbnV4LWZzZGV2ZWxAdmdl
ci5rZXJuZWwub3JnCj4gUzogICAgICBNYWludGFpbmVkCj4gVDogICAgICBnaXQgZ2l0Oi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2phY2svbGludXgtZnMuZ2l0Cj4g
ZnNub3RpZnkKPiBGOiAgICAgIGZzL25vdGlmeS8KPiBGOiAgICAgIGluY2x1ZGUvbGludXgvZnNu
b3RpZnkqLmgKClRoYW5rcyBhIGxvdCBmb3IgcG9pbnRpbmcgdGhpcyBkb2MsIEkgb3Zlcmxvb2tl
ZCBiZWNhdXNlIEkgbm90aWNlZCB0aGUgZWFybGllcjoKCkZBTk9USUZZCk06CUphbiBLYXJhIDxq
YWNrQHN1c2UuY3o+ClI6CUFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+ClI6CU1h
dHQgQm9icm93c2tpIDxtYXR0QGJvYnJvd3NraS5uZXQ+Ckw6CWxpbnV4LWZzZGV2ZWxAdmdlci5r
ZXJuZWwub3JnClM6CU1haW50YWluZWQKRjoJZnMvbm90aWZ5L2Zhbm90aWZ5LwpGOglpbmNsdWRl
L2xpbnV4L2Zhbm90aWZ5LmgKRjoJaW5jbHVkZS91YXBpL2xpbnV4L2Zhbm90aWZ5LmgKCklOT1RJ
RlkKTToJSmFuIEthcmEgPGphY2tAc3VzZS5jej4KUjoJQW1pciBHb2xkc3RlaW4gPGFtaXI3M2ls
QGdtYWlsLmNvbT4KTDoJbGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmcKUzoJTWFpbnRhaW5l
ZApGOglEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL2lub3RpZnkucnN0CkY6CWZzL25vdGlmeS9p
bm90aWZ5LwpGOglpbmNsdWRlL2xpbnV4L2lub3RpZnkuaApGOglpbmNsdWRlL3VhcGkvbGludXgv
aW5vdGlmeS5oCgo+IFdlIGNvdWxkIHByb2JhYmx5IHJlbmFtZS9tb3ZlIHRoZSBmYW5vdGlmeS9p
bm90aWZ5IGVudHJpZXMgdG8gYXBwZWFyIGFzCj4gc3ViIGVudHJpZXMgbWltaWNraW5nIHRoZSBW
RlMgZW50cmllczoKCj4gRklMRVNZU1RFTSBOT1RJRklDQVRJT04gKGZzbm90aWZ5IGluZnJhc3Ry
dWN0dXJlKQo+IC4uLgo+IEZJTEVTWVNURU0gTk9USUZJQ0FUSU9OIFtJTk9USUZZXQo+IC4uLgo+
IEZJTEVTWVNURU0gTk9USUZJQ0FUSU9OIFtGQU5PVElGWV0KCisxCgpLaW5kIHJlZ2FyZHMsClBl
dHIKCj4gVGhhbmtzLAo+IEFtaXIuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
