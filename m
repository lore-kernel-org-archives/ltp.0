Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41C1C77B61
	for <ltp@archiver.kernel.org>; Fri, 28 Apr 2023 13:30:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 942433CC08F
	for <ltp@archiver.kernel.org>; Fri, 28 Apr 2023 15:30:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3D303CBA26
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 15:30:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 98A601A007EB
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 15:30:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682688637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gbGnPF2Jil+qcNp0BBgAFYYZv7SY4yrvynnvwQEsjMw=;
 b=YpDmFYjLER0MdPwYNafxnnOujlvhhphd21gAOKIQ9GJKkTO+3TfBWer8bDJ+dM1liTrACS
 A0TWBmo30xvp6JqWzsCour0DFxMnTWcqI7kbKq2IeRLPCGOUlG9m9DiVaOMp1STX5pAvCw
 6agp9IswCv8Dc0B93SpxhoqH617e0Wc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-1wk5Yg2yP9mj4Bw1wWrPkw-1; Fri, 28 Apr 2023 09:30:35 -0400
X-MC-Unique: 1wk5Yg2yP9mj4Bw1wWrPkw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2a8be1c1844so45514251fa.3
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 06:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682688634; x=1685280634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gbGnPF2Jil+qcNp0BBgAFYYZv7SY4yrvynnvwQEsjMw=;
 b=gAGyEHVq2SOJcJzUzz4uTz2YgbEerfNO6KXNk4/J+IaV4119uWFlyLOiGsU3BWEO3q
 UjGTZJhJ19Ow2JmQ45sdX/FND2//bKp+DwGNbNuPN4E7QinJge1aotOsKo9LMxsnaJjC
 aqx79ZH1Q5SBD3jYYj3hHFhPTtcUqz3uVOMcLtELo2o8RrX3atqIt5D2A2+uPTG36LKk
 5MHgxKaJtKzTdjI/kd/D0Nl4wQ7ydnP6m6Vls4eF2JC4sDerzw84Y2OkTZ2HGXNSqnv/
 KxVdSX1wCq27BxZq/qyzYaFZlXGfHk7woERjIocb0Q0hy7WHMSK2zWmfbcCzKdPBNXRP
 tZjA==
X-Gm-Message-State: AC+VfDx/3dijDaEL1FnCV/MIAay7dNDqFc3x83FQ8th834BKMyQ9MCP0
 qyhdIIqlEijlNw8y3PWHYGDtY92hq+Qu+j943nPxLnb2aWQfRhzWdVwNEgz0ZyziRLVIxwU3BiJ
 Cl5dBfcPbFhby1KKgysWQM8SZ9m4=
X-Received: by 2002:a2e:97c4:0:b0:2a8:ca28:e4e with SMTP id
 m4-20020a2e97c4000000b002a8ca280e4emr1655598ljj.24.1682688634294; 
 Fri, 28 Apr 2023 06:30:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5MScgLIU8ljD2V9ecuU7E4eymsXgnaSjTn/o8m1PRQipqYuZesGy5+MTbwBV9Y6R3h2bRoDOcG+GzANGRMIls=
X-Received: by 2002:a2e:97c4:0:b0:2a8:ca28:e4e with SMTP id
 m4-20020a2e97c4000000b002a8ca280e4emr1655590ljj.24.1682688633996; Fri, 28 Apr
 2023 06:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230428084922.9834-1-liwang@redhat.com> <ZEufJa+TyZdY9gsq@yuki>
 <CAEemH2fcvpRLS7-rdpiGt-fqEwXCiAb-jpRdisb33axhdP3CoA@mail.gmail.com>
 <ZEvGchayVsZfrAH5@yuki>
In-Reply-To: <ZEvGchayVsZfrAH5@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 28 Apr 2023 21:30:21 +0800
Message-ID: <CAEemH2femWH5U98nvsnCR2OrZee1aBjGY7nnS3PX95u2NX6QgQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH] tst_cgroup: Avoid mixing mounts V1 and V2
 simultaneously
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

