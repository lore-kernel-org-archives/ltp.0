Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCC0C32793
	for <ltp@archiver.kernel.org>; Wed, 18 Jan 2023 21:40:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 068693CC888
	for <ltp@archiver.kernel.org>; Wed, 18 Jan 2023 22:40:57 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CA153CB48B
 for <ltp@lists.linux.it>; Wed, 18 Jan 2023 22:40:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 947CC600C54
 for <ltp@lists.linux.it>; Wed, 18 Jan 2023 22:40:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 942665C38C;
 Wed, 18 Jan 2023 21:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674078045;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nRe6YUmSAs3dOVw/6q+yJxYkl9Ipu0HC7LzEg64tDUo=;
 b=wWpGVbwDmiZ9MjJAEMBJpAWk12EQ8g/z08QbuQvDR21qfUtO+hB46LJgCRSvsD6hav/T/K
 3vnC+tJiJBC141Yxz8RK0Z5C0yRhmfBLtRo8ABH0z2j4G2QetGzixYh+TbTGn2qbXPK8cO
 mDxYxTdDA2+aZsRAuD5qHg9RS8Xxgrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674078045;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nRe6YUmSAs3dOVw/6q+yJxYkl9Ipu0HC7LzEg64tDUo=;
 b=ISlxj7G9RIRmtUcRa6Lvi1FUzh19umapqpIl1fODrt9lH6Kv4GfYUJ/2qqzMzV2eMKRj1a
 Q5lL+e6BbSQ52gBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC23F139D2;
 Wed, 18 Jan 2023 21:40:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EOvaMFxnyGN/PQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 18 Jan 2023 21:40:44 +0000
Date: Wed, 18 Jan 2023 22:40:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y8hnWhiYH/R5ZStF@pevik>
References: <20230118133643.11371-1-chrubis@suse.cz>
 <37ee8021-c13b-c4a9-f27b-84f504800169@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <37ee8021-c13b-c4a9-f27b-84f504800169@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statvfs01: Correcly zero terminate the
 strings
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
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSwKCj4gT24gMTguIDAxLiAyMyAxNDozNiwgQ3lyaWwgSHJ1YmlzIHdyb3RlOgo+ID4gRml4
ZXMgcmFuZG9tIGZhaWx1cmVzIGNhdXNlZCBieSB0aGUgZmFjdCB0aGF0IHRoZSBzdGFjayBpcyBu
b3QKPiA+IGd1YXJhbnRlZWQgdG8gYmUgemVyb2VkLgoKPiA+IEZpeGVzOiBlMzA1YWM0YTMwNWYg
KCJzdGF0dmZzMDE6IENvbnZlcnQgdG8gbmV3IExUUCBBUEkiKQo+ID4gU2lnbmVkLW9mZi1ieTog
Q3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+Cj4gPiBDQzogUGV0ciBWb3JlbCA8cHZvcmVs
QHN1c2UuY3o+Cj4gPiBDQzogUmljaGFyZCBQYWxldGhvcnBlIDxycGFsZXRob3JwZUBzdXNlLmNv
bT4KPiA+IENDOiBBdmluZXNoIEt1bWFyIDxha3VtYXJAc3VzZS5kZT4KPiA+IC0tLQo+ID4gICB0
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N0YXR2ZnMvc3RhdHZmczAxLmMgfCAzICsrKwo+ID4g
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgo+ID4gZGlmZiAtLWdpdCBhL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvc3RhdHZmcy9zdGF0dmZzMDEuYyBiL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvc3RhdHZmcy9zdGF0dmZzMDEuYwo+ID4gaW5kZXggZGQxNGQ2YTBlLi5mMTdk
YzRjZmEgMTAwNjQ0Cj4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N0YXR2ZnMv
c3RhdHZmczAxLmMKPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3RhdHZmcy9z
dGF0dmZzMDEuYwo+ID4gQEAgLTM4LDYgKzM4LDkgQEAgc3RhdGljIHZvaWQgcnVuKHZvaWQpCj4g
PiAgIAltZW1zZXQodmFsaWRfZm5hbWUsICdhJywgdmFsaWRfbGVuKTsKPiA+ICAgCW1lbXNldCh0
b29sb25nX2ZuYW1lLCAnYicsIHZhbGlkX2xlbiArIDEpOwo+ID4gKwl2YWxpZF9mbmFtZVt2YWxp
ZF9sZW5dID0gMDsKPiA+ICsJdG9vbG9uZ19mbmFtZVt2YWxpZF9sZW4rMV0gPSAwOwoKPiBJcyB0
aGVyZSBhIHBvc3NpYmlsaXR5IHRoYXQgdmFsaWRfbGVuIGNvdWxkIGJlIGVxdWFsIHRvIFBBVEhf
TUFYLTE/IEkgdGhpbmsKClBBVEhfTUFYIGlzIDQwOTYuIHN0YXR2ZnMuZl9uYW1lbWF4IGlzIG1v
c3RseSAyNTUgKG9ubHkgZm9yIHZmYXQgYW5kIGV4ZmF0IGlzCjE1MzAsIGJ1dCB0aGF0J3MgZm9y
IG11bHRpYnl0ZSBuYW1lcywgdGhlICJyZWFsIiBsZW5ndGgsIHdoZW4gY291bnRpbmcKY2hhcmFj
dGVycyBpcyBhbHNvIDI1NSkuCgo+IHRvb2xvbmdfZm5hbWVbXSBzaXplIHNob3VsZCBiZSBidW1w
ZWQgdG8gYXQgbGVhc3QgUEFUSF9NQVgrMS4Kc3RhdHZmczAxLmM6NDM6MjI6IHdhcm5pbmc6IGFy
cmF5IHN1YnNjcmlwdCA0MDk3IGlzIGFib3ZlIGFycmF5IGJvdW5kcyBvZiDigJhjaGFyWzQwOTZd
4oCZIFstV2FycmF5LWJvdW5kc10KPT4gUEFUSF9NQVgtMSBpcyB0aGUgbWF4aW11bSAoYXJyYXkg
c2l6ZSBpcyBQQVRIX01BWCkuCgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
