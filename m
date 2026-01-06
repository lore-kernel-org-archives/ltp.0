Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8306C47BC4
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 08:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767688786; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=mgxSth5cojCYfPugyDmWkWEVEyYkqSbRsUscip/g6KA=;
 b=RR43mtnnzttI6iA5KFsIJ3h51pNgvLr/+v03WHONeM9AHD/+JNhU5IwivyaLK9OHseNxw
 wnN6qia4vuPc4z/96RcC1Jv4vhBlBBmdTVmzfvZq0ullZdMGotnNF2QZAd9kuRpnf6wiW9E
 I2kIrDJPRFA7a7ryeI9+4g5WRh2HiaI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 253043C1028
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 09:39:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34EE83C04BA
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 09:39:21 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 53C911400162
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 09:39:21 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47d63594f7eso4308575e9.0
 for <ltp@lists.linux.it>; Tue, 06 Jan 2026 00:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767688761; x=1768293561; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hU9IgCnQmra50ll2WhtxPjpG1+W+ydkQATmVsxHhw0A=;
 b=GQgIDzgpM7iHd7d7kKE7FMLnuFsJtX5uZGYRpIbChFfpbLCtBHi0DZ8ZfG98f7VgYM
 gdAtmzKhFwyi51OoXzE+5XJbxy02Eoj4xXpNfqsiN3uS5+8uzW/6xH9lLu2clHEy+lNg
 rZPJZd4I2eXKA4hlOeAB3sKrpF16Csbn1oawTsHW6UR/8GW0XOqGORz/fPykV/XAtnqG
 c+HRucgWxvW1+ArhB2rsZ8ve9swIp9w/9xxUJTfKwDzcBrAf5rKt7+NvDpccUDNjKafV
 wzlBs8Rl+cGJxAWfOO5esujbIpQ9Ywu4MkrtYRgAOUC3O+CsO0mA+au+G8Eub8GtDhr7
 Wc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767688761; x=1768293561;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hU9IgCnQmra50ll2WhtxPjpG1+W+ydkQATmVsxHhw0A=;
 b=BABkLOIkXACkfqj6hJ3482ie1kKNJ71kUEygJov1MdCh31k3mUkdZxULNgfzlcIBVQ
 QKByPNa5cjTsTjsy/28a8Rt/MiR55hy56/XiH9q93wBgyX4Bxd6kT7rIZz4xIcLzlaCK
 W9XDSnl3g3Q5zTf9jMznq5PU7yi4yBTf/Xy03II6r+qmYbQ9bM10YINTflmAszvIgVe8
 cdEUQmwqSpITYPRJuKx224SsIyC0q5bmByUWe+1anx1isZSynFVisy3mlX7F26s3RAkz
 0fFq/58uxsP4RCMcZFeeYpgIWJ9keaPL88QEST18UOj2M+a01fMNsjMvoFBPzX0d301F
 hPbg==
X-Gm-Message-State: AOJu0YyZW6E7DfvEvgreR8P/Eu94c/u+v8WWG8DDcdIFE0ueq2l7L8+U
 Bde1xYn9+M4wvTUTjhRCcD6MyJJIfIkrtMMlIAVuiLvoiCNWGF7LfUnYBkXv/KnpsEZUvB7bvHV
 MATJKI20=
X-Gm-Gg: AY/fxX4Cn0swcZ2MrVzTSHxY+APEGSLi9efu1jrrkF/yJwT5TO5/8Xk7ioa82orJYUl
 BF3LE5IYilTMYl983tyP1XLJuz/+gBsDKUaOd/4fSFUVFdWxSuH1oocjbwtSddBnk42XWQNYkVF
 Uu1BrHCxYlwZcPyPYA1WRlTungLVfasfp2xTVJtx390J3cfVw1aHlMJIo9oS1kvq0DWXD/j8QJm
 DobUJ830JLjogF/KKkGc2OXcHV91VYxlKvuy9V+bj5UsCNo3DPWmbur4F3mNA9EXVZxGoBZkpII
 5cjtmscGjqpLKkuCU6pS3/qUgvTdtS+/zIRwHZOaiSUDeAdVz/t1nvotBlzEHza7WuMVJpDFh/C
 gHAXyIN/rl3r/ZBD7XIzubv+opRr5XNJmka71C336O5txnlxeMFwButGbNEYnX4yuQMmWyaI1zZ
 7SAtiL/B3UU7LM
X-Google-Smtp-Source: AGHT+IEshw23MehBMwtPEHXrQapW/cnaxLHnwlZyfL8DuokyZ2fsok1jYSiw8MA4AA4YTwync1/Plw==
X-Received: by 2002:a05:600c:a415:b0:477:a1a2:d829 with SMTP id
 5b1f17b1804b1-47d818bd5e4mr9389825e9.13.1767688760712; 
 Tue, 06 Jan 2026 00:39:20 -0800 (PST)
