Return-Path: <SRS0=Poid=QF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91312C433EF
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 14:48:19 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8183F6187F
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 14:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8183F6187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BF313C8973
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 15:48:16 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE4353C015A
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 15:48:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4046F1A00792
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 15:48:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3B3BD1FD29;
 Thu, 18 Nov 2021 14:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637246881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ex1x18/1q+0Y9uLRVaCf3rwNQNlNPk8FR4Jzuh1YxXg=;
 b=bwPBNakPTeKab9AzjjRUYFn8R6uK3c0ec2oKq7uV8RKexRMCBKr82RdMWRPcrIT4oIX5nQ
 xc3BZ6TFI4tZ/0LV/81EJrcTzXh91nT3/3jXLKo/vBSExkl8tHCKbU6Ot0Yigz7MptwQmz
 9O8dfMrqClVdR4bwwt7Ibz0qEqXizSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637246881;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ex1x18/1q+0Y9uLRVaCf3rwNQNlNPk8FR4Jzuh1YxXg=;
 b=O8zNX8Pn8NCOF3ISbbb5AoUZiwkuM+zXbrqcaAxiV31VuYYyOOmMShHhtJ/E0K12dDqUXU
 BnMzsapBw3cd4mAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 202A513D21;
 Thu, 18 Nov 2021 14:48:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qW9sBqFnlmGXDQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 18 Nov 2021 14:48:01 +0000
Date: Thu, 18 Nov 2021 15:49:05 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: tangmeng <tangmeng@uniontech.com>
Message-ID: <YZZn4WWZLf052bIF@yuki>
References: <20211116024706.30853-1-tangmeng@uniontech.com>
 <20211116024706.30853-2-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211116024706.30853-2-tangmeng@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] getuid/getuid03: Convert to new API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Pushed with several fixes, thanks.

- Rewrote the PASS/FAIL messages to be shorter and more to the point

- Added if (!TST_PASS) return; to the verify() fucntion, since if the
  call has failed there is no point in checking the value againts
  the /proc/self/stat

- There were wrong whitespaces that would have been caught by
  'make check' please make sure to run it before sending patches

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
