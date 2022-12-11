Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B30EC4332F
	for <ltp@archiver.kernel.org>; Sun, 11 Dec 2022 22:30:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFE533CBEDA
	for <ltp@archiver.kernel.org>; Sun, 11 Dec 2022 23:30:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D1293C2B4D
 for <ltp@lists.linux.it>; Sun, 11 Dec 2022 23:30:37 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 01F001400197
 for <ltp@lists.linux.it>; Sun, 11 Dec 2022 23:30:37 +0100 (CET)
Received: by mail-lf1-x136.google.com with SMTP id j4so15729419lfk.0
 for <ltp@lists.linux.it>; Sun, 11 Dec 2022 14:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rFzXLk7PdcwwNVPB9kovQqxzOBw5SWjkNY++5a2BGNo=;
 b=XpO+1TBjfy/w76yOPOGBLWr7PdcHfZWm7VPCEM4WymjVUFyK6aHPi3o+kBOpvjLDc8
 chfMwoWFMnpatFzYiSg4KiLitlYCoHEloh7zJ9M0zZY2sxRNsAOuSGKpGTHAkuC1vzoW
 tXb4JZZAj7+hPfG3p5r+drcG6slhbefy2CU4+v+oYep4rbEL4R3JqzO1UqghLEaZdElj
 M6NKZ0pzlg5hLIwMSwNuyNHwshYvTdyS0AXjwaQfo1xa+JnzLXvygFDkS7A1f2pAVE+b
 Srg7wLqSDgsJUMbO54XdWhHdbyLk388YWd1CSqWW+dALQYnPxSNFCZT4irZ9mB8zL8Rx
 0h2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rFzXLk7PdcwwNVPB9kovQqxzOBw5SWjkNY++5a2BGNo=;
 b=KgKg5/lD7YzzNWMgLYxrtcXWbw4TNWk46jYtLkE0szCkXjKn8mwVgkCb18gP5H17ai
 qh0xoxv61mr8v/AAv49+lPUqzm8PehXVO19jrh8+xYt0T5Xksvbqon/GO5sf962q7T4m
 g5pph+HL+oC3ldfdb3nHn2SwY0U+QPwXu19tbTIb3NHkH29dvEdf3ToC8kIIlLnTY7Oj
 q0NrYxhQFurUjFgc8nznN2+O2LvnO59BnBJuJGuaoAsoiKfjNUXJPMCz33pJAqyxeEjf
 wPkogt0Wg8JuRPpZzcWgGoi2L5xQvP7Ci00Mr2yu0Q4TE4pYHJ8+cXzoYbmY5lL3Wr4K
 JAmA==
X-Gm-Message-State: ANoB5pkuzW7qg6TmduSxF69Bhzr12xjjdK73v6PVQQk5HdODwtr7M9Pl
 TG56TKEV/WMnPG27TRgwtaAyXxbqy0464KH3FkXlck7c
X-Google-Smtp-Source: AA0mqf5oWALuK2m66mA9NdHux13HlnS/0pL87+noEwberBGwVjMU7AAhokjyOFLZRZaAW/lMwS6lYSFIe072c6M2xlQ=
X-Received: by 2002:a19:7107:0:b0:4a8:e955:77e7 with SMTP id
 m7-20020a197107000000b004a8e95577e7mr25002234lfc.573.1670797835633; Sun, 11
 Dec 2022 14:30:35 -0800 (PST)
MIME-Version: 1.0
From: Xinkuan Yan <lucky33newman@gmail.com>
Date: Mon, 12 Dec 2022 06:30:22 +0800
Message-ID: <CAFQkDyZABHU38_LTvsv1eP8PvK4rHprfZrL45CYqMvav1-O8_A@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] Question about log format.
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8gbGlzdCwKCkknbSB0cnlpbmcgdG8gZG8gYSBjb25jaXNlIHBhcnNpbmcgb2YgdGhlIExU
UCByZXBvcnQuCgpJIGRvbid0IGhhdmUgbXVjaCBleHBlcmllbmNlIGFuZCBJJ20gbm90IGZhbWls
aWFyIHdpdGggTFRQLCBzbyBJJ20gZ29pbmcgdG8KdGFrZSAjbWF0aCBhcyBhbiBleGFtcGxlLCBm
b3IgaXQgaXMgbm90IGNvbXBsZXguCgpSdW4gdGVzdCBjb21tYW5kOgoKLi9sdHAg4oCTZiBtYXRo
IOKAk3EKCkkgaGF2ZSB0aHJlZSBxdWVzdGlvbnMgbm93LCAgdGFraW5nIHRoZSBvbmUtbGluZSBv
dXRwdXQgcmVzdWx0IGJlbG93IGFzIGFuCmV4YW1wbGU6CgpmbG9hdF9pcGVyYiAxIFRQQVNTOiBU
ZXN0IHBhc3NlZAoKMSwgSXQgaXMgY2xlYXIgdGhhdCBUUEFTUyBtZWFucyBpdCBwYXNzZWQsIGJ1
dCB3aGF0IGlzIHRoZSBudW1iZXIgMQpzdGFuZGluZyBmb3IuCgoyLCBXaHkgdGhpcyBsaW5lIHNo
b3dlZCB1cCB0d2ljZT8gKCBQUzogQmV0d2VlbiB0aGVzZSB0d28gbGluZXMgYXJlIG1hbnkKVElO
Rk8uKQoKMywgV2hlcmUgdG8gY2hlY2sgdGhvc2Ugb3V0IHB1dCBzdGFuZGFyZHMsIHRha2luZyB5
b2N0byBwYWNrYWdlIHRlc3QgYXMgYQpzbWFsbCBjb21wcmVoZW5zaW9uLCB0aGF0IHN0YW5kYXJk
IHdhcyAoIFBBU1N8RkFJTHxTS0lQKTogVGVzdCBpbmZvLiBIb3cgaXMKaXQgbGlrZSBpbiBMVFA/
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