T24gRnJpLCBBcHIgMjgsIDIwMjMgYXQgOToxMuKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBUaGF0J3MgdGhlIG9yaWdpbmFsIGRlc2lnbi4gV2Ug
dHJpZWQgdG8ga2VlcCBmbGV4aWJsZSBidXQgaWdub3JlZAo+ID4gb25lIGV4Y2VwdGlvbiBWMSBt
b3VudHMgYWxsIGNvbnRyb2xsZXJzIGFuZCBWMiBvbmx5IGJhc2ljIG1vdW50Lgo+ID4gKE5vIGNv
bnRyb2xsZXJzIGNvbmZsaWN0IGluIHRoaXMgbW91bnRpbmcpLgo+ID4KPiA+IEZyb20gbXkgb2Jz
ZXJ2YXRpb24sIGlmIGEgc3lzdGVtKGUuZy4gUkhFTDgpIG9ubHkgYW5ub3VuY2VzCj4gPiBDZ3Jv
dXAgVjEgc3VwcG9ydCBidXQgZG9lcyBub3QgZ3VhcmFudGVlIFYyIHRvIGJlIHVzZWQuCj4gPiBB
IHRlc3QgcmVxdWlyZWQgJ0NUUkxfQkFTRScgY291bGQgbW91bnQgVjIgc3VjY2VzcyBidXQKPiA+
IHRoYXQgVjIgaXMgb25seSBwYXJ0IHdvcmsgYW5kIHRlc3Qgd2lsbCBnZXQgVEJST0suCj4gPiBX
ZSBhcmUgdW5hYmxlIHRvIHNheSB0aGlzIHNpdHVhdGlvbiBpcyBhIGJ1Zy4KPgo+IFNvIHRoZSBW
MiBkb2VzIG5vdCBhY3R1YWxseSB3b3JrIHVubGVzcyB0aGVyZSBpcyBhdCBsZWFzdCBvbmUgY29u
dHJvbGxlcgo+IGVuYWJsZWQ/IFRoYXQgc291bmRzIGxpa2UgYSBidWcgdG8gbWUsIG15IHN5c3Rl
bSBhY3R1YWxseSB1c2VzIHYxCj4gY29udHJvbGxlcnMgYW5kIHVuaWZpZWQgaGllcmFyY2h5IGF0
IHRoZSBzYW1lIHRpbWUuIFRoZSB1bmlmaWVkCj4gaGllcmFyY2h5IGlzIHVzZWQgdG8gZ3JvdXAg
ZGVhbW9uIHByb2Nlc3NlcyBhbmQga2lsbCB0aGVtIHdpdGggdGhlCj4gY2dyb3B1LmtpbGwgaWYg
bmVlZGVkLgoKCkhtbSwgbGV0IG1lIGludmVzdGlnYXRlLi4uCgo+Cj4gV2hhdCBleGFjdGx5IGhh
cHBlbnMgb24geW91ciBzeXN0ZW0/Cj4KCldoZW4gbW91bnRpbmcgVjEgd2l0aCBhbGwgY29udHJv
bGxlcnMgYW5kIG9ubHkgdGhlIGJhc2ljIG9mIFYyLAp0aGVyZSBsYWNrIG9mIHNvbWUgY29udHJv
bGxlciBmaWxlcyAoY2dyb3VwLmtpbGwpIGluIFYyLgoKIyBtb3VudCB8IGdyZXAgY2dyb3VwCnRt
cGZzIG9uIC9zeXMvZnMvY2dyb3VwIHR5cGUgdG1wZnMKKHJvLG5vc3VpZCxub2Rldixub2V4ZWMs
c2VjbGFiZWwsc2l6ZT0xODEzOTg0ayxucl9pbm9kZXM9NDUzNDk2LG1vZGU9NzU1KQpjZ3JvdXAg
b24gL3N5cy9mcy9jZ3JvdXAvc3lzdGVtZCB0eXBlIGNncm91cAoocncsbm9zdWlkLG5vZGV2LG5v
ZXhlYyxyZWxhdGltZSxzZWNsYWJlbCx4YXR0cixyZWxlYXNlX2FnZW50PS91c3IvbGliL3N5c3Rl
bWQvc3lzdGVtZC1jZ3JvdXBzLWFnZW50LG5hbWU9c3lzdGVtZCkKY2dyb3VwIG9uIC9zeXMvZnMv
Y2dyb3VwL3BlcmZfZXZlbnQgdHlwZSBjZ3JvdXAKKHJ3LG5vc3VpZCxub2Rldixub2V4ZWMscmVs
YXRpbWUsc2VjbGFiZWwscGVyZl9ldmVudCkKY2dyb3VwIG9uIC9zeXMvZnMvY2dyb3VwL2Rldmlj
ZXMgdHlwZSBjZ3JvdXAKKHJ3LG5vc3VpZCxub2Rldixub2V4ZWMscmVsYXRpbWUsc2VjbGFiZWws
ZGV2aWNlcykKY2dyb3VwIG9uIC9zeXMvZnMvY2dyb3VwL25ldF9jbHMsbmV0X3ByaW8gdHlwZSBj
Z3JvdXAKKHJ3LG5vc3VpZCxub2Rldixub2V4ZWMscmVsYXRpbWUsc2VjbGFiZWwsbmV0X2Nscyxu
ZXRfcHJpbykKY2dyb3VwIG9uIC9zeXMvZnMvY2dyb3VwL3BpZHMgdHlwZSBjZ3JvdXAKKHJ3LG5v
c3VpZCxub2Rldixub2V4ZWMscmVsYXRpbWUsc2VjbGFiZWwscGlkcykKY2dyb3VwIG9uIC9zeXMv
ZnMvY2dyb3VwL3JkbWEgdHlwZSBjZ3JvdXAKKHJ3LG5vc3VpZCxub2Rldixub2V4ZWMscmVsYXRp
bWUsc2VjbGFiZWwscmRtYSkKY2dyb3VwIG9uIC9zeXMvZnMvY2dyb3VwL2NwdSxjcHVhY2N0IHR5
cGUgY2dyb3VwCihydyxub3N1aWQsbm9kZXYsbm9leGVjLHJlbGF0aW1lLHNlY2xhYmVsLGNwdSxj
cHVhY2N0KQpjZ3JvdXAgb24gL3N5cy9mcy9jZ3JvdXAvaHVnZXRsYiB0eXBlIGNncm91cAoocncs
bm9zdWlkLG5vZGV2LG5vZXhlYyxyZWxhdGltZSxzZWNsYWJlbCxodWdldGxiKQpjZ3JvdXAgb24g
L3N5cy9mcy9jZ3JvdXAvY3B1c2V0IHR5cGUgY2dyb3VwCihydyxub3N1aWQsbm9kZXYsbm9leGVj
LHJlbGF0aW1lLHNlY2xhYmVsLGNwdXNldCkKY2dyb3VwIG9uIC9zeXMvZnMvY2dyb3VwL2ZyZWV6
ZXIgdHlwZSBjZ3JvdXAKKHJ3LG5vc3VpZCxub2Rldixub2V4ZWMscmVsYXRpbWUsc2VjbGFiZWws
ZnJlZXplcikKY2dyb3VwIG9uIC9zeXMvZnMvY2dyb3VwL21lbW9yeSB0eXBlIGNncm91cAoocncs
bm9zdWlkLG5vZGV2LG5vZXhlYyxyZWxhdGltZSxzZWNsYWJlbCxtZW1vcnkpCmNncm91cCBvbiAv
c3lzL2ZzL2Nncm91cC9ibGtpbyB0eXBlIGNncm91cAoocncsbm9zdWlkLG5vZGV2LG5vZXhlYyxy
ZWxhdGltZSxzZWNsYWJlbCxibGtpbykKY2dyb3VwMiBvbiAvdG1wL2Nncm91cF91bmlmaWVkIHR5
cGUgY2dyb3VwMgoocncscmVsYXRpbWUsc2VjbGFiZWwsbWVtb3J5X3JlY3Vyc2l2ZXByb3QpCiMg
Y2QgL3RtcC9jZ3JvdXBfdW5pZmllZC8KIyBscwpjZ3JvdXAuY29udHJvbGxlcnMgIGNncm91cC5t
YXguZGVwdGggIGNncm91cC5tYXguZGVzY2VuZGFudHMgIGNncm91cC5wcm9jcwogY2dyb3VwLnN0
YXQgIGNncm91cC5zdWJ0cmVlX2NvbnRyb2wgIGNncm91cC50aHJlYWRzICBjcHUucHJlc3N1cmUK
IGNwdS5zdGF0ICBpby5wcmVzc3VyZSAgbHRwICBtZW1vcnkucHJlc3N1cmUKCiMgY2QgbHRwLwoj
IGxzCmNncm91cC5jb250cm9sbGVycyAgY2dyb3VwLmV2ZW50cyAgY2dyb3VwLmZyZWV6ZSAgY2dy
b3VwLm1heC5kZXB0aAogY2dyb3VwLm1heC5kZXNjZW5kYW50cyAgY2dyb3VwLnByb2NzICBjZ3Jv
dXAuc3RhdCAgY2dyb3VwLnN1YnRyZWVfY29udHJvbAogY2dyb3VwLnRocmVhZHMgIGNncm91cC50
eXBlICBjcHUucHJlc3N1cmUgIGNwdS5zdGF0ICBkcmFpbiAgaW8ucHJlc3N1cmUKIG1lbW9yeS5w
cmVzc3VyZSAgdGVzdC00MTU5MgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
