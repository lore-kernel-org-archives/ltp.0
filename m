Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57892C4332F
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 14:02:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD5F43CDA43
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 15:02:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F34063C889D
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 15:02:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DBC78600781
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 15:02:06 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id C7D552254E;
 Mon,  7 Nov 2022 14:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667829725;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26JZm4pD0FnOHnSVjVGuHGqOK2HAl0erjxyBBv85UL4=;
 b=vz2bgywGJJTfgFBZaGL09k6sUXmC7hszi8JFWBDnGniUhly866mHnHZeUkcwZ6Iaqq9MYx
 1E6FfB2eVxa93uDm5/tcM0LnZ+GAfrHG8k6QNmleIxI3Jw1RF7QBitQ0GYuMGiJZlW7ZON
 CXVaA6/2BU4mk2WJutLiZ9YYnTUmwco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667829725;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26JZm4pD0FnOHnSVjVGuHGqOK2HAl0erjxyBBv85UL4=;
 b=p8Jnf9FvNH+YfEX6J1NJBOboPFO45mkzep/erzt5OYSYT+CrMUV2sIrHDSUAzM29qAkOVJ
 VhO2wYkXQfYiWoDA==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 2BD2C2C141;
 Mon,  7 Nov 2022 14:02:04 +0000 (UTC)
References: <1666856118-18962-1-git-send-email-zenghongling@kylinos.cn>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Hongling Zeng <zenghongling@kylinos.cn>
Date: Mon, 07 Nov 2022 13:54:27 +0000
Organization: Linux Private Site
In-reply-to: <1666856118-18962-1-git-send-email-zenghongling@kylinos.cn>
Message-ID: <87fseux3qc.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [LTP|PATCH] du: bug fix for testcase/du/du01.sh
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
Reply-To: rpalethorpe@suse.de
Cc: zhongling0719@126.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sCgpIb25nbGluZyBaZW5nIDx6ZW5naG9uZ2xpbmdAa3lsaW5vcy5jbj4gd3JpdGVzOgoK
PiBUaGUgcnVubHRwIGludGVyZmFjZSB0ZXN0IGZvciBjb21tYW5kIGR1IHJlcG9ydCBlcnJvciA6
Cj4gZHUwMSA5IFRGQUlMOiAnZHUgLWMnIGZhaWxlZAo+IGR1MDEgOSBUSU5GTzogTG9va2luZyBm
b3IgJ14xMFsyLTNdWzAtOV1bMC05XVtbOnNwYWNlOl1ddG90YWwnIGluOgo+IDQJLi90ZXN0ZGly
Cj4gNAkuL2Jhc2VkaXIKPiAxMDI1NgkuCj4gMTAyNTYJ5oC755So6YePCj4gZHUwMSAxMCBURkFJ
TDogJ2R1IC0tdG90YWwnIGZhaWxlZAo+Cj4gQWRkIHNsZWN0aXZlIGp1ZGdlbWVudCBmb3IgY2hp
bmVzZSBjb21tYW5kIGFuZCBmaXggdGhpcyBlcnJvci4KCkhvcGVmdWxseSB0aGlzIGhhcyBiZWVu
IGZpeGVkIGFscmVhZHkgYnkgc2V0dGluZyBMQ19BTEw9Qy4KCjlhY2RiZWQ2Y2UwZjBmOTk2YWU0
ZjhkYTU3Njk2ODcxODMyNjczNmMKdHN0X3Rlc3Quc2g6IE5vcm1hbGl6ZSB0aGUgbG9jYWxlCgpT
ZXQgdG8gc3VwZXJzZWRlZCBpbiBwYXRjaHdvcmsuCgo+Cj4gU2lnbmVkLW9mZi1ieTogemVuZ2hv
bmdsaW5nIDx6ZW5naG9uZ2xpbmdAa3lsaW5vcy5jbj4KPiAtLS0KPiAgdGVzdGNhc2VzL2NvbW1h
bmRzL2R1L2R1MDEuc2ggfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9jb21tYW5kcy9kdS9kdTAx
LnNoIGIvdGVzdGNhc2VzL2NvbW1hbmRzL2R1L2R1MDEuc2gKPiBpbmRleCA3OTc3ZmQ0Li5hOWM0
Mzc3IDEwMDc1NQo+IC0tLSBhL3Rlc3RjYXNlcy9jb21tYW5kcy9kdS9kdTAxLnNoCj4gKysrIGIv
dGVzdGNhc2VzL2NvbW1hbmRzL2R1L2R1MDEuc2gKPiBAQCAtNzQsNyArNzQsNyBAQCBjaGVjazI9
Il4xMFsyLTNdWzAtOV1bMC05XVtbOnNwYWNlOl1ddGVzdGZpbGUiCj4gIGNoZWNrMz0iXlwoMFx8
JHtwYWdlX3NpemV9XClbWzpzcGFjZTpdXVwuXC90ZXN0ZGlyXC90ZXN0c3ltbGluayIKPiAgY2hl
Y2s1PSJeMjBbNC02XVswLTldWzAtOV1bWzpzcGFjZTpdXVwuIgo+ICBjaGVjazc9Il4xMFs0LTVd
WzAtOV1bMC05XVx7NFx9W1s6c3BhY2U6XV1cLiIKPiAtY2hlY2s5PSJeMTBbMi0zXVswLTldWzAt
OV1bWzpzcGFjZTpdXXRvdGFsIgo+ICtjaGVjazk9Il4xMFsyLTNdWzAtOV1bMC05XVtbOnNwYWNl
Ol1dWyjmgLvnlKjph498dG90YWwpXSIKPiAgY2hlY2sxMT0iXjEwWzItM11bMC05XVswLTldW1s6
c3BhY2U6XV10ZXN0ZGlyXC90ZXN0c3ltbGluayIKPiAgY2hlY2sxND0iXjFbMCwxXU1bWzpzcGFj
ZTpdXVwuIgo+ICBjaGVjazE2PSJeMTBbMi0zXVswLTldWzAtOV1bWzpzcGFjZTpdXXRlc3RkaXJc
LyIKPiAtLSAKPiAyLjEuMAoKCi0tIApUaGFuayB5b3UsClJpY2hhcmQuCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
