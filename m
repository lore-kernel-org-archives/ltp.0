Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FBFC021B2
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 15:09:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 589403C9BF5
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 16:09:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F84A3C98CB
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 16:09:39 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 887071411A7B
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 16:09:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 92BDF21167;
 Tue, 25 Feb 2025 15:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740496177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qcrpYsbLKUHriRurdBJaObM3eg+5VHXSYAlJr3A5Meo=;
 b=klEKmWOkIbw481meYnJqP0NlmFwqOumqquNa82Y0ZaoXZYQ/5lXAYnvOVw2iijkAyE4529
 GOHp/JVi87lTuB1kbs71REDPInD+fLgy1STeAJnACAtBCyvsXeJLBGIJKtni0QRcpfkMCK
 7gIo9z5QU+EufNw9G6rzRla2RJM5LXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740496177;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qcrpYsbLKUHriRurdBJaObM3eg+5VHXSYAlJr3A5Meo=;
 b=YotDu2m39ZDw8WI/W1qbqxpjmJLAjEwU/YTNo7xFIwQLCHn4IaSd4KMtcoLIJygu8VT6eJ
 VACcSgPK4bRE34DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740496177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qcrpYsbLKUHriRurdBJaObM3eg+5VHXSYAlJr3A5Meo=;
 b=klEKmWOkIbw481meYnJqP0NlmFwqOumqquNa82Y0ZaoXZYQ/5lXAYnvOVw2iijkAyE4529
 GOHp/JVi87lTuB1kbs71REDPInD+fLgy1STeAJnACAtBCyvsXeJLBGIJKtni0QRcpfkMCK
 7gIo9z5QU+EufNw9G6rzRla2RJM5LXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740496177;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qcrpYsbLKUHriRurdBJaObM3eg+5VHXSYAlJr3A5Meo=;
 b=YotDu2m39ZDw8WI/W1qbqxpjmJLAjEwU/YTNo7xFIwQLCHn4IaSd4KMtcoLIJygu8VT6eJ
 VACcSgPK4bRE34DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 823CC13332;
 Tue, 25 Feb 2025 15:09:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tU4THzHdvWc1JgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Tue, 25 Feb 2025 15:09:37 +0000
Message-ID: <9bdb73d0-dd51-445e-bdc9-d201d81fe72f@suse.cz>
Date: Tue, 25 Feb 2025 16:09:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250224-disable_virt_other_getrusage04-v1-1-bcb433af9635@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20250224-disable_virt_other_getrusage04-v1-1-bcb433af9635@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/getrusage04: Disable for VIRT_OTHER
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

