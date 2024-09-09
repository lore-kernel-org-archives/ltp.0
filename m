Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CDFECE579
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 11:05:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62B723C1841
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 13:05:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 589173C12A6
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 13:05:18 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 501A060065E
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 13:05:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CC79F21B78;
 Mon,  9 Sep 2024 11:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725879916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=faLsgvT9mWRn3k7lFWg+Br1nYniyhjKkmWly4Xxb3RM=;
 b=AJtWbjsUXP+6HrC1fMHVPESxvtppepumTD3Do7Rj1GfEd5D7mlM5zr7W9/4j1Kx3JLy5fJ
 t8OW+7vTo63UUk8G9/ZD0qTsxqd/jOQK5zfco1au+l5qs9xu28yjQTy/LhzV2JRywEAZNS
 H4C6QztErSy0W8zMj9wI5bBi+LrX/7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725879916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=faLsgvT9mWRn3k7lFWg+Br1nYniyhjKkmWly4Xxb3RM=;
 b=nRrFNyNQaq0z59sVPWs/k/XkUB49zKkbjfc5AQ6ObnHKP1gaed/ahdrBhn0uMUULh3/x0Q
 btrG1XfCkUh6g6Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725879915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=faLsgvT9mWRn3k7lFWg+Br1nYniyhjKkmWly4Xxb3RM=;
 b=hm4deKmFiOK36WmhMII0HilzlI+LSeKGfAdNyDXluPRPpYXkkm9JLU4mCYyWaTIwQOC5uk
 tLG5rwm4rH2USofY7RldyivnTk/HKnCIuBTchWtQv3x65lGA6T1s8BkItuhi15Hez4pQNC
 XxzhPqigxFWSlvdRaBIX8Lkg7x2SW98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725879915;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=faLsgvT9mWRn3k7lFWg+Br1nYniyhjKkmWly4Xxb3RM=;
 b=UvzryfU7PiqAY+ZhFfLv6jmbDrkvlquNsO6juir7f8KJc5F43YSUpZDetQKydgUlSVktJy
 sfh0AHAj8i2VyJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1A5013A3A;
 Mon,  9 Sep 2024 11:05:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bhTaLmvW3mYzJAAAD6G6ig
 (envelope-from <akumar@suse.de>); Mon, 09 Sep 2024 11:05:15 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Mon, 09 Sep 2024 13:05:15 +0200
Message-ID: <2744588.vuYhMxLoTh@localhost>
Organization: SUSE
In-Reply-To: <20240909025243.537071-1-liwang@redhat.com>
References: <20240903140326.773060-1-pvorel@suse.cz>
 <20240909025243.537071-1-liwang@redhat.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; HAS_ORG_HEADER(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] swapoff01/swapon01: Define max_runtime 1 mins
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

SGksCgpSZXZpZXdlZC1ieTogQXZpbmVzaCBLdW1hciA8YWt1bWFyQHN1c2UuZGU+CgpPbiBNb25k
YXksIFNlcHRlbWJlciA5LCAyMDI0IDQ6NTI6NDPigK9BTSBHTVQrMiBMaSBXYW5nIHdyb3RlOgo+
IEZyb206IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+IAo+IFRlc3QgcnVuIG1vc3RseSBi
ZWxvdyAxIHNlYyBwZXIgZmlsZXN5c3RlbSwgb25seSBOVEZTIGlzIHZlcnkgc2xvdwo+IH4gMTAt
MTUgc2VjIGRlcGVuZGluZyBvbiBhcmNoaXRlY3R1cmUuCj4gCj4gQWxzbyB0aGlzIGlzIHRoZSBv
bmx5IHRlc3RzIGluIHN5c2NhbGxzIHdoaWNoIGZhaWxzIG9uIGR1ZSB0aW1lb3V0IG9uCj4gZW11
bGF0ZWQgcmlzYy12IHdpdGggTFRQX1RJTUVPVVRfTVVMPTIsTFRQX1JVTlRJTUVfTVVMPTIgKHdp
dGggdGhlCj4gZGVmYXVsdCAzMHMgcnVudGltZSA9PiAxIG1pbiBkdWUgTFRQX1JVTlRJTUVfTVVM
PTIpLgo+IAo+IEJhc2VkIG9uIHRoZSB0ZXN0IGNvbnN1bWVkIHRpbWUgb24gUlBpMCBhbmQgUlBp
NCwgd2Ugc2V0IHJ1bnRpbWUgdG8gNjBzLAo+IHRoYXQgc2hvdWxkIGJlIGVub3VnaCBldmVuIGZv
ciBzbG93IHJpc2MtdiBhbmQgbm90IHRoYXQgaGlnaCBmb3Igb3RoZXIgYXJjaHMuCj4gCj4gU2ln
bmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gU2lnbmVkLW9mZi1ieTog
TGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4gLS0tCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvc3dhcG9mZi9zd2Fwb2ZmMDEuYyB8IDEgKwo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL3N3YXBvbi9zd2Fwb24wMS5jICAgfCAxICsKPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fw
b2ZmL3N3YXBvZmYwMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb2ZmL3N3YXBv
ZmYwMS5jCj4gaW5kZXggMzE0NjMwMjY3Li45NjVkMTdjYzggMTAwNjQ0Cj4gLS0tIGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb2ZmL3N3YXBvZmYwMS5jCj4gKysrIGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9zd2Fwb2ZmL3N3YXBvZmYwMS5jCj4gQEAgLTUzLDUgKzUzLDYgQEAg
c3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ICAJLmFsbF9maWxlc3lzdGVtcyA9IDEs
Cj4gIAkubmVlZHNfcm9vdCA9IDEsCj4gIAkudGVzdF9hbGwgPSB2ZXJpZnlfc3dhcG9mZiwKPiAr
CS5tYXhfcnVudGltZSA9IDYwLAo+ICAJLnNldHVwID0gc2V0dXAKPiAgfTsKPiBkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEuYyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9uL3N3YXBvbjAxLmMKPiBpbmRleCA0OTkxNWMzMmQuLmVk
ZGNkNTc4OCAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9z
d2Fwb24wMS5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9u
MDEuYwo+IEBAIC01MSw1ICs1MSw2IEBAIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsK
PiAgCS5hbGxfZmlsZXN5c3RlbXMgPSAxLAo+ICAJLm5lZWRzX2Nncm91cF9jdHJscyA9IChjb25z
dCBjaGFyICpjb25zdCBbXSl7ICJtZW1vcnkiLCBOVUxMIH0sCj4gIAkudGVzdF9hbGwgPSB2ZXJp
Znlfc3dhcG9uLAo+ICsJLm1heF9ydW50aW1lID0gNjAsCj4gIAkuc2V0dXAgPSBzZXR1cAo+ICB9
Owo+IAoKUmVnYXJkcywKQXZpbmVzaAoKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
