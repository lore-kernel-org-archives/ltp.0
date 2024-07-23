Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1091C3DA63
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 17:59:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B6D33D1C1E
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 19:59:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDD8E3D1ADB
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 19:59:10 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 59225602995
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 19:59:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B44A11FD61;
 Tue, 23 Jul 2024 17:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721757548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ap2A2KDD+U7dDhbXFy+raCWgi3HsCdkmU6Qk8PbbWvA=;
 b=vwHOZUZfI9xDBJX6BrHTX8fwm4M6aRSbQlUIgkYmVT45IUn+IeGwzZNjHBMAHXEVoEI3aq
 2qHoszcMZ0zs760KvsWcSu76hnKGztPQCDV2Cs6LbHGTPzn2aRcq25JtGxVGAqvw/eKjB9
 xD7lyEOIQf/hk2rKYf6+bzfzOc6jxj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721757548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ap2A2KDD+U7dDhbXFy+raCWgi3HsCdkmU6Qk8PbbWvA=;
 b=Aiibu9yUd5wTSvpeJe+/sVpWMLmf/3zkpXgtd7rnKNiQDWnSQ+B/NNQODgOeTesIaQ8JB5
 vBg/vK+2gnkHRaBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721757548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ap2A2KDD+U7dDhbXFy+raCWgi3HsCdkmU6Qk8PbbWvA=;
 b=vwHOZUZfI9xDBJX6BrHTX8fwm4M6aRSbQlUIgkYmVT45IUn+IeGwzZNjHBMAHXEVoEI3aq
 2qHoszcMZ0zs760KvsWcSu76hnKGztPQCDV2Cs6LbHGTPzn2aRcq25JtGxVGAqvw/eKjB9
 xD7lyEOIQf/hk2rKYf6+bzfzOc6jxj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721757548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ap2A2KDD+U7dDhbXFy+raCWgi3HsCdkmU6Qk8PbbWvA=;
 b=Aiibu9yUd5wTSvpeJe+/sVpWMLmf/3zkpXgtd7rnKNiQDWnSQ+B/NNQODgOeTesIaQ8JB5
 vBg/vK+2gnkHRaBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E8DD13888;
 Tue, 23 Jul 2024 17:58:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GEcTGlTvn2aMEgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 23 Jul 2024 17:58:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 23 Jul 2024 17:41:03 +0200
MIME-Version: 1.0
Message-Id: <20240723-fchmodat2-v2-1-e658a98b113e@suse.com>
References: <20240723-fchmodat2-v2-0-e658a98b113e@suse.com>
In-Reply-To: <20240723-fchmodat2-v2-0-e658a98b113e@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2602;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=U2VGMxIUdQTXMvw5tt0u3nXxyihCqX23E98wwkw4Zeo=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmn+9WdSiio08ykAaEq2BS0j60uXoo0HeV9vUIz
 mjudk+WBkWJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp/vVgAKCRDLzBqyILPm
 Rp4wC/4+YyDKqNklfQGK/CtcwZRgSsqZGxbm5/0LnhDQFdw91otB9omaHmb0KZtPpjo3bRgeVYG
 JYJdpuSkIhnoXKmh4L99nchWnXmUkMKA6qGRo6G0JIPuu2MOw0oehChmual3NZXQmPRe5okrPel
 m7Z4JW0LnU4q3AHaEUVZPcKLTx0gSjMOQacHL5PRsbq/WlbzMonIRk0CbGaN0YKPRAqiWU5z4Io
 ar6d5M7u+7iYVqR7bgP8Rej4EfQgjvaqnuqAL8AL5tvD1/Jjdvdw0F/Ijsl7Kkk0VoTKlinnV1Z
 9GtaXtrQMqBgDddblA0gNqGXj9/i4/YrB8qZTIovYh+WX/2dQHy7GNiIn/qUocKrPu1SCjd6Ejm
 6yjVy1u9Epd6hSZparZXSEI8vV61v9xHKd2pZZZZSEtWi326JZDx2FYKYgVMm+5+w5eJzhn3OFy
 SoqjtMedHKghcZ49n9Lon+bKS7+1huX2gse4m0i0tE1C5dIYl16/54AuLkthkSDulWWCg=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-1.10 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/5] Add SAFE_SYMLINKAT macro
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
