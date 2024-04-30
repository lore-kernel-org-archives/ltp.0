Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280A8C4345F
	for <ltp@archiver.kernel.org>; Tue, 30 Apr 2024 10:07:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C9583CB15C
	for <ltp@archiver.kernel.org>; Tue, 30 Apr 2024 12:07:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4085F3C6825
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:06:50 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 01E34206C48
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:06:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 939FF1F7C0;
 Tue, 30 Apr 2024 10:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714471605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vwxuOltHsI9WXrmwaPjiDcWKL8U9cGmjvn2z2r8e0ek=;
 b=mXpi0im4ixjtqAXTD9SLXWdRju4F357Coj10c4W7iVUX0lJppc+iVBur0kaQ10XHvcVvQk
 tvjVJUhYCl7IukVgo5IIlyD+KMFjZ0qO0+Tk7VzAVLp+JSjVwyDcKtWcbP2o5I8OgKr2Gx
 V2oiugNYtcjVOldJw4/y6uFELy+ET/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714471605;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vwxuOltHsI9WXrmwaPjiDcWKL8U9cGmjvn2z2r8e0ek=;
 b=Z7k6SaRkGk2WK76EsZLy0sg1x4k/4EQYpEgCzTN6LuSI9OaJb5Na9khkMXkse0Cg1H+xZE
 UDd00dxsJPFlLSCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mXpi0im4;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Z7k6SaRk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714471605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vwxuOltHsI9WXrmwaPjiDcWKL8U9cGmjvn2z2r8e0ek=;
 b=mXpi0im4ixjtqAXTD9SLXWdRju4F357Coj10c4W7iVUX0lJppc+iVBur0kaQ10XHvcVvQk
 tvjVJUhYCl7IukVgo5IIlyD+KMFjZ0qO0+Tk7VzAVLp+JSjVwyDcKtWcbP2o5I8OgKr2Gx
 V2oiugNYtcjVOldJw4/y6uFELy+ET/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714471605;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vwxuOltHsI9WXrmwaPjiDcWKL8U9cGmjvn2z2r8e0ek=;
 b=Z7k6SaRkGk2WK76EsZLy0sg1x4k/4EQYpEgCzTN6LuSI9OaJb5Na9khkMXkse0Cg1H+xZE
 UDd00dxsJPFlLSCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80856136A8;
 Tue, 30 Apr 2024 10:06:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m5mvHrXCMGb7awAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 30 Apr 2024 10:06:45 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 30 Apr 2024 12:06:45 +0200
