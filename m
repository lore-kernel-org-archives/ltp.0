Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45A1C00140
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 16:38:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E1393C94B0
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 18:38:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EDC33C920E
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 18:38:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 514071A00906
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 18:38:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 38D6C37BD9;
 Wed, 10 Aug 2022 16:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660149498;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MItfLdweFxok0p5mi3Hbzi2HHTfdH7ywiJcc8f6ZiPQ=;
 b=EeDPFeNXlgEVTaXoM563R3K5p95D1uZ6fG0RBpJNSAWA/Pkn0F62+Db6ALwro0Ta/Bn1Qo
 RipmKmiUH9/vVFFZTwT8BLH9Mc9YUG6AG31NMiO8rAHMv2d6FIe9DD651PBOD2f8zRtp2j
 dylGCS7kh0946FGYJW/TVANFZNMFn5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660149498;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MItfLdweFxok0p5mi3Hbzi2HHTfdH7ywiJcc8f6ZiPQ=;
 b=upBlSqBaQaBfxZdblRRF+CD63FS8XPZwcLmtiP8/r79346c7YMdzXOU25QC3Lc7DYpTQuy
 GgcDJJKvyApp/bDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 094A213AB3;
 Wed, 10 Aug 2022 16:38:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rph8APre82LfcAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 10 Aug 2022 16:38:18 +0000
Date: Wed, 10 Aug 2022 18:38:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YvPe96wKjXH27S2B@pevik>
References: <20220808113756.11582-1-pvorel@suse.cz>
 <20220808113756.11582-5-pvorel@suse.cz>
 <b7559faa-50db-a339-8685-1e0f55427513@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b7559faa-50db-a339-8685-1e0f55427513@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/4] generate_lvm_runfile.sh: Fix bashism
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> Hi,
> I've tested the patchset and the generator script now work correctly.

Thanks! I'll wait unless you suggest anything on 3rd commit and merge with this
style change below. FYI I tested various setup:

for i in y n 0 1 ""; do
	echo "== '$i' =="
	LTP_COLORIZE_OUTPUT=$i PATH="/opt/ltp/testcases/bin:$PATH" $f
	rc=$?
	echo "'$i': $rc"
	[ $rc -eq 0 ] || break
done

I also added patch for this test
https://lore.kernel.org/ltp/20220808122716.18556-1-pvorel@suse.cz/

Kind regards,
Petr

> Reviewed-by: Martin Doucha <mdoucha@suse.cz>

diff --git testcases/lib/tst_ansi_color.sh testcases/lib/tst_ansi_color.sh
index 517b709d0..04e120cf7 100644
--- testcases/lib/tst_ansi_color.sh
+++ testcases/lib/tst_ansi_color.sh
@@ -24,9 +24,16 @@ tst_flag2color()
 
 tst_color_enabled()
 {
-	[ "$LTP_COLORIZE_OUTPUT" = "n" -o "$LTP_COLORIZE_OUTPUT" = "0" ] || return 1
-	[ "$LTP_COLORIZE_OUTPUT" = "y" -o "$LTP_COLORIZE_OUTPUT" = "1" ] || return 0
+	if [ "$LTP_COLORIZE_OUTPUT" = "n" -o "$LTP_COLORIZE_OUTPUT" = "0" ]; then
+		return 0
+	fi
+
+	if [ "$LTP_COLORIZE_OUTPUT" = "y" -o "$LTP_COLORIZE_OUTPUT" = "1" ]; then
+		return 0
+	fi
+
 	[ -t 1 ] || return 0
+
 	return 1
 }
 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
