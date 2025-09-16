Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD952CAC599
	for <ltp@archiver.kernel.org>; Tue, 16 Sep 2025 07:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758008301; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=M98WsKTelGzJyHka5NxPOIm2H+Uagaz9kULCdC5zye8=;
 b=ZI6lMa8ytJQpxFVFTGK7mgrA8moMcud4OSxwJtXLWuMmN1yprrwx4aoHIMd6WraMvHJ5y
 ljl6iggagvGVlQgOIKkk9in6sJyRRbZu/SOEacA/zRsQOQICOB3nlErWiRyAcJYlQFrHhT9
 XXbWJ27KkguBDdzurEgy2c6Aq1Tx3Vs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 390093CDAD6
	for <ltp@archiver.kernel.org>; Tue, 16 Sep 2025 09:38:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79EBA3CDA77
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 09:38:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A49571A002DB
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 09:37:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758008277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6F4BfzzaC15SLEBv7LBZBwUSgpBolIS/Xkdp85x/w3Q=;
 b=Tqzdfv++HDim/vtkI4S4Ku82/V7cJlU9CkfFAOUZM0CGaBrjii/KNCeNTHRWAV15eIcIrv
 bXqjuZsWAZa/ActC+8jjKAJs5IclkM3j5sXDBayB4/CYI2j+QEKFy49FEgVVXPpq9vCcnE
 htBzYljiZ8rtf9ZznOudux1ySUYVV/0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-uSQdVzzgNIyMnR2lVClQig-1; Tue, 16 Sep 2025 03:37:55 -0400
X-MC-Unique: uSQdVzzgNIyMnR2lVClQig-1
X-Mimecast-MFC-AGG-ID: uSQdVzzgNIyMnR2lVClQig_1758008274
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2659a7488a2so40066135ad.3
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 00:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758008274; x=1758613074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6F4BfzzaC15SLEBv7LBZBwUSgpBolIS/Xkdp85x/w3Q=;
 b=EWhXDtomfWbhW0aegIs5DAXnZylNAv/b6KdbuhuvA1NpIsrhTF/2/fSCKdxUaTBvoP
 hhb9DxEwLUGfzepuVdnwu7KwHgxC7Pe75mGzzAYdoswwwSw9AphCmY83L9vmLi9taUIg
 GgVCWRgDVrtbigM1n48fEQnyHWZ1c04xsZfERudKLLJXHQ06K+8nnumX4CMAjgf7sJip
 7dFl5+gz4I4ll63yNljdujRtax9bMvU/mIsCOBmd0CpgXLBRyhQoOSJrqXSRC1LO98I7
 8SWPsErdVLf3c6+z0h5z1+kNFeAf2Ns3DlO2ejFUqv83T9qkiHKA6YE+vG9LPIbYT9ZC
 J13w==
X-Gm-Message-State: AOJu0YyC2ks7hU/eIjhv6nM+pHtUOtPlGpG7QKhaLFt5UArk5xJqFl6f
 doerGrU/qd9rnbzkJVHVYWfJPNw6yRI+AgjLi3jXSv+RauCfupdQZDfaDwv1jw9xZHqmAze02ve
 CZ5aHqfZ1kq4rHeD8uq/xk3uDtQDK1r7bKNcGDdlOqB4bkQMNKDt7QEsvHfWSZo4CLm06jCa2MX
 iX/nxyS/NqfSqSCt1YcWBLsxGkUIw=
X-Gm-Gg: ASbGnctRjBF2FBaC8pc1RoPGiK7wdXS2uiQrvjjRKkU6nvKAlC7juCPkoQc/GLnFSJc
 xlfiRHBTwbcsZYY82W3EwNmrm07w9mW2fZfv/XGq9JD0xdL+X4PTUyGpLqp4v/qlsRsxk2lI9kJ
 /zUbxZSNVUa4pkLEX6zB7YLg==
X-Received: by 2002:a17:903:3c46:b0:25c:2ed4:fd7f with SMTP id
 d9443c01a7336-25d26d4d819mr183287535ad.42.1758008274270; 
 Tue, 16 Sep 2025 00:37:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHfAJYceyYQwBNApv5/mIWKDPkVG7p1HAPE8VzKbTtfoRPYbn6VlYVkEcUIc1Xd2eVRb1derbEOJ/zl1ytNQg=
