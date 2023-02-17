Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80ADDC05027
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 08:47:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6C3A3CBE6F
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 09:47:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A3A93CB089
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 09:47:13 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 17CBD1000A5F
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 09:47:12 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 915232294B;
 Fri, 17 Feb 2023 08:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676623631;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BrAcBpNzWL5V9N2ZRRMpBPLgkziayJKNg17TJaWKpLM=;
 b=0znSFF6RQ/2VnyxbBxrqohe+2B1bL8C1MJ+xI8xeTr/5E8n7jS9cWaioycs1xsoLFKXyFa
 AX66lHizTWjsX6Qd8pIY4LGdzj6KIn4D2E8ZUpt9eAWT5ivQ+zyBQbPstyM3JK2XgnUZa8
 i+PFOi6SKRUJmvKAKnezT4tLiRC8Nrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676623631;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BrAcBpNzWL5V9N2ZRRMpBPLgkziayJKNg17TJaWKpLM=;
 b=ACOp4Ehnwoq9wgpLFe60OF3IE7va3BuA2cE+JDukdOkLOCKHk1p3zP7aDyiiPBM+EfsiO4
 AzB+tH2Kn9FGhmAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48A87138E3;
 Fri, 17 Feb 2023 08:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TAM7Dw8/72ORBQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 17 Feb 2023 08:47:11 +0000
