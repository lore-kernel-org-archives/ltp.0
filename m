Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB81C61DD6
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 03:43:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD6A83EB19F
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 05:43:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A2483E9701
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 05:43:39 +0200 (CEST)
Received: from mta0.migadu.com (out-104.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::68])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EF9B01000DEB
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 05:43:38 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=hpmeSaBieRC891ZHXkhAQkPx16JuXjo0ZopPXKMPg+w=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788493417; v=1; x=1789098217;
 b=B+XNUSUZ/VmQW/ckEYwhv2Dk1v8xy5wB4kWjH+ufmaJNT3CxETC90WgJP2Sz6pm/mSrWkAMz
 X2+8+xYAfZh8GqQTr5mO1oREbg2tHT+YtwKGSWcis4fAOHVR9Isr0UnP/jfM1QjXS38UQWs7i4m
 P2ZhTMXueFUO/q97L37N6wzA=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id d5d63e96a2144ae3;
 Fri, 04 Sep 2026 03:43:37 +0000
X-Mizu-Trace-ID: d5d63e96a2144ae3
X-Migadu-Flow: FLOW_OUT
Date: Fri, 4 Sep 2026 11:43:29 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <apo-YSqDGDNbrzcc@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260903-coredump-v5-1-2ea86fa29107@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260903-coredump-v5-1-2ea86fa29107@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] coredump01: New core_pattern specifiers test
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> +static void verify_file_pattern(void)
> +{
> +	char dump[PATH_MAX + 32];
> +	pid_t pid;
> +
> +	tst_res(TINFO, "Testing file core_pattern");
> +
> +	set_pattern("%s/core.%%e.%%p.%%s", cwd);
> +
> +	pid = crash_child();
> +
> +	snprintf(dump, sizeof(dump), "%s/core.coredump01.%d.%d", cwd, pid, SIGABRT);
> +
> +	TST_EXP_PASS(access(dump, F_OK), "core.%%e.%%p.%%s expanded to core.coredump01.%d.%d",
> +		     pid, SIGABRT);

Generally this checks is really nice, but it'd be better to
add more checks for the core dump file?

e.g. file size > 0, ELF magic valid, and type == ET_CORE.

FYI:

+static int verify_core_dump(const char *path, long long expected_size)
+{
+       int fd;
+       struct stat st;
+       unsigned char magic[SELFMAG];
+       Elf64_Ehdr ehdr;
+
+       if (access(path, F_OK) != 0) {
+               tst_res(TFAIL, "Core dump file %s does not exist", path);
+               return -1;
+       }
+       tst_res(TPASS, "Core dump file %s exists", path);
+
+       SAFE_STAT(path, &st);
+       TST_EXP_EXPR(st.st_size > 0, "core file size = %ld bytes", st.st_size);
+
+       if (expected_size > 0 && st.st_size != expected_size) {
+               tst_res(TFAIL, "Core dump size mismatch: expected %lld bytes, got %ld",
+                       expected_size, st.st_size);
+               return -1;
+       }
+
+       fd = SAFE_OPEN(path, O_RDONLY, 0);
+       SAFE_READ(0, fd, magic, SELFMAG);
+       SAFE_CLOSE(fd);
+
+       TST_EXP_EXPR(!memcmp(magic, ELFMAG, 4),
+                       "core file has valid ELF magic");
+
+       fd = SAFE_OPEN(path, O_RDONLY, 0);
+       SAFE_READ(0, fd, &ehdr, sizeof(ehdr));
+       SAFE_READ(0, fd, &ehdr, sizeof(ehdr));
+       SAFE_CLOSE(fd);
+
+       TST_EXP_EXPR(ehdr.e_type == ET_CORE,
+                       "ELF type is ET_CORE (got %d)", ehdr.e_type);
+
+       return 0;
+}
+
 static void verify_file_pattern(void)
 {
        char dump[PATH_MAX + 32];
@@ -100,11 +140,14 @@ static void verify_file_pattern(void)

        TST_EXP_PASS(access(dump, F_OK), "core.%%e.%%p.%%s expanded to core.coredump01.%d.%d",
                     pid, SIGABRT);
+
+       verify_core_dump(dump, -1);
 }

 static void verify_pipe_pattern(void)
 {
        char res[PATH_MAX + 32], exe[PATH_MAX];
+       char dump[PATH_MAX + 32];
        int pid_seen, sig_seen, elf;
        long long bytes;
        pid_t pid;
@@ -121,6 +164,7 @@ static void verify_pipe_pattern(void)
        pid = crash_child();

        snprintf(res, sizeof(res), "%s/res.%d", cwd, pid);
+       snprintf(dump, sizeof(dump), "%s/res.%d.core", cwd, pid);

        /* the kernel spawns the helper asynchronously */
        if (TST_RETRY_FN_EXP_BACKOFF(access(res, F_OK), TST_RETVAL_EQ0, HELPER_TIMEOUT)) {
@@ -135,6 +179,8 @@ static void verify_pipe_pattern(void)
        TST_EXP_EQ_LI(pid_seen, pid);
        TST_EXP_EQ_LI(sig_seen, SIGABRT);
        TST_EXP_EXPR(elf && bytes > 0, "%s read %lli bytes of ELF core dump", HELPER, bytes);
+
+       verify_core_dump(dump, bytes);
 }

> +static void verify_pipe_pattern(void)
> +{
> +	char res[PATH_MAX + 32], exe[PATH_MAX];
> +	int pid_seen, sig_seen, elf;
> +	long long bytes;
> +	pid_t pid;
> +
> +	if (static_usermodehelper) {
> +		tst_res(TCONF, "CONFIG_STATIC_USERMODEHELPER is enabled, skipping pipe core_pattern");
> +		return;
> +	}
> +
> +	tst_res(TINFO, "Testing pipe core_pattern");
> +
> +	set_pattern("|%s %%e %%p %%s %s/res.%%p", helper_path, cwd);
> +
> +	pid = crash_child();
> +
> +	snprintf(res, sizeof(res), "%s/res.%d", cwd, pid);
> +
> +	/* the kernel spawns the helper asynchronously */
> +	if (TST_RETRY_FN_EXP_BACKOFF(access(res, F_OK), TST_RETVAL_EQ0, HELPER_TIMEOUT)) {
> +		tst_res(TFAIL, "%s did not report any core dump", HELPER);
> +		return;
> +	}
> +
> +	SAFE_FILE_SCANF(res, "exe=%15s pid=%d sig=%d bytes=%lld elf=%d",
> +			exe, &pid_seen, &sig_seen, &bytes, &elf);
> +
> +	TST_EXP_EQ_STR(exe, "coredump01");
> +	TST_EXP_EQ_LI(pid_seen, pid);
> +	TST_EXP_EQ_LI(sig_seen, SIGABRT);
> +	TST_EXP_EXPR(elf && bytes > 0, "%s read %lli bytes of ELF core dump", HELPER, bytes);

Here as well.

Also we need do something in the helper to save dump file.

> +}

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
