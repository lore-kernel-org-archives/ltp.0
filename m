Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94FDC5B552
	for <ltp@archiver.kernel.org>; Mon,  9 Jun 2025 06:41:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3AA063CA015
	for <ltp@archiver.kernel.org>; Mon,  9 Jun 2025 08:41:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4A0C3C1BC2
 for <ltp@lists.linux.it>; Mon,  9 Jun 2025 08:40:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3339C600800
 for <ltp@lists.linux.it>; Mon,  9 Jun 2025 08:40:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DB85821191;
 Mon,  9 Jun 2025 06:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749451250;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PxHL0oe5OQq46u8tegApvgV4SBbWQafh//WYOpH61HA=;
 b=adWh+JLFlRA8B9SjT9FLdxiIf2EkpxsU3vgXhJaiTN/UU8RvWLTcQABQ4JDl5tG92QMltM
 K5BKZuPGxNG3bC4UUjHd957vvlpq3TUw4NidhA8mc6Nrk5FtEdre09bT3KwM0bb7XzLlkv
 A6PU7eA9v7p+anzgVmghu+K+C8uB8gk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749451250;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PxHL0oe5OQq46u8tegApvgV4SBbWQafh//WYOpH61HA=;
 b=c1uMsDqRnkV9AHskrZXjNp2d0qYPBX93z3UI5669LSdShK3YyUYz3gxdaK5kmuNTwy8TN1
 9bGcmncZj8IL4BCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749451249;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PxHL0oe5OQq46u8tegApvgV4SBbWQafh//WYOpH61HA=;
 b=UHQcvFRh4On4L7KLYLQoFACSwZ2FzwC5zhYHQHT3xJKayjKJKVE0mXzmgwtpnTEEWdwOhr
 qcczp5tNcTUzqDLMWzNViopbVLO9smbHniszMDAvNU68tLTyEPcpthFScSlOt685mFR8wJ
 5k4NZBSKUi6a1PRbEXB4dmVr3gQPRn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749451249;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PxHL0oe5OQq46u8tegApvgV4SBbWQafh//WYOpH61HA=;
 b=+KDBvVmwO6RrfGodiyw740xeQ1eHbYZLV/VzIjqwhQQDlFfGtLvdeBoHisUmV1kjtry8Ar
 PiyriA/49BKJKfBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A80F4137FE;
 Mon,  9 Jun 2025 06:40:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zaUqJvGBRmiqagAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 09 Jun 2025 06:40:49 +0000
Date: Mon, 9 Jun 2025 08:40:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250609064048.GB1404144@pevik>
References: <20250606110541.220472-1-liwang@redhat.com>
 <20250606143936.GC1312985@pevik>
 <CAEemH2dbCPKsBUiXKR=Lut1ONmjhjcwWxkjMzYe6B+HbYQUE8A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dbCPKsBUiXKR=Lut1ONmjhjcwWxkjMzYe6B+HbYQUE8A@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gnu.org:url,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] tst_atomic: drop legacy inline assembly
 and use __atomic or __sync builtins
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

