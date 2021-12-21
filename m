Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C09C433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 08:42:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C8EA3C921E
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 09:42:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4FAFF3C9168
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 09:42:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8D963200E1C
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 09:42:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C0FC61F388;
 Tue, 21 Dec 2021 08:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640076159;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VWTXnKk7V9u00g1tv2NwYV8crtCbuNhH/FuAKk2tLoY=;
 b=oGarhh7SFw3b3BG7KpIWgmU4OcBvhYV5dPkaHMSusZARTduUugMynde2Jeeqe55te7TJUc
 6/Y/w03W1yEqrpGJVqCPDqkUlEzPdWvQFdAaERPNWq2V1w2lIoimZHwAA98SDmXCS51mxp
 gMpCJG7RicSDo+KipaSDB5nvl+eYbsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640076159;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VWTXnKk7V9u00g1tv2NwYV8crtCbuNhH/FuAKk2tLoY=;
 b=IKwzVnC03JI02cD8RPru+FhtzRoHv2JMRC+I+F70gGIL55OjNMkhL0KA2//ftpM2KUlubK
 3/auk4tg5gGz+9DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91EE013BEC;
 Tue, 21 Dec 2021 08:42:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PPPqIH+TwWETLgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 21 Dec 2021 08:42:39 +0000
Date: Tue, 21 Dec 2021 09:42:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: sujiaxun <sujiaxun@uniontech.com>
Message-ID: <YcGTfdiyejLZUnzG@pevik>
References: <20211217062637.29720-1-sujiaxun@uniontech.com>
 <YbxUx8mz7ejCjp7W@pevik> <YcDffj8+zqY3SNCz@pevik>
 <0bb516ab-5e9f-71f2-3e55-5e46c41aaee2@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0bb516ab-5e9f-71f2-3e55-5e46c41aaee2@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [v2,
 1/2] syscalls/sched_get_priority_max01: Convert to new
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

PiDlnKggMjAyMS8xMi8yMSDkuIrljYgzOjU0LCBQZXRyIFZvcmVsIOWGmemBkzoKPiA+IEhpIHN1
amlheHVuLAoKPiA+IG1lcmdlZC4gVGhhbmtzIQoKPiA+IEtpbmQgcmVnYXJkcywKPiA+IFBldHIK
Cj4gSSdtIHNvcnJ5LCBidXQgSSBoYXZlIGJlZW4gZGVhbGluZyB3aXRoIG90aGVyIHRoaW5ncyBz
b21lIHRpbWUgYWdvIGFuZCBoYXZlCj4gbm90IGJlZW4gYWJsZSB0byByZXBseSBpbiB0aW1lLiBU
aGFuayB5b3UgZm9yIGhlbHBpbmcgbW9kaWZ5IGFuZCBtZXJnZS4KCllvdSdyZSB3ZWxjb21lLiBU
aGFua3MgZm9yIHdvcmtpbmcgb24gTFRQLgoKS2luZCByZWdhcmRzLApQZXRyCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
