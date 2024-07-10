Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B830EC3DA42
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 18:04:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51E9B3D3FD2
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 20:04:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DD7A3D386A
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:02:21 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 290DC1A01981
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:02:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D52C01FCDC;
 Wed, 10 Jul 2024 18:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LL3MUfjhU5KoBwQO1eFr+3tB6DL+se9OifpN+0svvkw=;
 b=AshCEhNjecaQnGVBbjezbr1/y7M0/r9WJ4rlV/rcRbYMfYD2Evwu1045s/MpAvB4oB08cc
 Lpv7LyCLy2lmKbh2TnzUIhJXWA9J/95dutbyzs+/bq2k/hcSOJmd/WUexQPsz9fUta4ht6
 msPp0mXUPilg/O9G9Fkvjb5yv128lo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LL3MUfjhU5KoBwQO1eFr+3tB6DL+se9OifpN+0svvkw=;
 b=lx2805E946/KyCmieOWc9Wv60Rch4X9bo7sKqzjctgcjlx+wP1ne+eoJgU9E5v7ngGZWYt
 F70/Y5tVV872jsCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LL3MUfjhU5KoBwQO1eFr+3tB6DL+se9OifpN+0svvkw=;
 b=AshCEhNjecaQnGVBbjezbr1/y7M0/r9WJ4rlV/rcRbYMfYD2Evwu1045s/MpAvB4oB08cc
 Lpv7LyCLy2lmKbh2TnzUIhJXWA9J/95dutbyzs+/bq2k/hcSOJmd/WUexQPsz9fUta4ht6
 msPp0mXUPilg/O9G9Fkvjb5yv128lo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LL3MUfjhU5KoBwQO1eFr+3tB6DL+se9OifpN+0svvkw=;
 b=lx2805E946/KyCmieOWc9Wv60Rch4X9bo7sKqzjctgcjlx+wP1ne+eoJgU9E5v7ngGZWYt
 F70/Y5tVV872jsCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF608137D2;
 Wed, 10 Jul 2024 18:02:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YKlfLavMjmZJfAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jul 2024 18:02:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jul 2024 20:02:03 +0200
MIME-Version: 1.0
Message-Id: <20240710-landlock-v2-8-ff79db017d57@suse.com>
References: <20240710-landlock-v2-0-ff79db017d57@suse.com>
In-Reply-To: <20240710-landlock-v2-0-ff79db017d57@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=763;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=4dBf0txYyHkxBTNlYjHZpRF7TwNuDuKi/1tKq5F+cQ4=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjsyetBoqrxRVkRF6UFpLfV+0hfi0L5d152CH5
 o0GHJAXIcqJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo7MngAKCRDLzBqyILPm
 Rpy2C/4ix5Xu3db8Dgqfilavv6T0ZtAh47RuBY3YYpl5vt5RQpJ9xUgy7avBLQmrMOkfRhUvOZO
 kKDqQcM6CjPZlk+9qPM5XQAbpD+3mv8vL5MeXwRHmKdNEkNXCe4KrcI6k+VYilWHaikuDt3fOlZ
 IQo1v3UV857EyQ6HI/wW9wH5WGB6BCm24s5zJCFKWimu4T/7HApE6oGVrYfsf4zPqOwi6nK3XqD
 3G53vaaZaVJKDo+Bri5r4VkuJPeZy7+yxqAWYLUTKLoS/9s9aFRdVWuTbyGPM38KNU7gT+R+ORv
 gnr0Y1I0OVgQHtdK1jzA5EHNku9sLMhDxil0uyXACfVXHEIiBLZVLV2DUo9QvfX/oy2m7leUu0O
 azt7cc4gPVtg1eP703j5c+tpequjJU6Xk5Zk8MPiO4ulJp8DEtGZvwKntvt91q6mGakO5gpw9Gs
 In3MGhNP3EzoBe3d4GUOgSZw5jqy6OIDopBNfe1fgeAuH3BG0TyMsfB1Zw4fwLWsSJb14=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 08/11] Add CAP_MKNOD fallback in lapi/capability.h
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
