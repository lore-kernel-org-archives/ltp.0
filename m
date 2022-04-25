Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513F8C433EF
	for <ltp@archiver.kernel.org>; Mon, 25 Apr 2022 10:48:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4175B3C90DB
	for <ltp@archiver.kernel.org>; Mon, 25 Apr 2022 12:48:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD1503C1769
 for <ltp@lists.linux.it>; Mon, 25 Apr 2022 12:48:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6E9D920023B
 for <ltp@lists.linux.it>; Mon, 25 Apr 2022 12:48:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7FEEA21107;
 Mon, 25 Apr 2022 10:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650883684;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dUV8S4t7bXe7DUrl/0blBTBO1iuq9WPSVyHQ13oXZdY=;
 b=ZiCHMePnSw1T0eMs8ms8KRWx7sRATOuXgoDtW3wXyzSdiR/6otcTgL/G4Jp4GgR2jKI7yi
 EY8c736ZuCR242XqdkzC4pRLiyV/N9E1c8FQu4eE5OIsYl2F05e6Hyna6K0PIhUkYq3HtY
 mcakurpX75xjeEJmQ2lgrUBbtCriEWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650883684;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dUV8S4t7bXe7DUrl/0blBTBO1iuq9WPSVyHQ13oXZdY=;
 b=ia+il8joT2V1AZWjGbfg3oWiGboYVZubR2ebWWR62ZubpyUYpJmCKPXU9N4P41DneV4Ip9
 Z3yk1zObz3p8BABA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 734A613AED;
 Mon, 25 Apr 2022 10:48:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id c6zeG2R8ZmKuPQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 25 Apr 2022 10:48:04 +0000
Date: Mon, 25 Apr 2022 12:48:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Message-ID: <YmZ8Y7cZNBd55/oR@pevik>
References: <20220425060806.1038-1-chenhx.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220425060806.1038-1-chenhx.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/mount_setattr01: Add basic functional
 test
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

SGkgQ2hlbiwgYWxsLAoKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9sYXBpL2ZzbW91bnQuaCBiL2lu
Y2x1ZGUvbGFwaS9mc21vdW50LmgKPiArCj4gKy8qCj4gKyAqIG1vdW50X3NldGF0dHIoKQo+ICsg
Ki8KPiArc3RydWN0IG1vdW50X2F0dHIgewpJZiB5b3UgYnVpbGQgb24gbmV3IGVub3VnaCBnbGli
YyAoYW5kIGFwcGx5IHRvIHJlY2VudCBtYXN0ZXIpLCB5b3UgZ2V0IGZhaWx1cmVzCmR1ZSBzdHJ1
Y3QgcmVkZWZpbml0aW9uOgoKSW4gZmlsZSBpbmNsdWRlZCBmcm9tIG1vdW50X3NldGF0dHIwMS5j
OjM0OgouLi8uLi8uLi8uLi9pbmNsdWRlL2xhcGkvZnNtb3VudC5oOjQ4Ojg6IGVycm9yOiByZWRl
ZmluaXRpb24gb2Yg4oCYc3RydWN0IG1vdW50X2F0dHLigJkKICAgNDggfCBzdHJ1Y3QgbW91bnRf
YXR0ciB7CiAgICAgIHwgICAgICAgIF5+fn5+fn5+fn4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4u
Ly4uLy4uLy4uL2luY2x1ZGUvbGFwaS9tb3VudC5oOjExLAogICAgICAgICAgICAgICAgIGZyb20g
Li4vLi4vLi4vLi4vaW5jbHVkZS9sYXBpL2ZzbW91bnQuaDoxNSwKICAgICAgICAgICAgICAgICBm
cm9tIG1vdW50X3NldGF0dHIwMS5jOjM0OgovdXNyL2luY2x1ZGUvbGludXgvbW91bnQuaDoxMjk6
ODogbm90ZTogb3JpZ2luYWxseSBkZWZpbmVkIGhlcmUKClRoaXMgaXMgZHVlIG15IHJlY2VudCBj
aGFuZ2VzOgoKYzBjYjVkMTk2ICgibGFwaS9tb3VudC5oOiBJbmNsdWRlIGtlcm5lbC9saWJjIGhl
YWRlciIpCmh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2NvbW1pdC9j
MGNiNWQxOTYyZjcyMDY1ZGYyMmNkZGI3NzRkNTI0NmM5MDU3NjM5Cgo4YWU1OTZmOGIgKCJsYXBp
L2ZzbW91bnQuaDogSW5jbHVkZSBsYXBpL21vdW50LmggaW5zdGVhZCBsaWJjIGhlYWRlciIpCmh0
dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2NvbW1pdC84YWU1OTZmOGI1
NGQwZTg4MWQ1ZDhkODRjMTUyOGI0N2NlZDcyZTY2CgpUaGlzIHJlcXVpcmVzIHRvIHB1dCBpbnRv
IGNvbmZpZ3VyZS5hYwpBQ19DSEVDS19UWVBFUyhbc3RydWN0IG1vdW50X2F0dHJdLCwsWwojaWZk
ZWYgSEFWRV9MSU5VWF9NT1VOVF9ICiMgaW5jbHVkZSA8bGludXgvbW91bnQuaD4KI2Vsc2UKIyBp
bmNsdWRlIDxzeXMvbW91bnQuaD4KI2VuZGlmCl0pCgphbmQgaGVyZSBjaGVjayBmb3IgI2lmbmRl
ZiBIQVZFX1NUUlVDVF9NT1VOVF9BVFRSCgpNYXliZSBpdCB3YXNuJ3QgYSBnb29kIGlkZWEgdG8g
Y29tYmluZSA8bGludXgvbW91bnQuaD4gYW5kIDxzeXMvbW91bnQuaD4KKHN0cnVjdCBpcyBvbmx5
IGluIDxsaW51eC9tb3VudC5oPikuCgpJZiB3ZSBhZ3JlZSBvbiBpdCBhbmQgdGhpcyBpcyB0aGUg
b25seSBpc3N1ZSwgaXQgY2FuIGJlIGFwcGxpZWQgYmVmb3JlIG1lcmdlLgoKS2luZCByZWdhcmRz
LApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
