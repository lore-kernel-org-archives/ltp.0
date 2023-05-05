Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159BEC77B7C
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 16:36:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B09513CB6A8
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 18:36:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D56433CB64D
 for <ltp@lists.linux.it>; Fri,  5 May 2023 18:36:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 411A060068F
 for <ltp@lists.linux.it>; Fri,  5 May 2023 18:36:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1C52E2242A;
 Fri,  5 May 2023 16:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683304577;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EiDQnVPkX5uocVG1rCW7lqOzUbD1u/4CPCz5Ncl0Y/U=;
 b=Ee4tcGE6tDjDV6I6MKvL+Uo6tAp0lmfuCaMtqxidcUmAhZboB2a1K8fzj59HNricWPliYy
 8Z+u2NOQts2bZpjx2r5OKOxR42E6FYt0BaGctM3VzKsVb7XboFpMcXW8Tb5m/vQBzCQSfS
 pU/mb+boVZvmkLEgqXOWSzWU6eruagY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683304577;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EiDQnVPkX5uocVG1rCW7lqOzUbD1u/4CPCz5Ncl0Y/U=;
 b=GhAFeGPb7OtxNEu6uwq1n99kHxb6bPciMm7kuY5zB42yfPmkew4kVJD40D2sz/mlP7zGFl
 9PzUWRhsnDTieiAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8ECBF13513;
 Fri,  5 May 2023 16:36:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3r0bHYAwVWTcLQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 05 May 2023 16:36:16 +0000
Date: Fri, 5 May 2023 18:36:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20230505163614.GA28229@pevik>
References: <20230505162822.15676-1-pvorel@suse.cz>
 <CAASaF6w=6dOVtH_FYrMuUQPOrwXdMHM_dHD7e-74KHHaimeQWg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6w=6dOVtH_FYrMuUQPOrwXdMHM_dHD7e-74KHHaimeQWg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] endian_switch01: Add HAVE_GETAUXVAL guarder
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

