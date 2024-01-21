Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0862C47422
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 17:24:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB5D03CE24C
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 18:24:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 477F13CB2A9
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 18:24:37 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 60C18100126B
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 18:24:36 +0100 (CET)
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-dc22ae44595so1973156276.1
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 09:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705857875; x=1706462675;
 darn=lists.linux.it; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=snMWskyqUdl0O7NRtTKjUI7iqtPJz7QtelGMlXizfKM=;
 b=27b0FbEm40uUkEKAMmM5gun4odGtg8+kdhSvJQqhIG8ieHOC8qxcb/1KkeIqPsktJa
 SwaF+5PUNldH+rxxuUgTZIpl5bPtjfWnUayP0VkpDfcQEkAoxCOcb7sTM2JDtWMUn2sg
 VH3uMO7P01/4dgiy//03I4yBz+6jxP8zldyZGBiYEmNT0QSd1W9jlNTzpNETyW9iDr1H
 O0tZ6m721GBi9o4IfLhlpmZYsEd32ZA8fjwHCdTRv8hHIWovEgt6QdX3naJgaji/P5PC
 G36bruQRCN82+Z897NL26B0jxQAgj63TXRd5Z9UbeNJ6OGA3WrIzMRPRDkyBeeSvXNko
 9qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705857875; x=1706462675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=snMWskyqUdl0O7NRtTKjUI7iqtPJz7QtelGMlXizfKM=;
 b=FUf3I1uZcLfdHDSxRICyKQMQSsRHnbfUJeuzAWn54BuLxSgbJPgz620JRjqH+vXG/a
 A6V5VrRmZdt/bHyGCbBYddxmuxHYHf95+VVKLjVqMxlHqIS2CgYmuV7ysBlE+qbR9hmw
 hLIBdPUCcbsFZDla+UMHjm9wEyckaiGC4TdWx+LUiqjkYf1CJrqmxcXjDcA7f+2P2BsX
 wY/OknyWkwZQaKlb5QcQTTUD4/XATdU/JwcSwL5kh+yAnFLSHML/v6ZAcovHXG7CB0mL
 wHuNgQmy8xQF+V49C/oqLaIq3USvdHzWRApFB26Ag6gOfDvJ5dNw0zKS0FsdRc9sfO6+
 cY/w==
X-Gm-Message-State: AOJu0Yz4ZfLroBS6deUVfrCgS8m3RFNsIpMSrwEfjvTCUg61PCRd3lpy
 3xcVMWZ25suWuCG0YHo18hjmd8I4bteysOh4UM+rWa//3eYM4itxIwlEXpQZpAze35HYZvbak9u
 4zID+aVeF82KJdOEqb/Lq7+BH5SyWNqjlLaqZ
X-Google-Smtp-Source: AGHT+IGrK1KlJx8OJe/SsExcwnyiY0RZvxQ8XmHADUiWcEAjxBPYAf3y6wxGAsHruHPo3OlWiS8UNeyvqMDGySeP5w4=
X-Received: by 2002:a05:6902:543:b0:dc2:1ffe:92b3 with SMTP id
 z3-20020a056902054300b00dc21ffe92b3mr1186359ybs.81.1705857874878; Sun, 21 Jan
 2024 09:24:34 -0800 (PST)
MIME-Version: 1.0
References: <20240116031728.2500892-1-liwang@redhat.com>
 <CAM0EoMns7T+JkJquM21_9S0FUoPdPQxw1Ebg4jBPLer5cOF+uQ@mail.gmail.com>
 <CAEemH2cZ9KLCb=yaVvLzC6uo0m8+vmw7ic4KNTFe7K5TauV3dA@mail.gmail.com>
In-Reply-To: <CAEemH2cZ9KLCb=yaVvLzC6uo0m8+vmw7ic4KNTFe7K5TauV3dA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 21 Jan 2024 12:24:23 -0500
Message-ID: <CAM0EoMmy6t_D+xjyQt+Co2tH3kN5tvT9kqPqFeQH=w+DjZcV9g@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tcindex01: fix compilation errors due to missing
 TCA_TCINDEX_ constants
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
Cc: Jakub Kicinski <kuba@kernel.org>, Victor Nogueira <victor@mojatatu.com>,
 Pedro Tammela <pctammela@mojatatu.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGkgV2FuZywKCk9uIFdlZCwgSmFuIDE3LCAyMDI0IGF0IDc6NDnigK9QTSBMaSBXYW5nIDxs
aXdhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBIaSBKYW1hbCwKPgo+IEphbWFsIEhhZGkgU2Fs
aW0gPGpoc0Btb2phdGF0dS5jb20+IHdyb3RlOgo+Cj4+IFBhcmRvbiBteSBpZ25vcmFuY2UgLSB3
aGF0IGlzIHRoaXMgdHJlZT8gSSBkb250IHJlY2FsbCBzZWVpbmcgdGhpcwo+PiBhbnl3aGVyZS4g
SWYgeW91IHB1bGwgdWFwaSBoZWFkZXJzIGZyb20gdGhlIGtlcm5lbCBvbiB5b3VyIHRyZWUgeW91
Cj4+IGNhbiBjYXRjaCB0aGVzZSBkZWxldGlvbnMgc29vbmVyLi4KPgo+Cj4gVGhpcyBpcyBhbiBM
VFAgKExpbnV4IFRlc3QgUHJvamVjdCkgdGhhdCB0YXJnZXRzIHRlc3RpbmcgdGhlIExpbnV4IGtl
cm5lbC4KPgo+IFRoZSBjb21taXQgODJiMjU0NWVkOWEgeW91IG1hZGUgaW4ga2VybmVsIHJlY2Vu
dGx5IGNhdXNlZCB0aGUgTFRQCj4gY29tcGlsZSBicmVhayBvbiB0aGUgbGF0ZXN0IG1haW5saW5l
IGtlcm5lbC4gU28gdGhhdCdzIHdoeSBJIENDZWQgeW91Cj4gaW4gdGhpcyBwYXRjaC4KPgo+IEJU
VywgSXQgd291bGQgYmUgaGVscGZ1bCB0byBydW4gc29tZSBMVFAgdGVzdCBjYXNlcyBhZ2FpbnN0
IG91ciBrZXJuZWwtcGF0Y2gKPiBiZWZvcmUgc2VudCB0byBMS01MIG5leHQgdGltZS4KPgoKVGFr
ZSBhIGxvb2sgYXQgTklQQS4gSXQgYWxsb3dzIGRpc3RyaWJ1dGVkIHRlc3RpbmcgLSBtZWFuaW5n
IHlvdSBjYW4KcnVuIExUUCB0ZXN0cyBvbiB5b3VyIG1hY2hpbmUocykgYW5kIHRoZW4gc2hhcmUg
dGhlIHJlc3VsdHMuIFRoZXJlJ3MgYQpkb2MgaGVyZToKaHR0cHM6Ly9kb2NzLmdvb2dsZS5jb20v
ZG9jdW1lbnQvZC8xVFBsT092djBHYW9wQzNmelctd2lxOFRZcGw3cmg4VmxfbW1hbDB1RmVKYy9l
ZGl0Ckl0IGN1cnJlbnRseSBpdCB3b3JrcyBvbiBrZXJuZWwgYnJhbmNoIHNuYXBzaG90cyAtIHdo
aWNoIGF0IG1pbmltYWwKd291bGQgaGF2ZSBjYXVnaHQgdGhlIGlzc3VlIHlvdSBmaXhlZCBvbiBM
VFAgd2l0aCB0Y2luZGV4LgoKY2hlZXJzLApqYW1hbAoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
