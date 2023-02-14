Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E6CC61DA4
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 14:24:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 400EB3CC619
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 15:24:49 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 140573CB0B8
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 15:24:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 751831A005EA
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 15:24:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2F37222238;
 Tue, 14 Feb 2023 14:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676384676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T5/Aztc19TYPrC6cHfwbDchddFTk/SAo5o5IIH9dp6I=;
 b=M1ZPFtX1nc/CNVg97q397ha2MHpGWfHD3Uc+n/hLUu0eR1RrkMQYgsBB2RkZbYW92rjblz
 tla2Zj6y/apsHhoRIOSSw52x60goAkpYnmZ9OdFbwBx71jKko7DD2aGEh7wdTe44Z0p6Fc
 2Schb5rMcTwAF7yHAc31IbimGDWrI20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676384676;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T5/Aztc19TYPrC6cHfwbDchddFTk/SAo5o5IIH9dp6I=;
 b=KMVbmbbp6/OwwH5CY38ioU9VCOP2UOEoUb8N0yEBDChWbmj23puMbVcZgTGJJgpO545IIa
 7JLq+mrK3OjppcBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18B1113A21;
 Tue, 14 Feb 2023 14:24:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jA/1BKSZ62OeUgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 14 Feb 2023 14:24:36 +0000
Date: Tue, 14 Feb 2023 15:26:02 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Leo Liang <ycliang@andestech.com>
Message-ID: <Y+uZ+ngyoz94gp9e@yuki>
References: <20230214122509.2957225-1-ycliang@andestech.com>
 <20230214122509.2957225-2-ycliang@andestech.com>
 <Y+uOimkvJ76Q8diX@pevik> <Y+uQB1iojD/0oQDY@yuki>
 <Y+uYAn0RyjKBTfj4@ubuntu01>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+uYAn0RyjKBTfj4@ubuntu01>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [v2 2/2] lib/tst_pid.c: Increase PIDS_RESERVED to avoid
 fork failure.
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
> > > > After Adjusting how we count used pid, we increase
> > > > the number of PIDS_RESERVED to void fork failure.
> > > nit: in this case I'd actually keep changes in single commit
> > > (otherwise first commit alone would break tests),
> > 
> > Do we get a different result from ps and parsing /proc? That sounds
> > strange...
> 
> I think that's because "ps -eT" would list threads with the same PID
> but with different SPID.
> 
> I get the following output on my VM.
> 
> ycliang@ubuntu01:~$ ps -eT | wc -l
> 170
> ycliang@ubuntu01:~$ ls -d /proc/[0-9]* | xargs -n1 | wc -l
> 127

Adjusting the RESERVED constant is then a lousy workaround that wouldn't
work for systems with many threads per process.

One alternative would be to open /proc/$PID/status and read the number
of threads from there. Should be as easy as one call to
SAFE_FILE_LINES_SCANF().

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
