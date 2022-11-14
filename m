Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D07C433FE
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 15:26:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B47E03CD230
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 16:26:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E8CB3CD220
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 16:26:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 63339200972
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 16:26:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ACE36200E6;
 Mon, 14 Nov 2022 15:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668439605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IWzJ4jOz4krz1bZp5ywMI3mm7EpKIn+q93zw1libIp8=;
 b=lWSwWwb+qftKkZFwURzpKusimukExXzqtDQRCXPNYqFL58Og7QvWGWFMPgWRopxcGjXCZD
 yszSHjFaRQEIj8e6nAwARF9egdSBz26oTDNGJim5yLjU1LYLCpBJUBzGuONSPUzuVZO6MR
 bfxxQcYV9EA712m7KUS5FyZPK1vBnLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668439605;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IWzJ4jOz4krz1bZp5ywMI3mm7EpKIn+q93zw1libIp8=;
 b=bdwf1CMNmQfWapH0FQAv2SDpmpAorzQLPSYnpINti72ylX1kSrTQWUYt0wADYDCnzinBRE
 ssazApG+woy7L/Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9974413A8C;
 Mon, 14 Nov 2022 15:26:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UHU7JTVecmN2EQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 14 Nov 2022 15:26:45 +0000
Date: Mon, 14 Nov 2022 16:28:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y3JeiXgTqAJbzBtB@yuki>
References: <20221114093233.4668-1-mdoucha@suse.cz> <Y3JBzeBst/HufYqu@yuki>
 <7d899a16-7b4b-3ee9-8cba-949274610077@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7d899a16-7b4b-3ee9-8cba-949274610077@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] save_restore: Introduce new struct field for
 flags
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

SGkhCj4gPiBXb3VsZCB5b3UgY29uc2lkZXIgYWRkaW5nIFRTVF9TUl9UQ09ORl9NSVNTSU5HIGFu
ZCBUU1RfU1JfVENPTkZfUk8/Cj4gCj4gSSBjb3VsZCBzZXQgYm90aCB0byAwLCBpZiB0aGF0J3Mg
T0suCgpJIHN1cHBvc2UgdGhhdCB3b3VsZCB3b3JrIGZpbmUuCgo+ID4+ICsqICdUU1RfU1JfRkFJ
TF9NSVNTSU5HJyDigJMgRW5kIHRlc3Qgd2l0aCAnVEJST0snIGlmIHRoZSBmaWxlIGRvZXMgbm90
IGV4aXN0Cj4gPiAKPiA+IFRoaXMgRkFJTCBwYXJ0IGluIHRoaXMgbmFtZSBpcyBxdWl0ZSBtaXNs
ZWFkaW5nIHNpbmNlIHRoZSB0ZXN0IGVuZHMgd2l0aAo+ID4gVEJST0suIEkgd291bGQgc2F5IHRo
YXQgaXQgd291bGQgYmUgbXVjaCBtb3JlIGNsZWFyIGlmIGl0IHdhcyBuYW1lZAo+ID4gVFNUX1NS
X1RCUk9LX01JU1NJTkcuCj4gCj4gVGhlbiBJIHNob3VsZCBhbHNvIHJlbmFtZSBUU1RfU1JfUkVR
VUlSRUQgdG8gVFNUX1NSX1RCUk9LLCByZW5hbWUgCj4gVFNUX1NSX0NPTkRfQUNDRVNTIHRvIFRT
VF9TUl9TS0lQIGFuZCBhZGQgVFNUX1NSX1RDT05GIGZvciB0aGUgdHdvIG5ldyAKPiBmbGFncy4K
ClRoYXQgc291bmRzIGdvb2QgdG8gbWUsIGl0J3MgbXVjaCBjbG9zZWx5IG1hcHBlZCB0byB0aGUg
YWN0dWFsIHRlc3QKcmVzdWx0IHR5cGVzIGFuZCBzaG91bGQgYmUgY2xlYXIgZW5vdWdoLgoKLS0g
CkN5cmlsIEhydWJpcwpjaHJ1YmlzQHN1c2UuY3oKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