PiBPbiBGcmksIE1heSA1LCAyMDIzIGF0IDY6MjjigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cgo+ID4gRnJvbTogUGV0ciBWb3JlbCA8cGV0ci52b3JlbEBnbWFpbC5jb20+
Cgo+ID4gVGhpcyBmaXhlcyBjb21waWxhdGlvbiBvbiB1Q2xpYmMgLyB1Q2xpYmMtbmcgKGFuZCBh
bHNvIG9sZGVyIGdsaWJjKSwKPiA+IHdoaWNoIGRvZXMgbm90IHByb3ZpZGUgdGhpcyBoZWFkZXIu
Cgo+ID4gRml4ZXM6IDAzYjc2YTIwYyAoImVuZGlhbl9zd2l0Y2gwMS5jOiBkcm9wIHVudXNlZCBt
YWluNCgpIikKPiA+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHBldHIudm9yZWxAZ21haWwu
Y29tPgo+ID4gLS0tCj4gPiBIaSBKYW4sCgo+ID4gY2FuIHlvdSBwbGVhc2UgaGF2ZSBhIGxvb2ss
IEknZCBwcmVmZXIgdG8gbWVyZ2UgdGhpcyBiZWZvcmUgcmVsZWFzZQo+ID4gKGJ1aWxkIGZpeCBv
biBCdWlsZHJvb3QpLgoKPiBMb29rcyByZWFzb25hYmxlIChvbiBteSBwaG9uZSksIGFjay4KCkhp
IEphbiwKCnRoYW5rcyBmb3IgYSBxdWljayBhY2shCkknbGwgbWVyZ2UgaXQgb24gTW9uZGF5IHRv
IGdldCBvdGhlciBjaGFuZ2UgdG8gc2VlIGl0LgoKS2luZCByZWdhcmRzLApQZXRyCgoKPiA+IEtp
bmQgcmVnYXJkcywKPiA+IFBldHIKCj4gPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2l0
Y2gvZW5kaWFuX3N3aXRjaDAxLmMgfCAxNCArKysrKysrKysrKy0tLQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAxMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKPiA+IGRpZmYgLS1naXQgYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3aXRjaC9lbmRpYW5fc3dpdGNoMDEuYyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dpdGNoL2VuZGlhbl9zd2l0Y2gwMS5jCj4gPiBpbmRleCBk
OTY1YWVkNTYuLmZhYzllMjM4MiAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvc3dpdGNoL2VuZGlhbl9zd2l0Y2gwMS5jCj4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL3N3aXRjaC9lbmRpYW5fc3dpdGNoMDEuYwo+ID4gQEAgLTIsNyArMiw3IEBACj4g
PiAgLyoKPiA+ICAgKiBDb3B5cmlnaHQgKGMpIEludGVybmF0aW9uYWwgQnVzaW5lc3MgTWFjaGlu
ZXMgQ29ycC4sIDIwMDgKPiA+ICAgKiBDb3B5cmlnaHQgKGMpIFBhdWwgTWFja2VycmFzLCBJQk0g
Q29ycC4sIDIwMDgKPiA+IC0gKiBDb3B5cmlnaHQgKGMpIDIwMTggTGludXggVGVzdCBQcm9qZWN0
Cj4gPiArICogQ29weXJpZ2h0IChjKSAyMDE4LTIwMjMgTGludXggVGVzdCBQcm9qZWN0Cj4gPiAg
ICovCgo+ID4gIC8qCj4gPiBAQCAtMTUsMTYgKzE1LDIwIEBACj4gPiAgI2luY2x1ZGUgPHN0ZGxp
Yi5oPgo+ID4gICNpbmNsdWRlIDx1bmlzdGQuaD4KPiA+ICAjaW5jbHVkZSA8ZWxmLmg+Cj4gPiAt
I2luY2x1ZGUgPHN5cy9hdXh2Lmg+Cj4gPiAgI2luY2x1ZGUgPHN5cy90eXBlcy5oPgo+ID4gICNp
bmNsdWRlIDxzeXMvd2FpdC5oPgo+ID4gKwo+ID4gICNpbmNsdWRlICJ0c3RfdGVzdC5oIgoKPiA+
ICAjaWYgZGVmaW5lZChfX3Bvd2VycGM2NF9fKSB8fCBkZWZpbmVkKF9fcG93ZXJwY19fKQo+ID4g
Kwo+ID4gICMgaWZuZGVmIFBQQ19GRUFUVVJFX1RSVUVfTEUKPiA+IC0jIGRlZmluZSBQUENfRkVB
VFVSRV9UUlVFX0xFICAgICAgICAgICAgICAweDAwMDAwMDAyCj4gPiArIyAgZGVmaW5lIFBQQ19G
RUFUVVJFX1RSVUVfTEUgICAgICAgICAgICAgIDB4MDAwMDAwMDIKPiA+ICAjIGVuZGlmCgo+ID4g
KyMgaWZkZWYgSEFWRV9HRVRBVVhWQUwKPiA+ICsjICBpbmNsdWRlIDxzeXMvYXV4di5oPgo+ID4g
Kwo+ID4gIC8qCj4gPiAgICogTWFrZSBtaW5pbWFsIGNhbGwgdG8gMHgxZWJlLiBJZiB3ZSBnZXQg
RU5PU1lTIHRoZW4gc3lzY2FsbCBpcyBub3QKPiA+ICAgKiBhdmFpbGFibGUsIGxpa2VseSBiZWNh
dXNlIG9mOgo+ID4gQEAgLTk4LDYgKzEwMiwxMCBAQCBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRl
c3QgPSB7Cj4gPiAgICAgICAgIC5mb3Jrc19jaGlsZCA9IDEsCj4gPiAgfTsKCj4gPiArIyBlbHNl
Cj4gPiArVFNUX1RFU1RfVENPTkYoIlRvb2xjaGFpbiBkb2VzIG5vdCBoYXZlIDxzeXMvYXV4di5o
PiIpOwo+ID4gKyMgZW5kaWYgLyogSEFWRV9HRVRBVVhWQUwgKi8KPiA+ICsKPiA+ICAjZWxzZSAv
KiBkZWZpbmVkIChfX3Bvd2VycGM2NF9fKSB8fCAoX19wb3dlcnBjX18pICovCj4gPiAgVFNUX1RF
U1RfVENPTkYoIlRoaXMgc3lzdGVtIGRvZXMgbm90IHN1cHBvcnQgcnVubmluZyBvZiBzd2l0Y2go
KSBzeXNjYWxsIik7Cj4gPiAgI2VuZGlmCj4gPiAtLQo+ID4gMi40MC4xCgoKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
