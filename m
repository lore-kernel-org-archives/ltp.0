Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F00C3DA49
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 08:24:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB62D3D1F4C
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 10:24:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2D683D1C9C
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 10:23:58 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4E650100117E
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 10:23:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 75BDA1FB9D;
 Fri,  2 Aug 2024 08:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722587037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ap2A2KDD+U7dDhbXFy+raCWgi3HsCdkmU6Qk8PbbWvA=;
 b=sm+YdZOz71zEWmzsEj3difZpssIzhjYlBVx4Driyai7rbvQ1L6ta/nLAs9rRnpcNYyqjNw
 9lBuqn0pwrMQuYq/CnesaNN/jmSJcM9ZByom3a9Smtz1nn3xaXgAporAPjxiKFB2ZyPq1D
 LUmxuH7i48WPwY3XteOPPVEq8WB01hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722587037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ap2A2KDD+U7dDhbXFy+raCWgi3HsCdkmU6Qk8PbbWvA=;
 b=Q+2okyOwlSc0Co4tBzH8BFD4v9SQdU9UKRXamaIKhH1FxYvGvVjIj7o1UcaUK0v6CxGW1j
 mJQBP8oIN5MVO7DQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sm+YdZOz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Q+2okyOw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722587037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ap2A2KDD+U7dDhbXFy+raCWgi3HsCdkmU6Qk8PbbWvA=;
 b=sm+YdZOz71zEWmzsEj3difZpssIzhjYlBVx4Driyai7rbvQ1L6ta/nLAs9rRnpcNYyqjNw
 9lBuqn0pwrMQuYq/CnesaNN/jmSJcM9ZByom3a9Smtz1nn3xaXgAporAPjxiKFB2ZyPq1D
 LUmxuH7i48WPwY3XteOPPVEq8WB01hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722587037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ap2A2KDD+U7dDhbXFy+raCWgi3HsCdkmU6Qk8PbbWvA=;
 b=Q+2okyOwlSc0Co4tBzH8BFD4v9SQdU9UKRXamaIKhH1FxYvGvVjIj7o1UcaUK0v6CxGW1j
 mJQBP8oIN5MVO7DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4402613AED;
 Fri,  2 Aug 2024 08:23:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +Fz3DZ2XrGaaFgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 02 Aug 2024 08:23:57 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 02 Aug 2024 10:23:46 +0200
MIME-Version: 1.0
Message-Id: <20240802-fchmodat2-v5-1-bff2ec1a4f06@suse.com>
References: <20240802-fchmodat2-v5-0-bff2ec1a4f06@suse.com>
In-Reply-To: <20240802-fchmodat2-v5-0-bff2ec1a4f06@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2602;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=U2VGMxIUdQTXMvw5tt0u3nXxyihCqX23E98wwkw4Zeo=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmrJeb7gzLfdemFZe6YeBo4UtTLZIw/FvbQW7OK
 r+u3DmBX3uJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqyXmwAKCRDLzBqyILPm
 RoGVDACNWNXZb6VCoVp7fxSBzGP1ZTpowNBN5QZAEaDB9nkGAKbqvIHW/lf4tmop+orPvwIxGNB
 vD+wJz+XFU7SsqdPihT5twoBK6Oh2pkFxdNRCJ/atCVtbdn1yte856HTBp0VpcmxQvInY6ezXCf
 MwcCnv5PCj6+F1Tkhr3h5e52lfMq6MrpfXpsnxbvgBMOglblmgmLX8ZD+nBEoI3vhws5zcIFcgv
 e2HaW1nxH2E+iAIpaijXTzJ4k+Oi0Q2n79NkxmOuCPcRJVXB0b5/j4ZEgPGfkK2Byza5FT+HXXt
 TpQNL9HcuwG35aCROS+CIoOVEZ7I8+OFBjdieE/MvrQUc8la8EB/wns038ltZtTOy3g4/v4Zbf1
 oB8EWrhvuEyVKCUDEg6ByKDnaYu4vAvbjUzp70Y6k9CEpV8uDSqask0QVkBwwda2BDoSLVu5YuO
 +fMHBu91FMYs9pFxt1AMmwfdCw0SA77phSv2QO7ZLy5YDUbZKLknLflOcra2woWgDLvpY=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 75BDA1FB9D
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/5] Add SAFE_SYMLINKAT macro
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
index 92b9bc119..47a6f99df 100644
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
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
