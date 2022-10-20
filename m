Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66D0C4332F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 10:42:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25E353CB173
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 12:41:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 906EF3C9179
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 12:41:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A2A4C140005D
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 12:41:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0722022B2F;
 Thu, 20 Oct 2022 10:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666262508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WFluHRr9HVELu5UU6SefU7WJNVwK5/aMOJaev3HBamI=;
 b=yJm/F/9INV96rDUZUqs3wQ3c/5OMe9ov6tdOTzeR4+aqoLKzObn7R2i6ajhgBEjE1MPiFI
 2hN2ocrR6KT2FDZ7Y7EgUraCmRlTyW01sGjhRqU88tAEq85Tl5w11ezsHpajFHn/h0gP6L
 BJ2GzvDVO+jE0YHAJ51sBV9dTnvv1U8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666262508;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WFluHRr9HVELu5UU6SefU7WJNVwK5/aMOJaev3HBamI=;
 b=sDGJJr4mwTYCsZvAJYtTJEktNGng5PQWszNpBnKeWUqb1QOI1xrGGaka9JY+00Fh2nmlau
 vv6Z4MNcFCGDXUCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7CA513AF5;
 Thu, 20 Oct 2022 10:41:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5rReN+slUWPsZQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 20 Oct 2022 10:41:47 +0000
