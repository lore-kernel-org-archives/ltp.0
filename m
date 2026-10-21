Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1A5606A321
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=lk9+nKrp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y5oVoY5X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792597383; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/gQmIyJclHlgd3M1ya1pUzjJmMI0OQkKzZLV6YavvwU=;
 b=lk9+nKrpPlMbYcBlWWl1u/FXYYzmHRdtt7hDEn8eaosvEz87SOu99rA/MVlEJ8GShpKhT
 D5SB0s7CDgv44SS7s7xzvNjgvKGSIX+zBMBLYPNyCyay14Sg+mXj9cpbBIaq1cbxL6773Rd
 ytPLSqNEjT9B1cOIlj5xV0eMn62Sisk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E91903CFD1D
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 17:43:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BAB653CFD22
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 17:42:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1D2DA14002D1
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 17:42:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792597357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6D84ATBUkh0/lss4V0+XNxSQov4+c73xhRe6eGCgX8=;
 b=Y5oVoY5X8WjRHpx+As98zCCwhXWE4JJ4CMNsMYYOVFqFmxubfGc4k2mWf7aD+qDhvBBSJg
 YGvrh8TjXT+gboaGbM892lwNKsDEvGlw3p8PFRM0dd7g9of2+fbZN6iAoRaIS+ukvATSvr
 jn2jtVCu+cML3M7jBqSdtzLmjJM9Nrc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-pvWwokx3NmKDv6_KVV0HBw-1; Wed, 21 Oct 2026 11:42:35 -0400
X-MC-Unique: pvWwokx3NmKDv6_KVV0HBw-1
X-Mimecast-MFC-AGG-ID: pvWwokx3NmKDv6_KVV0HBw_1792597354
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48c430f0f01so744382f8f.1
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 08:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792597354; x=1793202154;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a6D84ATBUkh0/lss4V0+XNxSQov4+c73xhRe6eGCgX8=;
 b=iw9iY/0KS0CW1vJnZ8mBYJiR4kCQZD4wk5qOlVfQUXNs3BvxUE+jPekkIzYG6jWvDD
 9Pc7c0hRNE7oJRsbHjla7AZgE+THhRuSUHu14krWe/TIFXwQWxjIJg2PTsBkvvij7ECb
 CkKVrG4EDZT0vwkdy2oCVwSrlQFoNXOEchS5F+xun0HXQh72vEN7wRiZaVF5liVslQfS
 5vpI9eTlAKtZ6YdWHTLquSapQFH+PUzZAUa58z3LFPLR043XOPywa4twNhKvr4YgTw9Y
 wGhaKctGUWcbwP5CEQDVqvIW2CGAU9pgeReI+4+mpWNNNQkUpLyQXcbfLVAO2suxmHXq
 4Pqw==
X-Gm-Message-State: AFq9FYKfPME5/4JHz2xD1t66g35KHy4uIF44IlPdS8eoaNTUeJyGsFfk
 ngVSIC5D9k1UdKPx4BzdwxxoMRAxu123tY+UxtDHoeDztlNxylCyOwmZlHkuHLT5BHPX6C3U161
 THk8ly7tbVi7at6l3pY0CDq+7Llhk1nL+P/WrKmq31faMEMu6kDqVYMpsE0xUlo9HihLQ0f++5K
 GZPDEYZdwBS4khzzeA3kuDbi5AMJM=
X-Gm-Gg: AYBFou0awFNle8Kcp55h8xSPRwMV3Ghzf6ZxMI9PixqfiscTKrlYA6LTWFWoIywb9iC
 ABQuYnCKE6/xd424t6Spv9r/ygLHAp8z7aoOoM1NH6aYEBzI3gt6SZ10mQTn7YYf1+lRtJSWJV5
 1eQfDx6sne08g8qe2MtFk27YCekQqVgAuNq/TaA2FY7wKXqcY9oly9syg=
X-Received: by 2002:a05:600c:3b22:b0:4a1:dade:f049 with SMTP id
 5b1f17b1804b1-4a1fdd19f80mr53060245e9.15.1792597354425; 
 Wed, 21 Oct 2026 08:42:34 -0700 (PDT)
X-Received: by 2002:a05:600c:3b22:b0:4a1:dade:f049 with SMTP id
 5b1f17b1804b1-4a1fdd19f80mr53059755e9.15.1792597354007; Wed, 21 Oct 2026
 08:42:34 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <89fe77f22e26d912865c8b8266b150ba7459bfae.1792413314.git.jstancek@redhat.com>
 <49034ca7-baa3-40bc-801b-ee1e91908b9c@suse.com>
In-Reply-To: <49034ca7-baa3-40bc-801b-ee1e91908b9c@suse.com>
Date: Wed, 21 Oct 2026 17:42:17 +0200
X-Gm-Features: AclHuK-WL1bqTazSp_3OigWRWRSuv3n2VHsaso-VL6stMUDPvYDwmjE0zb8D2CE
Message-ID: <CAASaF6zciGtM4beMr10rtTXaopPsA5dak-HNHBJiLqL6sqdYBA@mail.gmail.com>
To: Avinesh Kumar <avinesh.kumar@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SjJbq4IcEOFIfmARYGi9ICVp9k04DpekSpQ2Pk6IsWk_1792597354
X-Mimecast-Originator: redhat.com
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nextafter01: Check exact results and convert to
 new API
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBPY3QgMTksIDIwMjYgYXQgMTE6MDjigK9QTSBBdmluZXNoIEt1bWFyIDxhdmluZXNo
Lmt1bWFyQHN1c2UuY29tPiB3cm90ZToKPgo+IEhpLAo+Cj4gPiArLypcCj4gPiArICogVmVyaWZ5
IHRoYXQgbmV4dGFmdGVyKCkgcmV0dXJucyB0aGUgbmV4dCByZXByZXNlbnRhYmxlIGRvdWJsZSBp
biB0aGUKPiBuaXQ6Cj4gOm1hbnBhZ2U6YG5leHRhZnRlcigzKWAKClB1c2hlZCB3aXRoIHRoaXMg
YWRkZWQuCgo+Cj4gUmV2aWV3ZWQtYnk6IEF2aW5lc2ggS3VtYXIgPGF2aW5lc2gua3VtYXJAc3Vz
ZS5jb20+Cj4KPiBSZWdhcmRzLAo+IEF2aW5lc2gKPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
