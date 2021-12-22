Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3474C433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 19:26:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C56563C9284
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 20:26:19 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93EEA3C08F2
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 20:26:10 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3E20D6002E1
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 20:26:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E61831F38B;
 Wed, 22 Dec 2021 19:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640201169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xxwpNT+n6aYrLrdXr362vBeClTuYbDJEkhyB49r8CLY=;
 b=NTFuUwsD211QAqn/669GSxl05sIpjljcA8IuLEPE0djwDNxED9shWnpU+P3YBi9WnuvT0c
 W76qzVo/bQMcIQWSsvItfy3D1BXzuDBpN/hC1W5FIcKXsbmiKOiFTa9aPgs/anLXa/ZByY
 d7Jw3jl30wjFYpR+EVO0BpYm+kG7Kwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640201169;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xxwpNT+n6aYrLrdXr362vBeClTuYbDJEkhyB49r8CLY=;
 b=T4OM3IjLrfgNJ1mf/uA+ZyIbRku2oUvNCkvSrgQoqVjP6s+/nXkzUaAtx6P07HslApXoAK
 wdZSODtyzJ0PRQCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8520613D75;
 Wed, 22 Dec 2021 19:26:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2O5OHNF7w2FZXQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 22 Dec 2021 19:26:09 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 22 Dec 2021 20:26:04 +0100
Message-Id: <20211222192604.16839-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211222192604.16839-1-pvorel@suse.cz>
References: <20211222192604.16839-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] tst_af_alg: TCONF on ciphers disabled by FIPS
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
Cc: Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Similar fix to 4fa302ef9d. It fixes:

./af_alg01
tst_af_alg.c:84: TBROK: unexpected error binding AF_ALG socket to hash algorithm 'md5': ELIBBAD (80)
become
tst_fips.c:22: TINFO: FIPS: on
tst_af_alg.c:111: TCONF: FIPS enabled => hash algorithm 'md5' disabled
tst_fips.c:22: TINFO: FIPS: on
tst_af_alg.c:111: TCONF: FIPS enabled => hash algorithm 'md5-generic' disabled

./af_alg02
tst_af_alg.c:37: TBROK: unexpected error binding AF_ALG socket to skcipher algorithm 'salsa20': ELIBBAD (80)
become
tst_fips.c:22: TINFO: FIPS: on
tst_af_alg.c:36: TCONF: FIPS enabled => skcipher algorithm 'salsa20' disabled

./af_alg04
tst_af_alg.c:81: TBROK: unexpected error binding AF_ALG socket to hash algorithm 'vmac64(aes)': ELIBBAD (80)
become
tst_fips.c:22: TINFO: FIPS: on
tst_af_alg.c:111: TCONF: FIPS enabled => hash algorithm 'vmac64(aes)' disabled

Tested on Debian stable bullseye and SLES 15-SP4.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: I asked Herbert Xu for confirmation that my code understanding is
correct and ELIBBAD is expected for ciphers disabled by FIPS.

 include/tst_af_alg.h |  2 +-
 lib/tst_af_alg.c     | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/tst_af_alg.h b/include/tst_af_alg.h
index 93ff5715b7..86df18eb81 100644
--- a/include/tst_af_alg.h
+++ b/include/tst_af_alg.h
@@ -73,7 +73,7 @@ int tst_try_alg(const char *algtype, const char *algname);
  *
  * Return true if the algorithm is available, or false if unavailable
  * and call tst_res() with TCONF. If another error occurs, tst_brk() is called
- * with TBROK.
+ * with TBROK unless algorithm is disabled due FIPS mode (errno ELIBBAD).
  */
 bool tst_have_alg(const char *algtype, const char *algname);
 
diff --git a/lib/tst_af_alg.c b/lib/tst_af_alg.c
index d99a9ee2ef..52c0b0abb4 100644
--- a/lib/tst_af_alg.c
+++ b/lib/tst_af_alg.c
@@ -31,10 +31,18 @@ void tst_alg_bind_addr(int algfd, const struct sockaddr_alg *addr)
 
 	if (ret == 0)
 		return;
+
+	if (errno == ELIBBAD && tst_fips_enabled()) {
+		tst_brk(TCONF,
+			"FIPS enabled => %s algorithm '%s' disabled",
+			addr->salg_type, addr->salg_name);
+	}
+
 	if (errno == ENOENT) {
 		tst_brk(TCONF, "kernel doesn't support %s algorithm '%s'",
 			addr->salg_type, addr->salg_name);
 	}
+
 	tst_brk(TBROK | TERRNO,
 		"unexpected error binding AF_ALG socket to %s algorithm '%s'",
 		addr->salg_type, addr->salg_name);
@@ -98,6 +106,14 @@ bool tst_have_alg(const char *algtype, const char *algname)
 		tst_res(TCONF, "kernel doesn't have %s algorithm '%s'",
 			algtype, algname);
 		return false;
+	case ELIBBAD:
+		if (tst_fips_enabled()) {
+			tst_res(TCONF,
+				"FIPS enabled => %s algorithm '%s' disabled",
+				algtype, algname);
+			return false;
+		}
+	/* fallthrough */
 	default:
 		errno = ret;
 		tst_brk(TBROK | TERRNO,
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
