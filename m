Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E162F5A8A5
	for <ltp@archiver.kernel.org>; Mon, 20 Apr 2026 18:03:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A66EC3E594D
	for <ltp@archiver.kernel.org>; Mon, 20 Apr 2026 20:02:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A92D33E2682
 for <ltp@lists.linux.it>; Mon, 20 Apr 2026 20:02:38 +0200 (CEST)
Received: from mail-dl1-x1244.google.com (mail-dl1-x1244.google.com
 [IPv6:2607:f8b0:4864:20::1244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E91BC2009C0
 for <ltp@lists.linux.it>; Mon, 20 Apr 2026 20:02:32 +0200 (CEST)
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-12c1a170a50so3959019c88.0
 for <ltp@lists.linux.it>; Mon, 20 Apr 2026 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776708151; x=1777312951; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7KK8qbhpGwuIYXyhGWTE28GWoC3fcWY9/bvn+eBxydM=;
 b=lr1+fn47wfkXWlIUIW0CRdaqIRJNbAkGwLhiYbjDl6xNZVXUrHUSh52iBvuG9mxETQ
 GrPsX2rP6Mb8otDHG17udQ0LpEqHMZR5SgezK2ln+X31BN417ORUt5G2zjay9r5XwLb/
 B4OtbtTs3/1Ip6fMZ31T2ctse7OkmDAvMwIqp15K26IlngkmSFVRvWj03OuW7X4SsVPh
 2p0T7HLqcxMFzQ/jYx0vWXjHPLnMq7JUjXrCCgxi2nhwLR2TgQd1MQwkdpDRXd2LdAAu
 B/cSrOh2kVn7I/m3jo5OTdRu2MS78nmGQIQha41Si26agJ+CAui9P72SR81clOT4I3CH
 oaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776708151; x=1777312951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7KK8qbhpGwuIYXyhGWTE28GWoC3fcWY9/bvn+eBxydM=;
 b=O4zaLHcSu7vDH25HOcPC/DPkdciRzsaADVoEUaXXHDfFClO8PaIR4bgjv4bBGCWq98
 Cz3nrvw/3N+2iaQuSVdTo/8Xts0/w+YQTVLBW2xVmhxqWDf/YEGJ8zEcEesOFUcnUffe
 3+21Cs4uRGupZzyMN9l7kFd6G9nTTlTj2lXhmEl41guXzOw3ZYRhoF+7kTitI3XoLijK
 jya/2YANtwFKWsiP2hBkg3H5oGF+qW2ocKabU97zG3UKpPoNKMyyosZkZMb8D61wyogZ
 tF1nDIJOC3649vE5dPi0ZGrgyJeHSE6lkzc7VkXlcWZtUNEabZS8/jLPAqQp2J+x24mK
 J0wQ==
X-Gm-Message-State: AOJu0Yxv1lIvrCtsRkajdtN0b7w5ekLCaHwQgLXquyS1Q79w+KqN2plZ
 PrbUhTDU/A5Xis8VOMvuFp5pqqVjbfGGIT+VrcpAOgdhZ7fRkmfbVME0
X-Gm-Gg: AeBDiet8zGfk7X4Z/XArkT928/qvgZeRCqliX37DDAfAWNLRGz38SQ2E+JwSwwQkDY+
 +LIu8+pMhpFyFu80WMw4a6oWDSRPdgVML2eWq5nz3+rSqnF9dRapWAdF03CC4XJZxmOuyMnBTQP
 aNFQ1H9+SRivx0KXjryP62zYv+4MpGgmPYJZrosikkZ4XbxhwxCHP9iEkFOAM5se/llaunMz4Oy
 6+rJhX6n63EOOnhOJtUEFBBefz3aAXhJnMl0YD4CEtyLe4M4A0W8TMcDAjP9Tag2CcPe0ZbcLJ2
 HrIVv90MDrTh14BaOq/VYDqS3vIoHiFC+VcqluvQKcYpIcY6oo3SqBDWA7E1Aa6FIrM+eTtn3dx
 w6FTxYWwC667UHHS0NB53YKazh7tAf96+hsz+UuCKA1dt6Hcjl5EdGYXtMYC7OIbcCBD2JLl3MN
 i3AxPni6yPOq0jmaqhLoiSqYDanjKjhOuad9ZiOv/4GdXK6WWKKn40trbcKp7NTk4/lY2sQ743+
 PcX87SS3qGjZVH3xQBeWrI5jIYht1xoUkXMtRenYivBeJQZ
X-Received: by 2002:a05:701b:2611:b0:12c:87b9:94b2 with SMTP id
 a92af1059eb24-12c87b99785mr1517122c88.28.1776708150958; 
 Mon, 20 Apr 2026 11:02:30 -0700 (PDT)
Received: from
 runnervmeorf1.jamfeejwbfzehnan2h2wbwda3a.dx.internal.cloudapp.net
 ([52.234.41.66]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c749c422csm15884901c88.3.2026.04.20.11.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 11:02:30 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 20 Apr 2026 18:02:28 +0000
Message-ID: <20260420180228.3934-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420163433.44646-1-mdoucha@suse.cz>
References: <20260420163433.44646-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/io_uring: Add IORING_OP_READ/WRITE constants
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

SGkgTWFydGluLAoKT24gTW9uLCAyMCBBcHIgMjAyNiAxODozNDowOSArMDIwMCwgTWFydGluIERv
dWNoYSB3cm90ZToKPiBsYXBpL2lvX3VyaW5nOiBBZGQgSU9SSU5HX09QX1JFQUQvV1JJVEUgY29u
c3RhbnRzCgo+ICsjaWZuZGVmIEhBVkVfSU9SSU5HX09QX1JFQUQKPiArI2RlZmluZSBJT1JJTkdf
T1BfUkVBRCAyMgo+ICsjZW5kaWYKPiArCj4gKyNpZm5kZWYgSEFWRV9JT1JJTkdfT1BfV1JJVEUK
PiArI2RlZmluZSBJT1JJTkdfT1BfV1JJVEUgMjMKPiArI2VuZGlmCgpBQ19DSEVDS19ERUNMUygp
IGRlZmluZXMgSEFWRV9ERUNMX0lPUklOR19PUF9SRUFEICh0byAwIG9yIDEpLCBub3QKSEFWRV9J
T1JJTkdfT1BfUkVBRC4gVGhlICNpZm5kZWYgZ3VhcmQgaXMgYWx3YXlzIGVudGVyZWQsIG1ha2lu
ZyB0aGUKY29uZmlndXJlLmFjIGNoZWNrcyBkZWFkIGNvZGUuIFVzZSAjaWYgIUhBVkVfREVDTF9J
T1JJTkdfT1BfUkVBRCBhbmQKI2lmICFIQVZFX0RFQ0xfSU9SSU5HX09QX1dSSVRFIOKAlCBzZWUg
aW5jbHVkZS9sYXBpL2xhbmRsb2NrLmggZm9yIHRoZQplc3RhYmxpc2hlZCBwYXR0ZXJuLgoKLS0t
Ck5vdGU6CgpPdXIgYWdlbnQgY29tcGxldGVkIHRoZSByZXZpZXcgb2YgdGhlIHBhdGNoLiBUaGUg
ZnVsbCByZXZpZXcgY2FuIGJlCmZvdW5kIGF0OiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVz
dC1wcm9qZWN0L2x0cC1hZ2VudC9hY3Rpb25zL3J1bnMvMjQ2ODIwMTUwNjMKClRoZSBhZ2VudCBj
YW4gc29tZXRpbWVzIHByb2R1Y2UgZmFsc2UgcG9zaXRpdmVzIGFsdGhvdWdoIG9mdGVuIGl0cwpm
aW5kaW5ncyBhcmUgZ2VudWluZS4gSWYgeW91IGZpbmQgaXNzdWVzIHdpdGggdGhlIHJldmlldywg
cGxlYXNlCmNvbW1lbnQgdGhpcyBlbWFpbCBvciBpZ25vcmUgdGhlIHN1Z2dlc3Rpb25zLgoKUmVn
YXJkcywKTFRQIEFJIFJldmlld2VyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
