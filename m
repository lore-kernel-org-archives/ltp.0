Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0695CCA0FED
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 12:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757076597; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=nm52eBPkr4ivafwQTdCg2ZJHqSOa0xRfoJx851WOLmM=;
 b=K5U9g0JIrs9DhfZQwp/73l6FGSyCBztsL+Pc2ohgQATfsykMRrL2/Be2XgcQTFXhJ3Y5t
 mwhSc5W1NILxMuoxHHfdiNMg2AnqbNRiseCu+g3ZgUxemRG5vUSeZI91bh0V5CZD3teEdJi
 pZRbRC8j+HWOzLc5JsMgDWFHP1dHmBQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 480473CD4ED
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 14:49:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FB063C84D3
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 14:49:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 50C0E2009D5
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 14:49:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757076573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6b11jbV71oCdYLLkek2NCfyiEtna/K2xkZePbvrUZa0=;
 b=IBhAj6stRpxdBz2wuN7F456HrLXav7HAImD8FxgQAWg8TDBQ+vg6gkeGBZ833AOuKUvPLE
 sPr5IyorYy1gCRzMTkTVt3gjDUZ4Rfk1DrGdXJ1rNXB+i5IM4ujqDMZkE22bNhVad+zp2l
 CM+PFbY8LMjagOsdbnyW/eQPsIN4xgs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-AmsD2a3bPdKDFtj5QP_v0Q-1; Fri, 05 Sep 2025 08:49:29 -0400
X-MC-Unique: AmsD2a3bPdKDFtj5QP_v0Q-1
X-Mimecast-MFC-AGG-ID: AmsD2a3bPdKDFtj5QP_v0Q_1757076568
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3276af4de80so2929660a91.1
 for <ltp@lists.linux.it>; Fri, 05 Sep 2025 05:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757076568; x=1757681368;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6b11jbV71oCdYLLkek2NCfyiEtna/K2xkZePbvrUZa0=;
 b=d178X37j2yI6IRRL6JNw2s49Ehh1vyapQR64eW+c85rJGHqZuIIlN1HVjSxyxfVGlo
 8fxjif5K/zU89Py4LyicuFCmFTa6vRQ98xT29yOy0JWeX9t9MqNEzm9/ZR1+EV2yWLSu
 nHgghwWYIrlFXolgtLgyedHWtCGhpB4Wkqi3vhxwKqYvqOZTzjXvSgWcoSahqN7Sl8Wn
 ynhSAn6wFQM/fdDaoLjavhER8NaJtZ86zKLNXA4mFMjGe7lUy4470G/y2i4XuNdEZDU0
 er3MRYfq+JM8lZ0Si9BlaRE+sE6Udnz3Bx2VCNzloV+ysq3rwtcg5O1K0krHgFOGtNO3
 Ugdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBoWul8Kfe3bphnPx9lWo2cdwEJVjbmI96Vb7iMgz71uCgHXWlfO9KCfg40uuUol+dI2U=@lists.linux.it
X-Gm-Message-State: AOJu0YwkcvlzT52HF5wfECLY6myR9FMyV8Q9dOPL22qC1QkSUOLpp0yq
 f4T3drJ3RWuu/+Xp7DWd0haEXa29lUtHBxyCbNtEiINVrqopjrCRJknQNG7GyWmAPo3DNRqSvvc
 OKz2yfM4Bvkrwv7RTolr1C2rtO0yvRnlkpYbQZ44Nduh/HJLETJTeCF8HJ53Yv4GMaj5BP5IXOE
 5hplrFWonx5SJL82kwH0uclbAlMT0=
X-Gm-Gg: ASbGncsW5LCfH0zcPdC/LzWMFkDKXlvFmjGcyyiJ1NFhuGH5Rub3zDPcqtbt9OhAO8z
 sqQiS36DBFK58rE69oxQsm5wxNTxjrEjm03MrfyIhT7ThVGTNFPejJC6u3glOszWO+ZK0j1VTTj
 67VeZfJBKF/efM6kUiUq/DNw==
X-Received: by 2002:a17:90b:35cc:b0:32b:d8a1:44f8 with SMTP id
 98e67ed59e1d1-32bd8a14695mr1744054a91.22.1757076568302; 
 Fri, 05 Sep 2025 05:49:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/8u2rU9UFCDmaEoB7jlJhf7CPp1dIzsKL9iOKfyMyuSvMX465IUIlk3oKkaUhApZLqNw9CkqcPdJkEJwsiNE=
