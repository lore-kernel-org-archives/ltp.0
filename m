Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CB2C433EF
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 14:03:42 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453A260EB4
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 14:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 453A260EB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE1EE3C75BA
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 15:03:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7064B3C559D
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 15:03:29 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 19D11201131
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 15:03:28 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 637D31FD36
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 14:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636121008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8AfklPGPJM4Di+D72ukjNzhDsyAj9tCkVnyScg6Vxew=;
 b=DnYhNITyvV3061MukS8OxxXiRvETKQUyu7ujNV35Z60n7IFbxtFghswcK0AxTLy8WnIBrM
 +5AcT8KcH2T36kKRN8pveegmehXM79FgFRuClVhCS2gt0pcM0azrb27piZF9kHkhJpj9u6
 PH5DKQoLYj0n1Yk8uIp3lQIyOX49mL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636121008;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8AfklPGPJM4Di+D72ukjNzhDsyAj9tCkVnyScg6Vxew=;
 b=/32HbmMUDGxeyc1Ylxlt13V2krGcvHeBF+lEXcEX3l/7RPO79Cj+yXSOpddmMMI271T/S9
 LwrRbJmqAu6yz2DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F2A913A2C
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 14:03:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id q0pNErA5hWGneQAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 05 Nov 2021 14:03:28 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  5 Nov 2021 15:04:25 +0100
Message-Id: <20211105140425.8272-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] metadata: Ignore system macros
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

Ingore all macros that start with underscore. Unless we do that we get
several thousands of __NR_foo macros and the hash table cannot keep up.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 metadata/metaparse.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index b38550550..f71d8628d 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -624,6 +624,9 @@ static void parse_macro(FILE *f)
 
 	macro_get_val(f, val, sizeof(val));
 
+	if (name[0] == '_')
+		return;
+
 	ENTRY e = {
 		.key = strdup(name),
 		.data = strdup(val),
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
