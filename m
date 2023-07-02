Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEFBEB64D9
	for <ltp@archiver.kernel.org>; Sun,  2 Jul 2023 19:12:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A57133CC267
	for <ltp@archiver.kernel.org>; Sun,  2 Jul 2023 21:12:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D38A3CC202
 for <ltp@lists.linux.it>; Sun,  2 Jul 2023 21:12:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 800D8600120
 for <ltp@lists.linux.it>; Sun,  2 Jul 2023 21:12:43 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EEA941F7AB;
 Sun,  2 Jul 2023 19:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688325160;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kS0r3VIRx/yhzWN84bxFfthREN1D0F6dsKWg0u5iXS8=;
 b=kaaI6fIR1pEJ8M8BPVxdFviDGpcfNElXv2g7NPjzTHaDV41cJhVlVAB+q60rR1puaHC5YS
 ZKeMQc8DetZIFlSXxc/RCcOdV4YomyD+esAp2Bba/WDj33IvIpXj4IHtZVOoct749apVGG
 4n69jplXUO6vYvoXgQANWNCm+kJkZMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688325160;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kS0r3VIRx/yhzWN84bxFfthREN1D0F6dsKWg0u5iXS8=;
 b=XvZjcJkdmgZ5zwMV9bg/FwN9Z925KRALQdT1sXrGo4kdyxnYG+paXUqjApNvr2A54g8HPu
 wvN8m/NchTkXTeCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CEB911348D;
 Sun,  2 Jul 2023 19:12:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GOiCMSjMoWT3TgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sun, 02 Jul 2023 19:12:40 +0000
Date: Sun, 2 Jul 2023 21:12:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20230702191234.GA360317@pevik>
References: <20230630193742.310416-1-pvorel@suse.cz>
 <CAOQ4uxjG0GrKRZE5btcbptjAaKRLj+OFMJRynPwPx4_BP4=e9g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjG0GrKRZE5btcbptjAaKRLj+OFMJRynPwPx4_BP4=e9g@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED][PATCH 1/1] runtest: Move fanotify23 from
 staging to syscalls
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW1pciwKCj4gT24gRnJpLCBKdW4gMzAsIDIwMjMgYXQgMTA6MzjigK9QTSBQZXRyIFZvcmVs
IDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gZmFub3RpZnkyMyBpcyBhIHRlc3QgZm9yIEZB
Tl9NQVJLX0VWSUNUQUJMRSwgcHJlcGFyZWQgZm9yIHY1LjE5LXJjMS4KPiA+IFdlIGZvcmdldCB0
byBtb3ZlIGl0IGFmdGVyIHY1LjE5IGJlaW5nIHJlbGVhc2VkLgoKPiA+IFNpZ25lZC1vZmYtYnk6
IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+ID4gLS0tCj4gPiBPYnZpb3VzbHkgd2UgZm9y
Z2V0IHRvIGNoZWNrIHRoZSBmaWxlIGFmdGVyIHNldmVyYWwga2VybmVsIHJlbGVhc2VzIDooLgo+
ID4gSSdtIHNvcnJ5LgoKPiBPaCwgbWlzc2VkIHlvdXIgbm90ZSBvbiBjb21taXQ6Cj4gWyBwdm9y
ZWw6IG1vdmUgdGVzdCBpbnRvIHN0YWdpbmcgXQoKPiBJZiBJJ2Qga25vd24sIEkgbWlnaHQgaGF2
ZSByZW1lbWJlcmVkIHRvIHJlbWluZCB5b3UgOy0pCgo+IGZhbm90aWZ5MjMgYW5kIGZhbm90aWZ5
MTAgYm90aCBhZGRlZCB0ZXN0cyBmb3IKPiBGQU5fTUFSS19FVklDVEFCTEUgYXQgdGhlIHNhbWUg
dGltZS4KCj4gQnV0IHNpbmNlIHRoZW4gdGhlcmUgd2VyZSB0d28gYXR0ZW1wdHMgdG8gaW1wcm92
ZSB0aGUgcmVsaWFiaWxpdHkKPiBvZiBmYW5vdGlmeTEwOgoKPiA0OGNmZDdhOTkgc3lzY2FsbHMv
ZmFub3RpZnkxMDogTWFrZSBldmljdGFibGUgbWFya3MgdGVzdCBtb3JlIHJlbGlhYmxlCj4gNGZl
ZmRmMzQwIGZhbm90aWZ5MTA6IE1ha2UgZXZpY3RhYmxlIG1hcmtzIHRlc3RzIG1vcmUgcmVsaWFi
bGUKCj4gSSB3b25kZXIgaWYgZmFub3RpZnkyMydzIHJlbGlhYmlsaXR5IGRpZCBub3QgY29tZSB1
cCBzbyBmYXIgYmVjYXVzZQo+IDEuIEl0IHdhcyBpbiBzdGFnaW5nIGxpc3QKPiAyLiBJdCBoYXMg
dGhpcyBoYWNrOgo+ICAgICAgICAvKiBTaHJpbmtlcnMgb24gb3RoZXIgZnMgZG8gbm90IHdvcmsg
cmVsaWFibHkgZW5vdWdoIHRvCj4gZ3VhcmFudGVlIG1hcmsgZXZpY3Rpb24gb24gZHJvcF9jYWNo
ZXMgKi8KPiAgICAgICAgLmRldl9mc190eXBlID0gImV4dDIiLAoKPiBJIGd1ZXNzIHdlIHdpbGwg
a25vdyBzb29uIC4uLgoKSSB3b25kZXIgbXlzZWxmIDopLiBCdXQgSSBhY3R1YWxseSBmaWxsZWQg
b3BlblNVU0UgYnVnIFsxXSBhYm91dCBmYW5vdGlmeTIzCnJhbmRvbWx5IGZhaWxpbmcsIHdoZW4g
cnVubmluZyBtb3JlIHRpbWVzIChlLmcuIC4vZmFub3RpZnkyMyAtaTUpLiBJIHdhcyBub3QKc3Vy
ZSBpZiBpdCdzIG9wZW5TVVNFIHNwZWNpZmljIG9yIG5vdCAoSSBzdXNwZWN0IHRoZSBwcm9ibGVt
IGlzIGdlbmVyaWMsIGJ1dCAyCnRlc3RlZCBEZWJpYW4gc3lzdGVtcyBkb24ndCBzdWZmZXIgdGhp
cyksIHRodXMgSSBmaXJzdCBwdXQgaXQgdG8gdGhlIEphbidzIHF1ZXVlLgoKS2luZCByZWdhcmRz
LApQZXRyCgpbMV0gaHR0cHM6Ly9idWd6aWxsYS5zdXNlLmNvbS8xMjEyOTA2Cgo+IFRoYW5rcywK
PiBBbWlyLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
