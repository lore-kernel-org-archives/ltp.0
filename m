Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60ED5C433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 16:07:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CBCC3C8A99
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 17:07:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F2883C89C6
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 17:06:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1CB5C600F24
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 17:06:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D2121F3B9;
 Mon, 13 Dec 2021 16:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639411608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dsb33ypcgga/R2kdxp3tdDB6zAxZuqa20//YWF3SW/8=;
 b=mERjy3M0K8u0ROwPO4Vr1LUYw8NK+ky5gzaS4sotcBQHhSm8k9Zc+yMHpWmVKur661LtGa
 MiIzPgT47O7vAzBuGSqNAo5iTKUUpMTKLgpz6InSAPjofcsOcARtOagInuiMIwvJCipMsm
 4/CJY0Hcccq3hbhPpvVx4pJs9IXvz/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639411608;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dsb33ypcgga/R2kdxp3tdDB6zAxZuqa20//YWF3SW/8=;
 b=dIqj9fwXao1ybXm8dnNkxiTI0NtCG6EhZUcGEA+Y2hyJuOFdOSNSHMhZM29NyXMvzL7rN4
 l+bRAvbsW0i6MgAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25BF713E3A;
 Mon, 13 Dec 2021 16:06:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Mf07CJhvt2FAVQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 13 Dec 2021 16:06:48 +0000
Message-ID: <85404e01-f8f0-7209-8ce1-9e8a2a416e86@suse.cz>
Date: Mon, 13 Dec 2021 17:06:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To: Jan Stancek <jstancek@redhat.com>, Li Wang <liwang@redhat.com>
References: <CAEemH2d+-rqscLPdn8q0AEkKaCSkCZ-pET_E=eWWN7Z=aB1k0w@mail.gmail.com>
 <CAASaF6zRCAYo3f4bRc+mxKHnprwtworq-fCif81ECZUWawumbQ@mail.gmail.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <CAASaF6zRCAYo3f4bRc+mxKHnprwtworq-fCif81ECZUWawumbQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] enable OOM protection for the library and test
 process?
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 13. 12. 21 10:32, Jan Stancek wrote:
> On Mon, Dec 13, 2021 at 9:04 AM Li Wang <liwang@redhat.com> wrote:
>>
>> Hi All,
>>
>> As we observed that oom tests occasionally ended with TBROK (Test killed) on small
>> RAM system, the reason seems test process(test_pid) get killed early than the expected
>> victim process so that can't report the status correctly.
>>
>> I'm thinking maybe we can purposely make the OOM ignore test process(test_pid)
>> and the main process? (achieve this only in mem library for OOM test)
> 
> There are likely more processes that could become unintended targets
> (e.g. harness process)
> (if we haven't tried already) Could we make expected victim process
> more appealing target by tweaking its oom_score/oom_score_adj ?

I'm afraid it won't be that easy. The main cause of OOM killer going
postal and killing processes with tiny memory footprint is that a
process executing the mlock() syscall cannot be targeted by OOM killer
at all. That's a known issue in the kernel with no easy fix.

You can protect the main test process using oom_score_adj but chances
are that OOM killer will just kill PID 1 (kernel panic), or find no
killable process left (also kernel panic).

Protecting the test harness is a bad idea because oom_score_adj is
inherited by child processes and it'll affect other tests as well. Given
the nature of OOM tests, I'd rather not assume that the protection will
be properly removed at the end.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
