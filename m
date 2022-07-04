Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F91C433EF
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 17:53:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26B683CA073
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 19:53:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CE743C649E
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 19:53:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4FB40600802
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 19:53:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 44AD22258D;
 Mon,  4 Jul 2022 17:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1656957214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uk4Q4ZaR+F5BbDy0z/yPhiAFMbo14aWzdYZk+6Gp2Ig=;
 b=knuD818HLOoUw3+rCaATAt9xjmJYecDFByd9MtF2dT/ootjk0Zxfc4RcwXv3X7DnVQ1vOi
 Xagskc0n9FUYOVvUIwLuyyQf0OxGpf2yjP5fwufbazeN0FDiVEcXGwGQh0PxYcge8/OML3
 vXJ54zxTHqFxk4bTye/cQERpD9VYLhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1656957214;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uk4Q4ZaR+F5BbDy0z/yPhiAFMbo14aWzdYZk+6Gp2Ig=;
 b=tVuzghTcN/s5xu0fwObt02r0LjXmZ26k+IYAKCNN4/J5iPL7sDPuIPIMmhODadjyJ73QX8
 Owrgvki08i7uZrCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F4A81342C;
 Mon,  4 Jul 2022 17:53:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id g8wwCh4pw2LOJwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 04 Jul 2022 17:53:34 +0000
Date: Mon, 4 Jul 2022 19:55:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: "Zhang, Cynthia X. (GSFC-710.0)[TELOPHASE CORP]" <cynthia.x.zhang@nasa.gov>
Message-ID: <YsMpmLENCE42TgnA@yuki>
References: <PH0PR09MB8537C12911766525158A7828D5BD9@PH0PR09MB8537.namprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PH0PR09MB8537C12911766525158A7828D5BD9@PH0PR09MB8537.namprd09.prod.outlook.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Inquiry: Country of Origin for LCOV	Version 1.x
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
Cc: oberpar@linux.ibm.com, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gSGVsbG8sIG15IG5hbWUgaXPigK9DeW50aGlh4oCvYW5kIEkgYW0gYSBTdXBwbHkgQ2hh
aW4gUmlzayBNYW5hZ2VtZW50Cj4gQW5hbHlzdCBhdCBOQVNBLiBOQVNBIGlzIGN1cnJlbnRseSBj
b25kdWN0aW5nIGEgc3VwcGx5IGNoYWluCj4gYXNzZXNzbWVudCBvZiBMQ09WIFZlcnNpb24gMS54
LiAgQXMgc3RhdGVkIGluIFNlY3Rpb25zIDIwOCBhbmQgNTE0IG9mCj4gdGhlIENvbnNvbGlkYXRl
ZCBBcHByb3ByaWF0aW9ucyBBY3QsIDIwMjIsIFB1YmxpYyBMYXcgMTE3LTEwMywgZW5hY3RlZAo+
IE1hcmNoIDE1LCAyMDIyLCBhIHJlcXVpcmVkIHN0ZXAgb2Ygb3VyIHByb2Nlc3MgaXMgdG8gdmVy
aWZ5IHRoZQo+IENvdW50cnkgb2YgT3JpZ2luIChDb08pIGluZm9ybWF0aW9uIGZvciB0aGUgcHJv
ZHVjdCAoaS5lLiwgdGhlIGNvdW50cnkKPiB3aGVyZSB0aGUgcHJvZHVjdHMgd2VyZSBkZXZlbG9w
ZWQsIG1hbnVmYWN0dXJlZCwgYW5kIGFzc2VtYmxlZC4pIEFzCj4gTENPViBWZXJzaW9uIDEueCBp
cyBvcGVuIHNvdXJjZSwgd2UgdW5kZXJzdGFuZCB0aGF0IHRoaXMgaW5xdWlyeSBpcwo+IG5vdCBk
aXJlY3RseSBhcHBsaWNhYmxlLCBhcyBjb250cmlidXRpb25zIG1heSBiZSBtYWRlIGZyb20gaW5k
aXZpZHVhbHMKPiBmcm9tIGFyb3VuZCB0aGUgd29ybGQuIEluIHRoaXMgY2FzZSwgTkFTQSBpcyBp
bnRlcmVzdGVkIGluIGNvbmZpcm1pbmcKPiB0aGUgZm9sbG93aW5nIGluZm9ybWF0aW9uOgo+Cj4g
ICAxLiAgSXMgdGhlcmUgYW4gb3JnYW5pemF0aW9uIHdoaWNoIHNwb25zb3JzL3B1Ymxpc2hlcyB0
aGUgcHJvamVjdCwKPiAgICAgICBvciBhIHByaW1hcnkgZGV2ZWxvcGVyIHdobyBhdWRpdHMgdGhl
IGNvZGUgZm9yIHBvdGVudGlhbAo+ICAgICAgIHZ1bG5lcmFiaWxpdGllcywgZXJyb3JzLCBvciBt
YWxpY2lvdXMgY29kZT8gWS9OCj4KPiAgIDIuICBEb2VzIExDT1YgVmVyc2lvbiAxLnggaGF2ZSBh
biBvdmVyc2VlaW5nIG9yZ2FuaXphdGlvbiBvcgo+ICAgICAgIGluZGl2aWR1YWwgYWxvbmcgdGhl
c2UgbGluZXM/IFkvTgo+Cj4gICAxLiAgSWYgc28sIHBsZWFzZSBwcm92aWRlIHRoZSBuYW1lIG9m
IHRoZSBvcmdhbml6YXRpb24gYW5kIGNvdW50cnkKPiAgIHRoZXkgYXJlIGVzdGFibGlzaGVkIGlu
LiAgSWYgdGhlIGluZm9ybWF0aW9uIGFib3ZlIGlzIHVua25vd24gb3IKPiAgIGNhbm5vdCBiZSBw
cm92aWRlZCwgd2UgcmVxdWVzdCB0aGF0IHlvdSBwcm92aWRlIHRoZSBjb3VudHJ5IG9yIGxpc3QK
PiAgIG9mIGNvdW50cmllcyB3aGVyZSB0aGUgbWFqb3JpdHkgb2YgY29udHJpYnV0aW9ucyBvcmln
aW5hdGUgZnJvbSB0bwo+ICAgc2F0aXNmeSBTZWN0aW9ucyAyMDggYW5kIDUxNCBvZiB0aGUgQ29u
c29saWRhdGVkIEFwcHJvcHJpYXRpb25zIEFjdCwKPiAgIDIwMjIsIFB1YmxpYyBMYXcgMTE3LTEw
MywgZW5hY3RlZCBNYXJjaCAxNSwgMjAyMi4KCkFzIGZhciBhcyBJIGNhbiB0ZWxsIExDT1YgaXMg
bWFpbnRhaW5lZCBieSBQZXRlciBPYmVycGFybGVpdGVyIGZyb20gSUJNCihub3cgaW4gQ0MpLgoK
LS0gCkN5cmlsIEhydWJpcwpjaHJ1YmlzQHN1c2UuY3oKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