PiBPbiBGcmksIEp1biA2LCAyMDI1IGF0IDEwOjM54oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIExpLCBDeXJpbCwKCj4gPiA+IFJlZmFjdG9yIHRzdF9hdG9t
aWMuaCB0byByZW1vdmUgYWxsIGxlZ2FjeSBhcmNoaXRlY3R1cmUtc3BlY2lmaWMgaW5saW5lCj4g
PiA+IGFzc2VtYmx5IGFuZCBmYWxsYmFjayBjb2RlIHBhdGhzLiBUaGUgbmV3IGltcGxlbWVudGF0
aW9uIHN1cHBvcnRzIG9ubHkKPiA+ID4gdHdvIHdlbGwtZGVmaW5lZCBpbnRlcmZhY2VzOiBfX2F0
b21pY18qIGJ1aWx0LWlucyAoR0NDIOKJpSA0LjcpIGFuZAo+ID4gX19zeW5jXyoKPiA+ID4gYnVp
bHQtaW5zIChHQ0Mg4omlIDQuMSkuCgo+ID4gPiBUaGlzIHNpbXBsaWZpY2F0aW9uIGltcHJvdmVz
IG1haW50YWluYWJpbGl0eSwgY2xhcml0eSwgYW5kIHBvcnRhYmlsaXR5Cj4gPiA+IGFjcm9zcyBw
bGF0Zm9ybXMuCgo+ID4gPiBUaGUgbWVtb3J5IG9yZGVyIGlzIGV4cGxpY2l0bHkgc2V0IHRvIF9f
QVRPTUlDX1NFUV9DU1QgdG8gcHJlc2VydmUgc3RyaWN0Cj4gPiA+IHNlcXVlbnRpYWwgY29uc2lz
dGVuY3ksIHdoaWNoIGFsaWducyB3aXRoIHRoZSBDKysxMSBtZW1vcnkgbW9kZWwuCgo+ID4gPiBS
ZWZlcmVuY2U6Cj4gPiBodHRwczovL2djYy5nbnUub3JnL29ubGluZWRvY3MvZ2NjL18wMDVmXzAw
NWZhdG9taWMtQnVpbHRpbnMuaHRtbAo+ID4gKzEKCj4gPiBUaGFua3MgZm9yIHRoZSB3b3JrIQo+
ID4gUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgoKPiA+ID4gU2lnbmVk
LW9mZi1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4gPiA+IFN1Z2dlc3RlZC1ieTog
Q3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+Cgo+ID4gPiArCj4gPiA+ICsvKiBVc2UgX19h
dG9taWMgYnVpbHQtaW5zIChHQ0MgPj0gNC43KSwgd2l0aCBzZXF1ZW50aWFsIGNvbnNpc3RlbmN5
LiAqLwoKPiA+ICsxIGZvciBkb2N1bWVudGluZyB0aGlzLiBIb3BlZnVsbHkgdGhlc2UgYXJlIG9s
ZCBlbm91Z2ggdG8gbm90IGhhdmluZyB0bwo+ID4gbWVudGlvbgo+ID4gaXQgaW4gdGhlIGRvY3Mu
IEJ1dCBpZiB5b3UgdGhpbmsgaXQncyBub3QgdGhhdCBvbGQsIGl0IG1pZ2h0IGJlIHdvcnRoCj4g
PiBsYXRlciB0bwo+ID4gZG9jdW1lbnQgaXQgaW4gZG9jL3VzZXJzL3N1cHBvcnRlZF9zeXN0ZW1z
LnJzdC4KCj4gPiBodHRwczovL2xpbnV4LXRlc3QtcHJvamVjdC5yZWFkdGhlZG9jcy5pby9lbi9s
YXRlc3QvdXNlcnMvc3VwcG9ydGVkX3N5c3RlbXMuaHRtbAoKPiA+IEluIHRoYXQgY2FzZSBtaW5p
bWFsIGNsYW5nIHZlcnNpb24gc2hvdWxkIGJlIG5vdGVkIGFzIHdlbGwuCgo+ID4gQlRXIEkgdHJp
ZWQgdG8gc2VhcmNoLCBzaG91bGQgaXQgYmUgY2xhbmcgMy41Pwo+ID4gSSB0cmllZCB0byBzZWFy
Y2ggYnV0IG5vdCBmb3VuZC4KPiA+IGh0dHBzOi8vY2xhbmcubGx2bS5vcmcvZG9jcy9MYW5ndWFn
ZUV4dGVuc2lvbnMuaHRtbCNjMTEtYXRvbWljLWJ1aWx0aW5zCgoKCj4gaHR0cHM6Ly9yZWxlYXNl
cy5sbHZtLm9yZy8zLjEvZG9jcy9SZWxlYXNlTm90ZXMuaHRtbAo+IEZyb20gdGhlIHJlbGVhc2Ug
bm90ZXMsIENsYW5nIHdhcyBpbXBsZW1lbnRlZCBfX2F0b21pYyBidWlsdGlucyBpbiB2My4xLgoK
PiBBbmQgeW91IG1hZGUgYSBnb29kIHBvaW50LCB3ZSBhbHNvIG5lZWQgdG8gbm90ZSB0aGUgbWlu
aW1hbCBDbGFuZyB2ZXJzaW9uLAo+IFNvbWV0aGluZyBsaWtlOgoKPiAgIC8qIFVzZSBfX2F0b21p
YyBidWlsdC1pbnMgKEdDQyA+PSA0LjcsIENsYW5nID49IDMuMSksIHdpdGggc2VxdWVudGlhbAo+
IGNvbnNpc3RlbmN5LiAqLwoKKzEgKG5vIG5lZWQgdG8gcmVwb3N0LCBwbGVhc2UganVzdCBhZGQg
aXQgYmVmb3JlIG1lcmdlKS4KCgo+IFAucy4KCj4gVGhlIHdvcnRoIHRvIG1lbnRpb24gZ2l0aHVi
IENJIGFsc28gcGFzc2VkIHdpdGggcmVtb3ZlIF9fc3luYyBidWlsdC1pbnMsCj4gYnV0IHRvIGJl
IG9uIHNhZmUgc2lkZSwgSSBzdGlsbCBrZWVwIHRoZW0gaW4sIG1heWJlIGZvciBzb21lb25lJ3Mg
dXNlIG9uCj4gb2xkZXIKPiBwbGF0Zm9ybS4KCisxCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gaHR0
cHM6Ly9naXRodWIuY29tL3dhbmdsaTU2NjUvbHRwL2NvbW1pdC8zYjFiODFlNjYyYzQ5YjA0Yjc5
YzJiZGY4MDdkODE4OTg0YTJkYmQ5CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
