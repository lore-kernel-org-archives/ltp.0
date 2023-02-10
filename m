Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0425C636CD
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 12:12:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3D6F3CC07E
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 13:12:27 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FAA83C304A
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 13:12:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B942E1000DC7
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 13:12:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7E76C5D6B9;
 Fri, 10 Feb 2023 12:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676031136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=27GgD1CyxS6xVT39146vmFaq8o1gCFAiKoEfuE1UuoM=;
 b=Fy+XZYLfq2IluEu7mYdTWXqeaoj/qVIEQaW7utsFXVhvnq2qH17N72TE7ogm6q3cCT/SQO
 cNJMeU6vhNBO02h0ktdLNlSeg4ATIO4gu1ZHLH6lpSm8q6QzkyMFU7JPls66QERWh8X449
 z+iW5VmqrovRXJVpw5ZFC0WFMLR039s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676031136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=27GgD1CyxS6xVT39146vmFaq8o1gCFAiKoEfuE1UuoM=;
 b=e4vLyWvD/QYTVSrnoXV1ALlY5XatMvDyZBkFAcKgB5uOVWSyeqr1oVQlMkSnr0qpTd4JuZ
 b+y6EnQ2wRYu3FAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66C0C13206;
 Fri, 10 Feb 2023 12:12:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3EudFqA05mPxAgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 10 Feb 2023 12:12:16 +0000
Date: Fri, 10 Feb 2023 13:13:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: xiao shoukui <xiaoshoukui@gmail.com>
Message-ID: <Y+Y0+ajVAD3JaBQv@yuki>
References: <20230210084408.8360-1-xiaoshoukui@gmail.com>
 <Y+YglzySGK8ts8y3@rei>
 <CAOHshYVJDij+fqanWw+XMod-LWa0tqvJDZWXPqhSZxcBSHH8mA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOHshYVJDij+fqanWw+XMod-LWa0tqvJDZWXPqhSZxcBSHH8mA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1 1/1] Add ioctl_loop08 test for LOOP_GET_STATUS
 lock imbalance
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gU2luY2VyZSB0aGFua3MgZm9yIHlvdXIgYWR2aWNlLgo+IEJhc2VkIG9uIG15IHRlc3Rz
77yMdGhlIGxvY2tkZXAgd2lsbCBibG9jayB0aGUgaW9jdGwgcmVxdWVzdCB0aHJlYWQgcmV0dXJu
IHRvCj4gdXNlcnNwYWNlIHdoZW4gaXQgZGV0ZWN0IGEgbG9jayBpbWJhbGFuY2UuIFBsYWNlIGlv
Y3RsIHJlcXVlc3QgaW4gdGhlIG1haW4KPiB0aHJlYWQsIHRoZXJlIGlzIG5vIGNoYW5jZSB0byBl
eGVjdXRlIGZpbmRfa21zZyBmb3IgZGV0ZXJtaW5pbmcgd2hhdAo+IGV4YWN0bHkgYSBsb2NrIHBy
b2JsZW0gaGFwcGFuZWQgYW5kIHByaW50aW5nIHRoZSB0ZXN0IHJlc3VsdC4KCkhtbSwgdGhlbiBt
YXliZSBpdCB3b3VsZCBiZSBlYXNpZXIgYW5kIG1vcmUgcmVsaWFibGUgdG8gcnVuIHRoZSBpb2N0
bCgpCmluIGEgY2hpbGQgcHJvY2Vzc2VzIGFuZCBmYWlsIHRoZSB0ZXN0IHdoZW4gdGhlIHBhcmVu
dCBkZXRlY3RzIHRoZQpjaGlsZCB0byBsb2NrdXAuCgpJIHN1cHBvc2UgdGhhdCB0aGUgcHJvY2Vz
cyB0aGF0IGNhbGxlZCB0aGUgaW9jdGwoKSBlbmRzIHVwIGluIHRoZSBECnN0YXRlLCByaWdodD8g
SW4gdGhhdCBjYXNlIHRoZSBwYXJlbnQgcmVhZCB0aGUgL3Byb2MvcGlkL3N0YXQgYSBmZXcKdGlt
ZXMgd2l0aCBzbGlnaHQgZGVsYXlzIGJldHdlZW4gdGhlbSBhbmQgaWYgdGhlIHByb2Nlc3Mga2Vl
cHMgaGFuZ2luZwppbiBEIHN0YXRlIHdlIGRlY2xhcmUgaXQgYmxvY2tlZCBmb3JldmVyLgoKLS0g
CkN5cmlsIEhydWJpcwpjaHJ1YmlzQHN1c2UuY3oKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
