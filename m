Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6C9E81DFB
	for <ltp@archiver.kernel.org>; Fri,  6 Oct 2023 13:31:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 525B93C9480
	for <ltp@archiver.kernel.org>; Fri,  6 Oct 2023 15:31:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5962E3C8B9E
 for <ltp@lists.linux.it>; Fri,  6 Oct 2023 08:41:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1CE9061761B
 for <ltp@lists.linux.it>; Fri,  6 Oct 2023 08:41:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B62D51F45F;
 Fri,  6 Oct 2023 06:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1696574503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AHPegFj7wYRBnWo4iJfVnNBssSPMttVzktBNWxsaxJY=;
 b=RPqzfKv4gZGmUZdxYmP2RazsngprG/807/v2Of1+KBo5sUqo9JSFupq8mGvNz6LrSpyLHC
 qoqJVH8IWZF4iVQ7uGKPcp2MOF2HAqeK2AYYUXY0Nn57WS3JfpE/hSCm86/po3CzryejT2
 7T2n4g1+hMUPCYmGifNU1lOhdwZT6OE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1696574503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AHPegFj7wYRBnWo4iJfVnNBssSPMttVzktBNWxsaxJY=;
 b=t5N6hNk50AuI+4qPPg4glFprLLTrJyOMPg25eEz33RGUSTueo0on1yxzZmg9dTdscRqq9O
 AZRSUM7ZJwsJjfDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4608913A2E;
 Fri,  6 Oct 2023 06:41:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2t+vCCasH2UZWgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 06 Oct 2023 06:41:42 +0000
Date: Fri, 6 Oct 2023 08:41:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <20231006064140.GA178316@pevik>
References: <20231004175217.404851126@linuxfoundation.org>
 <CA+G9fYsqbZhSQnEi-qSc7n+4d7nPap8HWcdbZGWLfo3mTH-L7A@mail.gmail.com>
 <20231005172448.GA161140@pevik>
 <CA+G9fYuyXgWvsRhznP2x2VE5CvSyCCgcvxPz2J=dbvg6YW2iUA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYuyXgWvsRhznP2x2VE5CvSyCCgcvxPz2J=dbvg6YW2iUA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 06 Oct 2023 15:30:10 +0200
Subject: Re: [LTP] [PATCH 6.1 000/259] 6.1.56-rc1 review
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
Cc: lkft-triage@lists.linaro.org, linux-kernel@vger.kernel.org,
 Olga Kornievskaia <kolga@netapp.com>, stable@vger.kernel.org, shuah@kernel.org,
 f.fainelli@gmail.com, jonathanh@nvidia.com, patches@kernelci.org,
 linux@roeck-us.net, srw@sladewatkins.net,
 Richard Palethorpe <rpalethorpe@suse.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 LTP List <ltp@lists.linux.it>, linux-nfs@vger.kernel.org,
 Eryu Guan <eguan@redhat.com>, rwarsow@gmx.de, pavel@denx.de,
 patches@lists.linux.dev, conor@kernel.org, sudipm.mukherjee@gmail.com,
 Benjamin Coddington <bcodding@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, Anna Schumaker <Anna.Schumaker@netapp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUaHUsIDUgT2N0IDIwMjMgYXQgMjI6NTQsIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6
