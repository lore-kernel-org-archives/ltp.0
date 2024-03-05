Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1FEC54E41
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 10:15:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 147CC3D022D
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 11:15:46 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8BE23C0E51
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 11:15:30 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 04FC36011AE
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 11:15:29 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 77A9476BE5;
 Tue,  5 Mar 2024 10:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709633728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xf81Xj5EdI3FOr4ewk7tIAe8q7AO+t6ZTxMZj0g7JZ0=;
 b=jB/quLZsue5j9oDK9NNtHYf/O7UVIjsq6qOwFBT497oIvZlNSIF6PGNbPZ8VNPUzKYKDgM
 pp2oDwLK8oOVLfSFzSMDOYaVOcUSqySY6mE6xM3ImgXpJtwNx/00l1zH0xC1GIiapr/gdY
 2CNclaNMEuIcfDoEaLsasN1T099ChZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709633728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xf81Xj5EdI3FOr4ewk7tIAe8q7AO+t6ZTxMZj0g7JZ0=;
 b=ka1TBj/aXSc5NyFoD4XyGgBKJiS/Rax4KcCpPRfZztC4/8Z2VO6EiBjXuvVnndU57g6RzU
 kFp4HktauQ6zfABg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709633728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xf81Xj5EdI3FOr4ewk7tIAe8q7AO+t6ZTxMZj0g7JZ0=;
 b=jB/quLZsue5j9oDK9NNtHYf/O7UVIjsq6qOwFBT497oIvZlNSIF6PGNbPZ8VNPUzKYKDgM
 pp2oDwLK8oOVLfSFzSMDOYaVOcUSqySY6mE6xM3ImgXpJtwNx/00l1zH0xC1GIiapr/gdY
 2CNclaNMEuIcfDoEaLsasN1T099ChZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709633728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xf81Xj5EdI3FOr4ewk7tIAe8q7AO+t6ZTxMZj0g7JZ0=;
 b=ka1TBj/aXSc5NyFoD4XyGgBKJiS/Rax4KcCpPRfZztC4/8Z2VO6EiBjXuvVnndU57g6RzU
 kFp4HktauQ6zfABg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C90913A5D;
 Tue,  5 Mar 2024 10:15:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id KWTVFcDw5mU2dgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 05 Mar 2024 10:15:28 +0000
