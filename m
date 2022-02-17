Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D949BC433EF
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 11:45:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A6F33CA0A7
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 12:45:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C5073C9564
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 12:45:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DA2931A01955
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 12:45:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0283C210DC;
 Thu, 17 Feb 2022 11:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645098325;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=loLYtvZYPROQc5ZQMZ4V5vjbczPWRMwCwDS0xewDOb0=;
 b=iKJ5wJ2+8i9Wv9xBSkMzLpQngwIymtW8BQeViqXqXuBdq7pZ7MoJ5F3aybMMi4Iqg+eWok
 Tn8VSQPhJ4+VClAhODJNoT72y3a49UOxtK8qxcjXT12rwpg27Z1LZFuJkya7n6LFble3b7
 jIH1t8jWMkwsg98xbOcj2w2G8brWUXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645098325;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=loLYtvZYPROQc5ZQMZ4V5vjbczPWRMwCwDS0xewDOb0=;
 b=fg2+dgVZN4SwakyIJeRQbEWYdlM4g4G801/0LWtKx1y6PVXkcl00InXWvGuzwYGj1IuPdh
 eLurrq59nAPMljCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA6AE13BBF;
 Thu, 17 Feb 2022 11:45:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HMTzJ1Q1DmJlZQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 17 Feb 2022 11:45:24 +0000
Date: Thu, 17 Feb 2022 12:45:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yg41Uk3IxfBRX+i8@pevik>
References: <20220203170522.22051-1-pvorel@suse.cz>
 <20220203170522.22051-3-pvorel@suse.cz> <Yg4bt2V6rrircZ+x@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yg4bt2V6rrircZ+x@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] sctputil.h: TCONF on EAFNOSUPPORT
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
Cc: Vlad Yasevich <vyasevich@gmail.com>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Neil Horman <nhorman@tuxdriver.com>, ltp@lists.linux.it,
 linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ3lyaWwsIGFsbCwKCj4gSGkhCj4gPiBkaWZmIC0tZ2l0IGEvdXRpbHMvc2N0cC90ZXN0bGli
