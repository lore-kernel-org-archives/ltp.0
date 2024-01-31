Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4DFC47258
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 15:15:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13ECF3CFF96
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 16:15:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 266523CB492
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 16:15:02 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4EEBA6019A6
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 16:15:01 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8970C1FB86;
 Wed, 31 Jan 2024 15:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706714100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ClPYoEK4bFUBa7k6SnD9lFD1SaV7eKmtVrefH6DHGA=;
 b=TwAfBM2OXILoTJennKq4re2ISrFXaBLrTrnm72b8S5/xwF0KMciraQ9urTo6FT0aPAGp0U
 gkhNWnYgnZh+EPjgcKbvR6+ADIflWW+yv+ZdY9nHPAtWMVhDsTVc7KshE7A+YRM3BMhFgP
 VF0QMcDjBOi6NqCk87+wSUPL4bLG27A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706714100;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ClPYoEK4bFUBa7k6SnD9lFD1SaV7eKmtVrefH6DHGA=;
 b=dfmz3u5lraoKl4B9imW+Ktbtrb6LxHY+eCRRsVtjCDeeACqSShDyHpgmOXIqeBVSmuKQsW
 SneWzQrA1Co37WDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706714100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ClPYoEK4bFUBa7k6SnD9lFD1SaV7eKmtVrefH6DHGA=;
 b=TwAfBM2OXILoTJennKq4re2ISrFXaBLrTrnm72b8S5/xwF0KMciraQ9urTo6FT0aPAGp0U
 gkhNWnYgnZh+EPjgcKbvR6+ADIflWW+yv+ZdY9nHPAtWMVhDsTVc7KshE7A+YRM3BMhFgP
 VF0QMcDjBOi6NqCk87+wSUPL4bLG27A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706714100;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ClPYoEK4bFUBa7k6SnD9lFD1SaV7eKmtVrefH6DHGA=;
 b=dfmz3u5lraoKl4B9imW+Ktbtrb6LxHY+eCRRsVtjCDeeACqSShDyHpgmOXIqeBVSmuKQsW
 SneWzQrA1Co37WDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AD5B132FA;
 Wed, 31 Jan 2024 15:15:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id SEvuCvRjumWJeQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 31 Jan 2024 15:15:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 31 Jan 2024 16:14:44 +0100
Message-ID: <20240131151446.936281-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131151446.936281-1-pvorel@suse.cz>
References: <20240131151446.936281-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] nfsstat01.sh: Validate parsing /proc/net/rpc/nfs{, d}
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
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

print TWARN when parsing /proc/net/rpc/nfs{,d} fails.
NOTE: better would be to quit with TBROK, but at this point test would
fail to umount.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NFS developers can ignore this patch (LTP specific).

@Cyril, @Martin it'd be nice to fix nfs_lib.sh so that it would support
tst_brk. The problem could be that get_calls() is called inside $()
therefore cd $LTPROOT (to leave mounted directory) in the cleanup
function is done for child process). I would have to redirect to a file
and read it afterwards, right? (similarly get_pcr10_aggregate() in
ima_tpm.sh does).

Kind regards,
Petr

 testcases/network/nfs/nfsstat01/nfsstat01.sh | 29 ++++++++++++++------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
index 708750a97..4c09ae135 100755
--- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
+++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
@@ -11,20 +11,33 @@ get_calls()
 	local name=$1
 	local field=$2
 	local nfs_f=$3
-	local calls=
-	local opt=
+	local type="lhost"
+	local calls opt
+
 	[ "$name" = "rpc" ] && opt="r" || opt="n"
+	! tst_net_use_netns && [ "$nfs_f" != "nfs" ] && type="rhost"
 
-	if tst_net_use_netns || [ "$nfs_f" = "nfs" ]; then
+	if [ "$type" = "lhost" ]; then
 		calls="$(grep $name /proc/net/rpc/$nfs_f | cut -d' ' -f$field)"
 		ROD nfsstat -c$opt | grep -q "$calls"
-		echo "$calls"
-		return
+	else
+		calls=$(tst_rhost_run -c "grep $name /proc/net/rpc/$nfs_f" | \
+			cut -d' ' -f$field)
+		tst_rhost_run -s -c "nfsstat -s$opt" | grep -q "$calls"
+	fi
+
+	if ! tst_is_int "$calls"; then
+		if [ "$type" = "lhost" ]; then
+			tst_res TINFO "lhost /proc/net/rpc/$nfs_f"
+			cat /proc/net/rpc/$nfs_f >&2
+		else
+			tst_res TINFO "rhost /proc/net/rpc/$nfs_f"
+			tst_rhost_run -c "cat /proc/net/rpc/$nfs_f" >&2
+		fi
+
+		tst_res TWARN "get_calls: failed to get integer value (args: $@)"
 	fi
 
-	calls=$(tst_rhost_run -c "grep $name /proc/net/rpc/$nfs_f" | \
-		cut -d' ' -f$field)
-	tst_rhost_run -s -c "nfsstat -s$opt" | grep -q "$calls"
 	echo "$calls"
 }
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
