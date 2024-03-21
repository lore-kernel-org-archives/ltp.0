Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47753C54E68
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 07:35:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A79893CE840
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 08:35:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A5BB3CB427
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 08:35:41 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1FB77140C7C4
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 08:35:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D93A5CA48;
 Thu, 21 Mar 2024 07:35:40 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27DBF13976;
 Thu, 21 Mar 2024 07:35:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bkKECEzj+2XfYQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 21 Mar 2024 07:35:40 +0000
Date: Thu, 21 Mar 2024 08:35:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Shirisha ganta <shirisha@linux.ibm.com>
Message-ID: <20240321073534.GA533096@pevik>
References: <20230929091401.205277-1-shirisha@linux.ibm.com>
 <20231128112254.GA367506@pevik>
 <c58c5365f7c801e93745775577a3cbb83159fb91.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c58c5365f7c801e93745775577a3cbb83159fb91.camel@linux.ibm.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Queue-Id: 3D93A5CA48
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Migrating the
 libhugetlbfs/testcases/truncate.c test
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

PiA+IC4uLgo+ID4gPiArc3RhdGljIHZvaWQgc2lnYnVzX2hhbmRsZXIoaW50IHNpZ251bSkKPiA+
ID4gK3sKPiA+ID4gKwl0ZXN0X3Bhc3MgPSAxOwo+ID4gPiArCXNpZ2xvbmdqbXAoc2lnX2VzY2Fw
ZSwgMTcpOwo+ID4gV2hhdCAxNyBzdGFuZHMgZm9yPyBJcyB0aGVyZSBhbnkgY29uc3RhbnQgd2hp
Y2ggY291bGQgYmUgdXNlZD8gT3IgY2FuCj4gPiB5b3UgZGVmaW5lCj4gPiBzb21ldGhpbmcgKHRo
ZSBuYW1lIG9mIHRoZSBjb25zdGFudCB3b3VsZCBiZSBzZWxmLWRlc2NyaWJpbmcpLgo+IFRoZSB2
YWx1ZSAxNyBpcyBvZnRlbiBjaG9zZW4gYXMgYSBub24temVybyByZXR1cm4gdmFsdWUgZm9yIHNp
Z3NldGptcAo+IGJlY2F1c2UgaXQgaXMgdW5saWtlbHkgdG8gYmUgYSB2YWxpZCByZXR1cm4gdmFs
dWUgZnJvbSBhIG5vcm1hbAo+IGZ1bmN0aW9uLiBCeSB1c2luZyBhIG5vbi16ZXJvIHZhbHVlLCB5
b3UgY2FuIGRpc3Rpbmd1aXNoIGJldHdlZW4gYQo+IGRpcmVjdCByZXR1cm4gZnJvbSBzaWdzZXRq
bXAgKHdoZXJlIHRoZSByZXR1cm4gdmFsdWUgaXMgMCkgYW5kIGEgcmV0dXJuCj4gYWZ0ZXIgYSBz
aWdsb25nam1wICh3aGVyZSB0aGUgcmV0dXJuIHZhbHVlIGlzIG5vbi16ZXJvKS4KPiBCeSB1c2lu
ZyBhIG5vbi16ZXJvIHZhbHVlIChsaWtlIDE3KSwgeW91IGNhbiBkaWZmZXJlbnRpYXRlIGJldHdl
ZW4KPiBub3JtYWwgZnVuY3Rpb24gcmV0dXJucyBhbmQganVtcHMgZHVlIHRvIGV4Y2VwdGlvbmFs
IGNvbmRpdGlvbnMuIGhlCj4gc3BlY2lmaWMgdmFsdWUgY2hvc2VuIChzdWNoIGFzIDE3KSBjYW4g
dmFyeSBiYXNlZCBvbiB0aGUgcHJvZ3JhbW1lcuKAmXMKPiBwcmVmZXJlbmNlIG9yIHRoZSBjb250
ZXh0IG9mIHRoZSBhcHBsaWNhdGlvbi4gU29tZSBkZXZlbG9wZXJzIG1pZ2h0IHVzZQo+IG90aGVy
IG5vbi16ZXJvIHZhbHVlcywgYnV0IDE3IGhhcyBiZWNvbWUgYSBjb252ZW50aW9uIGR1ZSB0byBp
dHMKPiB1bmlxdWVuZXNzIGFuZCByZWFkYWJpbGl0eS4KClRoYW5rcyBmb3IgaW5mbyEKCktpbmQg
cmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
