Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3D6CAC592
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 08:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758530966; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=n73t5knMIA1t6qKWkAWWhbrGySLqT7CZp0OhN87QJJc=;
 b=RpGsxlpcRNzKOVirccS8d9VMq1Up6qH4YPvdxS1LjDrAaycdKycwLPOZcW9DYzHL0EaxJ
 /ZRVjhZvwmpNdmQIPJ0+ciW/RQD+fbRWTXIBG4fyh6LdVbuNms2SDAvrX6uupVUVGUwF08C
 FWkKaVUoG3ghS05rPfuR30U/4WMXQDk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96A6B3CDE3F
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 10:49:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4FB53C2566
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 10:49:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 053B52002B6
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 10:49:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758530943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oZd9V9Y2EEKY5IxR5FyfaxsYVNQkaYubUl6ixtbI9ag=;
 b=DlzE3Dql9DBvNfv3yGzNKC2k+NMv52mA9v+X8ohp9AHbPoXSBnuB6DENw6fnHZHAhxdMwX
 ia0lqBtYiHdoN9uBsPgLUCLknPGN2+4ma+g0qwzJsI5VYvt1fp8aoCkfHgIWoohpSsqc9s
 OdKp7QFqHM0Ij4PhqtKhGyGNXUspS8E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-4n9tKU9DO-u8ZxZIPrq_jQ-1; Mon, 22 Sep 2025 04:49:01 -0400
X-MC-Unique: 4n9tKU9DO-u8ZxZIPrq_jQ-1
X-Mimecast-MFC-AGG-ID: 4n9tKU9DO-u8ZxZIPrq_jQ_1758530940
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3f3c118cbb3so2110423f8f.3
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 01:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758530940; x=1759135740;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oZd9V9Y2EEKY5IxR5FyfaxsYVNQkaYubUl6ixtbI9ag=;
 b=sraCmgjz36BwSMm87MQNHR8Ozp+fYJ1uHevjrNjjY74jGGymtP7P+cMnwX/INJfg7a
 4qBHf4j8AfqO3/Rb6BCfwIUGs8GOLG4L4fL07QM9ejpZkbtMBT4dgOHpOi8ewLCSpoQH
 c776YU6liQxhfa0RbOrRxSzeBtUFFeUa6ahdQXN/QGEEXR+eNYKlh/U9+7YcWCSHTuKL
 eC5IY081iKEeiNjz6VvHVSI4s7oG2t1AS6q7QH7t1DS0iQXED2OeDOD5YGZt9D9Sq1U1
 NY/KsYkJXEUGVWrF8aFhUiyMZqkZlBBYOCJ5Tx46rAtk4uuX2XrwF80VzbtfUxFnrflw
 msmQ==
X-Gm-Message-State: AOJu0YwhfK7Zo5bfAEy+qryRjoV/OZR9U30sq86a0SM2VdJMumXUdHUK
 C9AKJ2SpxpFUxUQ/aOmVekh2XCCOwKXXL+iowURZs9cjW0bK8lE6kz7Ipb/Ls834RPmp3DqLCbV
 Sdkrg5VIO/RU5eAFcfAZ06k7NA8lok0lVv/B0i2/6R0IkevC0fzoUV1upDuTjUw8KbBKZJTSU9j
 UBxht9wINR9wdd8Tdt2pqR+DdPOno=
X-Gm-Gg: ASbGncvzenEV35KmJ8M3FXFxXdCuskeiQGobouwBAfkoPVC5dstRf/zN5tsS1YgF7CJ
 wzGJT/09Z7gcEAUkq32UxEpZoDSsnYHk9xKozxLqfUKCu95RRQe5mTztmtMztCRQQmJeFcp9fT+
 3R+zpWt4NSS15Rz9lXfwqUJbbhslaxwoGD+I686d4LX1DGAWqR3XUw+5zpsD1iAwa2vi0kkd10I
 JgjbpNlt/mgcgVVGytV5Qc=