X-Received: by 2002:a17:903:3c46:b0:25c:2ed4:fd7f with SMTP id
 d9443c01a7336-25d26d4d819mr183287335ad.42.1758008273848; Tue, 16 Sep 2025
 00:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2e0TUFeWS7mjfz5FVW_Jb6Pv76YiEXLHY+ojwfGpvfWWw@mail.gmail.com>
 <CAEemH2cTiKAhn2hjr71Qn1-CRHBoFm_FH4Xp3BPQm1arrxUVTA@mail.gmail.com>
 <3f256fea-0add-413b-939e-b2d252415bfa@suse.com>
 <63d60b27-d732-4525-a62f-5fd0d910511e@suse.com>
In-Reply-To: <63d60b27-d732-4525-a62f-5fd0d910511e@suse.com>
Date: Tue, 16 Sep 2025 15:37:40 +0800
X-Gm-Features: AS18NWCOVgaw9WylvHKXHhY5amd0rDqKB0rlo2IB4hkd6yum3zViug4AIwMmLYg
Message-ID: <CAEemH2fU8OQkwCM8jkRe_TTB=NaWs2NMV0DCojiDyv-NkR1B9Q@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kNhzaEmp9mKvKIY7G38Kwu9v9ZwBoZrEukk5-kgH0qU_1758008274
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] kirk cannot handle env variable correctly
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBTZXAgMTYsIDIwMjUgYXQgMzoyMOKAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cndyb3RlOgoKPgo+IE9uIDkvMTYvMjUgOToxOSBBTSwgQW5k
cmVhIENlcnZlc2F0byB3cm90ZToKPgo+IEhpIQo+IE9uIDkvMTYvMjUgNjozNSBBTSwgTGkgV2Fu
ZyB3cm90ZToKPgo+Cj4gQWZ0ZXIgbG9va2luZyBhdCB0aGUgbHRwLnB5LCBpdCBvdmVycmlkZXMg
dGhlIHVzZXItc2V0IExUUF9USU1FT1VUX01VTCBlbnYKPiB2YXJpYWJsZS4KPiBTbyBtYXliZSB3
ZSBuZWVkIHRvIGVuYWJsZSB0aGF0IHRvIGNvbmZpZyBieSAtLWVudiwgd2hhdCBkbyB5b3UgdGhp
bms/Cj4KPiBJbmRlZWQsIHRoaXMgaXMgYSBmZWF0dXJlIHRoYXQgZG9lc24ndCBtYWtlIG11Y2gg
c2Vuc2UgYW55bW9yZS4gV2Ugc2hvdWxkCj4gZmV0Y2ggZW52IHZhcmlhYmxlcyBmcm9tIHRoZSBj
b21tYW5kIGxpbmUgYW5kIG5vdCBmcm9tIHRoZSAtLWVudiBvcHRpb24uCj4gVGhpcyB3YXMgYWRk
ZWQgd2hlbiBGcmFtZXdvcmsgQVBJIHdhcyBhIHBsdWdpbiBhbmQgd2UgY291bGQgaW1wbGVtZW50
Cj4gbXVsdGlwbGUgZnJhbWV3b3JrcywgYnV0IG5vdyB3ZSBvbmx5IHN1cHBvcnQgTFRQLgo+Cj4g
SSdtIGN1cnJlbnRseSB3b3JraW5nIG9uIGEgbmV3IGtpcmsgdmVyc2lvbiwgd2hlcmUgbXVsdGlw
bGUgY29tbXVuaWNhdGlvbgo+IGNoYW5uZWxzIGFuZCBTVVQgY2FuIGJlIGltcGxlbWVudGVkIHNl
cGFyYXRlbHkgaW4gb3JkZXIgdG8gY3JlYXRlIGNvbXBsZXgKPiBzY2VuYXJpb3MuIE15IGlkZWEg
aXMgdG8gcmVtb3ZlIEZyYW1ld29yayBBUEkgYW5kIC0tZW52IHZhcmlhYmxlIG5leHQgdG8KPiB0
aGF0LiBGb3Igbm93IHdlIGNhbiBtZXJnZSB0aGlzIHBhdGNoLgo+Cj4gLSBBbmRyZWEKPgo+IEkg
Zm9yZ290IG9uZSB0aGluZzogY2FuIHlvdSBwbGVhc2Ugc2VuZCBhIFBSPyBTbyBJIGNhbiBtZXJn
ZSBpdCB2aWEgZ2l0aHViCj4gYW5kIHdlIGtlZXAgdHJhY2sgb2YgaXQgaW4gdGhlIG5leHQgcmVs
ZWFzZS4gVGhhbmtzIQo+CgpZZXMsIHRoaXMgY291bGQgYmUgYSBzaW1wbGUgd29ya2Fyb3VuZDoK
aHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9raXJrL3B1bGwvNzAKCgotLSAK
UmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
