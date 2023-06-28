Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD5AEB64DA
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 10:11:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 081A53C9991
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 12:11:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 351333C9991
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 12:11:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7D502200042
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 12:11:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5DBD02187F;
 Wed, 28 Jun 2023 10:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687947093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nJNJSNTTNh2JCFGe0rsIE8YNFrRfLqpVv3jDwxu/kQ=;
 b=1M/VOkpAPbO9GRW6aHPKoN3cQlCAucE1vQ7N7CBT+vzkvelbXTliGhw0pGtTk5XgTVFtzE
 DR92gC/+BzEehG2JF804j5Zcsa51j/LkoeeZPc0cKbixg2PfHYBSxUA8cCamEaB1kZugGL
 AR/25cIrPsciid74+7d94XYaz298Suo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687947093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nJNJSNTTNh2JCFGe0rsIE8YNFrRfLqpVv3jDwxu/kQ=;
 b=34b3usdD4lsSdoP5NYlxBteRGnPdiN8z8oI8KSKtFpNgapNeNrcHSEicyd96tDtCLAVQwT
 mStHpGJjHh522VCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E1CD138EF;
 Wed, 28 Jun 2023 10:11:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id d3IME1UHnGTlEQAAMHmgww
 (envelope-from <jack@suse.cz>); Wed, 28 Jun 2023 10:11:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id C47F6A0707; Wed, 28 Jun 2023 12:11:32 +0200 (CEST)
