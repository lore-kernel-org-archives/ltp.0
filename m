Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D884C433F5
	for <ltp@archiver.kernel.org>; Tue, 15 Feb 2022 09:27:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60E393CA00E
	for <ltp@archiver.kernel.org>; Tue, 15 Feb 2022 10:27:36 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25C523C816F
 for <ltp@lists.linux.it>; Tue, 15 Feb 2022 10:27:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 59226200DAA
 for <ltp@lists.linux.it>; Tue, 15 Feb 2022 10:27:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6927C210DC;
 Tue, 15 Feb 2022 09:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644917245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7hM2kSUa7Hx0yOHo/i9mfg+fg0oo8cPv4qAfxdVMBhA=;
 b=DKXsmHBW99alz9XR0fxmXotuxe4wjU/ZEdXXFSJNNPFjrNmg3asGqChy8NGbSdJ2CkA06J
 O7nEyi9HRPHG7RY9owbIlTCZpcFAcRZjf5ONC6rEGrdl+3BPeIAbYNTDbJ0vaSO34H+oZq
 Cde36zLE2FzkkSlyuYs2KTI6pPeKa+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644917245;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7hM2kSUa7Hx0yOHo/i9mfg+fg0oo8cPv4qAfxdVMBhA=;
 b=wqCIj30GDnXNRadB91QCEtS7YisFkZCW2r/h1ut8KyG/bD/dkjLoul2arkkrivJd2YMx5+
 3dXIm85ReO2AAIAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4784713C36;
 Tue, 15 Feb 2022 09:27:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YGxnEP1xC2KCfQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 15 Feb 2022 09:27:25 +0000
Message-ID: <ec14e0ce-21fe-43bf-a8fb-15b2ccd97c8a@suse.cz>
Date: Tue, 15 Feb 2022 10:27:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To: Li Wang <liwang@redhat.com>
References: <20220214165129.32686-1-mdoucha@suse.cz>
 <CAEemH2c=+3_HBez0Pn6Yyx+v4PXJpwD3HZtPt87BR6AohtKvUw@mail.gmail.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <CAEemH2c=+3_HBez0Pn6Yyx+v4PXJpwD3HZtPt87BR6AohtKvUw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] test_children_cleanup.sh: Fix race condition
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMTUuIDAyLiAyMiA1OjMwLCBMaSBXYW5nIHdyb3RlOgo+IEl0IGRvZXNuJ3Qgd29yayBmb3Ig
YWxsIHBsYXRmb3JtcyBhbmQgd2UgY2FuIG5vdCBndWFyYW50ZWUgaG93IGxvbmcgaXQgd2lsbAo+
IGNvc3QgYmVmb3JlIFBJRCAxIHJlYXBzIHpvbWJpZSBwcm9jZXNzLgo+IAo+IEFsc28sIEkganVz
dCBnZXQgdG8ga25vdyB0aGF0IMKgRG9ja2VyIGRvZXMgbm90IHJ1biBwcm9jZXNzZXMgdW5kZXIg
YQo+IHNwZWNpYWwgaW5pdCBwcm9jZXNzIHRoYXQgcHJvcGVybHkgcmVhcHMgY2hpbGQgcHJvY2Vz
c2VzLCBzbyB0aGF0IGl0IGlzCj4gcG9zc2libGUgZm9yIHRoZSBjb250YWluZXIgdG8gZW5kIHVw
IHdpdGggem9tYmllIHByb2Nlc3NlcyB0aGF0IGNhdXNlCj4gYWxsIHNvcnRzIG9mIHRyb3VibGUu
Cj4gCj4gSSBldmVuIHRyeSBhZGRpbmcgYGtpbGwgLVNJR0NITEQgMWAgYnV0IGRvZXMgbm90IHdv
cmsgYXMgZXhwZWN0ZWQuCj4gCj4gU2VlIENJIGpvYnM6Cj4gwqDCoGh0dHBzOi8vZ2l0aHViLmNv
bS93YW5nbGk1NjY1L2x0cC9ydW5zLzUxOTQyNzA5OTg/Y2hlY2tfc3VpdGVfZm9jdXM9dHJ1ZQo+
IDxodHRwczovL21haWwuZ29vZ2xlLmNvbS9tYWlsL3UvMS8lRTIlODAlOEJodHRwczovL2dpdGh1
Yi5jb20vd2FuZ2xpNTY2NS9sdHAvcnVucy81MTk0MjcwOTk4P2NoZWNrX3N1aXRlX2ZvY3VzPXRy
dWU+Cj4gCj4gVGhlcmVmb3JlLCBJIHN1Z2dlc3QgZ2l2aW5nIGEgY2hhbmNlIHRvIG15IHJlZmlu
ZWQgcGF0Y2ggVjIgOikuCgpXaGVuIEkgd2FzIHRlc3RpbmcgdGhlIGxpYnRlc3QgeWVzdGVyZGF5
IG9uIGEgbW9kZXJhdGVseSBzdHJlc3NlZAptYWNoaW5lLCBJIGFjdHVhbGx5IHNhdyB0aGUgY2hp
bGQgcHJvY2VzcyBzdGlsbCBpbiB0aGUgUiBzdGF0ZSBkdXJpbmcKdGhlIGZpcnN0IHN0YXRlIGNo
ZWNrIGEgY291cGxlIG9mIHRpbWVzLiBUaGF0J3Mgd2h5IEkndmUgYWRkZWQgbG9vcGluZwp3aXRo
IGRlbGF5LgoKT24gdGhlIG90aGVyIGhhbmQgSSBkaWQgbm90IHNlZSBhbnkgem9tYmllcyBldmVu
IGFmdGVyIHNldmVyYWwgaHVuZHJlZAp0cmllcy4gQnV0IEkgY2FuIGFkZCBhIHpvbWJpZSBjaGVj
ayB0byBteSBwYXRjaCBhIHdlbGwuCgotLSAKTWFydGluIERvdWNoYSAgIG1kb3VjaGFAc3VzZS5j
egpRQSBFbmdpbmVlciBmb3IgU29mdHdhcmUgTWFpbnRlbmFuY2UKU1VTRSBMSU5VWCwgcy5yLm8u
CkNPUlNPIElJYQpLcml6aWtvdmEgMTQ4LzM0CjE4NiAwMCBQcmFndWUgOApDemVjaCBSZXB1Ymxp
YwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
