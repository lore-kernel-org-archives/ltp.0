Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69924CA0FF0
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 13:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756472529; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=CnEVT1sYGzSKAfqYlHe2JjqD5m/tl3WsHZJSTz/qz2c=;
 b=bTir+nNGMm966JBDu2uHRwhW9wWvTVmH2VHiffh++cejkMDGxSWD1n8IZ/YrZtSxTqbX/
 W0T/xy1enrRuaMNLfp1EahBD3hJBSaHHri3PunkIXgpmzjQ9J/CqloLHnsAZjSUEyF0gy84
 ZaIGJ5PrjonvASgbwoYX2YWvSFKM5hc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC7853CD169
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 15:02:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9142C3CD13C
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 15:01:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 25C591400997
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 15:01:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kg38OYZXPpcXpaQuCwdpdjQW9ILJ6QVIDgWiSdi2K/s=;
 b=KG36POJ8QwkixNUPIohghH6lQvUwqhMX/OUCSks/QVEWnhn6wbfL3S08PPI2EpoHLl6AoW
 aDsha4QKLyQ5RTW11rFHmAuoIk7KFv8LHo6pKpM9z8Gbv8DZfAunPcnj7nyxptd96jxJ5E
 m/d/lkfzUtdxKGRif8HWA5eduvczS6E=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-VAecK_3YOLSdnSW9iGOW6g-1; Fri, 29 Aug 2025 09:01:41 -0400
X-MC-Unique: VAecK_3YOLSdnSW9iGOW6g-1
X-Mimecast-MFC-AGG-ID: VAecK_3YOLSdnSW9iGOW6g_1756472500
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-24456ebed7bso29278895ad.0
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 06:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472500; x=1757077300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kg38OYZXPpcXpaQuCwdpdjQW9ILJ6QVIDgWiSdi2K/s=;
 b=ID1tjynZP4bYHB+AIA9IOY4OR00RWsqLc9+s24eyyYtM/l0sn9uTZfGBGfiWC9gpvd
 3A7s7YpzTVGHuHT74QfeKUl8Tu6FwcALq3B389XficUYS0lyU6odULVkJOZArYUMN3AV
 kNEBCiOCEeKy5ZpFAFZVHbcQ8eK+KQrRyUQMVjX0OiVmd9E2nOrVxRhf1TBn0/Xr/aFI
 2UKaoxhtybWkMbSweBtZQe910/iGXJM0ThMHwez4RdwwKaD/Soty1v/TU4SbaEgPl0LZ
 Gzq+4s3Q2jynTLVHrRMEcWwgch0nyVaByOrqOR7a3wV7QZg0QrNO6LW0luFZBSzVkWlZ
 1KGA==
X-Gm-Message-State: AOJu0Yx2YxChmfoyH1KMoFQo2KP0N2/HscVoYtQLai2in9jthgxFkAll
 MOn9JtHxjazWTsbgdGhd86Dm53193d5sH8vAiKL91sZkKgxEqXt2DJRhhTgXYtQ90Nc5MW1TlTl
 t3C+miAtUUqcCNN19hv3zMXuI/ErzF781VSR6M81+buBHLKgyxrnO+YSUMgZlvvPJWo6RCGanhx
 /IMcHMxHMLioQjTusFjA1QTlXUyxg=
X-Gm-Gg: ASbGncvumPttZ4GVKe5EAbFulcR5v0Rwq9JlljR69DMMmUM6oc16GaO6lnUE1IbHEr3
 wlTFFhEA2GKR82QOI8VNX4bv93QR1Bhqs/HEfGU1RV0Qvha3j5JL1k5hag7sgO+BwH3Nm4QmyDk
 COFtMBUxGJUHiY8S/ELqJqIg==
X-Received: by 2002:a17:902:db01:b0:231:9817:6ec1 with SMTP id
 d9443c01a7336-248753a26eemr179383495ad.17.1756472500274; 
 Fri, 29 Aug 2025 06:01:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJMXYq4zfxEBi4krr4XlvYyWxW+3IUu4q9Yu4Q40PJYJgdKj2OPDsKfJX/t+udq7lMkeexkDL6ypuQ46kW7y0=
X-Received: by 2002:a17:902:db01:b0:231:9817:6ec1 with SMTP id
 d9443c01a7336-248753a26eemr179380975ad.17.1756472498135; Fri, 29 Aug 2025
 06:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250630153205.19017-1-chrubis@suse.cz>
 <20250630153205.19017-2-chrubis@suse.cz>
In-Reply-To: <20250630153205.19017-2-chrubis@suse.cz>
Date: Fri, 29 Aug 2025 21:01:25 +0800
X-Gm-Features: Ac12FXwk-qRGaIDVEGOPcL0eYkn8-mnEHcbuOYLJWTtqBtTo4PT7hLh03Vr8mPc
Message-ID: <CAEemH2dBMvswRiuwPB4_uAr5zkYb2NRWyTjz9t1eLi_12KHdcg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iTBarBmGeRKllTiEV6aglOGVCMJQCFrZKicMd4Shd1I_1756472500
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/2] syscalls/statmount06: Fix and enable the test
 on FUSE
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

T24gTW9uLCBKdW4gMzAsIDIwMjUgYXQgMTE6MzHigK9QTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cgo+IFJlcG9ydGVkLWJ5OiBKYW4gUG9sZW5za3kgPGphcG9AbGludXgu
aWJtLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4K
PgoKUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKCi0tIApSZWdhcmRz
LApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
