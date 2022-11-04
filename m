Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363BCC4332F
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 15:44:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBA953CAF38
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 16:44:27 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D3943C32DD
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 16:44:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CA9381A0088B
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 16:44:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 205C61F8AE;
 Fri,  4 Nov 2022 15:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667576656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qN9FgM9dbBCxhOWBamBqxRyDQsKviiYY20MTsOklPVc=;
 b=NQPFID69Ij7goF9UyFxwPERVBVUeUyKosrcgCkoL2/GtJ0HkNT8NlXMj8/uS607sXlTbtB
 GucSqtPpBBVX9hzsi4pMLzq/6IMdqYVaihwhdZMlaSzm/Ju1s+9tl3OWQHuisHDcXpX+6D
 0q1GPoaRKJpElKU7tt56kjyUwg3gorA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667576656;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qN9FgM9dbBCxhOWBamBqxRyDQsKviiYY20MTsOklPVc=;
 b=ytgIqxpxRvWQR3Y49mfCidekT+IikkX8A32rFsBm2PIEUVR3ScgstCcORlKl0Ib/8PhAA2
 g9d69rpHtctxC9AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D54B13216;
 Fri,  4 Nov 2022 15:44:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 97MUAlAzZWO3WwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 04 Nov 2022 15:44:16 +0000
Message-ID: <051a74e3-0a6a-5fe3-3e10-24430c8e5a96@suse.cz>
Date: Fri, 4 Nov 2022 16:44:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Andrea Cervesato <andrea.cervesato@suse.com>, ltp@lists.linux.it
References: <20221104092411.5446-1-andrea.cervesato@suse.com>
 <c9a2c8ce-9dfb-a001-fa93-10a669c0e228@suse.cz>
 <6597b3e7-2f24-6d6d-e0f9-976251518e21@suse.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <6597b3e7-2f24-6d6d-e0f9-976251518e21@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Correctly handle user time in setitimer01
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

T24gMDQuIDExLiAyMiAxNToyMCwgQW5kcmVhIENlcnZlc2F0byB3cm90ZToKPiBIaSEKPiAKPiBP
biAxMS80LzIyIDEzOjQ2LCBNYXJ0aW4gRG91Y2hhIHdyb3RlOgo+PiBUaGlzIGFwcHJvYWNoIGxv
b2tzIGxpa2UgaXQnbGwgbGVhZCB0byBzb21lIGJhZCBlZGdlIGNhc2VzIHdoZW4KPj4gMCA8IHRp
bWVfc3RlcCA8IDEwMDAuIEl0J2QgYmUgYmV0dGVyIHRvIGtlZXAgdGhlIG9yaWdpbmFsIHRpbWVf
c3RlcCAKPj4gZGV0ZWN0aW9uIGFuZCBpbml0aWFsaXplICJlcnJvciIgdmFyaWFibGUgbGlrZSB0
aGlzIChhbmQgYWxzbyByZW5hbWUgCj4+IGl0IHRvICJtYXJnaW4iKToKPj4KPj4gaW50IGppZmZ5
Owo+Pgo+PiB2ZXJpZnlfc2V0aXRpbWVyKCkKPj4gewo+PiDCoMKgwqDCoC4uLgo+PiDCoMKgwqDC
oG1hcmdpbiA9ICh0Yy0+d2hpY2ggPT0gSVRJTUVSX1JFQUwpID8gMCA6IGppZmZ5Owo+IEhlcmUg
d2UgY2FuJ3QgdGFrZSBpbiBjb25zaWRlcmF0aW9uIENMT0NLX01PTk9UT05JQ19DT0FSU0UgcmVz
b2x1dGlvbiBieSAKPiBkZWZhdWx0LCBiZWNhdXNlIG9uIElUSU1FUl9SRUFMIHdlIGFyZSBoYXZp
bmcgYSBjbG9jayByZXNvbHV0aW9uIGdpdmVuIAo+IGJ5IENMT0NLX01PTk9UT05JQy4gQW5kIHVu
Zm9ydHVuYXRlbHkgd2UgYXJlIG5vdCBzdXJlIGl0J3MgdW5kZXIgdGhlIAo+IG1pbGxpc2Vjb25k
IHJlc29sdXRpb24gYWxsIHRoZSB0aW1lcywgd2hpY2ggbWVhbnMgbWFyZ2luID4gMC4gRm9yIHRo
aXMgCj4gcmVhc29uLCBpbiB0aGUgcGF0Y2ggd2UgYXJlIGZldGNoaW5nIGNsb2NrIHJlc29sdXRp
b24gaW4gYSBkaWZmZXJlbnQgCj4gd2F5LCBhY2NvcmRpbmcgd2l0aCB0aGUgY291bnRlciB0aW1l
ci4gV2UgY2FuIGZldGNoIGRpZmZlcmVudCAKPiByZXNvbHV0aW9ucyBmcm9tIHNldHVwIHRobyBh
bmQgdXNpbmcgaW5zaWRlIHRoZSB0ZXN0IGNvZGUuCgpUaGVyZSBpcyBub3RoaW5nIHByZXZlbnRp
bmcgeW91IGZyb20gdXNpbmcgQ0xPQ0tfTU9OT1RPTklDX0NPQVJTRSAKcmVzb2x1dGlvbiBhcyB0
aW1lX3N0ZXAgZXZlbiBmb3IgSVRJTUVSX1JFQUwuIFRoZSBvbmx5IGNvbnN0cmFpbnRzIGFyZSAK
dGhhdCB0aGUgdGltZXIgdmFsdWUgbXVzdCBiZToKMSkgaGlnaGVyIHRoYW4gQ0xPQ0tfTU9OT1RP
TklDIHJlc29sdXRpb24gKHByZWZlcmFibHkgYSBtdWx0aXBsZSBvZiBpdCkKMikgbGFyZ2UgZW5v
dWdoIHNvIHRoYXQgeW91IGNhbiBjYWxsIHNldGl0aW1lcigpIGFnYWluIGJlZm9yZSB0aGUgdGlt
ZXIgCmV4cGlyZXMKCkNMT0NLX01PTk9UT05JQ19DT0FSU0UgcmVzb2x1dGlvbiBzaG91bGQgc2F0
aXNmeSB0aGUgZmlyc3QgY29uc3RyYWludCBieSAKZGVmaW5pdGlvbi4KCi0tIApNYXJ0aW4gRG91
Y2hhICAgbWRvdWNoYUBzdXNlLmN6ClFBIEVuZ2luZWVyIGZvciBTb2Z0d2FyZSBNYWludGVuYW5j
ZQpTVVNFIExJTlVYLCBzLnIuby4KQ09SU08gSUlhCktyaXppa292YSAxNDgvMzQKMTg2IDAwIFBy
YWd1ZSA4CkN6ZWNoIFJlcHVibGljCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
