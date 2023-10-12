Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97A5CDB482
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 09:19:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3349C3CD433
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 11:19:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD7BE3C8903
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 11:19:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 50EB01000376
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 11:19:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9F7441F74C;
 Thu, 12 Oct 2023 09:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697102341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OY7dRLvz8/heZkhu7l84J77vvKalTvxk5IvslXbtw4Y=;
 b=nF64GWtAz4AqMpKlljoHdyvxcrdpHMU9BFr76EE1VXB1XIPJXzs7hQzRu4jLjD28zZLhNy
 5vMvvHUh0DTRZDhJzdTWRNwlZRaUlrvj4QZD3mcEW2/KC7fOAnEJCjLw1Mel5d696Wthhi
 VzY0L+6ObF/ekuqwyrgDEPphYw6vi08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697102341;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OY7dRLvz8/heZkhu7l84J77vvKalTvxk5IvslXbtw4Y=;
 b=hQgoeHYci0WduSFKWaowsKhfOPf4oC2FF0A0UxSLrzPhDByD56IzZINb8q5koAd3RJ4g9o
 8Q8aGXf9Y2Q37eAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78321139ED;
 Thu, 12 Oct 2023 09:19:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XALGGQW6J2WLaAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 12 Oct 2023 09:19:01 +0000
Date: Thu, 12 Oct 2023 11:19:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Marius Kittler <mkittler@suse.de>
Message-ID: <ZSe6MNMQ6L5yJdV4@yuki>
References: <20231005134504.3828-1-mkittler@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231005134504.3828-1-mkittler@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Fix memcontrol tests under Tumbleweed
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

SGkhCj4gVGhlc2UgdGVzdHMgdXNlIGBhbGxfZmlsZXN5c3RlbXNgIGluIGNvbWJpbmF0aW9uIHdp
dGgKPiBgZGV2X21pbl9zaXplYCB3aGljaCBkb2VzIG5vdCB3b3JrIG9uIFR1bWJsZXdlZWQgYXMg
aXQgcmVzdWx0cwo+IGluOgo+IAo+IGBgYAo+IHRzdF90ZXN0LmM6MTY0NDogVElORk86ID09PSBU
ZXN0aW5nIG9uIHhmcyA9PT0KPiB0c3RfdGVzdC5jOjEwOTk6IFRJTkZPOiBGb3JtYXR0aW5nIC9k
ZXYvbG9vcDAgd2l0aCB4ZnMgb3B0cz0nJyBleHRyYSBvcHRzPScnCj4gRmlsZXN5c3RlbSBtdXN0
IGJlIGxhcmdlciB0aGFuIDMwME1CLgo+IOKApgo+IHRzdF90ZXN0LmM6MTEwNTogVEJST0s6IG1r
ZnMueGZzIGZhaWxlZCB3aXRoIGV4aXQgY29kZSAxCj4gYGBgCj4gCj4gVGhpcyBpcyBsaWtlbHkg
YSBsaW1pdGF0aW9uIGludHJvZHVjZWQgaW4gbmV3ZXIga2VybmVsIHZlcnNpb25zLgo+Cj4gSW5j
cmVhc2luZyBgZGV2X21pbl9zaXplYCB0byAzMDAgZml4ZXMgdGhlIHRlc3RzLiBJbgo+IGBtZW1j
b250cm9sMDNgIGFuZCBgbWVtY29udHJvbDA0YCB0aGUgYGRldl9taW5fc2l6ZWAgc2V0dGluZwo+
IGNhbiBiZSBkcm9wcGVkIGNvbXBsZXRlbHkuCgpTaG91bGRuJ3Qgd2UganVzdCByZW1vdmUgYWxs
IG9mIGRldl9taW5fc2l6ZSByZWNvcmRzPwoKV2UgYWxyZWFkeSBoYXZlIERFVl9TSVpFX01CIHNl
dCB0byAzMDAgaW4gbGliL3RzdF9kZXZpY2UuYyBzbyB3aXRoIG5vCmxpbWl0cyB3ZSB3aWxsIHVz
ZSB0aGUgZGVmYXVsdCAzMDBNYi4KCi0tIApDeXJpbCBIcnViaXMKY2hydWJpc0BzdXNlLmN6Cgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
