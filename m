Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7B1ECAAA1
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 17:09:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33F313CA972
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 19:09:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD6963CA7AF
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 19:09:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4A2B21A00816
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 19:09:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C126D1F9A3;
 Tue,  6 Sep 2022 17:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662484147;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q3JU2CHqflh//ALWAYt/4tqcyKdsuEm7wMaM5PwXh24=;
 b=jVwm54gEirs5S/BNaYA5r4fz0GuAeLQ6+ECpEEWIXNVDQ3a4ExWWqPcLZcz3Cp+M/l7Zgt
 M8PWkXDnkcjo7QDBL664YTMQo2izh+U/sGAp+8y6ohnPA7PXPfUU03jXEWg5MXNg4sk/1+
 ca2gGnvRbFzAN5SW0rIa6Ty2y8RW5aE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662484147;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q3JU2CHqflh//ALWAYt/4tqcyKdsuEm7wMaM5PwXh24=;
 b=dzfHIU1+aZmudtuNDKd84X1IDwCb4p3G2Jx2DvktH6eMtpAhqfPoEAb4YXNkP1DgA/eJDh
 ISX4gLB+yVjpQkCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C9C513A7A;
 Tue,  6 Sep 2022 17:09:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VGeCHLN+F2MsSgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 06 Sep 2022 17:09:07 +0000
Date: Tue, 6 Sep 2022 19:09:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <Yxd+sYodBJpiqyG5@pevik>
References: <20220905154239.2652169-1-amir73il@gmail.com>
 <20220905154239.2652169-5-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220905154239.2652169-5-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/9] syscalls/fanotify10: Avoid undesired event in
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90
aWZ5MTAuYwo+IEBAIC02Niw2ICs2Niw3IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgZmFub3RpZnlf
Y2xhc3NbXSA9IHsKPiAgI2RlZmluZSBHUk9VUFNfUEVSX1BSSU8gMwoKPiAgc3RhdGljIGludCBm
ZF9ub3RpZnlbTlVNX0NMQVNTRVNdW0dST1VQU19QRVJfUFJJT107Cj4gK3N0YXRpYyBpbnQgZmRf
c3luY2ZzOwoKPiAgc3RhdGljIGNoYXIgZXZlbnRfYnVmW0VWRU5UX0JVRl9MRU5dOwo+ICBzdGF0
aWMgaW50IGV4ZWNfZXZlbnRzX3Vuc3VwcG9ydGVkOwo+IEBAIC0zNDIsMTQgKzM0MywxMSBAQCBz
dGF0aWMgdm9pZCBzaG93X2Zhbm90aWZ5X21hcmtzKGludCBmZCkKPiAgCX0KPiAgfQoKPiAtc3Rh
dGljIHZvaWQgZHJvcF9jYWNoZXMoY29uc3QgY2hhciAqcGF0aCkKTm90ZSBmb3IgbXlzZWxmIHRv
IGFkZCB2b2lkIGhlcmUgYmVmb3JlIG1lcmdlCj4gK3N0YXRpYyB2b2lkIGRyb3BfY2FjaGVzKCkK
PiAgewoKZmFub3RpZnkxMC5jOiBJbiBmdW5jdGlvbiDigJhkcm9wX2NhY2hlc+KAmToKZmFub3Rp
ZnkxMC5jOjM1MjoxMzogd2FybmluZzogb2xkLXN0eWxlIGZ1bmN0aW9uIGRlZmluaXRpb24gWy1X
b2xkLXN0eWxlLWRlZmluaXRpb25dCiAgMzUyIHwgc3RhdGljIHZvaWQgZHJvcF9jYWNoZXMoKQoK
S2luZCByZWdhcmRzLApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
