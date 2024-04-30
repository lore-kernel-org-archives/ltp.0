Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EB6C4345F
	for <ltp@archiver.kernel.org>; Tue, 30 Apr 2024 12:25:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34BDC3CB663
	for <ltp@archiver.kernel.org>; Tue, 30 Apr 2024 14:25:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 177763CB3DC
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 14:23:07 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6544D6096AB
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 14:23:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BA94134027
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714479784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7hDB+Pli+R8oTq/6OjXX3jJvQ6OjxEE8ZErS4P3D7I=;
 b=XxwwW+PQwVdCLrRJhAR5krVcaxXwPBaRSRh/jPPi/GJkcGkPlTIDoGsqTrfk1DQFGWeVgu
 qFYe0EyKSvXa09yoVklXcKCNO8MAjYLOYql61pFLbwK86EuyJhuJ8Pqzvs4sHtsAvmi+v2
 FDgFWBZhqFg0H+NhmK6J1JqNoNFxaro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714479784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7hDB+Pli+R8oTq/6OjXX3jJvQ6OjxEE8ZErS4P3D7I=;
 b=TQrpgnRE7+kYP0z9kzeuM9uazWFluFp/r5AicnYMZRl2MumKAficL7eT6YZlp7XyMBzrpz
 p3BmiJ3OmypAWqDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XxwwW+PQ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TQrpgnRE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714479784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7hDB+Pli+R8oTq/6OjXX3jJvQ6OjxEE8ZErS4P3D7I=;
 b=XxwwW+PQwVdCLrRJhAR5krVcaxXwPBaRSRh/jPPi/GJkcGkPlTIDoGsqTrfk1DQFGWeVgu
 qFYe0EyKSvXa09yoVklXcKCNO8MAjYLOYql61pFLbwK86EuyJhuJ8Pqzvs4sHtsAvmi+v2
 FDgFWBZhqFg0H+NhmK6J1JqNoNFxaro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714479784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7hDB+Pli+R8oTq/6OjXX3jJvQ6OjxEE8ZErS4P3D7I=;
 b=TQrpgnRE7+kYP0z9kzeuM9uazWFluFp/r5AicnYMZRl2MumKAficL7eT6YZlp7XyMBzrpz
 p3BmiJ3OmypAWqDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF2A213991
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:23:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yNGfKqjiMGaQHAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:23:04 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Apr 2024 14:21:58 +0200
Message-ID: <20240430122208.13043-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430122208.13043-1-mdoucha@suse.cz>
References: <20240430122208.13043-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BA94134027
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/9] KVM: Implement strchr() and basic sprintf()
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

Add basic implementation of sprintf() that supports string, pointer
and integer arguments but without advanced formatting options like
field alignment and padding.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/kvm/include/kvm_guest.h |  11 +
 testcases/kernel/kvm/lib_guest.c         | 312 +++++++++++++++++++++++
 2 files changed, 323 insertions(+)

diff --git a/testcases/kernel/kvm/include/kvm_guest.h b/testcases/kernel/kvm/include/kvm_guest.h
index 96f246155..f19bacc39 100644
--- a/testcases/kernel/kvm/include/kvm_guest.h
+++ b/testcases/kernel/kvm/include/kvm_guest.h
@@ -39,9 +39,15 @@ typedef unsigned int uint32_t;
 typedef long long int64_t;
 typedef unsigned long long uint64_t;
 typedef unsigned long uintptr_t;
+typedef __builtin_va_list va_list;
 
 #define NULL ((void *)0)
 
+#define va_start __builtin_va_start
+#define va_arg __builtin_va_arg
+#define va_end __builtin_va_end
+#define va_copy __builtin_va_copy
+
 void *memset(void *dest, int val, size_t size);
 void *memzero(void *dest, size_t size);
 void *memcpy(void *dest, const void *src, size_t size);
@@ -49,6 +55,11 @@ void *memcpy(void *dest, const void *src, size_t size);
 char *strcpy(char *dest, const char *src);
 char *strcat(char *dest, const char *src);
 size_t strlen(const char *str);