X-Received: by 2002:a05:6000:2209:b0:3ec:e285:546b with SMTP id
 ffacd0b85a97d-3ee8558132dmr9655631f8f.50.1758530940423; 
 Mon, 22 Sep 2025 01:49:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0oN+MkrTjguyVNTk9WuYNN9rS80YHJPRTVl0k7n1lz5mzbVmSyvFgmAJKNRGePRK5HBrkJ1zVyPuhRHgE69U=
X-Received: by 2002:a05:6000:2209:b0:3ec:e285:546b with SMTP id
 ffacd0b85a97d-3ee8558132dmr9655601f8f.50.1758530939976; Mon, 22 Sep 2025
 01:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250917102737.GA336745@pevik>
In-Reply-To: <20250917102737.GA336745@pevik>
Date: Mon, 22 Sep 2025 10:48:43 +0200
X-Gm-Features: AS18NWAuwVr4slZGXafeNfXFwhzq-3tRdTB01zeXDEZ9Zvzfp004J6TUHFseZ3g
Message-ID: <CAASaF6yjdrLLVnehESx1TjsrB_z48nmN_2i585GPfkG3Vvg15Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QJIHfGw_imCG4J5ukKEonJsBzPat8__9hJRwUStP4ME_1758530940
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] 'nobody' user for testing
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: Betty Zhou <bettyzhou@google.com>, ltp@lists.linux.it,
 Edward Liaw <edliaw@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBTZXAgMTcsIDIwMjUgYXQgMTI6MjfigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cj4KPiBIaSwKPgo+IEkgZm91bmQgYSBzZXR1cCBidWcgb24gTFRQIElNQSB0
