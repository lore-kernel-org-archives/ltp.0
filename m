Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE29ECAAD1
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 09:20:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D6BD3CA6E0
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 11:20:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 741723CA0B0
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 11:20:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D941F1400178
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 11:20:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 366C61FDF2;
 Wed, 31 Aug 2022 09:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661937641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CRluOKpO061mpj8Xri7a3Sf1TeEN6GXZI5TxKuFHQXE=;
 b=m/aIRFw47ksvQuE7cNXaIKTpsXm9WMzRmDle/MrnVrlmaPK/gFwjgIAcitlTthH87GDSx7
 A3oJAY3KZGtrZkk+QyJ5bIMXavT92FWKian4i0A891/pC3gVPMmopbTqPALRdJ4489INC8
 2VSl40IMmAoBhlQtFl3USq6Jn3GWExI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661937641;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CRluOKpO061mpj8Xri7a3Sf1TeEN6GXZI5TxKuFHQXE=;
 b=S7c7W6cWqCRjJ1gFhfd/yCDhKWjs8RGZ1Eea7X/AIXFxswa9Fh8Nsx7ErtJpT/vqxI3OID
 y9TghRyLQy9xGHDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9DFD1332D;
 Wed, 31 Aug 2022 09:20:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yHzmJOgnD2ONQgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 31 Aug 2022 09:20:40 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 31 Aug 2022 11:20:36 +0200
Message-Id: <20220831092036.20779-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831092036.20779-1-pvorel@suse.cz>
References: <20220831092036.20779-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] doc: Document macros for stringification
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Also note header which define useful macros (hint for users).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/c-test-api.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 9db4579da..03126304a 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -837,6 +837,8 @@ start for you. See 'testcases/kernel/device-drivers/block' for details.
 1.12 Useful macros
 ~~~~~~~~~~~~~~~~~~
 
+These macros are defined in 'include/tst_common.h'.
+
 [source,c]
 -------------------------------------------------------------------------------
 ARRAY_SIZE(arr)
@@ -852,6 +854,14 @@ LTP_ALIGN(x, a)
 
 Aligns the x to be next multiple of a. The a must be power of 2.
 
+[source,c]
+-------------------------------------------------------------------------------
+TST_TO_STR(s)  /* stringification */
+TST_TO_STR_(s) /* macro expansion */
+-------------------------------------------------------------------------------
+
+Macros for stringification.
+
 1.13 Filesystem type detection and skiplist
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
