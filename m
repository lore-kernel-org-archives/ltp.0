Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AA4103E173
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 13:27:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73DBA3E58F4
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 14:27:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 959313E5CAA
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 14:26:54 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 641C3200D0A
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 14:26:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BDA3C5BD51;
 Wed, 18 Mar 2026 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773840404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lJTWWmWal3J4dkM0BK4CAsVA7Mn0TQLSU6jgQShB0Ek=;
 b=av1f2Q3Qgbg98kXlErnz8pRuGd26S0X+oEKJsKLyytasRzyX9DValH9j7FRB3+iWcGxEqF
 QocDvX0zjc/3NbRkPZrL6eaig1By4m3nhAk7XOIUBsDZ6Unpe0ba29nzU8ztnQgPQAfOq/
 JDTreOAfPidJX/qKizt5FrU3PB1e8NM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773840404;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lJTWWmWal3J4dkM0BK4CAsVA7Mn0TQLSU6jgQShB0Ek=;
 b=NhJOAQ/OmrB40oy994UposLvH0UoHewKee6MpY04vmfh7i5kED5hcjtX6Q0KjXGjDa3j03
 l0fG8fWu9ssBNcBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773840403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lJTWWmWal3J4dkM0BK4CAsVA7Mn0TQLSU6jgQShB0Ek=;
 b=pMxH9BoBREXqDSu8rxMJtMrVOmQpkXOXJFZilESZTrfgnzghR9gLrrpFnPmDnOrhvERxtj
 rdq4LESy7aZcWtpIBl2M+nzRYNYrDGujaFmhp3tL8T9AfwJnqn4oSLYEhGt2yAsQxr0FrD
 xJQga1sT/Z5nnRSC+TX7J3EItR6LmPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773840403;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lJTWWmWal3J4dkM0BK4CAsVA7Mn0TQLSU6jgQShB0Ek=;
 b=qEbd1tS5joy8OfGQTEhsJ1pOKIDURakEqXQ0glt1ZAqGwStUkaeHYDW1dW0XGAUh4Jmp01
 yVZLkS4ffr+1qbDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BCC64273C;
 Wed, 18 Mar 2026 13:26:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sKe5IBOouml3HwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 18 Mar 2026 13:26:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Mar 2026 14:26:38 +0100
Message-ID: <20260318132639.18818-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318132639.18818-1-pvorel@suse.cz>
References: <20260318132639.18818-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] runpwtests03.sh: Replace modprobe -l to lsmod
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

modprobe does not have -l option. And 'busybox modprobe -l'
would require busybox as a dependency. List modules with find.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/power_management/runpwtests03.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/power_management/runpwtests03.sh b/testcases/kernel/power_management/runpwtests03.sh
index 72ad2ad687..ebd0957e64 100755
--- a/testcases/kernel/power_management/runpwtests03.sh
+++ b/testcases/kernel/power_management/runpwtests03.sh
@@ -115,9 +115,11 @@ pwkm_load_unload() {
 	RC=0
 	loaded_governor=`cat \
 		/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`
-	for module in `modprobe -l | grep cpufreq_ | \
-		cut -f8 -d"/" | cut -f1 -d"."`
-	do
+
+	modules=$(find /lib/modules/$(uname -r) -type f -name '*.ko*' |
+		grep cpufreq_ | cut -f8 -d"/"  | cut -f1 -d".")
+
+	for module in $modules; do
 		#echo -n "Loading $module ... "
 		if [ $module != "cpufreq_$loaded_governor" ]; then
 			modprobe $module >/dev/null
@@ -128,9 +130,8 @@ pwkm_load_unload() {
 			fi
 		fi
 	done
-	for module in `modprobe -l | grep cpufreq_ | \
-		cut -f8 -d"/" | cut -f1 -d"."`
-		do
+
+	for module in $modules; do
 		#echo -n "Unloading $module ... "
 		if [ $module != "cpufreq_$loaded_governor" ]; then
 			modprobe -r $module >/dev/null
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