ZXN0cyBpbWFfY29uZGl0aW9uYWxzLnNoIGFuZAo+IGltYV9tZWFzdXJlbWVudHMuc2ggd2hpY2gg
dXNlICdzdWRvJyAod2l0aCB1c2VyICdub2JvZHknKS4gV2UgaGF2ZSBtYW55IEMgdGVzdHMKPiBp
biBMVFAgd2hpY2ggdXNlICdub2JvZHknIHVzZXIgc29tZWhvdywgYnV0IHRoZXkgZG9uJ3QgYWN0
dWFsbHkgZXhlY3V0ZQo+IGFueXRoaW5nIHdpdGggdGhpcyBhY2NvdW50LiBJTUhPIHRoZXNlIGFy
ZSB0aGUgb25seSB0ZXN0cyB3aGljaCBleGVjdXRlIHdpdGggJ3N1ZG8nCj4gKHBsZWFzZSBkb3Vi
bGUgY2hlY2sgbWUpLgo+Cj4gJCBnaXQgZ3JlcCAtbCBub2JvZHkgdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy8gfCB3YyAtbAo+IDE2MAo+Cj4gQmVjYXVzZSBvbiBuZXdlciBzeXN0ZW1zIChJIGNo
ZWNrZWQgVHVtYmxld2VkLCBGZWRvcmEsIERlYmlhbikgJ25vYm9keScgYWNjb3VudCB1c2UKPiAv
dXNyL3NiaW4vbm9sb2dpbiB3aGljaCBwcmV2ZW50cyBsb2dnaW5nLCB3ZSAxKSBlaXRoZXIgbmVl
ZCB0byBjaGFuZ2UgYWNjb3VudAo+IHRvIHVzZSBiYXNoIChhbmQgcmVzdG9yZSBpdCBiYWNrIGFm
dGVyIHRlc3RpbmcpIG9yIDIpIGNyZWF0ZSBhIGRlZGljYXRlZCB1c2VyCj4gZm9yIHRlc3Rpbmcu
IEknZCB0cnkgdG8gdXNlICd1c2VyYWRkJyBhbmQgY2hlY2sgd2l0aCBncmVwIC9ldGMvcGFzc3dk
IGlmIHRoZQo+IHVzZXIgaXMgbm90IGFscmVhZHkgZGVmaW5lZC4KPgo+IEkgdGVuZCB0byB1c2Ug
MiksIGFkZCBpdCBvbmx5IHRvIElNQSB0ZXN0cyAodG8gaW1hX3NldHVwLnNoKS4gQnV0IEkgY291
bGQKPiBwdXQgc29tZSBtb3JlIGdlbmVyaWMgY29kZSB0byB0c3RfdGVzdC5zaCBzbyB0aGF0IGl0
IGNhbiBiZSByZXVzZWQgYnkgb3RoZXIKPiB0ZXN0cyBpbiB0aGUgZnV0dXJlLiBXRFlUPwoKSGkg
UGV0ciwKCkRvIHRob3NlIHRlc3RzIHN0YXJ0IHVuZGVyIHJvb3QgdXNlcj8gSSdtIHRoaW5raW5n
IHdlIHdyaXRlIG91ciBvd24KKG11Y2ggc2ltcGxlcikKdmVyc2lvbiBvZiAic3VkbyIsIHRoYXQg
anVzdCBjaGFuZ2VzIHVpZC9naXQgYmFzZWQgb24gcGFyYW1ldGVycyBhbmQKZXhlY3V0ZXMgd2hh
dGV2ZXIgd2UgZ2l2ZSBpdC4KCkphbgoKPgo+IEFsc28sIGFzIHdlIGhlYXZpbHkgdXNlICdub2Jv
ZHknIGFscmVhZHkgSSdtIG5vdCBzdXJlIGlmIGl0J3Mgd29ydGggdG8gYm90aGVyCj4gd2l0aCBw
dXR0aW5nIGVudmlyb25tZW50IHZhcmlhYmxlIGFsbG93aW5nIGEgZGlmZmVyZW50IHVzZXIuIE5v
Ym9keSBzbyBmYXIgY29tcGxhaW5lZCwKPiBldmVuIEFPU1AgZm9sa3Mgc2VlbSB0byBiZSB1c2Vk
IEMgdGVzdHMgd2hpY2ggdXNlICdub2JvZHknIChlLmcuIGZjaG1vZDA2LmMgaXMKPiBjb21waWxl
ZCBbMV0gYW5kIG5vdCBkaXNhYmxlZCBbMl0pLgo+Cj4gQWxzbywgd2UgYWdyZWVkIHdpdGggQ3ly
aWwsIHRoYXQgaXQnZCBiZSBnb29kIHRvIGNvbnZlcnQgdGhlc2UgMiBJTUEgdGVzdHMgdG8KPiB1
c2UgJ3N1JyBpbnN0ZWFkIG9mICdzdWRvJyBiZWNhdXNlICdzdScgaXMgc2ltcGxlciB0aGFuICdz
dWRvJyAoYWx0aG91Z2ggd2hlbgo+IHRlc3Rpbmcgd2l0aCByYXBpZG8gWzNdIG5vbmUgb2YgdGhl
bSB3b3JrcyBvdXQgb2YgdGhlIGJveCkuCj4KPiBbMV0gaHR0cHM6Ly9hbmRyb2lkLmdvb2dsZXNv
dXJjZS5jb20vcGxhdGZvcm0vZXh0ZXJuYWwvbHRwLysvcmVmcy9oZWFkcy9tYWluL2FuZHJvaWQv
QW5kcm9pZC5icAo+IFsyXSBodHRwczovL2FuZHJvaWQuZ29vZ2xlc291cmNlLmNvbS9wbGF0Zm9y
bS9leHRlcm5hbC9sdHAvKy9yZWZzL2hlYWRzL21haW4vYW5kcm9pZC90b29scy9kaXNhYmxlZF90
ZXN0cy50eHQKPiBbM10gaHR0cHM6Ly9naXRodWIuY29tL3JhcGlkby1saW51eC9yYXBpZG8KPgoK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