Message-ID: <d4d411f1-8f07-1fc9-8762-3ab7faa75f24@suse.cz>
Date: Thu, 20 Oct 2022 12:41:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: Li Wang <liwang@redhat.com>
References: <20221018152527.4636-1-rpalethorpe@suse.com>
 <f15cfed9-b389-b176-9d7d-8f2fcc8aaff0@suse.cz>
 <CAEemH2fVhxhZNsMx0_CU8am_MRoOxnJ1fgu=qJTRag5z1=o0Yw@mail.gmail.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <CAEemH2fVhxhZNsMx0_CU8am_MRoOxnJ1fgu=qJTRag5z1=o0Yw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] ptrace07: Fix compilation when not on x86
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjAuIDEwLiAyMiA1OjUzLCBMaSBXYW5nIHdyb3RlOgo+IAo+IAo+IE9uIFdlZCwgT2N0IDE5
LCAyMDIyIGF0IDU6MzAgUE0gTWFydGluIERvdWNoYSA8bWRvdWNoYUBzdXNlLmN6IAo+IDxtYWls
dG86bWRvdWNoYUBzdXNlLmN6Pj4gd3JvdGU6Cj4gICAgIFJldmVydGluZyAxZGY0ZGUwNjIwNmIw
NzlmMjRkZGU3MTU3ZDAzN2I0ODcyN2M3NDNkIGlzIHRoZSBiZXN0IHNvbHV0aW9uCj4gICAgIGhl
cmUuIEJ1aWxkaW5nIHB0cmFjZTA3IGFuZCBzaW1pbGFyIGFyY2gtc3BlY2lmaWMgdGVzdHMgd2l0
aG91dCBhIGtleQo+ICAgICBwaWVjZSBvZiBjb2RlIGRvZXMgbm90IG1ha2Ugc2Vuc2UuIFRoZSBw
cmVwcm9jZXNzb3IgYXJjaCBjaGVja3Mgc2hvdWxkCj4gICAgIHdyYXAgYXJvdW5kIHRoZSB3aG9s
ZSBmaWxlLCBub3QganVzdCBhIHNtYWxsIG5vbi1wb3J0YWJsZSBiaXQgdGhhdCdzCj4gICAgIGNy
dWNpYWwgZm9yIHRoZSB0ZXN0IHRvIHdvcmsuCj4gCj4gIEZyb20gd2hhdCBJIGtub3csIG9uZSBv
ZiB0aGUgdXNlcyBvZiAiZW1wdHkgbWFjcm8iIGlzIHRvIGNvbmRpdGlvbmFsbHkKPiBpbmNsdWRl
IGNlcnRhaW4gcG9ydGlvbnMgb2YgYSBwcm9ncmFtLiBJbiBwdHJhY2UwNywgaXQgaW52b2tlcyB0
aGF0IHVzZWxlc3MKPiBtYWNybyBmb3IgY29tcGlsaW5nIHBhc3Mgb24gbm9uLXg4NiBhcmNoIGJ1
dCBkb2VzIG5vdCBhbGxvdyBleGVjdXRlIGl0Lgo+IAo+IEkgZG9uJ3Qgc2VlIHdoeSB0aGF0J3Mg
Y3J1Y2lhbCBmb3IgYSB0ZXN0LCBpZiB3ZSB3cmFwIGFyb3VuZCB0aGUgd2hvbGUgCj4gZmlsZSBh
bmQKPiBhdm9pZCBpdCBjb21waWxpbmcgb24gbm9uLXg4NiwgaXNuJ3QgdGhpcyBlc3NlbnRpYWxs
eSBzYW1lIGFzIHRoYXQ/Cj4gCj4gVGhlIG9ubHkgZGlzdGluY3Rpb27CoGJldHdlZW4gdGhlbSBp
cyBwYXJ0bHkgb3Igd2hvbGx5IHNraXBwaW5nIHRoZSBrZXkKPiBjb2RlIGNvbXBpbGF0aW9uLiBv
ciBtYXliZSBJIGNvbXBsZXRlbHkgbWlzdW5kZXJzdG9vZCB0aGlzIHBhcnQuCgpUaGUgY29kZSB0
aGF0IHdvdWxkIGJlIGdlbmVyYXRlZCBieSB0aGUgbm9uLWVtcHR5IHZlcnNpb24gb2YgdGhlIG1h
Y3JvIAppcyBjcnVjaWFsIGZvciByZXN0IG9mIHRoZSBwcm9ncmFtIHRvIHdvcmsuIFB1dHRpbmcg
Y29uZGl0aW9uYWwgYnVpbGQgCmRpcmVjdGl2ZXMgb25seSBhcm91bmQgYSBmZXcgbGluZXMgb2Yg
Y29kZSBjYW4gY2F1c2UgYm9ndXMgd2FybmluZ3MgCmFib3V0IHVuaW5pdGlhbGl6ZWQgdmFyaWFi
bGVzIGFuZCBtYWtlIGl0IGRpZmZpY3VsdCB0byBhZGQgbW9yZSAKYXJjaC1zcGVjaWZpYyBjb2Rl
IGxpa2UgdGhlIGNwdWlkX2NvdW50KCkgbWFjcm8uIFRoZXJlJ3Mgbm90aGluZyB3cm9uZyAKd2l0
aCB3cml0aW5nIHRlc3RzIGxpa2UgdGhpczoKCiNpbmNsdWRlICJ0c3RfdGVzdC5oIgoKI2lmZGVm
IF9feDg2XzY0X18KI2luY2x1ZGUgImxhcGkvY3B1aWQuaCIKCnZvaWQgc2V0dXAodm9pZCkKewoJ
Li4uCn0KCnZvaWQgcnVuKHZvaWQpCnsKCS4uLgp9Cgp2b2lkIGNsZWFudXAodm9pZCkKewoJLi4u
Cn0KCnN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKCS4uLgoJLnN1cHBvcnRlZF9hcmNo
cyA9IChjb25zdCBjaGFyICpjb25zdCBbXSkgewoJCSJ4ODZfNjQiLAoJCU5VTEwKCX0sCn07Cgoj
ZWxzZSAvKiBfX3g4Nl82NF9fICovCiNkZWZpbmUgVFNUX1RFU1RfVENPTkYoInRoaXMgdGVzdCBp
cyBvbmx5IHN1cHBvcnRlZCBvbiB4ODZfNjQiKQojZW5kaWYgLyogX194ODZfNjRfXyAqLwoKCklJ
VUMsIHRoZSBtZXRhZGF0YSBwYXJzZXIgd2lsbCBzdGlsbCByZWFkIC5zdXBwb3J0ZWRfYXJjaHMg
cmVnYXJkbGVzcyBvZiAKY29uZGl0aW9uYWwgYnVpbGQgZGlyZWN0aXZlcy4gQW5kIGl0J2xsIHBy
ZXZlbnQgZXJyYXRpYyB0ZXN0IGJlaGF2aW9yIGluIAplZGdlIGNhc2VzIHdoZXJlIHRoZSBMVFAg
bGlicmFyeSBiZWxpZXZlcyB0aGUgY29kZSB3YXMgY29tcGlsZWQgZm9yIHRoZSAKcmlnaHQgYXJj
aGl0ZWN0dXJlIGJ1dCB0aGUgR0NDIHByZXByb2Nlc3NvciBkaXNhZ3JlZXMuCgotLSAKTWFydGlu
IERvdWNoYSAgIG1kb3VjaGFAc3VzZS5jegpRQSBFbmdpbmVlciBmb3IgU29mdHdhcmUgTWFpbnRl
bmFuY2UKU1VTRSBMSU5VWCwgcy5yLm8uCkNPUlNPIElJYQpLcml6aWtvdmEgMTQ4LzM0CjE4NiAw
MCBQcmFndWUgOApDemVjaCBSZXB1YmxpYwoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
