Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD11C3DA41
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 11:20:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24D943CE830
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 13:20:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DE053C0FBE
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:18:39 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 22EC96035F6
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:18:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AC8EE1F8C8;
 Thu, 11 Jul 2024 11:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720696718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LL3MUfjhU5KoBwQO1eFr+3tB6DL+se9OifpN+0svvkw=;
 b=HBRTYM6wTYFLFWFKlSRLDr1na5Y0w3t0dBn4vc0y+w2rqMYBqwgkvWLD0SN6IaHx8IKVul
 mKve/1/Lb9DRwO1HqxWGEGsYTQ5JKVEahHKVBV+Uok9qCSxc/n6jUIfqfXSr5c391gE4UK
 PRYkzILDAKT43q6EfF38NHV5GLWN8Ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720696718;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LL3MUfjhU5KoBwQO1eFr+3tB6DL+se9OifpN+0svvkw=;
 b=saaQmR10kAZSvNt7N0PDB+w5TEjIBnpnT/GdFagSnV0ui1LYZ6ftai6cQbzWGDYa16SHRp
 kFMk8i97eQ/Qj7Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720696718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LL3MUfjhU5KoBwQO1eFr+3tB6DL+se9OifpN+0svvkw=;
 b=HBRTYM6wTYFLFWFKlSRLDr1na5Y0w3t0dBn4vc0y+w2rqMYBqwgkvWLD0SN6IaHx8IKVul
 mKve/1/Lb9DRwO1HqxWGEGsYTQ5JKVEahHKVBV+Uok9qCSxc/n6jUIfqfXSr5c391gE4UK
 PRYkzILDAKT43q6EfF38NHV5GLWN8Ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720696718;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LL3MUfjhU5KoBwQO1eFr+3tB6DL+se9OifpN+0svvkw=;
 b=saaQmR10kAZSvNt7N0PDB+w5TEjIBnpnT/GdFagSnV0ui1LYZ6ftai6cQbzWGDYa16SHRp
 kFMk8i97eQ/Qj7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F347139E7;
 Thu, 11 Jul 2024 11:18:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GG8MIY6/j2bBVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 11 Jul 2024 11:18:38 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jul 2024 13:18:19 +0200
MIME-Version: 1.0
Message-Id: <20240711-landlock-v3-8-c7b0e9edf9b0@suse.com>
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
In-Reply-To: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=763;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=4dBf0txYyHkxBTNlYjHZpRF7TwNuDuKi/1tKq5F+cQ4=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmj79/btEawNhpsQRoQ80xtyDjQw1rqg0yte3T0
 M0pORj7mF+JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo+/fwAKCRDLzBqyILPm
 RktmC/9L5YdInFaSL7lJpXB8jolOvCLdOyV/lw5j4G6zwhA2SZiAD/HjRDNSBXNBllbO4nlJDf/
 9HJBubs6JB5S3QZaVl2WwHK4oP9A+fqpJYKskLs8UVaecF0WHiLFTFTxey/crOcZcjZ3aRhXPSb
 QuhMrQQCZfW69T87rpnydxXyM8RWgiPfuCTkjoL1ukQ/SG3rJqVyDRk3uaKupiOHVInCLq2xgz+
 Sj7j0Dt7B8YTNNEaR54fn+gUvixUvOZTDjYZqo0FJnTP04axzITFx6ZbTccVQ/3qeSJ4iYSH46i
 uCDBd6EQHthChup2NKN/iZiw+Pby7ByBg9uLeX+77gi5rMTYaClGGFS8TeYSXr7OlpCShnJku8l
 KRPLU7zE4+8U0vp/AgPOzU2OxRzVB4LNTZFevx+nf8iLAm91mwejXxHdJ3BallzNF1B+Kb3IzzJ
 nV4Tzu57Ikxi4ffSlY9ns7wnIiidkJ9bqomH8tjbFFOBlEvdzsIsy6drUCtShO6pJDKdc=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-0.30 / 50.00];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 08/11] Add CAP_MKNOD fallback in lapi/capability.h
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/capability.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/lapi/capability.h b/include/lapi/capability.h
index 2b593797c..0f317d6d7 100644
--- a/include/lapi/capability.h
+++ b/include/lapi/capability.h
@@ -44,14 +44,18 @@
 # define CAP_SYS_TIME         25
 #endif
 
-#ifndef CAP_AUDIT_READ
-# define CAP_AUDIT_READ       37
-#endif
-
 #ifndef CAP_SYS_RESOURCE
 # define CAP_SYS_RESOURCE     24
 #endif
 
+#ifndef CAP_MKNOD
+# define CAP_MKNOD            27
+#endif
+
+#ifndef CAP_AUDIT_READ
+# define CAP_AUDIT_READ       37
+#endif
+
 #ifndef CAP_BPF
 # define CAP_BPF              39
 #endif

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
