Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226CEC83F3E
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 08:57:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A4273CB7C2
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 10:56:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDD463CB794
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 10:56:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4B59A200BC5
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 10:56:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C3A5F211CE;
 Tue,  5 Sep 2023 08:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693904207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZOR2pV8xjDBGwXlMZG9MHvD6llKWksv/aBBeZECurlI=;
 b=0uRXUAoxLTvwRfxAq8mrr3xVEUBR9JBs/GgBfJOsEWiwAaYhogoTcrDtv53SmhkCESeNbd
 al2w1U0BGqC+DmA0rvWAWCXqYgqpXRSTaHvsWyoIUDoeziFGOIwNeqRgkqu7nMfvT/nUfx
 oOPd4dOIfdcqsC55MpqI+7wOapMhBuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693904207;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZOR2pV8xjDBGwXlMZG9MHvD6llKWksv/aBBeZECurlI=;
 b=48TOENp/vL2zgFn6659GO7Dwd1p/A+euAeieOvEmCh454jSqu/LKnriFYMmmo59O2XYlGI
 MFe56I7+J+s+krDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B117413499;
 Tue,  5 Sep 2023 08:56:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ENb/KU/t9mR/HgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 05 Sep 2023 08:56:47 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  5 Sep 2023 10:57:25 +0200
Message-ID: <20230905085726.11038-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] doc: Add .min_swap_avail
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

U2lnbmVkLW9mZi1ieTogQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+Ci0tLQogZG9jL2Mt
dGVzdC1hcGkudHh0ICAgICAgICAgICAgICB8IDEzICsrKysrKysrKy0tLS0KIGRvYy90ZXN0LXdy
aXRpbmctZ3VpZGVsaW5lcy50eHQgfCAgMSArCiAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZG9jL2MtdGVzdC1hcGkudHh0IGIv
ZG9jL2MtdGVzdC1hcGkudHh0CmluZGV4IGY2OTI5MDllMi4uMzczYWYwY2Q0IDEwMDY0NAotLS0g
YS9kb2MvYy10ZXN0LWFwaS50eHQKKysrIGIvZG9jL2MtdGVzdC1hcGkudHh0CkBAIC0yMzI4LDEx
ICsyMzI4LDE2IEBAIGJvdGggVjEgYW5kIFYyIGZlYXNpYmxlLgogU29tZSB0ZXN0cyByZXF1aXJl
IG1vcmUgdGhhbiBzcGVjaWZpYyBudW1iZXIgb2YgQ1BVLiBJdCBjYW4gYmUgZGVmaW5lZCB3aXRo
CiBgLm1pbl9jcHVzID0gTmAuCiAKLTEuMzkgUmVxdWlyZSBtaW5pbXVtIHNpemUgb2YgTWVtQXZh
aWxhYmxlIGZvciBhIHRlc3RjYXNlCi1+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgorMS4zOSBSZXF1aXJlIG1pbmltdW0gbWVtb3J5IG9yIHN3
YXAgc2l6ZSBmb3IgYSB0ZXN0Y2FzZQorfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgorCitTb21lIHRlc3RzIHJlcXVpcmUgYXQgbGVhc3Qgc2l6
ZShNQikgb2YgZnJlZSBSQU0gb3IgU3dhcC4KKworVG8gbWFrZSBzdXJlIHRoYXQgdGVzdCB3aWxs
IHJ1biBvbmx5IG9uIHN5c3RlbXMgd2l0aCBtb3JlIHRoYW4gbWluaW1hbAorcmVxdWlyZWQgYW1v
dW50IG9mIFJBTSBzZXQgYC5taW5fbWVtX2F2YWlsID0gTmAuCiAKLVNvbWUgdGVzdHMgcmVxdWly
ZSBtb3JlIHRoYW4gc3BlY2lmaWMgc2l6ZShNQikgb2YgTWVtQXZhaWxhYmxlLiBJdCBjYW4gYmUg
ZGVmaW5lZAotd2l0aCBgLm1pbl9tZW1fYXZhaWwgPSBOYC4KK1NpbWlsYXJpbHkgZm9yIHRlc3Rz
IHRoYXQgcmVxdWlyZSBjZXJ0YWluIGFtb3VudCBvZiBmcmVlIFN3YXAgdXNlCitgLm1pbl9zd2Fw
X2F2YWlsID0gTmAuCiAKIDEuNDAgVGVzdCB0YWdzCiB+fn5+fn5+fn5+fn5+fgpkaWZmIC0tZ2l0
IGEvZG9jL3Rlc3Qtd3JpdGluZy1ndWlkZWxpbmVzLnR4dCBiL2RvYy90ZXN0LXdyaXRpbmctZ3Vp
ZGVsaW5lcy50eHQKaW5kZXggNmQxYTY5MTY1Li5lMmVkYzY1OGEgMTAwNjQ0Ci0tLSBhL2RvYy90
ZXN0LXdyaXRpbmctZ3VpZGVsaW5lcy50eHQKKysrIGIvZG9jL3Rlc3Qtd3JpdGluZy1ndWlkZWxp
bmVzLnR4dApAQCAtMzcwLDYgKzM3MCw3IEBAIGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0
LXByb2plY3QvbHRwL3dpa2kvU2hlbGwtVGVzdC1BUElbU2hlbGwgVGVzdCBBUEldLgogfCAnLm1p
bl9rdmVyJyB8ICdUU1RfTUlOX0tWRVInCiB8ICcubWluX21lbV9hdmFpbCcgfCBub3QgYXBwbGlj
YWJsZQogfCAnLm1udF9mbGFncycgfCAnVFNUX01OVF9QQVJBTVMnCit8ICcubWluX3N3YXBfYXZh
aWwnIHwgbm90IGFwcGxpY2FibGUKIHwgJy5tbnRwb2ludCcsICcubW50X2RhdGEnIHwgJ1RTVF9N
TlRQT0lOVCcKIHwgJy5tb3VudF9kZXZpY2UnIHwgJ1RTVF9NT1VOVF9ERVZJQ0UnCiB8ICcubmVl
ZHNfY2dyb3VwX2N0cmxzJyB8IOKAkwotLSAKMi40MS4wCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
