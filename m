Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1E3CAC598
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 10:28:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1355D3CDC10
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 12:28:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09C6E3CDADE
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 12:27:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DF7A66008EA
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 12:27:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C18361F79A;
 Wed, 17 Sep 2025 10:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758104861;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=mCYtqmwVLr2LFVnb15pKypUP8SiEjk6ZbCqmcJoxoB4=;
 b=Un8IsUy1xD99xr2gWBKWlCCH7nxoxgK7Th8jyGY46J9t37/qlSy8exbXkp1NMZ7oHaJR5z
 5Cxw1Uyykcb+T5nBowxe5S0XY4Bt1ttI7jqM3FAfv5/hMCFIr24g9qvFlKKymk8mhyqhxL
 7P3TkhJ5AgkM1RbBX2N8p2Lew1EYaE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758104861;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=mCYtqmwVLr2LFVnb15pKypUP8SiEjk6ZbCqmcJoxoB4=;
 b=PNV31eSPOsGhnvzwhzPG5DKfhUtSR+bsVYs4Q1AEQXJKlLqyfV6dqsMz8Xi6TDzXsjUjBl
 +zrS7mWJsu2BoyAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="mdZNEr/+";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="OZPnBb/5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758104859;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=mCYtqmwVLr2LFVnb15pKypUP8SiEjk6ZbCqmcJoxoB4=;
 b=mdZNEr/+ZFvP0cb+ZeYCPKWFhsn3zoRtYyygxlkJ+gGVSYJckBSP+MAGBfsVEPXMT4Gy4Q
 YwumdtuGYTKLwo9wvE4bsdXCABduO7Czw4vcy5uTqzZDfxGxKlgVlrjptJiYf59r+bNWCj
 ZQnVX87LV9LXV8FJlHDMZeQnmjoP1yQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758104859;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=mCYtqmwVLr2LFVnb15pKypUP8SiEjk6ZbCqmcJoxoB4=;
 b=OZPnBb/5P/Ukl52RHqHRiHnD31oNSyVDR13e+IvE3oMcqbFI3+ZCV4S8K/ceQvNsLmTLke
 LXAycJ/oneV1qoCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40A351368D;
 Wed, 17 Sep 2025 10:27:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id x3SdDBuNymh+NQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Sep 2025 10:27:39 +0000
Date: Wed, 17 Sep 2025 12:27:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20250917102737.GA336745@pevik>
MIME-Version: 1.0
Content-Disposition: inline
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: C18361F79A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC] 'nobody' user for testing
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
Cc: Betty Zhou <bettyzhou@google.com>, Edward Liaw <edliaw@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

I found a setup bug on LTP IMA tests ima_conditionals.sh and
ima_measurements.sh which use 'sudo' (with user 'nobody'). We have many C tests
in LTP which use 'nobody' user somehow, but they don't actually execute
anything with this account. IMHO these are the only tests which execute with 'sudo'
(please double check me).

$ git grep -l nobody testcases/kernel/syscalls/ | wc -l
160

Because on newer systems (I checked Tumblewed, Fedora, Debian) 'nobody' account use
/usr/sbin/nologin which prevents logging, we 1) either need to change account
to use bash (and restore it back after testing) or 2) create a dedicated user
for testing. I'd try to use 'useradd' and check with grep /etc/passwd if the
user is not already defined.

I tend to use 2), add it only to IMA tests (to ima_setup.sh). But I could
put some more generic code to tst_test.sh so that it can be reused by other
tests in the future. WDYT?

Also, as we heavily use 'nobody' already I'm not sure if it's worth to bother
with putting environment variable allowing a different user. Nobody so far complained,
even AOSP folks seem to be used C tests which use 'nobody' (e.g. fchmod06.c is
compiled [1] and not disabled [2]).

Also, we agreed with Cyril, that it'd be good to convert these 2 IMA tests to
use 'su' instead of 'sudo' because 'su' is simpler than 'sudo' (although when
testing with rapido [3] none of them works out of the box).

[1] https://android.googlesource.com/platform/external/ltp/+/refs/heads/main/android/Android.bp
[2] https://android.googlesource.com/platform/external/ltp/+/refs/heads/main/android/tools/disabled_tests.txt
[3] https://github.com/rapido-linux/rapido

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
