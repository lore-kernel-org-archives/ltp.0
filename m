Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93488C47077
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 13:25:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFA193CE417
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 14:25:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74D2C3CD0B7
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 14:25:00 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 83C1D600949
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 14:24:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 42FE72216D;
 Thu, 11 Jan 2024 13:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704979498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5FNPWwVV6Wcl5U0amA2jtCO560bxYqtTDfJAfoqAn4=;
 b=AZFmFrotpYv8w8a32yhCX/cQi6JMm4MjgNg6O6ulrngyaxZ1sab7vMH8w0AvRedGhku2Ko
 twj9x0nnUl7Trg+wOd/fAIHvioxLyExt+MpgF7fHpr301fpR49WHFW5mWvfCB8NbXHOtPE
 TY09O4uE/hqz6L816gcBbWJQmzFXbAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704979498;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5FNPWwVV6Wcl5U0amA2jtCO560bxYqtTDfJAfoqAn4=;
 b=evjaelxIyJT0EpoXbrlLqF3fo/j0YHiCVsyTw3t23e6P40h2AQzpkYOZHeAgT4wj5HWHtX
 aB1ru5/DVQFCRpAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704979498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5FNPWwVV6Wcl5U0amA2jtCO560bxYqtTDfJAfoqAn4=;
 b=AZFmFrotpYv8w8a32yhCX/cQi6JMm4MjgNg6O6ulrngyaxZ1sab7vMH8w0AvRedGhku2Ko
 twj9x0nnUl7Trg+wOd/fAIHvioxLyExt+MpgF7fHpr301fpR49WHFW5mWvfCB8NbXHOtPE
 TY09O4uE/hqz6L816gcBbWJQmzFXbAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704979498;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5FNPWwVV6Wcl5U0amA2jtCO560bxYqtTDfJAfoqAn4=;
 b=evjaelxIyJT0EpoXbrlLqF3fo/j0YHiCVsyTw3t23e6P40h2AQzpkYOZHeAgT4wj5HWHtX
 aB1ru5/DVQFCRpAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 368CC132CF;
 Thu, 11 Jan 2024 13:24:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id guXtDCrsn2VIMAAAD6G6ig
 (envelope-from <pvorel@suse.de>); Thu, 11 Jan 2024 13:24:58 +0000
MIME-Version: 1.0
Date: Thu, 11 Jan 2024 14:24:58 +0100
From: pvorel <pvorel@suse.de>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
In-Reply-To: <CA+G9fYvd9X5QdKGPWH+8Pi9NX5J89QLGt=sPRg57jEa3MwKsuA@mail.gmail.com>
References: <CA+G9fYvd9X5QdKGPWH+8Pi9NX5J89QLGt=sPRg57jEa3MwKsuA@mail.gmail.com>
User-Agent: Roundcube Webmail
Message-ID: <946d8254bd2189335a3871181a6d8811@suse.de>
X-Sender: pvorel@suse.de
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-7.16 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; XM_UA_NO_VERSION(0.01)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-1.87)[94.27%];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:url,linaro.org:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ioprio_set03.c:40: TFAIL: ioprio_set IOPRIO_CLASS_BE prio
 8 should not work
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
Cc: lkft-triage@lists.linaro.org, Yang Xu <xuyang2018.jy@cn.fujitsu.com>,
 LTP List <ltp@lists.linux.it>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 2024-01-11 12:35, Naresh Kamboju wrote:
> LTP ioprio_set03 failed for a while on all the architectures.
> Anyone have noticed this failure ?
Works for us in openSUSE Tumbleweed (kernel 6.6.10)

> Am I missing something in Kconfig / userspace tools ?
I have no idea. Is there anything interesting in dmesg?

Kind regards,
Petr

> 
> tst_test.c:1690: TINFO: LTP version: 20230929
> tst_test.c:1574: TINFO: Timeout per run is 0h 05m 00s
> ioprio_set03.c:40: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8 should not 
> work
> ioprio_set03.c:48: TINFO: tested illegal priority with class NONE
> ioprio_set03.c:51: TPASS: returned correct error for wrong prio: EINVAL 
> (22)
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Links:
> 
>  -
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240109/testrun/22021120/suite/ltp-syscalls/test/ioprio_set03/details/
> -
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240110/testrun/22034175/suite/ltp-syscalls/test/ioprio_set03/history/
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