+char *strchr(const char *s, int c);
+char *strrchr(const char *s, int c);
+
+int vsprintf(char *dest, const char *fmt, va_list ap);
+int sprintf(char *dest, const char *fmt, ...);
 
 /* Exit the VM by looping on a HLT instruction forever */
 void kvm_exit(void) __attribute__((noreturn));
diff --git a/testcases/kernel/kvm/lib_guest.c b/testcases/kernel/kvm/lib_guest.c
index f3e21d3d6..73a76ccb1 100644
--- a/testcases/kernel/kvm/lib_guest.c
+++ b/testcases/kernel/kvm/lib_guest.c
@@ -76,6 +76,74 @@ size_t strlen(const char *str)
 	return ret;
 }
 
+char *strchr(const char *s, int c)
+{
+	for (; *s; s++) {
+		if (*s == c)
+			return (char *)s;
+	}
+
+	return NULL;
+}
+
+char *strrchr(const char *s, int c)
+{
+	const char *ret = NULL;
+
+	for (; *s; s++) {
+		if (*s == c)
+			ret = s;
+	}
+
+	return (char *)ret;
+}
+
+#if defined(__x86_64__) && !defined(__ILP32__)
+uint64_t u64divu16(uint64_t a, uint16_t b)
+{
+	return a / b;
+}
+
+unsigned int u64modu16(uint64_t a, uint16_t b)
+{
+	return a % b;
+}
+
+#else /* defined(__x86_64__) && !defined(__ILP32__) */
+
+/* u64 short division helpers to avoid need to link libgcc on 32bit archs */
+uint64_t u64divu16(uint64_t a, uint16_t b)
+{
+	uint64_t ret = 0;
+	uint32_t tmp = a >> 32;
+
+	ret = tmp / b;
+	ret <<= 32;
+	tmp %= b;
+	tmp <<= 16;
+	tmp |= (a >> 16) & 0xffff;
+	ret |= (tmp / b) << 16;
+	tmp %= b;
+	tmp <<= 16;
+	tmp |= a & 0xffff;
+	ret |= tmp / b;
+	return ret;
+}
+
+unsigned int u64modu16(uint64_t a, uint16_t b)
+{
+	uint32_t tmp = a >> 32;
+
+	tmp %= b;
+	tmp <<= 16;
+	tmp |= (a >> 16) & 0xffff;
+	tmp %= b;
+	tmp <<= 16;
+	tmp |= a & 0xffff;
+	return tmp % b;
+}
+#endif /* defined(__x86_64__) && !defined(__ILP32__) */
+
 char *ptr2hex(char *dest, uintptr_t val)
 {
 	unsigned int i;
@@ -95,6 +163,250 @@ char *ptr2hex(char *dest, uintptr_t val)
 	return ret;
 }
 
