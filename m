Return-Path: <SRS0=fXc4=OT=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030F1C433EF
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 08:40:27 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A72861407
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 08:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A72861407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6DC23C6E9B
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 10:40:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F354D3C4EE7
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 17:56:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 192D41A00F22
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 17:56:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1202D2027F
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632844581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tmrdO+yPQEA56zpEhfSZW2AeMvp8XbJtO5Zg7fYhiBg=;
 b=jh7xH1iouOID0TAJ/JCSsablKFVR515yrneBQV+fCW3J46qMPoTa02lhf5V6xyC+fYwOkO
 YNrakKqPz9WwCkHz/iGmw1FK+DFRoeh4/spKRF8uhqWXkakizp1nwvIV0GL8f2kaLtPCa0
 51R2SUQ2L66E2AGyZlscuNZAz4oXOIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632844581;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tmrdO+yPQEA56zpEhfSZW2AeMvp8XbJtO5Zg7fYhiBg=;
 b=5wBWZz3TKGiTHjbg+I/XzblNmGlLFBWdOe4IsSvKtnloIdPRNYNSSRaM4ILevb0cBQxfLL
 K4hGWWZayPcXK7Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB4BB13CCC
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 15:56:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id al13NyQ7U2FnegAAMHmgww
 (envelope-from <asmorodskyi@suse.de>)
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 15:56:20 +0000
From: Anton Smorodskyi <asmorodskyi@suse.de>
To: ltp@lists.linux.it
Organization: SUSE Linux
Message-ID: <19307e07-fee3-aaaa-b934-452917478a36@suse.de>
Date: Tue, 28 Sep 2021 17:56:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Sep 2021 10:40:04 +0200
Subject: [LTP] getrusage04 issues on virtualized env
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

SGkgYWxsLAoKSSBhbSBydW5uaW5nIExUUCB0ZXN0cyBpbiBkaWZmZXJlbnQgcHVibGljIGNsb3Vk
IHByb3ZpZGVycyAoIEF6dXJlICwgR0NFCiwgQW1hem9uICkuIEN1cnJlbnRseSBoYXZlIGlzc3Vl
cyB3aXRoIGdldHJ1c2FnZTA0IHRlc3Qgb24gQXp1cmUgLiBMb29rcwpsaWtlCmh0dHBzOi8vZ2l0
aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2NvbW1pdC8zZTBiYTlhYTZhN2M5MzNhNzRk
NjUyNWNhNjkwMjg5OTJhM2JhMWFkCm5vdCBiZWhhdmVzIGFzIGV4cGVjdGVkID09PiB0ZXN0IGlz
IG5vdCBhY3R1YWxseSBza2lwcGVkIG9uIEF6dXJlIGFuZApmYWlsaW5nIGJlY2F1c2Ugb2Yga25v
d24gaW5zdGFiaWxpdHkgb2YgdGhlIHRlc3RzIGluIHZpcnR1YWwgZW52aXJvbm1lbnRzIDoKCnNo
LTQuNCMgZ2V0cnVzYWdlMDQ7IGVjaG8gY21kLWV4aXQtNzc0LSQ/CmdldHJ1c2FnZTA0ICAgIDAg
IFRJTkZPICA6ICBFeHBlY3RlZCB0aW1lcnMgZ3JhbnVsYXJpdHkgaXMgNDAwMCB1cwpnZXRydXNh
Z2UwNCAgICAwICBUSU5GTyAgOiAgVXNpbmcgMSBhcyBtdWx0aXBseSBmYWN0b3IgZm9yIG1heCBb
dXNddGltZQppbmNyZW1lbnQgKDEwMDArNDAwMHVzKSEKZ2V0cnVzYWdlMDQgICAgMCAgVElORk8g
IDogIHV0aW1lOiAgICAgICAgMjUzOHVzOyBzdGltZTogICAgICAgICAgIDB1cwpnZXRydXNhZ2Uw
NCAgICAwICBUSU5GTyAgOiAgdXRpbWU6ICAgICAgICAzODEzdXM7IHN0aW1lOiAgICAgICAgMTkw
NnVzCmdldHJ1c2FnZTA0ICAgIDAgIFRJTkZPICA6ICB1dGltZTogICAgICAgIDYzMTd1czsgc3Rp
bWU6ICAgICAgICA2MzE3dXMKZ2V0cnVzYWdlMDQgICAgMCAgVElORk8gIDogIHV0aW1lOiAgICAg
ICAgNzQwN3VzOyBzdGltZTogICAgICAgIDYzMTd1cwpnZXRydXNhZ2UwNCAgICAwICBUSU5GTyAg
OiAgdXRpbWU6ICAgICAgICA4ODQ5dXM7IHN0aW1lOiAgICAgICAgODg0OXVzCmdldHJ1c2FnZTA0
ICAgIDAgIFRJTkZPICA6ICB1dGltZTogICAgICAgIDk1ODd1czsgc3RpbWU6ICAgICAgIDEyNzgz
dXMKZ2V0cnVzYWdlMDQgICAgMCAgVElORk8gIDogIHV0aW1lOiAgICAgICAgOTYzN3VzOyBzdGlt
ZTogICAgICAgMTYwNjJ1cwpnZXRydXNhZ2UwNCAgICAwICBUSU5GTyAgOiAgdXRpbWU6ICAgICAg
IDEwNzA5dXM7IHN0aW1lOiAgICAgICAyMTQxOHVzCmdldHJ1c2FnZTA0ICAgIDEgIFRGQUlMICA6
ICBnZXRydXNhZ2UwNC5jOjEzMzogc3RpbWUgaW5jcmVhc2VkID4gNTAwMHVzOgoKCkkgbWFudWFs
bHkgY2hlY2tlZCAic3lzdGVtZC1kZXRlY3QtdmlydCIgZXhlY3V0aW9uIG9uIFZNIGluIGF6dXJl
IGFuZCBpdApyZXR1cm5zICJtaWNyb3NvZnQiIGFzIGV4cGVjdGVkLiBEaWdnaW5nIGludG8gdHN0
X2lzX3ZpcnQgc291cmNlIGNvZGUKYW5kIGFyb3VuZCBhbHNvIGhhdmVuJ3QgYnJpbmcgYW55IGlk
ZWFzIHRvIG1lIDooCgpBbnkgaGludHMgaG93IHRvIGZvbGxvdyB1cCA/CgotLSAKQW50b24gU21v
cm9kc2t5aSA8YXNtb3JvZHNreWlAc3VzZS5jb20+ClFBIEVuZ2luZWVyClNVU0UgU29mdHdhcmUg
U29sdXRpb25zIEdlcm1hbnkgR21iSApNYXhmZWxkc3RyLiA1CjkwNDA5IE51cmVtYmVyZyBHZXJt
YW55CihIUkIgMzY4MDksIEFHIE7DvHJuYmVyZykKTWFuYWdpbmcgRGlyZWN0b3I6IEZlbGl4IElt
ZW5kw7ZyZmZlcgoKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