Date: Wed, 28 Jun 2023 12:11:32 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20230628101132.kvchg544mczxv2pm@quack3>
References: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
 <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
 <e770188fd86595c6f39d4da86d906a824f8abca3.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
 <CAOQ4uxjQcn9DUo_Z2LGTgG0SOViy8h5=ST_A5v1v=gdFLwj6Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjQcn9DUo_Z2LGTgG0SOViy8h5=ST_A5v1v=gdFLwj6Hw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] splice: always fsnotify_access(in),
 fsnotify_modify(out) on success
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 linux-fsdevel@vger.kernel.org, Chung-Chiang Cheng <cccheng@synology.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkIDI4LTA2LTIzIDA5OjMzOjQzLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToKPiBPbiBUdWUs
IEp1biAyNywgMjAyMyBhdCAxMTo1MOKAr1BNIEFoZWxlbmlhIFppZW1pYcWEc2thCj4gPG5hYmlq
YWN6bGV3ZWxpQG5hYmlqYWN6bGV3ZWxpLnh5ej4gd3JvdGU6Cj4gPgo+ID4gVGhlIGN1cnJlbnQg
YmVoYXZpb3VyIGNhdXNlZCBhbiBhc3ltbWV0cnkgd2hlcmUgc29tZSB3cml0ZSBBUElzCj4gPiAo
d3JpdGUsIHNlbmRmaWxlKSB3b3VsZCBub3RpZnkgdGhlIHdyaXR0ZW4tdG8vcmVhZC1mcm9tIG9i
amVjdHMsCj4gPiBidXQgc3BsaWNlIHdvdWxkbid0Lgo+ID4KPiA+IFRoaXMgYWZmZWN0ZWQgdXNl
cnNwYWNlIHdoaWNoIHVzZXMgaW5vdGlmeSwgbW9zdCBub3RhYmx5IGNvcmV1dGlscwo+ID4gdGFp
bCAtZiwgdG8gbW9uaXRvciBwaXBlcy4KPiA+IElmIHRoZSBwaXBlIGJ1ZmZlciBoYWQgYmVlbiBm
aWxsZWQgYnkgYSBzcGxpY2UtZmFtaWx5IGZ1bmN0aW9uOgo+ID4gICAqIHRhaWwgd291bGRuJ3Qg
a25vdyBhbmQgdGh1cyB3b3VsZG4ndCBzZXJ2aWNlIHRoZSBwaXBlLCBhbmQKPiA+ICAgKiBhbGwg
d3JpdGVzIHRvIHRoZSBwaXBlIHdvdWxkIGJsb2NrIGJlY2F1c2UgaXQncyBmdWxsLAo+ID4gdGh1
cyBzZXJ2aWNlIHdhcyBkZW5pZWQuCj4gPiAoRm9yIHRoZSBwYXJ0aWN1bGFyIGNhc2Ugb2YgdGFp
bCAtZiB0aGlzIGNvdWxkIGJlIHdvcmtlZCBhcm91bmQKPiA+ICB3aXRoIC0tLWRpc2FibGUtaW5v
dGlmeS4pCj4gPgo+IAo+IElzIG15IHVuZGVyc3RhbmRpbmcgb2YgdGhlIHRhaWwgY29kZSB3cm9u
Zz8KPiBNeSB1bmRlcnN0YW5kaW5nIHdhcyB0aGF0IHRhaWxfZm9yZXZlcl9pbm90aWZ5KCkgaXMg
bm90IGNhbGxlZCBmb3IKPiBwaXBlcywgb3IgaXMgaXQgYmVpbmcgY2FsbGVkIHdoZW4gdGFpbGlu
ZyBhIG1peGVkIGNvbGxlY3Rpb24gb2YgcGlwZXMKPiBhbmQgcmVndWxhciBmaWxlcz8gSWYgdGhl
cmUgYXJlIHN1YnRsZXRpZXMgbGlrZSB0aG9zZSB5b3UgbmVlZCB0bwo+IG1lbnRpb24gdGhlbSAs
IG90aGVyd2lzZSBwZW9wbGUgd2lsbCBub3QgYmUgYWJsZSB0byByZXByb2R1Y2UgdGhlCj4gcHJv
YmxlbSB0aGF0IHlvdSBhcmUgZGVzY3JpYmluZy4KCldlbGwsIG9uIG15IG9wZW5TVVNFIDE1LjQg
YXQgbGVhc3QsIHRhaWwgLWYgZG9lcyB1c2UgaW5vdGlmeSBvbiBGSUZPcyBhbmQKaW5kZWVkIHdo
ZW4gZGF0YSBpcyBzcGxpY2VkIHRvIHRoZSBGSUZPLCB0YWlsIGRvZXNuJ3Qgbm90aWNlLgoKPiBJ
IG5lZWQgdG8gd2FybiB5b3UgYWJvdXQgc29tZXRoaW5nIHJlZ2FyZGluZyB0aGlzIHBhdGNoIC0K
PiBvZnRlbiB0aGVyZSBhcmUgY29sbGlkaW5nIGludGVyZXN0cyBhbW9uZyBkaWZmZXJlbnQga2Vy
bmVsIHVzZXJzIC0KPiBmc25vdGlmeSB1c2UgY2FzZXMgcXVpdGUgb2Z0ZW4gY29sbGlkZSB3aXRo
IHRoZSBpbnRlcmVzdCBvZiB1c2VycyB0cmFja2luZwo+IHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb25z
IGFuZCBJTl9BQ0NFU1MvSU5fTU9ESUZZIG9uIGFub255bW91cyBwaXBlcwo+IHNwZWNpZmljYWxs
eSBoYXZlIGJlZW4gdGhlIHNvdXJjZSBvZiBzZXZlcmFsIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24g
cmVwb3J0cwo+IGluIHRoZSBwYXN0IGFuZCBoYXZlIGRyaXZlbiBvcHRpbWl6YXRpb25zIGxpa2U6
Cj4gCj4gNzFkNzM0MTAzZWRmICgiZnNub3RpZnk6IFJlYXJyYW5nZSBmYXN0IHBhdGggdG8gbWlu
aW1pc2Ugb3ZlcmhlYWQKPiB3aGVuIHRoZXJlIGlzIG5vIHdhdGNoZXIiKQo+IGU0M2RlN2YwODYy
YiAoImZzbm90aWZ5OiBvcHRpbWl6ZSB0aGUgY2FzZSBvZiBubyBtYXJrcyBvZiBhbnkgdHlwZSIp
Cj4gCj4gVGhlIG1vcmFsIG9mIHRoaXMgc3RvcnkgaXM6IGV2ZW4gaWYgeW91ciBwYXRjaGVzIGFy
ZSBhY2NlcHRlZCBieSBmc25vdGlmeQo+IHJldmlld2Vycywgb25jZSB0aGV5IGFyZSBzdGFnZWQg
Zm9yIG1lcmdpbmcgdGhleSB3aWxsIGJlIHN1YmplY3QgdG8KPiBwZXJmb3JtYW5jZSByZWdyZXNz
aW9uIHRlc3RzIGFuZCBJIGNhbiB0ZWxsIHlvdSB3aXRoIGNlcnRhaW50eSB0aGF0Cj4gcGVyZm9y
bWFuY2UgcmVncmVzc2lvbiB3aWxsIG5vdCBiZSB0b2xlcmF0ZWQgZm9yIHRoZSB0YWlsIC1mIHVz
ZSBjYXNlLgo+IEkgd2lsbCBwdXNoIHlvdXIgdjQgcGF0Y2hlcyB0byBhIGJyYW5jaCBpbiBteSBn
aXRodWIsIHRvIGxldCB0aGUga2VybmVsCj4gdGVzdCBib3RzIHJ1biB0aGUgcGVyZm9ybWFuY2Ug
cmVncmVzc2lvbnMgb24gaXQgd2hlbmV2ZXIgdGhleSBnZXQgdG8gaXQuCj4gCj4gTW9yZW92ZXIs
IGlmIGNvcmV1dGlscyB3aWxsIGNoYW5nZSB0YWlsIC1mIHRvIHN0YXJ0IHNldHRpbmcgaW5vdGlm
eSB3YXRjaGVzCj4gb24gYW5vbnltb3VzIHBpcGVzIChteSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQg
Y3VycmVudGx5IGRvZXMgbm90PyksCj4gdGhlbiBhbnkgdGFpbCAtZiBvbiBhbm9ueW1vdXMgcGlw
ZSBjYW4gY3JpcHBsZSB0aGUgIm5vIG1hcmtzIG9uIHNiIgo+IHBlcmZvcm1hbmNlIG9wdGltaXph
dGlvbiBmb3IgYWxsIGFub255bW91cyBwaXBlcyBhbmQgdGhhdCB3b3VsZCBiZQo+IGEgKnZlcnkq
IHVuZm9ydHVuYXRlIG91dGNvbWUuCgpEbyB5b3UgbWVhbiB0aGUgInNfZnNub3RpZnlfY29ubmVj
dG9ycyIgY2hlY2s/IFllYWgsIGEgZnNub3RpZnkgd2F0Y2ggb24KYW55IHBpcGUgaW5vZGUgaXMg
Z29pbmcgdG8gc29tZXdoYXQgc2xvdyBkb3duIHRoZSBmc25vdGlmeSBjYWxscyBmb3IgYW55CnBp
cGUuIE9UT0ggSSBkb24ndCBleHBlY3QgaW5vdGlmeSB3YXRjaGVzIG9uIHBpcGUgaW5vZGVzIHRv
IGJlIGNvbW1vbiBhbmQKaXQgaXMgbm90IGxpa2UgdGhlIG92ZXJoZWFkIGlzIGh1Z2UuIEFsc28g
bm9ib2R5IHJlYWxseSBwcmV2ZW50cyB5b3UgZnJvbQpwbGFjaW5nIHdhdGNoIG9uIHBpcGUgaW5v
ZGUgbm93IHdpdGggc2ltaWxhciBjb25zZXF1ZW5jZXMsIHRoaXMgcGF0Y2ggb25seQptYWtlcyBp
dCBhY3R1YWxseSB3b3JraW5nIHdpdGggc3BsaWNlLiBTbyBJJ20gbm90IHdvcnJpZWQgYWJvdXQg
dGhlCnBlcmZvcm1hbmNlIGltcGFjdC4gQXQgbGVhc3QgdW50aWwgc29tZWJvZHkgY29tZXMgd2l0
aCBhIHJlYWxpc3RpYwpjb21wbGFpbnQgOy0pLgoKPiBJIHRoaW5rIHdlIG5lZWQgdG8gYWRkIGEg
cnVsZSB0byBmYW5vdGlmeV9ldmVudHNfc3VwcG9ydGVkKCkgdG8gYmFuCj4gc2IvbW91bnQgbWFy
a3Mgb24gU0JfS0VSTk1PVU5UIGFuZCBiYWNrcG9ydCB0aGlzCj4gZml4IHRvIExUUyBrZXJuZWxz
IChJIHdpbGwgbG9vayBpbnRvIGl0KSBhbmQgdGhlbiB3ZSBjYW4gZmluZSB0dW5lCj4gdGhlIHNf
ZnNub3RpZnlfY29ubmVjdG9ycyBvcHRpbWl6YXRpb24gaW4gZnNub3RpZnlfcGFyZW50KCkgZm9y
Cj4gdGhlIFNCX0tFUk5NT1VOVCBzcGVjaWFsIGNhc2UuCgpZZWFoLCBwcm9iYWJseSBtYWtlcyBz
ZW5zZS4KCgkJCQkJCQkJSG9uemEKLS0gCkphbiBLYXJhIDxqYWNrQHN1c2UuY29tPgpTVVNFIExh
YnMsIENSCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
