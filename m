Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39644C369B4
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 09:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744710862; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=jMiNwoaxo0kgZKowr6PpT0wPifjGA7XsFMdDNfnnUmU=;
 b=VtsCiW2i17DclawOp5TwxhWkQ9Wz3I72LkbCGn0aWF1FOqbewxhXK19yf/PLFxE83lO8V
 OYEtOkL54L6nfaDIqT5o5XWvxKh9p//SiUyxL7zuE1Bhn9mEyoWQi4v87Y33GEXofabUaDk
 OFL4egjwBywHAcWSTkFCBNAZVFj1hX8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FEF23CB881
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 11:54:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32B683C2EFA
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 11:54:02 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CEB3D600C18
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 11:54:01 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso56146435e9.0
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 02:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744710841; x=1745315641; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTYUf70RRZ3SC8qECxMNKVUbzQfj+sP8V8ESXiw3DMg=;
 b=DU27pQQ+fjNdluX54m0aGljfq8t4pPacaWTxFZBcAhxdYXJWV3vyOen6qhFAyNoBNo
 uNHYxR3OcI5sMS8NHW/iRUWOvI94gc7zIxtNtbGO+77CtxzosWb9gB+DMybbWbK1FLIZ
 AByjkPFI76uHfauraSMg7DcR8rb63bozXUh2tjfnFZRol+yLlcWZ99Dn3BAdH/Dqwxp1
 AyBovlVQzRaiPBDmW5kvSWYjnN2kuDBpMrJ7SDafcd/CDmKPd49szbEyujFvFz2HrzSU
 L2WBqNNYRvsUw9jJvKPeb3RS7OYhtr47MbNgfmr2pUBJXaaHUt0ftUjQT5mLDR0VEurW
 yvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744710841; x=1745315641;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FTYUf70RRZ3SC8qECxMNKVUbzQfj+sP8V8ESXiw3DMg=;
 b=BJ0RgUpvAVBUZU4QBBJ5rWyvhLUKZKzXvIaxAM5lbuxMVfbYxFTFTJizVa/1dmBS+S
 T8Er5XfJ8A9Ii0AcyDXWOcjz0JBqw4leN0qe6vvF3spYavKv2/Dbj/Z+3XQRfh9udh4N
 oW0/6RJpSPNZxEZD0XKRrEwQ3ZjYOF1hAVa/oyNShHuEzKc4BQnb2Y/0Ztt4QXHaTOEi
 IGuntzeLDV/FawwyfbOAWZ+1KuFOgfkL3fAduxQortapckAZTghAvgYXCQ+WidDvIctc
 gmMjhpgmtGcT4T893ZiYbNhVp8KgE4GpZnrHt8YE/K9V7G/rwvD+6xpyE3t0l9kDA5Ot
 OKOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYBOEl7ffDuPv96q0mRF1uQbTpdUU0OdHuekKODj9Wx/llwKlMMamWwRe89ftJZVE5LPo=@lists.linux.it
X-Gm-Message-State: AOJu0YyCN9H3wFIIAfIyO40VeeKibWbAVvyold8A/Co515T45FYlC28p
 gpe5AQ29C19kMVi2AyqXdAMCx+34tJGvFZWR1kacSkap+E6xLiUtZedxqZ3qOPM=
X-Gm-Gg: ASbGncubYvA9QdqGyAxl1uc+MduNwPjfCxtpcxRfwX9W2uDeJHJMQX2y9UYfqjT/YJr
 pD8knvXRXBDC4bzz2+Q9b0ZZwoekBYi3qYhp4c88xQdvG1bi6uUkq6bZWd6eQSyKRjcqoeWNcLE
 RB32Ys740Lucq7fCGksbhWSI6TVlRoas+VPhUyse0BQBr5IQCVLEy5kP3VDc2AYVmRs8xxcnwu9
 bK6DKk08HNSFbuFB4li7N7DJxVTVDxueQyAjMHqOO+uNLU2kEw19p3L42dMhqVljtYBDm7SJ3Ru
 FoHBRK/CP7upU616o4zu3k9H3Q20YuiuvYqblL07YcMM7a5zso62CO3mW7GkaWfXxmG8w5FNBDF
 eKSYVuBxSP8JU4hYPfbclivpl9OwNEzXfwX2QaqVSUVLcWvSbLwB0JMDyZRC+L1KeoYA9mLWOKI
 h8Qvmqzlo96YpA/w==
