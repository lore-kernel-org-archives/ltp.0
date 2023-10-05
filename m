Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D60BE9370C
	for <ltp@archiver.kernel.org>; Thu,  5 Oct 2023 13:45:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0749C3CD9D9
	for <ltp@archiver.kernel.org>; Thu,  5 Oct 2023 15:45:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05B963CB48E
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 15:45:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 253DD60192B
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 15:45:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE0891F890;
 Thu,  5 Oct 2023 13:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696513507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cazzJuGC9cY3DDS9MpIm4osq40PAFG1F4vziZjhqdao=;
 b=jYFPrCPlgJ5HtOKNrdsU2OkZIJ6qtLYSQptajw425oaOmFjnb3x6g+SRJUh4odpL6YoM3n
 jsRBrSfnQmpWGlMXFP3tQiv8uKF+nUmxbOUvermV9+3PcgYrFgkEQqOUU4lWM3H7MwxERG
 N9GCLEDhZvZPy+Atx3kZYiE4jNuwD+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696513507;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cazzJuGC9cY3DDS9MpIm4osq40PAFG1F4vziZjhqdao=;
 b=VxTlAwNBE1oejLXVz035GJ/NUC/DLhX9491jVq0sGJp9pG5MDe+qjXWEHBRynFQGWYdk3C
 6+GNPKEi7HnB22DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8391139C2;
 Thu,  5 Oct 2023 13:45:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 71zhL+O9HmUsFwAAMHmgww
 (envelope-from <mkittler@suse.de>); Thu, 05 Oct 2023 13:45:07 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Thu,  5 Oct 2023 15:45:04 +0200
Message-ID: <20231005134504.3828-1-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Fix memcontrol tests under Tumbleweed
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