X-Received: by 2002:a17:90b:35cc:b0:32b:d8a1:44f8 with SMTP id
 98e67ed59e1d1-32bd8a14695mr1744035a91.22.1757076567827; Fri, 05 Sep 2025
 05:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250904102609.133359-1-liwang@redhat.com>
 <20250904110018.GA56668@pevik> <aLl7ConfYPBglqhx@rei.lan>
 <CAEemH2f=6MRZTk95ZctgPG-MKdyw5oK9WNgh3Tm8WNHQ9NcW_g@mail.gmail.com>
 <aLmwLn9RDo2qmk7K@yuki.lan>
 <CAEemH2cK3idxQHmpSGs8VuWSOosHrFNYK=ic0s90B_WNh7AVjw@mail.gmail.com>
 <CAEemH2cXQ=_F=Bq5CZN1j=SbeceDCKCdZh4jDdGSz-x10XZLtA@mail.gmail.com>
 <aLqq9o9Dkbhr957V@yuki.lan>
 <CAEemH2cRQVq4N-SdRTFEuUzyUbqfCVg_mpQ58t1BeaNSO9NuvQ@mail.gmail.com>
 <aLrYUvN7UMpd64iJ@yuki.lan>
In-Reply-To: <aLrYUvN7UMpd64iJ@yuki.lan>
Date: Fri, 5 Sep 2025 20:49:15 +0800
X-Gm-Features: Ac12FXx9BUl_m0dDo0rIaU6qbDrgKsBNOS-WYUCpUrbThUzLAxNfFHw0JexHpbk
Message-ID: <CAEemH2c_26s1ojGnStAxzGHVEhbVTpM0dL3PU=Od=G90gPvnGg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8b0vDQ8BJOl1C5yhaJ4pVgj_JuWa8X_FY8PUC0BveTI_1757076568
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] sched_football: synchronize with kickoff flag
 to reduce skew
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBTZXAgNSwgMjAyNSBhdCA4OjMx4oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+IFRoaXMgaGFzIGltcHJvdmVkIHNvbWV0aGluZywgYnV0
IHN0aWxsIG9ic2VydmVzIHNwb3JhZGljIGZhaWwgb24gUkhFTAo+IHN0b2NrCj4gPiBrZXJuZWwu
Cj4gPiBIb3dldmVyLCBib3RoIHRoZSBSSEVMIFJULWtlcm5lbCBhbmQgdGhlIG1haW5saW5lIHY2
LjE3LXJjNCBzdG9jayBrZXJuZWwKPiA+IHBhc3MuCj4KPiBNYXliZSBhZGQgYSBzaG9ydCB1c2xl
ZXAoKSBiZWZvcmUgdGhlIHJlZmVyZWUgc2V0cyB0aGUga2lja29mZl9mbGFnIHNvCj4gdGhhdCB0
aGUgc3lzdGVtIGhhcyBtb3JlIHRpbWUgdG8gc2h1ZmZsZSBwcm9jZXNzZXM/Cj4KClRoYW5rcywg
SSBkbyBtYW51YWxseSB0ZXN0IGFuZCBub3cgYWxtb3N0IDEvMjAgdGltZXMgZmFpbC4KQW5kIHRo
ZSB3b3J0aCBtZW50aW9uaW5nIHRoYXQgdGhpcyBpcyBub3QgYSBuZXcgZmFpbHVyZSBpbiBSSEVM
IGtlcm5lbHMuClRob3NlIHBhdGNoZXMgc2luY2UgdGhlIGJhcnJpZXIgaGF2ZSBhbHJlYWR5IG11
Y2ggaW1wcm92ZWQgdGhlIHRlc3QKcmVzdWx0IGZyb20gUkhFTCBzaWRlLiBBdCBsZWFzdCBmcm9t
IFJIRUwgUlQta2VybmVsIEkgZGlkbid0IG9ic2VydmUKZmFpbCBhbnkgbW9yZS4KClNvICxhcyBs
b25nIGFzIHRoZSBwYXRjaCB3b3JrcyBvbiB0aGUgU1VTRSBrZXJuZWwgdG8gcmVzb2x2ZSBpdCdz
IE5FVwpwcm9ibGVtLApJIHRoaW5rIHdlIGNhbiBtZXJnZS4KCi0tIApSZWdhcmRzLApMaSBXYW5n
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