PiB3cm90ZToKCj4gPiBIaSBOYXJlc2gsCgo+ID4gPiBPbiBXZWQsIDQgT2N0IDIwMjMgYXQgMjM6
NDEsIEdyZWcgS3JvYWgtSGFydG1hbgo+ID4gPiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+
IHdyb3RlOgoKPiA+ID4gPiBUaGlzIGlzIHRoZSBzdGFydCBvZiB0aGUgc3RhYmxlIHJldmlldyBj
eWNsZSBmb3IgdGhlIDYuMS41NiByZWxlYXNlLgo+ID4gPiA+IFRoZXJlIGFyZSAyNTkgcGF0Y2hl
cyBpbiB0aGlzIHNlcmllcywgYWxsIHdpbGwgYmUgcG9zdGVkIGFzIGEgcmVzcG9uc2UKPiA+ID4g
PiB0byB0aGlzIG9uZS4gIElmIGFueW9uZSBoYXMgYW55IGlzc3VlcyB3aXRoIHRoZXNlIGJlaW5n
IGFwcGxpZWQsIHBsZWFzZQo+ID4gPiA+IGxldCBtZSBrbm93LgoKPiA+ID4gPiBSZXNwb25zZXMg
c2hvdWxkIGJlIG1hZGUgYnkgRnJpLCAwNiBPY3QgMjAyMyAxNzo1MToxMiArMDAwMC4KPiA+ID4g
PiBBbnl0aGluZyByZWNlaXZlZCBhZnRlciB0aGF0IHRpbWUgbWlnaHQgYmUgdG9vIGxhdGUuCgo+
ID4gPiA+IFRoZSB3aG9sZSBwYXRjaCBzZXJpZXMgY2FuIGJlIGZvdW5kIGluIG9uZSBwYXRjaCBh
dDoKPiA+ID4gPiAgICAgICAgIGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvcHViL2xpbnV4L2tlcm5l
bC92Ni54L3N0YWJsZS1yZXZpZXcvcGF0Y2gtNi4xLjU2LXJjMS5nego+ID4gPiA+IG9yIGluIHRo
ZSBnaXQgdHJlZSBhbmQgYnJhbmNoIGF0Ogo+ID4gPiA+ICAgICAgICAgZ2l0Oi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC1zdGFibGUtcmMuZ2l0
IGxpbnV4LTYuMS55Cj4gPiA+ID4gYW5kIHRoZSBkaWZmc3RhdCBjYW4gYmUgZm91bmQgYmVsb3cu
Cgo+ID4gPiA+IHRoYW5rcywKCj4gPiA+ID4gZ3JlZyBrLWgKCj4gPiA+IFJlc3VsdHMgZnJvbSBM
aW5hcm/igJlzIHRlc3QgZmFybS4KPiA+ID4gUmVncmVzc2lvbnMgb24gYXJtNjQgYmNtMjcxMS1y
cGktNC1iIGRldmljZSBydW5uaW5nIExUUCBkaW8gdGVzdHMgb24KPiA+IENvdWxkIHlvdSBwbGVh
c2Ugbm90ZSBpbiB5b3VyIHJlcG9ydHMgYWxzbyBMVFAgdmVyc2lvbj8KCj4gU3VyZS4KPiBXZSBh
cmUgcnVubmluZyBMVFAgVmVyc2lvbjogMjAyMzA1MTYgZm9yIG91ciB0ZXN0aW5nLgoKPiBXZSB3
aWxsIHVwZGF0ZSB0aGUgbGF0ZXN0IExUUCByZWxlYXNlICgyMDIzMDkyOSkgbmV4dCB3ZWVrLgoK
R3JlYXQsIHRoYW5rIHlvdS4KCj4gPiBGWUkgdGhlIGJlc3QgTFRQIHJlbGVhc2UgaXMgYWx3YXlz
IHRoZSBsYXRlc3QgcmVsZWFzZSBvciBnaXQgbWFzdGVyIGJyYW5jaC4KCj4gV2UgaGF2ZSB0d28g
dGhyZWFkcyBoZXJlLgo+IDEpIExUUCByZWxlYXNlIHRhZyB0ZXN0aW5nIG9uIGFsbCBzdGFibGUt
cmMgYnJhbmNoZXMKPiAyKSBMVFAgbWFzdGVyIHRlc3Rpbmcgb24gYSBnaXZlbiBzcGVjaWZpYyBr
ZXJuZWwgdmVyc2lvbiBbYV0KCkdyZWF0LCB0aGlzIG1ha2VzIHNlbnNlLgoKQlRXIGZyb20gbG9v
a2luZyBpbiB0aGUgbG9nIFtiXSAoIklORk86IGx0cC1wYW4gcmVwb3J0ZWQgc29tZSB0ZXN0cyBG
QUlMIikKSSBzZWUgeW91IHVzZSBydW5sdHAuIFdlIHJlY29tbWVuZCB0byBzd2l0Y2ggdG8ga2ly
ayBbY10uIEFuZCB3ZSBkZWZpbml0ZWx5CmFwcHJlY2lhdGUgeW91ciBmZWVkYmFjayBmcm9tIGl0
LgoKS2luZCByZWdhcmRzLApQZXRyCgo+IFthXSBodHRwczovL3FhLXJlcG9ydHMubGluYXJvLm9y
Zy9sa2Z0L2x0cC1tYXN0ZXIvCltiXSBodHRwczovL3FhLXJlcG9ydHMubGluYXJvLm9yZy9sa2Z0
L2x0cC1tYXN0ZXIvYnVpbGQvdjYuNS4zXzIwMjMwOTI5LTItZzQ4YTE1MGJmZC90ZXN0cnVuLzIw
MjIzNzkwL3N1aXRlL2x0cC1jdmUvdGVzdC9jdmUtMjAxNy04ODkwL2xvZwpbY10gaHR0cHM6Ly9n
aXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9raXJrLyNyZWFkbWUKCj4gLSBOYXJlc2gKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
