Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AB1C77B7D
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 15:37:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20EDC3CB399
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 17:37:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A00033CB8F3
 for <ltp@lists.linux.it>; Wed, 17 May 2023 17:36:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0FDDD1400255
 for <ltp@lists.linux.it>; Wed, 17 May 2023 17:36:43 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3E5611FFAC;
 Wed, 17 May 2023 15:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684337803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uojooJ5umkG3K/XTcXlEEd0rOP7pRjmeSfhQGyI5O7U=;
 b=DvWARpWQwSGGKxzBQXDbvhNtktE2Q2vyulcucGXEJSE89VAneNP99rIn3+Y0fEwd0pvcx8
 gnVHPg2c2Gk1CGwXRIdk6bvzfIP54wCfMho/XnHxiqZWcLZWbFqmat6i8wlNH4dh8NCkmx
 Mjy1kI9lF8/kNrSp+X42fRTm6d+cbxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684337803;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uojooJ5umkG3K/XTcXlEEd0rOP7pRjmeSfhQGyI5O7U=;
 b=Qo/cdg+A4Ixjr9xf0Co1nLQwmuzAso79wz7Y03tHViMKmCYAKDScrRCbcFBejAsdwKqO4m
 KzYrW6zLajpwnnBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 221C413478;
 Wed, 17 May 2023 15:36:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8JSHB4v0ZGSTCgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 17 May 2023 15:36:43 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Nicolai Stange <nstange@suse.de>,
	ltp@lists.linux.it
Date: Wed, 17 May 2023 17:36:38 +0200
Message-Id: <20230517153642.26919-4-mdoucha@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230517153642.26919-1-mdoucha@suse.cz>
References: <20230517153642.26919-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/7] lib: Add safe functions for pthread_kill() and
 mutexes
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_safe_pthread.h |  52 ++++++++++++
 lib/safe_pthread.c         | 161 +++++++++++++++++++++++++++++++++++++
 2 files changed, 213 insertions(+)

