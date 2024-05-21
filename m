Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23775C25B74
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 06:18:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE70D3CFF4E
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 08:18:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE4913CFF2C
 for <ltp@lists.linux.it>; Tue, 21 May 2024 08:16:35 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EB16310007D8
 for <ltp@lists.linux.it>; Tue, 21 May 2024 08:16:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C121120136;
 Tue, 21 May 2024 06:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716272192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JyTL+g3WZZxwvwc6canhxEhUcasQyBSf8MGLCDipXXk=;
 b=vddkY2tq/o4aASijHE0/VSTRzyLOPO6uQmIWw8j71bv+AeFox7BDct1x50GZIQ4H9OMExz
 MavDJlZ+XNi72G/iJslmuZHjQKyk9mgGO6YCGLMg/VtgjZLFjdrLiPfb4ndGrd9PZNyK5X
 Qtof7oSTa05Di/jN6dvVMA/0lntofXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716272192;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JyTL+g3WZZxwvwc6canhxEhUcasQyBSf8MGLCDipXXk=;
 b=IhOftSG1mXs/PssHVSx27+aq6GXQkmrJ6E+EBzlkbzl3n4tQSZQlsRdv5lSFFAURnLqsjm
 bZv22ZO2kImvhyDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716272192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JyTL+g3WZZxwvwc6canhxEhUcasQyBSf8MGLCDipXXk=;
 b=vddkY2tq/o4aASijHE0/VSTRzyLOPO6uQmIWw8j71bv+AeFox7BDct1x50GZIQ4H9OMExz
 MavDJlZ+XNi72G/iJslmuZHjQKyk9mgGO6YCGLMg/VtgjZLFjdrLiPfb4ndGrd9PZNyK5X
 Qtof7oSTa05Di/jN6dvVMA/0lntofXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716272192;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JyTL+g3WZZxwvwc6canhxEhUcasQyBSf8MGLCDipXXk=;
 b=IhOftSG1mXs/PssHVSx27+aq6GXQkmrJ6E+EBzlkbzl3n4tQSZQlsRdv5lSFFAURnLqsjm
 bZv22ZO2kImvhyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AFC613A75;
 Tue, 21 May 2024 06:16:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0A/9IkA8TGZmMQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 21 May 2024 06:16:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 21 May 2024 08:15:27 +0200
MIME-Version: 1.0
Message-Id: <20240521-fchmodat2-v1-1-191b4a986202@suse.com>
References: <20240521-fchmodat2-v1-0-191b4a986202@suse.com>
In-Reply-To: <20240521-fchmodat2-v1-0-191b4a986202@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2602;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=vZJo+4bNWir1hjKK/l9txbaAucuzVgca4HYec7I/zYY=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmTDw/UZ6lron1jhptBTEoOoP/1s+08kQxteOYv
 R7MtFoYRh2JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZkw8PwAKCRDLzBqyILPm
 RlZEC/4lkA34msWhYedSVZjQFGi9s+dfhrp3g4s2XvAOCDG+oOsEVURaIFPkJr38E3NWnUuhJ/F
 vdqV7VQnz/jCG0OEl5oH3yxyXQYE4i05G+alOWQ6FAMxQpGV8XjIoE54DmiN6/P8juX5+yyWE2V
 FbWDjY5TfTCubcVAWBCqoofqyC72RLH9GqGj38+p07yvHtWhYynW9aHJ/7HKXTEbogjElPCAGLr
 JwjTSBGyuBKu85Eg1qoz3drWIFQhgMubLADS+NcACycDrUsJ81ARZiR4BNMEbB5w0pulFsEyDeO
 Tx1JyIOhlGTDV8XvZ9kGJdr3if8IGohnGdg+UL3BI8jMi84+367O6wmXSlbuI7pR993jpxoRZJN
 h2MrgUANRqijjFd4B3cOrIINo3Z/JUw/6a8Tst5yy74S6p+mh8sqcqREE3+mXO2ETuP596cEFLO
 TGX3bRamWcCNj2Scx3JUSXqRcgYInDjBz3I4IGU8XJvCby/eSWaNvy7XNUN5/OZFo9fco=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.993]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/5] Add SAFE_SYMLINKAT macro
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
 include/safe_macros_fn.h  |  4 ++++
 include/tst_safe_macros.h |  3 +++
 lib/safe_macros.c         | 20 ++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
index d256091b7..6d9e72e4f 100644
--- a/include/safe_macros_fn.h
+++ b/include/safe_macros_fn.h
@@ -122,6 +122,10 @@ int safe_symlink(const char *file, const int lineno,
                  void (cleanup_fn)(void), const char *oldpath,
                  const char *newpath);
 
+int safe_symlinkat(const char *file, const int lineno,
+                 void (cleanup_fn)(void), const char *oldpath,
+                 const int newdirfd, const char *newpath);
+
 ssize_t safe_write(const char *file, const int lineno,
 		   void (cleanup_fn)(void), enum safe_write_opts len_strict,
 		   int fildes, const void *buf, size_t nbyte);
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 8de8ef106..764affbd2 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -191,6 +191,9 @@ int safe_getgroups(const char *file, const int lineno, int size, gid_t list[]);
 #define SAFE_SYMLINK(oldpath, newpath) \
 	safe_symlink(__FILE__, __LINE__, NULL, (oldpath), (newpath))
 
+#define SAFE_SYMLINKAT(oldpath, newdirfd, newpath) \
+	safe_symlinkat(__FILE__, __LINE__, NULL, (oldpath), (newdirfd), (newpath))
+
 #define SAFE_WRITE(len_strict, fildes, buf, nbyte) \
 	safe_write(__FILE__, __LINE__, NULL, (len_strict), (fildes), (buf), (nbyte))
 
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 109268587..f91e77022 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -527,6 +527,26 @@ int safe_symlink(const char *file, const int lineno,
 	return rval;
 }
 
+int safe_symlinkat(const char *file, const int lineno,
+                 void (cleanup_fn)(void), const char *oldpath,
+				 const int newdirfd, const char *newpath)
+{
+	int rval;
+
+	rval = symlinkat(oldpath, newdirfd, newpath);
+
+	if (rval == -1) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"symlinkat(%s,%d,%s) failed", oldpath, newdirfd, newpath);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid symlinkat(%s,%d,%s) return value %d", oldpath,
+			newdirfd, newpath, rval);
+	}
+
+	return rval;
+}
+
 ssize_t safe_write(const char *file, const int lineno, void (cleanup_fn) (void),
 		   enum safe_write_opts len_strict, int fildes, const void *buf,
 		   size_t nbyte)

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
