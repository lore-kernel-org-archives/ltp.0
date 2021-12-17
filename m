Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7E4C433FE
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 10:35:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8FCA3C9060
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 11:35:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F24C3C876C
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 11:34:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 231B51002036
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 11:34:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EF6701F38C;
 Fri, 17 Dec 2021 10:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639737287;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b6NnzF1wz58Ijw5cZqKk8su0lPsl/RfTk3r3vN/GGBU=;
 b=FSM4Qpjq91dQFkw23KLPZhhQGNsTOasUxdzAJf2UOBOMqrx9HXtHXj0q5Df5edd/zG7m09
 VKhloNP1XDRjQ4ZiKsZPGVMMZ2d5mgwvdzWLmz4+xuQcwinXM+dCCbnR9TBkS/5d4pzZbq
 YaWTtI9rxEU34o/TSRMw+sSIsH2isKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639737287;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b6NnzF1wz58Ijw5cZqKk8su0lPsl/RfTk3r3vN/GGBU=;
 b=ZmyNgJeHsUxCSivtqStegFiSGCAisAL3glSi3AplWLf0WsMASDkmVEQQ8BNEbZ36GT5UPR
 RFE9JY4GvZPVxQDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE6C213DD4;
 Fri, 17 Dec 2021 10:34:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WYCBMMdnvGH+LwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 17 Dec 2021 10:34:47 +0000
Date: Fri, 17 Dec 2021 11:34:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Ybxnxs5t5lDpNS4U@pevik>
References: <1639552849-2251-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639552849-2251-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbxAuBpxXtPXIwYO@pevik> <61BC59C5.9090708@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61BC59C5.9090708@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/4] zram/zram_lib.sh: adapt the situation that
 zram device is being used
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> >> If zram-generator package is installed and works, then we can not remove zram module
> >> because zram swap is being used. This case needs a clean zram environment, change this
> >> test by using hot_add/hot_remove interface[1]. So even zram device is being used, we
> >> still can add zram device and remove them in cleanup.

> > BTW this was added in v4.2-rc1 (6 years ago, 6566d1a32bf7 ("zram: add dynamic
> > device add/remove functionality")). Hopefully anybody still supporting older
> > kernels is using old LTP for it.
> Oh, I don't realize it before. I tested it on centos7 then I think this 
> control interface maybe introduced long time ago.

> To be honst, I don't want to make this case more complex. How about 
> adding  /sys/class/zram-control check after load zram module. If not, 
> just report  case needs to use hot_add/hot_remove interface .

Would it work something like this?

ZRAM_SYSCTL_KERNEL_VERSION="4.2"
...
zram_cleanup()
{
...
	if tst_kvcmp -lt $ZRAM_SYSCTL_KERNEL_VERSION; then
		for i in $(seq $dev_start $dev_end); do
			echo $i > /sys/class/zram-control/hot_remove
		done
	fi

zram_load()
{
...
	if [ ! -d "/sys/class/zram-control" ]; then
		modprobe zram num_devices=$dev_num
		module_load=1
		dev_start=0
		dev_end=$(($dev_num - 1))
		tst_res TPASS "all zram devices(/dev/zram0~$dev_end) successfully created"
		return
	fi

	tst_kvcmp -lt $ZRAM_SYSCTL_KERNEL_VERSION && \
		tst_brk TCONF "test requires kernel $ZRAM_SYSCTL_KERNEL_VERSION+"

	dev_start=$(ls /dev/zram* | wc -w)
	dev_end=$(($dev_start + $dev_num - 1))

	for i in $(seq  $dev_start $dev_end); do
		cat /sys/class/zram-control/hot_add > /dev/null
	done

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