Date: Fri, 17 Feb 2023 09:47:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Y+8/CHVbHycW1+Gv@pevik>
References: <20230213010924.12352-1-wegao@suse.com>
 <20230216235218.25757-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230216235218.25757-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] fsconfig03: New test CVE-2022-0185
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKSSd2ZSB0ZXN0ZWQgdmFyaW91cyBrZXJuZWxzLCBpdCBsb29rcyBsaWtlIHRlc3Qg
d29ya3MgYXMgZXhwZWN0ZWQKKG9sZGVyIHVucGF0Y2hlZCBrZXJuZWwgZmFpbHMsIG5ld2VyIHdv
cmtzLCB2ZXJ5IG9sZCBvbmVzIFRDT05GKS4KCj4gVGhlcmUgYXJlIHJlcHJvZHVjZXJzIGF2YWls
YWJsZSBmb3IgQ1ZFLTIwMjItMDE4NQo+IGh0dHBzOi8vd3d3Lm9wZW53YWxsLmNvbS9saXN0cy9v
c3Mtc2VjdXJpdHkvMjAyMi8wMS8yNS8xNAoKPiBBbHNvIHdpdGggbGlua3Mgb3IgZXZlbiBhIHpp
cCBmaWxlIGZvciBhbiBleHBsb2l0Cj4gaHR0cHM6Ly9naXRodWIuY29tL0NydXNhZGVycy1vZi1S
dXN0L0NWRS0yMDIyLTAxODUKCj4gVGhlIGV4cGxvaXRzIGFyZSBraW5kIG9mIGNvbXBsaWNhdGVk
IGFzIHRoZXkgdHJ5IHRvIGJlIGNvbXBsZXRlLAo+IGJ1dCB0aGUgZXhwbG9pdGF0aW9uIHZlY3Rv
ciBpcyB0aGUgZnNjb25maWcoKSBzeXNjYWxsLAo+IHRoaXMgY2FzZSB1c2VkIGZvciBhZGQgc29t
ZSBjb3ZlcmFnZSB0byB0aGF0IHRvIGRldGVjdCBpdC4KCj4gV2hlbiBrZXJuZWwgPCB2NS4xNS4x
NiwgeW91IGNhbiBlYXNpbHkgcmVwcm9kdWNlIGNyYXNoIHVzZSB0ZXN0IGNhc2UKPiB3aXRob3V0
IGNoZWNrIGVycm9yIGFuZCByZXR1cm4gbG9naWMgaW4gbG9vcC4KCj4gSSBoYXZlIHVzZWQgdGhp
cyB0ZXN0IGNhc2UgdHJpZ2dlciA1LjE0LjEga2VybmVsIGNyYXNoIHdpdGggZXh0Mi80LgoKPiBK
dXN0IG1ha2Ugc3VyZSB5b3VyIGtlcm5lbCBoYXZlIG5vdCBwYXRjaGVkIGJ5IGZvbGxvd2luZyB0
d28gY29tbWl0czoKPiBlMTkyY2NjMTdlY2YzIC0gZml4IHVwIHBhcmFtIGxlbmd0aCBwYXJzaW5n
IGluIGxlZ2FjeV9wYXJzZV9wYXJhbQpGWUk6IGNvbW1pdCA3MjJkOTQ4NDdkZTI5MzEwZThhYTAz
ZmNiZGI0MWZjOTJjNTIxNzU2IHVwc3RyZWFtLgo9PiB0aGF0J3MgYSBiYWNrcG9ydCBvZiA3MjJk
OTQ4NDdkZTI5IHdlIGhhdmUgaW4gLnRhZ3MgaW4gNS4xNSBzdGFibGUgYnJhbmNoLgpUaGlzIGlz
IG5vdCBvYnZpb3VzLCBiZWNhdXNlIHRoZSBoYXNoIGlzIGRpZmZlcmVudDsgYWxzbyBoYXNoIHdp
bGwgYmUKZGlmZmVyZW50IGZvciBmb3Igb3RoZXIga2VybmVsIHN0YWJsZSBicmFuY2hlcywgZS5n
LiBpbiA1LjEwIHN0YWJsZSBpdCdzCmJhY2twb3J0ZWQgaW50byBlYWRkZTI4N2E2MmU2NmIyZjll
NjJkMDA3YzU5YThmNTBkNGI4NDEzLgoKVGhpcyBpcyBtaXNsZWFkaW5nLCBJIGZpcnN0IHdvbmRl
cmVkIGlmIGUxOTJjY2MxN2VjZjMgc2hvdWxkbid0IGJlIGluIHRhZ3MKKGl0IHNob3VsZG4ndCBi
ZWNhdXNlIGl0J3MgYSBiYWNrcG9ydCBvZiA3MjJkOTQ4NDdkZTI5ID0+IHdlIGRvbid0IHB1dCBi
YWNrcG9ydHMKdGhlcmU6ICJXZSBkb27igJl0IHRyYWNrIGFsbCBiYWNrcG9ydHMgdG8gc3RhYmxl
IGtlcm5lbCBidXQganVzdCB0aG9zZSB3aGljaCBhcmUKc3RhYmxlIGJyYW5jaCBzcGVjaWZpYyAo
dW5pcXVlKSwgaS5lLiBubyBjb21taXQgaW4gbWFpbmxpbmUuIEV4YW1wbGUgb2YgY29tbWl0czoK
YzRhMjNjODUyZTgwLCBjYWM2OGQxMmM1MzEuIiBbMV0pLgoKVGhlcmVmb3JlIEknZCByZW1vdmUg
dGhpcyB3aG9sZSBzZWN0aW9uICgiSnVzdCBtYWtlIHN1cmUuLi4iKS4KCj4gY2ViZTg1ZDU3MGNm
OCAtIGV4dDQ6IHN3aXRjaCB0byB0aGUgbmV3IG1vdW50IGFwaQoKSSBzdXBwb3NlIHRlc3QgaXMg
bm93IHdvcmtpbmcgYXMgZXhwZWN0ZWQgcmVnYXJkbGVzcyBrZXJuZWwgdXNlcwp0aGUgb2xkIG1v
dW50IEFQSSBvciB0aGUgbmV3IG9uZSAoZnJvbSBjZWJlODVkNTcwY2Y4KSwgcmlnaHQ/CklzIHRo
aXMgY29tbWVudCB1cCB0byBkYXRlPwoKQWxzbywgbml0OiBrZXJuZWwgY29tbWl0cyBhcmUgdXN1
YWxseSBwdXQgaW4gZm9ybSBvZiBoYXNoICgiLi4uIiksIGkuZS4KZTE5MmNjYzE3ZWNmICgidmZz
OiBmc19jb250ZXh0OiBmaXggdXAgcGFyYW0gbGVuZ3RoIHBhcnNpbmcgaW4gbGVnYWN5X3BhcnNl
X3BhcmFtIikKCktpbmQgcmVnYXJkcywKUGV0cgoKWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9saW51
eC10ZXN0LXByb2plY3QvbHRwL3dpa2kvQy1UZXN0LUFQSSMxMzgtdGVzdC10YWdzCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