+char *u64tostr(char *dest, uint64_t val, uint16_t base, int caps)
+{
+	unsigned int i;
+	uintptr_t tmp = u64divu16(val, base);
+	char hex = caps ? 'A' : 'a';
+	char *ret = dest;
+
+	for (i = 1; tmp; i++, tmp = u64divu16(tmp, base))
+		;
+
+	dest[i] = '\0';
+
+	do {
+		tmp = u64modu16(val, base);
+		dest[--i] = tmp + (tmp >= 10 ? hex - 10 : '0');
+		val = u64divu16(val, base);
+	} while (i);
+
+	return ret;
+}
+
+char *i64tostr(char *dest, int64_t val)
+{
+	if (val < 0) {
+		dest[0] = '-';
+		u64tostr(dest + 1, -val, 10, 0);
+		return dest;
+	}
+
+	return u64tostr(dest, val, 10, 0);
+}
+
+int vsprintf(char *dest, const char *fmt, va_list ap)
+{
+	va_list args;
+	int ret = 0;
+	char conv;
+	uint64_t u64val = 0;
+	int64_t i64val = 0;
+	const char * const uint_conv = "ouxX";
+
+	va_copy(args, ap);
+
+	for (; *fmt; fmt++) {
+		if (*fmt != '%') {
+			dest[ret++] = *fmt;
+			continue;
+		}
+
+		conv = 0;
+		fmt++;
+
+		switch (*fmt) {
+		case '%':
+			dest[ret++] = *fmt;
+			break;
+
+		case 'c':
+			dest[ret++] = va_arg(args, int);
+			break;
+
+		case 's':
+			strcpy(dest + ret, va_arg(args, const char *));
+			ret += strlen(dest + ret);
+			break;
+
+		case 'p':
+			strcpy(dest + ret, "0x");
+			ptr2hex(dest + ret + 2,
+				(uintptr_t)va_arg(args, void *));
+			ret += strlen(dest + ret);
+			break;
+
+		case 'l':
+			fmt++;
+
+			switch (*fmt) {
+			case 'l':
+				fmt++;
+
+				if (*fmt == 'd' || *fmt == 'i') {
+					i64val = va_arg(args, long long);
+					conv = *fmt;
+					break;
+				}
+
+				if (strchr(uint_conv, *fmt)) {
+					u64val = va_arg(args,
+						unsigned long long);
+					conv = *fmt;
+					break;
+				}
+
+				va_end(args);
+				return -1;
+
+			case 'd':
+			case 'i':
+				i64val = va_arg(args, long);
+				conv = *fmt;
+				break;
+
+			default:
+				if (strchr(uint_conv, *fmt)) {
+					u64val = va_arg(args,
+						unsigned long);
+					conv = *fmt;
+					break;
+				}
+
+				va_end(args);
+				return -1;
+			}
+			break;
+
+		case 'h':
+			fmt++;
+
+			switch (*fmt) {
+			case 'h':
+				fmt++;
+
+				if (*fmt == 'd' || *fmt == 'i') {
+					i64val = (signed char)va_arg(args, int);
+					conv = *fmt;
+					break;
+				}
+
+				if (strchr(uint_conv, *fmt)) {
+					u64val = (unsigned char)va_arg(args,
+						unsigned int);
+					conv = *fmt;
+					break;
+				}
+
+				va_end(args);
+				return -1;
+
+			case 'd':
+			case 'i':
+				i64val = (short int)va_arg(args, int);
+				conv = *fmt;
+				break;
+
+			default:
+				if (strchr(uint_conv, *fmt)) {
+					u64val = (unsigned short int)va_arg(
+						args, unsigned int);
+					conv = *fmt;
+					break;
+				}
+
+				va_end(args);
+				return -1;
+			}
+			break;
+
+		case 'z':
+			fmt++;
+
+			if (*fmt == 'd' || *fmt == 'i') {
+				i64val = va_arg(args, ssize_t);
+				conv = *fmt;
+				break;
+			}
+
+			if (strchr(uint_conv, *fmt)) {
+				u64val = va_arg(args, size_t);
+				conv = *fmt;
+				break;
+			}
+
+			va_end(args);
+			return -1;
+
+		case 'd':
+		case 'i':
+			i64val = va_arg(args, int);
+			conv = *fmt;
+			break;
+
+		default:
+			if (strchr(uint_conv, *fmt)) {
+				u64val = va_arg(args, unsigned int);
+				conv = *fmt;
+				break;
+			}
+
+			va_end(args);
+			return -1;
+		}
+
+		switch (conv) {
+		case 0:
+			continue;
+
+		case 'd':
+		case 'i':
+			i64tostr(dest + ret, i64val);
+			ret += strlen(dest + ret);
+			break;
+
+		case 'o':
+			u64tostr(dest + ret, u64val, 8, 0);
+			ret += strlen(dest + ret);
+			break;
+
+		case 'u':
+			u64tostr(dest + ret, u64val, 10, 0);
+			ret += strlen(dest + ret);
+			break;
+
+		case 'x':
+			u64tostr(dest + ret, u64val, 16, 0);
+			ret += strlen(dest + ret);
+			break;
+
+		case 'X':
+			u64tostr(dest + ret, u64val, 16, 1);
+			ret += strlen(dest + ret);
+			break;
+
+		default:
+			va_end(args);
+			return -1;
+		}
+	}
+
+	va_end(args);
+	dest[ret++] = '\0';
+	return ret;
+}
+
+int sprintf(char *dest, const char *fmt, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, fmt);
+	ret = vsprintf(dest, fmt, args);
+	va_end(args);
+	return ret;
+}
+
 void *tst_heap_alloc_aligned(size_t size, size_t align)
 {
 	uintptr_t addr = (uintptr_t)heap_end;
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