X-Google-Smtp-Source: AGHT+IHNKcwc4tUr5VkAAMaMS+0PqknRBuDbY2aHldBJpAgpHWa/uAhb0+HDSG7y5bECzk3w5/nrNw==
X-Received: by 2002:a05:600c:1d88:b0:43d:7588:6688 with SMTP id
 5b1f17b1804b1-43f3a94c5a0mr148406085e9.12.1744710841192; 
 Tue, 15 Apr 2025 02:54:01 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c8224sm201054185e9.22.2025.04.15.02.54.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 02:54:00 -0700 (PDT)
Message-ID: <fce9cfda-e29b-4475-8934-d8fee4f795a9@suse.com>
Date: Tue, 15 Apr 2025 11:54:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20250411114326.526-1-andrea.cervesato@suse.de>
 <20250414154141.GC443040@pevik>
 <bcf4c112-75d7-4a4a-a9ba-0579455a9fa9@suse.com>
 <20250415094934.GB473949@pevik>
Content-Language: en-US
In-Reply-To: <20250415094934.GB473949@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v5 0/4] Support for Patchwork CI
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gNC8xNS8yNSAxMTo0OSwgUGV0ciBWb3JlbCB3cm90ZToKPiBTdXJlLCBsZXQncyBpZ25vcmUg
aXQuCj4KPiBGWUkgSSBkaWQgbm90IHRoaW5rIHRvIGFkZCBhbm90aGVyIGxheWVyLiBJdCB3b3Vs
ZCBiZSBnaXQgcHVzaCBpbgo+IGNpLXBhdGNod29yay10cmlnZ2VyLnltbCAobW9yZSBjb2RlLCBi
dXQgT1RPSCBjaS1kb2NrZXItYnVpbGQueW1sIHdvdWxkIG5vdCBoYXZlCj4gdG8gYmUgbW9kaWZp
ZWQpLgo+Cj4gQWxzbywgeW91IGRlY2lkZSB0byB0cmlnZ2VyIGNpLWRvY2tlci1idWlsZC55bWwg
dmlhIGNpLXBhdGNod29yay10cmlnZ2VyLnltbCwKPiB3aGljaCBpZ25vcmVzIGNpLXNwaGlueC1k
b2MueW1sLiBUaGVyZWZvcmUgcGF0Y2hlcyB3aGljaCBtb2RpZnkganVzdAo+IGRvY3VtZW50YXRp
b24sIGUuZy4gZXZlbiB3aXRoIHRoaXMgQ0kgd2UgY2FuIGhhdmUgY2hhbmdlcyB3aGljaCBicmVh
awo+IHJlYWR0aGVkb2NzLm9yZy4KPgo+IEkgY3JlYXRlZCBhIHNpbmdsZSBqb2IgY2ktc3BoaW54
LWRvYy55bWwgYmVjYXVzZSAxKSBpdCdzIGVhc2llciB0byBzcG90IHdoYXQgZ290Cj4gYnJva2Vu
IDIpIEkgY29uc2lkZXIgYnVpbGRpbmcgdGhlIGRvYyBpbiBhbGwgZGlzdHJvcyBhcyBhIHdhc3Rl
IG9mIHRpbWUuIFNob3VsZAo+IHdlIHJlY29uc2lkZXIgaXQ/IEkgY291bGQgbW92ZSBidWlsZGlu
ZyBvZiB0aGUgZG9jIHRvIGNpLXNwaGlueC1kb2MueW1sIGFuZAo+IHJlbW92ZSBjaS1zcGhpbngt
ZG9jLnltbC4gT3RoZXIgb3B0aW9uIGlzIHRoYXQgeW91IHRyaWdnZXIgYWxzbyBjaS1zcGhpbngt
ZG9jLnltbAo+IChub3RoaW5nIHVyZ2VudCwgY2FuIGJlIGRvbmUgbGF0ZXIpLgpXZSBjYW4gZG8g
aXQgbGF0ZXIgb25jZSB3ZSBoYXZlIGV2ZXJ5dGhpbmcgd29ya2luZyBmb3IgYmFzaWNzIGJ1aWxk
IHRlc3RzLgo+Cj4+PiA2KSBMaW5rcyBpbiBQYXRjaHdvcmsgY29udGFpbnMgam9iIElECj4+PiBJ
dCB3b3VsZCBiZSBuaWNlIGlmIGxpbmtzIGluIHRoZSBwYXRjaHdvcmsgdGFibGUgY29udGFpbiBh
bHNvIGpvYiB0byB0aGUgc3BlY2lmaWMgZGlzdHJvLCBlLmcuCj4+PiBodHRwczovL2dpdGh1Yi5j
b20vYWNlcnYvbHRwL2FjdGlvbnMvcnVucy8xNDQ0NzI1MDcwNS9qb2IvNDA1MTA3NTUzMDUKPj4g
SXQgJ3Mgc29tZXRoaW5nIEkgdHJpZWQgYXQgdGhlIHZlcnkgYmVnaW5uaW5nIGJ1dCBJIGRpZG4n
dCBmaW5kIGEgc29sdXRpb24KPj4gdG8gZ2V0IHRoYXQgIjQwNTEwNzU1MzA1IiBmcm9tIC9qb2Ig
LiBJIG5lZWQgdG8gcmVhZCBkb2N1bWVudGF0aW9uIGFnYWluIGFuZAo+PiB0byB0cnkgYSBjb3Vw
bGUgb2Ygc29sdXRpb25zLi4uaXQncyBqdXN0IGEgcmVhbGx5IHNsb3cgaW1wbGVtZW50YXRpb24K
Pj4gcHJvY2VzcyBmb3IgYSBzaW1wbGUgaW1wcm92ZW1lbnQsIHNvIEkgYm90aGVyZWQgbW9yZSBh
Ym91dCBzdGFiaWxpdHkgYW5kCj4+IGJhc2ljIGZ1bmN0aW9uYWxpdGllcyDwn5mCIFdlIGNhbiBh
ZGQgdGhpcyBpbXByb3ZlbWVudCBsYXRlciBpZiBpdCdzIG9rLgo+IFN1cmUsIGl0IGNhbiB3YWl0
Lgo+Cj4+IFRoZXJlIGFyZSBzdGlsbCBzb21lIHRoaW5ncyB3aGljaCBhcmUgbW9yZSBpbXBvcnRh
bnQsIGxpa2Ugc2hvd2luZyBsaW50aW5nCj4+IHdhcm5pbmdzIGluIFBhdGNod29yayBkdWUgdG8g
Im1ha2UgY2hlY2siIGNvbW1hbmQuCj4gSSBkb24ndCBjb25zaWRlciB0aGlzIGltcG9ydGFudCB1
bnRpbCBMVFAgaXMgaW4gdGhlIHN0YXRlIHdoZW4gaXQncyBjbGVhbi4gQVRNIEkKPiB3b3VsZCBk
byBpdCBvbmx5IGZvciBuZXcgZmlsZXMuIEZvciBtb2RpZmllZCBmaWxlcyBJIHdvdWxkIHByaW50
IHdhcm5pbmcgb25seQo+IHdoZW4gdGhlcmUgYXJlIG5ldyB3YXJuaW5ncyAoY29tcGFyZSBjb3Vu
dCB3YXJuaW5nIG9uIG1hc3RlcjsgY29tcGFyaW5nIGRpZmYgb2YKPiB3YXJuaW5nIG9uIG1hc3Rl
ciB2cy4gcGFydGljdWxhciBwYXRjaHNldCB3aWxsIG5vdCB3b3JrIGJlY2F1c2UgbGluZSBudW1i
ZXIKPiBjaGFuZ2VzKS4KPgo+IEl0IHNob3VsZCBiZSB3YXJuaW5nIG9ubHkgKG5vdCBhIGZhaWx1
cmUpLgo+Cj4gSSBndWVzcyB0aGlzIHdpbGwgYmUgc2VwYXJhdGUgd29ya2Zsb3csIHJpZ2h0PyBP
bmNlIGFueWJvZHkgc3RhcnQgb24gaXQsIEkgZ3Vlc3MKPiB3ZSBzaG91bGQgaGF2ZSBzY3JpcHQg
d2hpY2ggdGFrZXMgaW5wdXQgb2YgY2hhbmdlZCBmaWxlcyBhbmQgZ2VuZXJhdGVzIG91dHB1dAo+
IG9mIG1ha2UgY2hlY2stKiBjb21tYW5kcy4KCkkgc3RpbGwgZG9uJ3Qga25vdywgd2Ugd2lsbCBu
ZWVkIGFuIGltcGxlbWVudGF0aW9uIGxhdGVyIG9uLgoKLSBBbmRyZWEKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