Message-ID: <7002191.9J7NaK4W3v@localhost>
Organization: SUSE
In-Reply-To: <20240423125742.25834-1-andrea.cervesato@suse.de>
References: <20240423125742.25834-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 939FF1F7C0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 HAS_ORG_HEADER(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add utime07 test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKUmV2aWV3ZWQtYnk6IEF2aW5lc2ggS3VtYXIgPGFrdW1hckBzdXNlLmRlPgp3
aXRoIGJlbG93IGNvbW1lbnRzLgoKT24gVHVlc2RheSwgQXByaWwgMjMsIDIwMjQgMjo1Nzo0MuKA
r1BNIEdNVCsyIEFuZHJlYSBDZXJ2ZXNhdG8gd3JvdGU6Cj4gRnJvbTogQW5kcmVhIENlcnZlc2F0
byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KPiAKPiBUaGlzIHRlc3QgaGFzIGJlZW4gZXh0
cmFjdGVkIGZyb20gc3ltbGluazAxIHRlc3QgYW5kIGl0IHZlcmlmaWVzIHRoYXQKPiB1dGltZSgp
IGlzIHdvcmtpbmcgY29ycmVjdGx5IG9uIHN5bWxpbmsoKSBnZW5lcmF0ZWQgZmlsZXMuCj4gCj4g
U2lnbmVkLW9mZi1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNv
bT4KPiAtLS0KPiBVcGRhdGUgbGljZW5zZQo+IEFkZCBjaGVjayBmb3Igc3ltbGluayBhcyByZXF1
ZXN0ZWQKPiBUZXh0IG91dHB1dCBpcyBlYXNpZXIgdG8gcmVhZCBub3cKPiAKPiAgcnVudGVzdC9z
bW9rZXRlc3QgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICstCj4gIHJ1bnRlc3Qvc3lz
Y2FsbHMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQo+ICB0ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL3V0aW1lLy5naXRpZ25vcmUgfCAgIDEgKwo+ICB0ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL3V0aW1lL3V0aW1lMDcuYyAgfCAxMDAgKysrKysrKysrKysrKysrKysrKysrCj4g
IDQgZmlsZXMgY2hhbmdlZCwgMTAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3V0aW1lL3V0aW1lMDcu
Ywo+IAo+IGRpZmYgLS1naXQgYS9ydW50ZXN0L3Ntb2tldGVzdCBiL3J1bnRlc3Qvc21va2V0ZXN0
Cj4gaW5kZXggODNlZWJmZTdiLi5mNmYxNGZkMmIgMTAwNjQ0Cj4gLS0tIGEvcnVudGVzdC9zbW9r
ZXRlc3QKPiArKysgYi9ydW50ZXN0L3Ntb2tldGVzdAo+IEBAIC05LDcgKzksNyBAQCB3YWl0MDIg
d2FpdDAyCj4gIHdyaXRlMDEgd3JpdGUwMQo+ICBzeW1saW5rMDEgc3ltbGluazAxCj4gIHN0YXQw
NCBzeW1saW5rMDEgLVQgc3RhdDA0Cj4gLXV0aW1lMDFBIHN5bWxpbmswMSAtVCB1dGltZTAxCj4g
K3V0aW1lMDcgdXRpbWUwNwo+ICByZW5hbWUwMUEgc3ltbGluazAxIC1UIHJlbmFtZTAxCj4gIHNw
bGljZTAyIHNwbGljZTAyIC1zIDIwCj4gIGRmMDFfc2ggZGYwMS5zaAo+IGRpZmYgLS1naXQgYS9y
dW50ZXN0L3N5c2NhbGxzIGIvcnVudGVzdC9zeXNjYWxscwo+IGluZGV4IGI5ZGQ5ZmVjNi4uNGQx
YzUyMjIxIDEwMDY0NAo+IC0tLSBhL3J1bnRlc3Qvc3lzY2FsbHMKPiArKysgYi9ydW50ZXN0L3N5
c2NhbGxzCj4gQEAgLTE2NzcsMTIgKzE2NzcsMTIgQEAgdXN0YXQwMSB1c3RhdDAxCj4gIHVzdGF0
MDIgdXN0YXQwMgo+ICAKPiAgdXRpbWUwMSB1dGltZTAxCj4gLXV0aW1lMDFBIHN5bWxpbmswMSAt
VCB1dGltZTAxCj4gIHV0aW1lMDIgdXRpbWUwMgo+ICB1dGltZTAzIHV0aW1lMDMKPiAgdXRpbWUw
NCB1dGltZTA0Cj4gIHV0aW1lMDUgdXRpbWUwNQo+ICB1dGltZTA2IHV0aW1lMDYKPiArdXRpbWUw
NyB1dGltZTA3Cj4gIAo+ICB1dGltZXMwMSB1dGltZXMwMQo+ICAKPiBkaWZmIC0tZ2l0IGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy91dGltZS8uZ2l0aWdub3JlIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy91dGltZS8uZ2l0aWdub3JlCj4gaW5kZXggOTRjMGFlMDdjLi40MDM3NjQ1MjEg
MTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91dGltZS8uZ2l0aWdub3Jl
Cj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91dGltZS8uZ2l0aWdub3JlCj4gQEAg
LTQsMyArNCw0IEBACj4gIC91dGltZTA0Cj4gIC91dGltZTA1Cj4gIC91dGltZTA2Cj4gKy91dGlt
ZTA3Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdXRpbWUvdXRpbWUw
Ny5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91dGltZS91dGltZTA3LmMKPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NAo+IGluZGV4IDAwMDAwMDAwMC4uMjY0N2JjODk3Cj4gLS0tIC9kZXYvbnVs
bAo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdXRpbWUvdXRpbWUwNy5jCj4gQEAg
LTAsMCArMSwxMDAgQEAKPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25s
eQo+ICsvKgo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMDAgU2lsaWNvbiBHcmFwaGljcywgSW5jLiAg
QWxsIFJpZ2h0cyBSZXNlcnZlZC4KPiArICogICAgQXV0aG9yOiBEYXZpZCBGZW5uZXIKPiArICog
ICAgQ29waWxvdDogSm9uIEhlbmRyaWNrc29uCj4gKyAqIENvcHlyaWdodCAoQykgMjAyNCBBbmRy
ZWEgQ2VydmVzYXRvIGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20KPiArICovCj4gKwo+ICsvKlwK
PiArICogW0Rlc2NyaXB0aW9uXQo+ICsgKgo+ICsgKiBUaGlzIHRlc3QgdmVyaWZpZXMgdGhhdCB1
dGltZSgpIGlzIHdvcmtpbmcgY29ycmVjdGx5IG9uIHN5bWxpbmsoKQo+ICsgKiBnZW5lcmF0ZWQg
ZmlsZXMuCj4gKyAqLwo+ICsKPiArI2luY2x1ZGUgPHV0aW1lLmg+Cj4gKyNpbmNsdWRlICJ0c3Rf
dGVzdC5oIgo+ICsKPiArc3RhdGljIHZvaWQgY3JlYXRlX3N5bWxpbmsoY29uc3QgY2hhciogcGF0
aCwgY29uc3QgY2hhciogc3ltbmFtZSkKTG9va3MgbGlrZSB0aGlzIGlzIGdlbmVyYXRpbmcgbWFr
ZSBjaGVjayBlcnJvcnMuCnV0aW1lMDcuYzoxOTogRVJST1I6ICJmb28qIGJhciIgc2hvdWxkIGJl
ICJmb28gKmJhciIKPiArewo+ICsJc3RydWN0IHN0YXQgYXN5bWxpbms7Cj4gKwo+ICsJU0FGRV9T
WU1MSU5LKHBhdGgsIHN5bW5hbWUpOwo+ICsJU0FGRV9MU1RBVChzeW1uYW1lLCAmYXN5bWxpbmsp
Owo+ICsKPiArCWlmICgoYXN5bWxpbmsuc3RfbW9kZSAmIFNfSUZNVCkgIT0gU19JRkxOSykgewo+
ICsJCXRzdF9icmsoVEJST0ssCj4gKwkJCSJzeW1saW5rIGdlbmVyYXRlZCBhIG5vbi1zeW1ib2xp
YyBsaW5rICVzIHRvICVzIiwKPiArCQkJc3ltbmFtZSwKPiArCQkJcGF0aCk7Cj4gKwl9Cj4gK30K
PiArCj4gK3N0YXRpYyB2b2lkIHRlc3RfdXRpbWUodm9pZCkKPiArewo+ICsJY2hhciAqc3ltbmFt
ZSA9ICJteV9zeW1saW5rMCI7Cj4gKwlzdHJ1Y3Qgc3RhdCBvbGRzeW1fc3RhdDsKPiArCXN0cnVj
dCBzdGF0IG5ld3N5bV9zdGF0Owo+ICsKPiArCXRzdF9yZXMoVElORk8sICJUZXN0IGlmIHV0aW1l
KCkgY2hhbmdlcyBhY2Nlc3MgdGltZSIpOwo+ICsKPiArCWNyZWF0ZV9zeW1saW5rKHRzdF9nZXRf
dG1wZGlyKCksIHN5bW5hbWUpOwo+ICsJU0FGRV9TVEFUKHN5bW5hbWUsICZvbGRzeW1fc3RhdCk7
Cj4gKwo+ICsJc3RydWN0IHV0aW1idWYgdXRpbWVzID0gewo+ICsJCS5hY3RpbWUgPSBvbGRzeW1f
c3RhdC5zdF9hdGltZSArIDEwMCwKPiArCQkubW9kdGltZSA9IG9sZHN5bV9zdGF0LnN0X210aW1l
ICsgMTAwCj4gKwl9Owo+ICsKPiArCVRTVF9FWFBfUEFTUyh1dGltZShzeW1uYW1lLCAmdXRpbWVz
KSk7Cj4gKwlTQUZFX1NUQVQoc3ltbmFtZSwgJm5ld3N5bV9zdGF0KTsKPiArCj4gKwl0aW1lX3Qg
dGVtcCwgZGlmZjsKPiArCj4gKwl0ZW1wID0gbmV3c3ltX3N0YXQuc3RfYXRpbWUgLSBvbGRzeW1f
c3RhdC5zdF9hdGltZTsKPiArCWRpZmYgPSBuZXdzeW1fc3RhdC5zdF9tdGltZSAtIG9sZHN5bV9z
dGF0LnN0X210aW1lIC0gdGVtcDsKCk5pdDogdGhpcyBjb21wYXJpc29uIGxvZ2ljIGFzc3VtZXMg
dGhlIGRpZmYgdmFsdWVzIGZvciBhdGltZSBhbmQgbXRpbWUgdG8gYmUKc2FtZSwgd2hpY2ggaXMg
dGhlIGNhc2UgaGVyZSBieSB1c2luZyBoYXJkY29kZWQgdmFsdWUgb2YgMTAwLgoKRWl0aGVyIHdl
IGNhbiBkZWZpbmUgdGhlIGRpZmYgdmFsdWUgYXMgbWFjcm8sIG9yIG1heWJlIHdlIGNhbiB1c2UK
ClRTVF9FWFBfRVFfTEkobmV3c3ltX3N0YXQuc3RfYXRpbWUgLSBvbGRzeW1fc3RhdC5zdF9hdGlt
ZSwgMTAwKTsKVFNUX0VYUF9FUV9MSShuZXdzeW1fc3RhdC5zdF9tdGltZSAtIG9sZHN5bV9zdGF0
LnN0X210aW1lLCAxMDApOwoKYnV0IGl0cyB1cHRvIHlvdSA6KQoKPiArCj4gKwlUU1RfRVhQX0VY
UFIoZGlmZiA9PSAwLAo+ICsJCSJ1dGltZSgpIGNvcnJlY3RseSBjaGFuZ2VkIGFjY2VzcyB0aW1l
Iik7Cj4gKwo+ICsJU0FGRV9VTkxJTksoc3ltbmFtZSk7Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lk
IHRlc3RfdXRpbWVfbm9fcGF0aCh2b2lkKQo+ICt7Cj4gKwljaGFyICpzeW1uYW1lID0gIm15X3N5
bWxpbmsxIjsKPiArCXN0cnVjdCB1dGltYnVmIHV0aW1lczsKPiArCj4gKwl0c3RfcmVzKFRJTkZP
LCAiVGVzdCBpZiB1dGltZSgpIHJhaXNlcyBFTk9FTlQgd2hlbiBzeW1saW5rIHBvaW50cyB0byBu
b3doZXJlIik7Cj4gKwo+ICsJY3JlYXRlX3N5bWxpbmsoImJjK2VGaGkhayIsIHN5bW5hbWUpOwo+
ICsJVFNUX0VYUF9GQUlMKHV0aW1lKHN5bW5hbWUsICZ1dGltZXMpLCBFTk9FTlQpOwo+ICsKPiAr
CVNBRkVfVU5MSU5LKHN5bW5hbWUpOwo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCB0ZXN0X3V0aW1l
X2xvb3Aodm9pZCkKPiArewo+ICsJY2hhciAqc3ltbmFtZSA9ICJteV9zeW1saW5rMiI7Cj4gKwlz
dHJ1Y3QgdXRpbWJ1ZiB1dGltZXM7Cj4gKwo+ICsJdHN0X3JlcyhUSU5GTywgIlRlc3QgaWYgdXRp
bWUoKSByYWlzZXMgRUxPT1Agd2hlbiBzeW1saW5rIGlzIGxvb3BpbmciKTsKPiArCj4gKwljcmVh
dGVfc3ltbGluayhzeW1uYW1lLCBzeW1uYW1lKTsKPiArCVRTVF9FWFBfRkFJTCh1dGltZShzeW1u
YW1lLCAmdXRpbWVzKSwgRUxPT1ApOwo+ICsKPiArCVNBRkVfVU5MSU5LKHN5bW5hbWUpOwo+ICt9
Cj4gKwo+ICtzdGF0aWMgdm9pZCBydW4odm9pZCkKPiArewo+ICsJdGVzdF91dGltZSgpOwo+ICsJ
dGVzdF91dGltZV9ub19wYXRoKCk7Cj4gKwl0ZXN0X3V0aW1lX2xvb3AoKTsKPiArfQo+ICsKPiAr
c3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ICsJLnRlc3RfYWxsID0gcnVuLAo+ICsJ
Lm5lZWRzX3RtcGRpciA9IDEsCj4gK307Cj4gCgpSZWdhcmRzLApBdmluZXNoCgoKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