Date: Tue, 5 Mar 2024 11:15:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240305101522.GB3825993@pevik>
References: <20240301062716.3023-1-wegao@suse.com>
 <5681819a-2a3a-4c47-a1f1-3f9f49c994d9@fujitsu.com>
 <20240303131402.GC1856074@pevik>
 <CAEemH2eKts8X+tj1keU4Vqp5LwKRa8V1w7QdzGOPmC95F9JK7Q@mail.gmail.com>
 <c7f1510a-adf5-49b8-9f0e-45ad259be38d@fujitsu.com>
 <CAEemH2e1yeu9yL2CbW3z0rVov67Oty_em0HmTrj86SUe0wMATw@mail.gmail.com>
 <ZeaZLq4tsazFvxuW@wegao.81.247.47>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZeaZLq4tsazFvxuW@wegao.81.247.47>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="jB/quLZs";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ka1TBj/a"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; TO_DN_EQ_ADDR_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,fujitsu.com:email]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Queue-Id: 77A9476BE5
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] libswap.c: Improve caculate swap dev number
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBNb24sIE1hciAwNCwgMjAyNCBhdCAwNjowNDowOFBNICswODAwLCBMaSBXYW5nIHdyb3Rl
Ogo+ID4gT24gTW9uLCBNYXIgNCwgMjAyNCBhdCA1OjE54oCvUE0gWWFuZyBYdSAoRnVqaXRzdSkg
PHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+Cj4gPiB3cm90ZToKCj4gPiA+IEhpICBMae+8jAoK
Cgo+ID4gPiA+IE9uIFN1biwgTWFyIDMsIDIwMjQgYXQgOToxNOKAr1BNIFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6Cj4gPiA+ID4gPG1haWx0bzpwdm9yZWxAc3VzZS5jej4+IHdyb3RlOgoKPiA+
ID4gPiAgICAgSGkgV2VpLCBYdSwKCj4gPiA+ID4gICAgICA+IEhpICBXZWkKCj4gPiA+ID4gICAg
ICA+ID4gSSBlbmNvdW50ZXIgYSBkZWFkIGxvb3Agb24gZm9sbG93aW5nIGNvZGUgaW4gb3VyIHRl
c3Qgb24gcHBjNjQKPiA+ID4gPiAgICAgbWFjaGluZToKPiA+ID4gPiAgICAgID4gPiB3aGlsZSAo
KGMgPSBmZ2V0YyhmcCkpICE9IEVPRikKCj4gPiA+ID4gICAgICA+ID4gSSB0aGluayAiL3Byb2Mv
c3dhcHMiIGlzIG5vdCBub3JtYWwgZmlsZSBhbmQgY2FuIG5vdCBnZXQgRU9GIGluCj4gPiA+ID4g
ICAgIHNvbWUgc2l0dWF0aW9uLAo+ID4gPiA+ICAgICAgPiA+IHNvIGkgdXNlIGZnZXRzIGEgbGlu
ZSBhbmQgY2FjdWxhdGUgc3dhcCBkZXYgbnVtYmVyLgoKPiA+ID4gPiAgICAgSSBndWVzcyB0aGUg
cHJvYmxlbSBoYXMgYmVlbiBmaXhlZCBieSBhbm90aGVyIHBhdGNoIFsxXSwgdGh1cwo+ID4gPiA+
ICAgICBjbG9zaW5nIGl0IGluCj4gPiA+ID4gICAgIHBhdGNod29yay4gUGxlYXNlIGxldCBtZSBr
bm93IGlmIG5vdC4KCgo+ID4gPiA+IFNlZW1zIG5vdCwgdGhlIHBhdGNoIFsxXSBiZWxvdyBpcyBt
YWlubHkgdG8gY291bnQgdGhlIGZyZWUgZGlzayBzaXplLgoKPiA+ID4gPiBCdXQgV2VpJ3Mgd29y
ayBoZXJlIGlzIHRvIGNhbGN1bGF0ZSBzd2FwLWRldiBudW1iZXJzIGNvcnJlY3RseQo+ID4gPiA+
IChlc3BlY2lhbGx5IGdldCByaWQgb2YgRU9GIGFmZmVjdGlvbiB0byBzb21lIGRlZ3JlZSkuCgo+
ID4gPiA+IFh1IFlhbmcsIHdoYXQgZG8geW91IHRoaW5rPyBvciBkaWQgSSBtaXNzIGFueXRoaW5n
IGhlcmU/CgoKCj4gPiA+IEkgc3RpbGwgdGhpbmsgd2UgY2FuIHVzZSB0aGUgc2FtZSB3YXkgaW4g
aXBjIGxpYnMgdG8gZ2V0IHJpZCBvZiB0aGUgRU9GCj4gPiA+IHByb2JsZW0gaW5zdGVhZCBvZgo+
ID4gPiBzZWFyY2hpbmcgImRldiIga2V5d29yZC4gV2UganVzdCBkb24ndCBuZWVkIHRvICBjYWxj
dWFsdGUgIi9wcm9jL3N3YXBzIgo+ID4gPiBoZWFkZXIuCgoKPiA+IFNvdW5kcyBnb29kIHRvIG1l
LiBBdCBsZWFzdCBpdCBjb3VudHMgcmlnaHQgbGluZXMuCgo+ID4gSXQnZCBiZSBncmVhdCB0byBo
YXZlIGEgcGF0Y2ggYnkgdGhhdCB3YXkuCgoKCgo+ID4gPiBpbnQgZ2V0X3VzZWRfc3lzdmlwYyhj
b25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLCBjb25zdCBjaGFyCj4gPiA+ICpzeXN2
aXBjX2ZpbGUpCj4gPiA+IHsKPiA+ID4gICAgICAgICBGSUxFICpmcDsKPiA+ID4gICAgICAgICBp
bnQgdXNlZCA9IC0xOwo+ID4gPiAgICAgICAgIGNoYXIgYnVmW0JVRlNJWkVdOwoKPiA+ID4gICAg
ICAgICBmcCA9IHNhZmVfZm9wZW4oZmlsZSwgbGluZW5vLCBOVUxMLCBzeXN2aXBjX2ZpbGUsICJy
Iik7Cgo+ID4gPiAgICAgICAgIHdoaWxlIChmZ2V0cyhidWYsIEJVRlNJWkUsIGZwKSAhPSBOVUxM
KQo+ID4gPiAgICAgICAgICAgICAgICAgdXNlZCsrOwoKPiA+ID4gICAgICAgICBmY2xvc2UoZnAp
OwoKPiA+ID4gICAgICAgICBpZiAodXNlZCA8IDApIHsKPiA+ID4gICAgICAgICAgICAgICAgIHRz
dF9icmsoVEJST0ssICJjYW4ndCByZWFkICVzIHRvIGdldCB1c2VkIHN5c3ZpcGMgcmVzb3VyY2UK
PiA+ID4gdG90YWwgYXQgIgo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAiJXM6JWQiLCBz
eXN2aXBjX2ZpbGUsIGZpbGUsIGxpbmVubyk7Cj4gPiA+ICAgICAgICAgfQoKPiA+ID4gICAgICAg
ICByZXR1cm4gdXNlZDsKPiA+ID4gfQoKPiA+ID4gQnV0IHdlIGRvbid0IGdldCB0aGUgYWN0dWFs
IHJlYXNvbiwgSSBzdGlsbCB3b25kZXIgd2h5IHRoaXMgZGVhZGxvb3AKPiA+ID4gZXhpc3RzIG8g
cHBjYzY0IGluc3RlYWQgb2YKPiA+ID4gb3RoZXIgYXJjaGl0ZWN0dXJlKGllIHg4Nl82NCkuCgpG
WUkgYWxzbyBvdGhlciBhcmNoaXRlY3R1cmVzIGZhaWxzIChlZy5nIGxlYXN0IGFhcmNoNjQsIHMz
OTB4IGFuZCBwcGM2NGxlIHdoaWNoCndhcyBpbiB0aGUgb3JpZ2luYWwgcmVwb3J0OyBpdCBsb29r
cyB0byBtZSBpdCB3b3JrcyBvbiB4ODZfNjQpLgoKUHJvYmxlbSBpcyBzb21ld2hlcmUgaW4KYzFi
OGMwMTFlNDQ3MDg4YjA4Nzg3NDYyZTBjMmVkNTBjZDhjNDNmMy4uOGZkOTQxNjQ5YWZlZWNjNWY4
NzUwOGM5Zjk0ZTlhODQwYTg0ZTQ0ZAp3aGljaCBjb250YWlucyAzMTk2OTNkMGIgKCJsaWJsdHBz
d2FwOiBhbHRlciB0c3RfY291bnRfc3dhcHMgQVBJIiksIHdoaWNoIGlzIFdlaQp0cnlpbmcgdG8g
Zml4LgoKPiA+IE9rLCBJIHRoaW5rIHdlIGNhbiBqdXN0IGFwcGx5IHlvdXIgc3VnZ2VzdGVkIG1l
dGhvZCB0byBzZWUgaWYgdGhhdCBkZWFkbG9vcAo+ID4gZGlzYXBwZWFycy4KCj4gSGkgUGV0ciwg
WHUsIExpIAo+IERlYWRsb29wIHdpbGwgZGlzYXBwZWFyIGlmIHlvdSB1c2UgZmdldHMsIGZnZXRj
IGNhbiBub3QgZ2V0IEVPRiBvbiBwcGM2NC4oU3VzcGVjdCBhbiBidWcpCj4gU28gZWl0aGVyIHVz
ZSBteSBwYXRjaCBvciBYdSdzIHN1Z2dlc3Rpb24gYm90aCBjYW4gd29yay4KCkkgd291bGQgdm90
ZSBmb3IgWHUncyBzdWdnZXN0aW9uIChhbnkgbGluZSBleGNlcHQgdGhlIGZpcnN0IGhlYWRlciBp
cyB2YWxpZCksCmFjdHVhbGx5IHRoaXMgaW1wbGVtZW50YXRpb24gaXMgbm90IGNvcnJlY3Qgd2hl
biBpdCBjb3VudHMgb25seSAvZGV2OgoKIyBkZCBpZj0vZGV2L3plcm8gb2Y9L3Jvb3Qvc3dhcCBi
cz0xMDBNIGNvdW50PTEKIyBta3N3YXAgLWYgL3Jvb3Qvc3dhcAojIHN3YXBvbiAvcm9vdC9zd2Fw
CgojIGNhdCAvcHJvYy9zd2FwcwpGaWxlbmFtZQkJCQlUeXBlCQlTaXplCQlVc2VkCQlQcmlvcml0
eQovZGV2L2RtLTAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFydGl0aW9uCTE5MjUw
OAkJNDA0OAkJLTIKL3Jvb3Qvc3dhcCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZpbGUJ
CTEwMjM5NgkJMAkJLTMKCihzZWNvbmQgbGluZSB3aXRob3V0IC9kZXYpCgpBbHNvIHR5cG8gaW4g
dGhlIHN1YmplY3Q6IHMvY2FjdWxhdGUvY2FsY3VsYXRlLwoKV2VpLCBwbGVhc2Ugc2VuZCBuZXcg
dmVyc2lvbiBhbmQgQ2MgdXMuCgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