VGhlc2UgdGVzdHMgdXNlIGBhbGxfZmlsZXN5c3RlbXNgIGluIGNvbWJpbmF0aW9uIHdpdGgKYGRl
dl9taW5fc2l6ZWAgd2hpY2ggZG9lcyBub3Qgd29yayBvbiBUdW1ibGV3ZWVkIGFzIGl0IHJlc3Vs
dHMKaW46CgpgYGAKdHN0X3Rlc3QuYzoxNjQ0OiBUSU5GTzogPT09IFRlc3Rpbmcgb24geGZzID09
PQp0c3RfdGVzdC5jOjEwOTk6IFRJTkZPOiBGb3JtYXR0aW5nIC9kZXYvbG9vcDAgd2l0aCB4ZnMg
b3B0cz0nJyBleHRyYSBvcHRzPScnCkZpbGVzeXN0ZW0gbXVzdCBiZSBsYXJnZXIgdGhhbiAzMDBN
Qi4K4oCmCnRzdF90ZXN0LmM6MTEwNTogVEJST0s6IG1rZnMueGZzIGZhaWxlZCB3aXRoIGV4aXQg
Y29kZSAxCmBgYAoKVGhpcyBpcyBsaWtlbHkgYSBsaW1pdGF0aW9uIGludHJvZHVjZWQgaW4gbmV3
ZXIga2VybmVsIHZlcnNpb25zLgoKSW5jcmVhc2luZyBgZGV2X21pbl9zaXplYCB0byAzMDAgZml4
ZXMgdGhlIHRlc3RzLiBJbgpgbWVtY29udHJvbDAzYCBhbmQgYG1lbWNvbnRyb2wwNGAgdGhlIGBk
ZXZfbWluX3NpemVgIHNldHRpbmcKY2FuIGJlIGRyb3BwZWQgY29tcGxldGVseS4KClNpZ25lZC1v
ZmYtYnk6IE1hcml1cyBLaXR0bGVyIDxta2l0dGxlckBzdXNlLmRlPgotLS0KIHRlc3RjYXNlcy9r
ZXJuZWwvY29udHJvbGxlcnMvbWVtY2cvbWVtY29udHJvbDAyLmMgfCAyICstCiB0ZXN0Y2FzZXMv
a2VybmVsL2NvbnRyb2xsZXJzL21lbWNnL21lbWNvbnRyb2wwMy5jIHwgMSAtCiB0ZXN0Y2FzZXMv
a2VybmVsL2NvbnRyb2xsZXJzL21lbWNnL21lbWNvbnRyb2wwNC5jIHwgMSAtCiAzIGZpbGVzIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3Rj
YXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cvbWVtY29udHJvbDAyLmMgYi90ZXN0Y2FzZXMv
a2VybmVsL2NvbnRyb2xsZXJzL21lbWNnL21lbWNvbnRyb2wwMi5jCmluZGV4IDE2NTYxNzZiNi4u
MGQ5M2FiZDllIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL21lbWNn
L21lbWNvbnRyb2wwMi5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cv
bWVtY29udHJvbDAyLmMKQEAgLTEzNCw3ICsxMzQsNyBAQCBzdGF0aWMgc3RydWN0IHRzdF90ZXN0
IHRlc3QgPSB7CiAJLnRjbnQgPSAyLAogCS50ZXN0ID0gdGVzdF9tZW1jZ19jdXJyZW50LAogCS5t
b3VudF9kZXZpY2UgPSAxLAotCS5kZXZfbWluX3NpemUgPSAyNTYsCisJLmRldl9taW5fc2l6ZSA9
IDMwMCwKIAkubW50cG9pbnQgPSBUTVBESVIsCiAJLmFsbF9maWxlc3lzdGVtcyA9IDEsCiAJLmZv
cmtzX2NoaWxkID0gMSwKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMv
bWVtY2cvbWVtY29udHJvbDAzLmMgYi90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL21lbWNn
L21lbWNvbnRyb2wwMy5jCmluZGV4IGJjNzI2ZjM5NS4uOWM2YzgwOGUwIDEwMDY0NAotLS0gYS90
ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL21lbWNnL21lbWNvbnRyb2wwMy5jCisrKyBiL3Rl
c3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cvbWVtY29udHJvbDAzLmMKQEAgLTIzOSw3
ICsyMzksNiBAQCBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7CiAJLmNsZWFudXAgPSBj
bGVhbnVwLAogCS50ZXN0X2FsbCA9IHRlc3RfbWVtY2dfbWluLAogCS5tb3VudF9kZXZpY2UgPSAx
LAotCS5kZXZfbWluX3NpemUgPSAyNTYsCiAJLm1udHBvaW50ID0gVE1QRElSLAogCS5hbGxfZmls
ZXN5c3RlbXMgPSAxLAogCS5za2lwX2ZpbGVzeXN0ZW1zID0gKGNvbnN0IGNoYXIgKmNvbnN0W10p
ewpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9tZW1jZy9tZW1jb250
cm9sMDQuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cvbWVtY29udHJvbDA0
LmMKaW5kZXggYzk2M2ExY2Q4Li4zMmEwYjlmZDQgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJu
ZWwvY29udHJvbGxlcnMvbWVtY2cvbWVtY29udHJvbDA0LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5l
bC9jb250cm9sbGVycy9tZW1jZy9tZW1jb250cm9sMDQuYwpAQCAtMjMyLDcgKzIzMiw2IEBAIHN0
YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKIAkuY2xlYW51cCA9IGNsZWFudXAsCiAJLnRl
c3RfYWxsID0gdGVzdF9tZW1jZ19sb3csCiAJLm1vdW50X2RldmljZSA9IDEsCi0JLmRldl9taW5f
c2l6ZSA9IDI1NiwKIAkubW50cG9pbnQgPSBUTVBESVIsCiAJLmFsbF9maWxlc3lzdGVtcyA9IDEs
CiAJLnNraXBfZmlsZXN5c3RlbXMgPSAoY29uc3QgY2hhciAqY29uc3RbXSl7Ci0tIAoyLjQyLjAK
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