SGksCkkgdGhpbmsgaXQnZCBiZSBiZXR0ZXIgdG8gY2hhbmdlIHRoZSBjb25kaXRpb24gdG8gdGhp
czoKCmlmICh0c3RfaXNfdmlydChWSVJUX0FOWSkpCiAgICAgdHN0X2Jya20oVENPTkYsIC4uLik7
CgpPdGhlcndpc2Ugd2UnbGwgcGxheSBlbmRsZXNzIHdoYWNrLWEtbW9sZSB3aXRoIGZ1dHVyZSB2
aXJ0IGVudmlyb25tZW50cy4KCk9uIDI0LiAwMi4gMjUgMTc6MjYsIFJpY2FyZG8gQi4gTWFybGnD
qHJlIHdyb3RlOgo+IEZyb206IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4g
Cj4gVGhpcyB0ZXN0IGlzIGtub3duIHRvIGJlIHVuc3RhYmxlIHVuZGVyIHNvbWUgZW52aXJvbm1l
bnRzIHN1Y2ggYXMgaW4gdGhlCj4gY29udGV4dCBvZiBhIGNsb3VkIGluc3RhbmNlIHdpdGhpbiBB
V1MgKGFuZCBvdGhlciBwcm92aWRlcnMgYXMgd2VsbCksIHdoaWNoCj4gb3V0cHV0cyAiYW1hem9u
IiBmb3IgYHN5c3RlbWQtZGV0ZWN0LXZpcnRgIGFuZCB0aGVyZWZvcmUgZmFsbHMgaW50byB0aGUK
PiBWSVJUX09USEVSIGNhdGVnb3J5Lgo+IAo+IFN1Z2dlc3RlZC1ieTogTWFydGluIERvdWNoYSA8
bWRvdWNoYUBzdXNlLmN6Pgo+IFNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxy
Ym1Ac3VzZS5jb20+Cj4gLS0tCj4gICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldHJ1c2Fn
ZS9nZXRydXNhZ2UwNC5jIHwgOCArKysrKy0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9nZXRydXNhZ2UvZ2V0cnVzYWdlMDQuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvZ2V0cnVzYWdlL2dldHJ1c2FnZTA0LmMKPiBpbmRleCBiMDNiYzU0OWJkODM1YjMzYWNh
YTAyNjkzNzA2MjU1ZTg4Y2JlNGY4Li4wZTIyZTJlZTlkYWRmYjFjMDVkZjQ0MjVjNjViMDRiMjU3
OWUxNjQ5IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0cnVzYWdl
L2dldHJ1c2FnZTA0LmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldHJ1c2Fn
ZS9nZXRydXNhZ2UwNC5jCj4gQEAgLTE5OCw5ICsxOTgsMTEgQEAgc3RhdGljIHZvaWQgc2V0dXAo
dm9pZCkKPiAgIHsKPiAgIAl0c3Rfc2lnKE5PRk9SSywgREVGX0hBTkRMRVIsIGNsZWFudXApOwo+
ICAgCj4gLQlpZiAodHN0X2lzX3ZpcnQoVklSVF9YRU4pIHx8IHRzdF9pc192aXJ0KFZJUlRfS1ZN
KSB8fCB0c3RfaXNfdmlydChWSVJUX0hZUEVSVikpCj4gLQkJdHN0X2Jya20oVENPTkYsIE5VTEws
ICJUaGlzIHRlc3RjYXNlIGlzIG5vdCBzdXBwb3J0ZWQgb24gdGhpcyIKPiAtCQkgICAgICAgICIg
dmlydHVhbCBtYWNoaW5lLiIpOwo+ICsJaWYgKHRzdF9pc192aXJ0KFZJUlRfWEVOKSB8fCB0c3Rf
aXNfdmlydChWSVJUX0tWTSkgfHwKPiArCSAgICB0c3RfaXNfdmlydChWSVJUX0hZUEVSVikgfHwg
dHN0X2lzX3ZpcnQoVklSVF9PVEhFUikpCj4gKwkJdHN0X2Jya20oVENPTkYsIE5VTEwsCj4gKwkJ
CSAiVGhpcyB0ZXN0Y2FzZSBpcyBub3Qgc3VwcG9ydGVkIG9uIHRoaXMiCj4gKwkJCSAiIHZpcnR1
YWwgbWFjaGluZS4iKTsKPiAgIAo+ICAgCUJJQVNfTUFYID0gZ3Vlc3NfdGltZXJfcmVzb2x1dGlv
bigpOwo+ICAgCj4gCj4gLS0tCj4gYmFzZS1jb21taXQ6IGExYWViZmQ0ZDk5ZDVkYTEyODM0ZGFl
NTIxNTgxNWZmOGQ4Mjk5NWMKPiBjaGFuZ2UtaWQ6IDIwMjUwMjI0LWRpc2FibGVfdmlydF9vdGhl
cl9nZXRydXNhZ2UwNC1jOWRiMmFhOWU2OWMKPiAKPiBCZXN0IHJlZ2FyZHMsCgoKLS0gCk1hcnRp
biBEb3VjaGEgICBtZG91Y2hhQHN1c2UuY3oKU1cgUXVhbGl0eSBFbmdpbmVlcgpTVVNFIExJTlVY
LCBzLnIuby4KQ09SU08gSUlhCktyaXppa292YSAxNDgvMzQKMTg2IDAwIFByYWd1ZSA4CkN6ZWNo
IFJlcHVibGljCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
