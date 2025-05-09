Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E28C3ABBC
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 11:34:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8070D3CC1DD
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 13:34:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E78B33CC1A1
 for <ltp@lists.linux.it>; Fri,  9 May 2025 13:34:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C9B3C600707
 for <ltp@lists.linux.it>; Fri,  9 May 2025 13:34:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 18063210F9;
 Fri,  9 May 2025 11:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746790472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WYRp18yDXGZMhuxUm8duXyhXusySuBcKZ0It3BANXTo=;
 b=COoEEXoJ5qatcq5bTnUDgZWT4GM4oRARgirwqGu1wMc/+e+hgh8RTVrVVAm5up3pKTg/2O
 vzo3WSaxvjuw47M9Pk0Ph64MUXyZpaXqQRWQDU6qYrUV/dXgiF5lq/vlsXetBF5ndE5zPE
 DcP6tyAS1ZHM98rYlo4NRoFW/TfWnmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746790472;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WYRp18yDXGZMhuxUm8duXyhXusySuBcKZ0It3BANXTo=;
 b=YCd6bmpM/bpTzWZmP7gKND7HiM5DaktvOL/auSOnT3+syvYg7aS+Osy9UKdjXOLlZOQDBK
 6wZbaXCvID659qDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746790472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WYRp18yDXGZMhuxUm8duXyhXusySuBcKZ0It3BANXTo=;
 b=COoEEXoJ5qatcq5bTnUDgZWT4GM4oRARgirwqGu1wMc/+e+hgh8RTVrVVAm5up3pKTg/2O
 vzo3WSaxvjuw47M9Pk0Ph64MUXyZpaXqQRWQDU6qYrUV/dXgiF5lq/vlsXetBF5ndE5zPE
 DcP6tyAS1ZHM98rYlo4NRoFW/TfWnmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746790472;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WYRp18yDXGZMhuxUm8duXyhXusySuBcKZ0It3BANXTo=;
 b=YCd6bmpM/bpTzWZmP7gKND7HiM5DaktvOL/auSOnT3+syvYg7aS+Osy9UKdjXOLlZOQDBK
 6wZbaXCvID659qDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 037371399F;
 Fri,  9 May 2025 11:34:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cgNyAEjoHWjYFQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Fri, 09 May 2025 11:34:32 +0000
Message-ID: <1f0c4c30-6258-4ece-8bb2-881165f06317@suse.cz>
Date: Fri, 9 May 2025 13:34:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, Petr Vorel <pvorel@suse.cz>
References: <20250507154543.22309-1-mdoucha@suse.cz>
 <20250507175328.GA182617@pevik>
 <CAEemH2d1Ae6r_7N2V2KBm0pb0wxedWMxwKkN4nnub19-P5YTEQ@mail.gmail.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <CAEemH2d1Ae6r_7N2V2KBm0pb0wxedWMxwKkN4nnub19-P5YTEQ@mail.gmail.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap_24-1: Change vm.max_map_count if needed
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMDkuIDA1LiAyNSA2OjAzLCBMaSBXYW5nIHdyb3RlOgo+IFRoZXJlIGFyZW1hbnkgd2F5cyB0
b2F2b2lkwqBPT00gKGUuZy4sIG92ZXJjb21taXRfbWVtb3J5LCBvb21fc2NvcmVfYWRqLAo+IHVs
aW1pdCwgZXRjLikuIEhvd2V2ZXIsIHRoZSBwdXJwb3NlIG9mIHRoZSBtbWFwXzI0LTEuYyB0ZXN0
IGlzIHRvIAo+IGV4aGF1c3QgdGhldmlydHVhbAo+IGFkZHJlc3Mgc3BhY2UgYW5kIHRyaWdnZXIg
RU5PTUVNLgo+IAo+IExpbWl0aW5nIHZtLm1heF9tYXBfY291bnQgbWF5IHByZXZlbnQgT09NLCBi
dXQgaXQgY2hhbmdlcyB0aGUgZmFpbHVyZSAKPiBjYXVzZSB0bwo+IGhpdHRpbmcgdGhlbWFwIGNv
dW50IGxpbWl0LCBub3QgYWN0dWFsIGFkZHJlc3Mgc3BhY2UgZXhoYXVzdGlvbiwgd2hpY2ggCj4g
bWlnaHQgYmUgYXdheQo+IGZyb20gdGhldGVzdCdzIGludGVudC4KPiAKPiBJZ3Vlc3MgdXNpbmcg
c2V0cmxpbWl0KFJMSU1JVF9BUywgLi4uKSBpcyBtb3JlIGFwcHJvcHJpYXRlIGhlcmUsIGFzIGl0
IAo+IGVuZm9yY2VzIGFkZHJlc3MKPiBzcGFjZSBsaW1pdHMgd2hpbGUgcHJlc2VydmluZyB0aGUg
b3JpZ2luYWwgdGVzdCBnb2FsLgoKNjRiaXQgYWRkcmVzcyBzcGFjZSBpcyBzbyBsYXJnZSB0aGF0
IGV4aGF1c3RpbmcgaXQgcmVxdWlyZXMgNTEyK0dCIG9mIApwYWdlIHRhYmxlIHN0cnVjdHVyZXMg
YWxvbmUgKGZvciB0aGUgNDhiaXQgdmFyaWFudCkuIEFuZCBrZXJuZWwgd2lsbCBub3QgCnJldHVy
biBFTk9NRU0gd2hlbiBpdCBydW5zIG91dCBvZiBmcmVlIG1lbW9yeSBmb3IgcGFnZXRhYmxlIHN0
cnVjdHVyZXMsIAppdCdsbCB0cmlnZ2VyIE9PTS4KClRoZSBtbWFwXzI0LTEgdGVzdCBzdGFydGVk
IGZhaWxpbmcgYWZ0ZXIgdGhlIGRlZmF1bHQgdm0ubWF4X21hcF9jb3VudCAKaW5jcmVhc2VkIGlu
IG9uZSBvZiBvdXIgdGVzdGVkIHByb2R1Y3Qgc28gdGhpcyBpcyB0aGUgbGltaXQgd2Ugd2FudCB0
byAKY2hhbmdlIGhlcmUuIEJ1dCB5b3UgY291bGQgY29weSB0aGUgdGVzdCBhbmQgY2hhbmdlIFJM
SU1JVF9BUyB0aGVyZS4gClRoYXQgd291bGQgYWxzbyBiZSBhIHZhbGlkIHRlc3QgY2FzZS4KCi0t
IApNYXJ0aW4gRG91Y2hhICAgbWRvdWNoYUBzdXNlLmN6ClNXIFF1YWxpdHkgRW5naW5lZXIKU1VT
RSBMSU5VWCwgcy5yLm8uCkNPUlNPIElJYQpLcml6aWtvdmEgMTQ4LzM0CjE4NiAwMCBQcmFndWUg
OApDemVjaCBSZXB1YmxpYwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