L3NjdHB1dGlsLmggYi91dGlscy9zY3RwL3Rlc3RsaWIvc2N0cHV0aWwuaAo+ID4gaW5kZXggMWUy
MTc2MGJlYy4uYzRiZWRiNDdjZiAxMDA2NDQKPiA+IC0tLSBhL3V0aWxzL3NjdHAvdGVzdGxpYi9z
Y3RwdXRpbC5oCj4gPiArKysgYi91dGlscy9zY3RwL3Rlc3RsaWIvc2N0cHV0aWwuaAo+ID4gQEAg
LTEzMyw5ICsxMzMsMTQgQEAgZXh0ZXJuIGludCBUU1RfQ05UOwo+ID4gIHN0YXRpYyBpbmxpbmUg
aW50IHRlc3Rfc29ja2V0KGludCBkb21haW4sIGludCB0eXBlLCBpbnQgcHJvdG9jb2wpCj4gPiAg
ewo+ID4gIAlpbnQgc2sgPSBzb2NrZXQoZG9tYWluLCB0eXBlLCBwcm90b2NvbCk7Cj4gPiArCWlu
dCByZXMgPSBUQlJPSzsKCj4gPiAtCWlmIChzayA9PSAtMSkKPiA+IC0JCXRzdF9icmttKFRCUk9L
LCB0c3RfZXhpdCwgInNvY2tldDogJXMiLCBzdHJlcnJvcihlcnJubykpOwo+ID4gKwlpZiAoc2sg
PT0gLTEpIHsKPiA+ICsJCWlmIChlcnJubyA9PSBFQUZOT1NVUFBPUlQpCj4gPiArCQkJcmVzID0g
VENPTkY7Cj4gPiArCj4gPiArCQl0c3RfYnJrbShyZXMsIHRzdF9leGl0LCAic29ja2V0OiAlcyIs
IHN0cmVycm9yKGVycm5vKSk7Cj4gPiArCX0KCj4gSSB3b3VsZCBrZWVwIHRoZSBtZXNzYWdlcyBz
ZXBhcmF0ZWQgaGVyZSwgaS5lLiBkbyBzb21ldGhpbmcgYXM6Cgo+IAlpZiAoZXJybm8gPT0gRUFG
Tk9TVVBQT1JUKQo+IAkJdHN0X2Jya20oVEJST0sgfCBURVJSTk8sICJzb2NrZXQoJWksICVpLCAl
aSkgbm90IHN1cHBvcnRlZCIsCj4gCQkJIGRvbWFpbiwgdHlwZSwgcHJvdG9jb2wpOwoKPiAJdHN0
X2Jya20oVEJST0sgfCBURVJSTk8sICJzb2NrZXQoKSIpOworMQoKCj4gQnR3IHRoaXMgY29kZSBh
Y3R1YWxseSBkdXBsaWNhdGVzIHRoZSBzYWZlX3NvY2tldCgpIGZ1bmN0aW9uIHdlIGRvIGhhdmUK
PiBhbHJlYWR5LCBzbyBpdCBtYXkgYXMgd2VsbCBiZSBlYXNpZXIgdG8ganVzdCByZXBsYWNlIHRo
ZSB0ZXN0X3NvY2tldCgpCj4gd2l0aCBTQUZFX1NPQ0tFVCgpIGluIHRoZSB0ZXN0cy4uLgpJIG9y
aWdpbmFsbHkgd2FudGVkIHRvIHVzZSBzYWZlX21hY3Jvcy5oIGluIHNjdHB1dGlsLmggdG8gcmVw
bGFjZSB0aGVzZQp0ZXN0X3tiaW5kLGNvbm5lY3QsbGlzdGVuLHNvY2tldH0gd2l0aCB0aGVpciBT
QUZFXyooKSB2YXJpYW50cy4KCkJ1dCBpdCBsZWFkcyBpbnRvIGRlcGVuZGVuY3kgbWFueSByZWRl
ZmluaXRpb24gcHJvYmxlbXMgZHVlIG1peGluZwo8bmV0aW5ldC9pbi5oPiBhbmQgPGxpbnV4L2lu
Lmg+LCBlLmcuOgoKL3Vzci9pbmNsdWRlL25ldGluZXQvaW4uaDo2ODo1OiBlcnJvcjogcmVkZWNs
YXJhdGlvbiBvZiBlbnVtZXJhdG9yIOKAmElQUFJPVE9fR1JF4oCZCiAgIDY4IHwgICAgIElQUFJP
VE9fR1JFID0gNDcsICAgICAgLyogR2VuZXJhbCBSb3V0aW5nIEVuY2Fwc3VsYXRpb24uICAqLwov
dXNyL2luY2x1ZGUvbGludXgvaW4uaDo1NTozOiBub3RlOiBwcmV2aW91cyBkZWZpbml0aW9uIG9m
IOKAmElQUFJPVE9fR1JF4oCZIHdpdGggdHlwZSDigJhlbnVtIDxhbm9ueW1vdXM+4oCZCiAgIDU1
IHwgICBJUFBST1RPX0dSRSA9IDQ3LCAgICAgICAgICAgICAvKiBDaXNjbyBHUkUgdHVubmVscyAo
cmZjIDE3MDEsMTcwMikgICAgKi8KICAgICAgfCAgIF5+fn5+fn5+fn5+CmluIHV0aWxzL3NjdHAv
ZnVuY190ZXN0cy90ZXN0XzFfdG9fMV9ydG9pbmZvLmMsIHdoaWNoIHJlcXVpcmVzIDxsaW51eC9p
bi5oPiBmb3IKYXQgbGVhc3QgSVBQUk9UT19TQ1RQIHdoaWNoIGlzIG5vdCBpbiA8bmV0aW5ldC9p
bi5oPi4KCklQUFJPVE9fU0NUUCBpcyBhbHNvIGluIDxsaW51eC9zY3RwLmg+LCBidXQgaXQgYWxz
byByZXF1aXJlcyA8bmV0aW5ldC9zY3RwLmg+CmZvciBzY3RwX3JlY3Ztc2coKSBhbmQgaXQgY3Jl
YXRlcyBhbm90aGVyIHJlZGVmaW5pdGlvbiBjb25mbGljdCBkdWUgdXNpbmcKPG5ldGluZXQvc2N0
cC5oPiB3aXRoIDxsaW51eC9zY3RwLmg+ID0+IGRlcGVuZGVuY3kgaGVsbCA6KS4KCkZZSSB0ZXN0
XzFfdG9fMV9ydG9pbmZvLmMgdXNlcyB0ZXN0X3NvY2tldCgpIGFuZCBzY3RwdXRpbC5oLgoKU3Vy
ZSB0aGlzIGlzIHNvbHZhYmxlIHZpYSBlaXRoZXIgdXNpbmcgbGFwaSBoZWFkZXJzIHdoaWNoIHdv
dWxkIGxvYWQgb25seSBvbmUgb2YKdGhlbSBhbmQgd2l0aCBhZGRpbmcgZXh0cmEgZGVmaW5pdGlv
bnMgb3Igc2ltcGxlIGp1c3QgYWRkaW5nIHRoZSBtaXNzaW5nCmRlZmluaXRpb25zIGludG8gc2N0
cHV0aWwuaC4KCkJ1dCBJTUhPIGEgY2xlYW5lciBzb2x1dGlvbiBpcyB0byByZXdyaXRlIHRlc3Qg
b25lIGJ5IG9uZSAod2hpY2ggd291bGQgdGFrZQp0aW1lKSwgYnV0IHdlJ3JlIHdhaXRpbmcgcmVw
bHkgZnJvbSBTQ1RQIG1haW50YWluZXJzIHdoZXJlIChhbmQgd2hvKSBpcyBnb2luZyB0bwptYWlu
dGFpbiB0aGVzZSB0ZXN0cyB3aGljaCBkZXNlcnZlIGEgbWFzc2l2ZSBjbGVhbnVwLi4uCgpUaHVz
IGZvciBub3csIEknbGwgZm9sbG93IHlvdXIgb3RoZXIgc3VnZ2VzdGlvbnMgYW5kIG1lcmdlIHNv
IHRoYXQgd2UgaGF2ZSBJUHY2CmZpeGVzIGluLgoKS2luZCByZWdhcmRzLApQZXRyCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