diff --git a/include/tst_safe_pthread.h b/include/tst_safe_pthread.h
index 8fb553929..360b561b6 100644
--- a/include/tst_safe_pthread.h
+++ b/include/tst_safe_pthread.h
@@ -52,4 +52,56 @@ int safe_pthread_cancel(const char *file, const int lineno,
 #define SAFE_PTHREAD_CANCEL(thread_id) \
 	safe_pthread_cancel(__FILE__, __LINE__, thread_id);
 
+int safe_pthread_mutexattr_init(const char *file, const int lineno,
+	pthread_mutexattr_t *attr);
+#define SAFE_PTHREAD_MUTEXATTR_INIT(attr) \
+	safe_pthread_mutexattr_init(__FILE__, __LINE__, (attr))
+
+int safe_pthread_mutexattr_destroy(const char *file, const int lineno,
+	pthread_mutexattr_t *attr);
+#define SAFE_PTHREAD_MUTEXATTR_DESTROY(attr) \
+	safe_pthread_mutexattr_destroy(__FILE__, __LINE__, (attr))
+
+int safe_pthread_mutexattr_settype(const char *file, const int lineno,
+	pthread_mutexattr_t *attr, int type);
+#define SAFE_PTHREAD_MUTEXATTR_SETTYPE(attr, type) \
+	safe_pthread_mutexattr_settype(__FILE__, __LINE__, (attr), (type))
+
+int safe_pthread_mutex_init(const char *file, const int lineno,
+	pthread_mutex_t *mutex, const pthread_mutexattr_t *attr);
+#define SAFE_PTHREAD_MUTEX_INIT(mutex, attr) \
+	safe_pthread_mutex_init(__FILE__, __LINE__, (mutex), (attr))
+
+int safe_pthread_mutex_destroy(const char *file, const int lineno,
+	pthread_mutex_t *mutex);
+#define SAFE_PTHREAD_MUTEX_DESTROY(mutex) \
+	safe_pthread_mutex_destroy(__FILE__, __LINE__, (mutex))
+
+int safe_pthread_mutex_lock(const char *file, const int lineno,
+	pthread_mutex_t *mutex);
+#define SAFE_PTHREAD_MUTEX_LOCK(mutex) \
+	safe_pthread_mutex_lock(__FILE__, __LINE__, (mutex))
+
+/* Terminates the test on any error other than EBUSY */
+int safe_pthread_mutex_trylock(const char *file, const int lineno,
+	pthread_mutex_t *mutex);
+#define SAFE_PTHREAD_MUTEX_TRYLOCK(mutex) \
+	safe_pthread_mutex_trylock(__FILE__, __LINE__, (mutex))
+
+/* Terminates the test on any error other than ETIMEDOUT */
+int safe_pthread_mutex_timedlock(const char *file, const int lineno,
+	pthread_mutex_t *mutex, const struct timespec *abstime);
+#define SAFE_PTHREAD_MUTEX_TIMEDLOCK(mutex, abstime) \
+	safe_pthread_mutex_timedlock(__FILE__, __LINE__, (mutex), (abstime))
+
+int safe_pthread_mutex_unlock(const char *file, const int lineno,
+	pthread_mutex_t *mutex);
+#define SAFE_PTHREAD_MUTEX_UNLOCK(mutex) \
+	safe_pthread_mutex_unlock(__FILE__, __LINE__, (mutex))
+
+int safe_pthread_kill(const char *file, const int lineno,
+	pthread_t thread, int sig);
+#define SAFE_PTHREAD_KILL(thread, sig) \
+	safe_pthread_kill(__FILE__, __LINE__, (thread), (sig))
+
 #endif /* TST_SAFE_PTHREAD_H__ */
diff --git a/lib/safe_pthread.c b/lib/safe_pthread.c
index d70bb8707..aeafe014c 100644
--- a/lib/safe_pthread.c
+++ b/lib/safe_pthread.c
@@ -106,3 +106,164 @@ int safe_pthread_barrier_init(const char *file, const int lineno,
 
 	return rval;
 }
+
+int safe_pthread_mutexattr_init(const char *file, const int lineno,
+	pthread_mutexattr_t *attr)
+{
+	int ret;
+
+	ret = pthread_mutexattr_init(attr);
+
+	if (ret) {
+		tst_brk_(file, lineno, TBROK,
+			"pthread_mutexattr_init(%p) failed: %s",
+			attr, tst_strerrno(ret));
+	}
+
+	return ret;
+}
+
+int safe_pthread_mutexattr_destroy(const char *file, const int lineno,
+	pthread_mutexattr_t *attr)
+{
+	int ret;
+
+	ret = pthread_mutexattr_destroy(attr);
+
+	if (ret) {
+		tst_brk_(file, lineno, TBROK,
+			"pthread_mutexattr_destroy(%p) failed: %s",
+			attr, tst_strerrno(ret));
+	}
+
+	return ret;
+}
+
+int safe_pthread_mutexattr_settype(const char *file, const int lineno,
+	pthread_mutexattr_t *attr, int type)
+{
+	int ret;
+
+	ret = pthread_mutexattr_settype(attr, type);
+
+	if (ret) {
+		tst_brk_(file, lineno, TBROK,
+			"pthread_mutexattr_settype(%p, %d) failed: %s",
+			attr, type, tst_strerrno(ret));
+	}
+
+	return ret;
+}
+
+int safe_pthread_mutex_init(const char *file, const int lineno,
+	pthread_mutex_t *mutex, const pthread_mutexattr_t *attr)
+{
+	int ret;
+
+	ret = pthread_mutex_init(mutex, attr);
+
+	if (ret) {
+		tst_brk_(file, lineno, TBROK,
+			"pthread_mutex_init(%p, %p) failed: %s",
+			mutex, attr, tst_strerrno(ret));
+	}
+
+	return ret;
+}
+
+int safe_pthread_mutex_destroy(const char *file, const int lineno,
+	pthread_mutex_t *mutex)
+{
+	int ret;
+
+	ret = pthread_mutex_destroy(mutex);
+
+	if (ret) {
+		tst_brk_(file, lineno, TBROK,
+			"pthread_mutex_destroy(%p) failed: %s",
+			mutex, tst_strerrno(ret));
+	}
+
+	return ret;
+}
+
+int safe_pthread_mutex_lock(const char *file, const int lineno,
+	pthread_mutex_t *mutex)
+{
+	int ret;
+
+	ret = pthread_mutex_lock(mutex);
+
+	if (ret) {
+		tst_brk_(file, lineno, TBROK,
+			"pthread_mutex_lock(%p) failed: %s",
+			mutex, tst_strerrno(ret));
+	}
+
+	return ret;
+}
+
+int safe_pthread_mutex_trylock(const char *file, const int lineno,
+	pthread_mutex_t *mutex)
+{
+	int ret;
+
+	ret = pthread_mutex_trylock(mutex);
+
+	if (ret && ret != EBUSY) {
+		tst_brk_(file, lineno, TBROK,
+			"pthread_mutex_trylock(%p) failed: %s",
+			mutex, tst_strerrno(ret));
+	}
+
+	return ret;
+}
+
+int safe_pthread_mutex_timedlock(const char *file, const int lineno,
+	pthread_mutex_t *mutex, const struct timespec *abstime)
+{
+	int ret;
+
+	ret = pthread_mutex_timedlock(mutex, abstime);
+
+	if (ret && ret != ETIMEDOUT) {
+		tst_brk_(file, lineno, TBROK,
+			"pthread_mutex_timedlock(%p, {%lld, %ld}) failed: %s",
+			mutex, (long long)abstime->tv_sec, abstime->tv_nsec,
+			tst_strerrno(ret));
+	}
+
+	return ret;
+}
+
+int safe_pthread_mutex_unlock(const char *file, const int lineno,
+	pthread_mutex_t *mutex)
+{
+	int ret;
+
+	ret = pthread_mutex_unlock(mutex);
+
+	if (ret) {
+		tst_brk_(file, lineno, TBROK,
+			"pthread_mutex_unlock(%p) failed: %s",
+			mutex, tst_strerrno(ret));
+	}
+
+	return ret;
+}
+
+int safe_pthread_kill(const char *file, const int lineno,
+	pthread_t thread, int sig)
+{
+	int ret;
+
+	ret = pthread_kill(thread, sig);
+
+	if (ret) {
+		tst_brk_(file, lineno, TBROK,
+			"pthread_kill(..., %d) failed: %s",
+			sig, tst_strerrno(ret));
+	}
+
+	return ret;
+}
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
