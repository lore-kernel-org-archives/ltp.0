Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14908C6FA82
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 10:00:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 352533CAD73
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 12:00:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3E783CAD4C
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 12:00:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EE31C6011E1
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 12:00:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D616221A95;
 Fri, 23 Sep 2022 10:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663927218;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N1RlR/JAWdZ+k53BIayAm8s75PXeOfyKhOGxrszhfBc=;
 b=np5PEnPtq8+n+SjDjFw6B4Rogsm0Rs5B+pEh9AWV3zk9YOku13ueyXA19WyWDUOAtKTzlO
 HaShxI7Do3kQfWZSypg34c+TuFNfiZk4NAa6O7CIWux2YiqbkahiTx5zfqroXqm9tnkVv8
 i7A8wJTB1NbvznhDsPuTuBL1yOhcawI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663927218;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N1RlR/JAWdZ+k53BIayAm8s75PXeOfyKhOGxrszhfBc=;
 b=CEJN5sZalzZmKW+G550VlUqgQL+R3WZwUrIrxtr+cPtvdBm14zqLa28x0fViWD5ynMj05S
 NalQ3KuP7Tu5m9CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B029713A00;
 Fri, 23 Sep 2022 10:00:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fPFrKbKDLWMgMwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 23 Sep 2022 10:00:18 +0000
Date: Fri, 23 Sep 2022 12:00:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Yy2DsPHqapfu649o@pevik>
References: <20220921155006.13360-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220921155006.13360-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_supported_fs: Implement checking paths
 against skiplist
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

Hi all,

> Implement tst_supported_fs feature suggested by pvorel in his patch:
> tst_test.sh: Fix filesystem support detection
FYI there is still be need to detect filesystem in particular directory in
ima_setup.sh [1] to avoid df dependency:

if [ "$(df -T $TMPDIR | tail -1 | awk '{print $2}')" != "tmpfs" -a -n "$TST_NEEDS_DEVICE" ]; then
	unset TST_NEEDS_DEVICE
fi

But I guess I'll just reuse the exit code of: ./tst_supported_fs -d $TMPDIR -s "tmpfs"

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/blob/74e4a5c6fb42a1231c149c57efbca345aa93777d/testcases/kernel/security/integrity/ima/tests/ima_setup.sh#L355

> Although the tst_fs_type_name() functions could use some improvements,
> e.g. ext4 must be specified in skiplist as "ext2/ext3/ext4" to get properly
> skipped and vfat is missing from the list of known filesystems.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
