Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10586C4332F
	for <ltp@archiver.kernel.org>; Fri,  9 Dec 2022 09:51:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 515693CBFDD
	for <ltp@archiver.kernel.org>; Fri,  9 Dec 2022 10:51:04 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D25723CBFB7
 for <ltp@lists.linux.it>; Fri,  9 Dec 2022 10:50:54 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 178A41A00A47
 for <ltp@lists.linux.it>; Fri,  9 Dec 2022 10:50:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F1A42337DB;
 Fri,  9 Dec 2022 09:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670579452;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/jlPgLCwOWydwhjAcqazNRKl7ZeYDspQ84RSa3Ulzzs=;
 b=d6lWFm9onZj2DteaVjEosP1Xbei28ymTH/LBBEMrOosWkZl3r94Tt9MV4hd/ao3qLDKTa4
 r0VTWgv/tMIZ3FMsGQtI45Qw4duvjAuZm48Iu7cBxeI6x1LWodqnOB1XMEhVNhn/N/gLFk
 zLcpNoOtHgpHfcHvWCCm1PHJk3n4v3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670579452;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/jlPgLCwOWydwhjAcqazNRKl7ZeYDspQ84RSa3Ulzzs=;
 b=IUH0R95iYtJTFOEq3Ep3rvUjmBGNgtQLqAIVi7kqYTyujfciOV8te8+f1XLQusW7KmNR0E
 w0spiP6tGsmlsmBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C325F138E0;
 Fri,  9 Dec 2022 09:50:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZsY/LfwEk2MecgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 09 Dec 2022 09:50:52 +0000
Date: Fri, 9 Dec 2022 10:50:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: zhaogongyi <zhaogongyi@huawei.com>
Message-ID: <Y5ME+qWykgu7PYoV@pevik>
References: <f276dc67c7234650835e3b859ec81204@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f276dc67c7234650835e3b859ec81204@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] config.mk.in: build.sh: Add
 -Wno-missing-field-initializers to CFLAGS
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

PiBIaSEKCgo+ID4gSGkhCj4gPiA+IEFkZCBDRkxBR1MgLVduby1taXNzaW5nLWZpZWxkLWluaXRp
YWxpemVycyB0byBzdXBwcmVzcyB0aGUgY29tcGlsYXRpb24KPiA+ID4gd2FybmluZ3MgbGlrZToK
Cj4gPiA+IGF1dG9ncm91cDAxLmM6ODc6MTogd2FybmluZzogbWlzc2luZyBpbml0aWFsaXplciBm
b3IgZmllbGQKPiA+ID4g4oCYbmVlZHNfY21kc+KAmSBvZiDigJhzdHJ1Y3QgdHN0X3Rlc3TigJkg
Wy1XbWlzc2luZy1maWVsZC1pbml0aWFsaXplcnNdICB9Owo+ID4gPiBeIEluIGZpbGUgaW5jbHVk
ZWQgZnJvbSBhdXRvZ3JvdXAwMS5jOjIxOjA6Cj4gPiA+IC4uLy4uLy4uLy4uL2luY2x1ZGUvdHN0
X3Rlc3QuaDozMjQ6MjE6IG5vdGU6IOKAmG5lZWRzX2NtZHPigJkgZGVjbGFyZWQgaGVyZQo+ID4g
PiAgIGNvbnN0IGNoYXIgKmNvbnN0ICpuZWVkc19jbWRzOwoKPiA+IFRoaXMgaXMgYWN0dWFsbHkg
Y2F1c2VkIGJ5IGEgZ2NjIGJ1ZyB0aGF0IGhhcyBiZWVuIGFscmVhZHkgZml4ZWQgc2VlOgoKPiA+
IGh0dHBzOi8vZ2NjLmdudS5vcmcvYnVnemlsbGEvc2hvd19idWcuY2dpP2lkPTg0Njg1Cgo+IFRo
YW5rIHlvdSBmb3IgeW91ciBub3RpY2UuCgoKPiA+IEFuZCBJIGRvIG5vdCB0aGluayB0aGF0IGl0
J3MgYSBnb29kIGlkZWEgdG8gd29yayBhcm91bmQgZ2NjIHdhcm5pbmdzIGluIG91cgo+ID4gYnVp
bGQgc3lzdGVtLgoKSXQncyBqdXN0IG1hdHRlciBvZiB0aW1lIHdoZW4gb2xkIGdjYyBwYXNzZXMg
YXdheS4KCgo+IEkgaGF2ZW4ndCBwYWlkIGF0dGVudGlvbiB0byBvdGhlciB3YXJuaW5nIG1lc3Nh
Z2VzIG5vdy4gTWF5YmUgdGhleSBzaG91bGQgYmUgaWdub3JlZCBhcyB3ZWxsLgoKTW9zdCBvZiB0
aGUgd2FybmluZ3MgYXJlIHZhbGlkIGFuZCBzaG91bGQgYmUgZml4ZWQuIFRoYXQgdGFrZXMgdGlt
ZSwgYnV0IHdlIGFsbApzbG93bHkgd29yayBvbiBpdC4gQW55d2F5LCB3YXJuaW5nIGFyZSBoZXJl
IGZvciBhIHJlYXNvbiwgSSBwcmVmZXIgdG8gaGF2ZSBmYWxzZQpwb3NpdGl2ZXMgdGhhbiBsb3N0
IHZhbGlkIHdhcm5pbmcuCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gUmVnYXJkcywKPiBHb25neWkK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