Received: from localhost ([88.128.90.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6f0e15sm29124505e9.10.2026.01.06.00.39.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 00:39:20 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 06 Jan 2026 09:39:19 +0100
Message-Id: <DFHDD9J0CNI4.Z9KH3N2E6TMW@suse.com>
To: "Wei Gao" <wegao@suse.com>
X-Mailer: aerc 0.18.2
References: <20251022020509.6945-1-wegao@suse.com>
 <20251224085004.10267-1-wegao@suse.com>
 <DFGO5L1W0DED.2G5VJDLYAJM7L@suse.com>
 <aVyrMIHYwxncN6J_@autotest-wegao.qe.prg2.suse.org>
In-Reply-To: <aVyrMIHYwxncN6J_@autotest-wegao.qe.prg2.suse.org>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] io_submit04: Add test case for RWF_NOWAIT flag
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgo+ID4gV2UgcmV0dXJuIGJlY2F1c2UgaWYgaW9fc3VibWl0KCkgZmFpbHMgdGhlcmUncyBu
b3RoaW5nIHRvIGRvIG1vcmUuCj4gdHN0X3JlcyhUQlJPSyB3aWxsIHRyaWdnZXIgZXJyb3Igc3Vj
aCBhcyA6Cj4gbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgJy9ob21lL3dlZ2FvL2x0cC9saWIn
Cj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4uLy4uLy4uLy4uL2luY2x1ZGUvdHN0X3Rlc3QuaDoy
MCwKPiAgICAgICAgICAgICAgICAgIGZyb20gaW9fc3VibWl0MDQuYzoxNDoKPiBpb19zdWJtaXQw
NC5jOiBJbiBmdW5jdGlvbiDigJhydW7igJk6Cj4gLi4vLi4vLi4vLi4vaW5jbHVkZS90c3RfY29t
bW9uLmg6ODA6MzI6IGVycm9yOiBzaXplIG9mIHVubmFtZWQgYXJyYXkgaXMgbmVnYXRpdmUKPiAg
ICA4MCB8ICAgICAgICAgZG8geyAoKHZvaWQpc2l6ZW9mKGNoYXJbMSAtIDIgKiAhIShjb25kaXRp
b24pXSkpOyB9IHdoaWxlICgwKQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF4KPiAuLi8uLi8uLi8uLi9pbmNsdWRlL3RzdF9jb21tb24uaDo4Mzo5OiBub3RlOiBpbiBl
eHBhbnNpb24gb2YgbWFjcm8g4oCYVFNUX0JVSUxEX0JVR19PTuKAmQo+ICAgIDgzIHwgICAgICAg
ICBUU1RfQlVJTERfQlVHX09OKGNvbmRpdGlvbikKPiAgICAgICB8ICAgICAgICAgXn5+fn5+fn5+
fn5+fn5+fgo+IC4uLy4uLy4uLy4uL2luY2x1ZGUvdHN0X3Rlc3QuaDo3MToxNzogbm90ZTogaW4g
ZXhwYW5zaW9uIG9mIG1hY3JvIOKAmFRTVF9SRVNfU1VQUE9SVFNfVENPTkZfVERFQlVHX1RGQUlM
X1RJTkZPX1RQQVNTX1RXQVJO4oCZCj4gICAgNzEgfCAgICAgICAgICAgICAgICAgVFNUX1JFU19T
VVBQT1JUU19UQ09ORl9UREVCVUdfVEZBSUxfVElORk9fVFBBU1NfVFdBUk4oXAo+ICAgICAgIHwg
ICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+Cj4gaW9fc3VibWl0MDQuYzo2MzoxNzogbm90ZTogaW4gZXhwYW5zaW9uIG9m
IG1hY3JvIOKAmHRzdF9yZXPigJkKPiAgICA2MyB8ICAgICAgICAgICAgICAgICB0c3RfcmVzKFRC
Uk9LIHwgVFRFUlJOTywgImlvX3N1Ym1pdCgpIHJldHVybnMgJWxkLCBleHBlY3RlZCAlbGQiLAo+
ICAgICAgIHwgICAgICAgICAgICAgICAgIF5+fn5+fn4KPiBtYWtlOiAqKiogWy4uLy4uLy4uLy4u
L2luY2x1ZGUvbWsvcnVsZXMubWs6NDg6IGlvX3N1Ym1pdDA0XSBFcnJvciAxCj4gLWJhc2g6IC4v
aW9fc3VibWl0MDQ6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKPgo+IFNvIGkgc3VwcG9zZSB3
ZSBuZWVkIHVzZSAidHN0X2JyayhUQlJPSyIgd2l0aG91dCByZXR1cm4sIGNvcnJlY3Q/CgpZZXMs
IHNvcnJ5LCBjaHJpc3RtYXMgdmFjYXRpb24gaXMgaGl0dGluZyA6LSkKCi0tIApBbmRyZWEgQ2Vy
dmVzYXRvClNVU0UgUUUgQXV0b21hdGlvbiBFbmdpbmVlciBMaW51eAphbmRyZWEuY2VydmVzYXRv
QHN1c2UuY29tCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
