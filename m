Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EBFC4707B
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 08:26:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B6083CE435
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 09:26:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F9683C4D74
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 09:25:58 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1BBBE6003CA
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 09:25:57 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 302B1220CC;
 Thu, 11 Jan 2024 08:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704961464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8dK+fHyY422dpG7NBNYk8qBMeA87GMj9AMCQiiZ5+yU=;
 b=V8c/b8MzukqdwFp0FhnDg51o1O5BtnzZxlHeHrFix84ACrh8g0HK9xhyAQjGfyIuoRx3+N
 PtKDMSDiu6CJSRn0ERHiCDwiiWvellFcY9v5TATTA0Xp5guQaftGVqanV+yr2Sn/wLiXt1
 LfvWQf8rAtJlDZfGvYqLu0qvH6grUWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704961464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8dK+fHyY422dpG7NBNYk8qBMeA87GMj9AMCQiiZ5+yU=;
 b=L4VbpG0NRYmNRXk7AcHA78GDrzTUMbq7eYPtltXZGE7FATHR+RpRMhOnEYGk2pbwnmzhIF
 QfwaBcWLofpMd9BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704961541;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8dK+fHyY422dpG7NBNYk8qBMeA87GMj9AMCQiiZ5+yU=;
 b=Om1baiXsq8FA7rJnyJ4UwvAAKYJCLa3yNhkej7kVaEpY+arBUab1qD25RkQn59qTLGwJK/
 pOtDBAE7Ep/g0VWRHt0UdOPLWp2s+XKkjPJbYZOPU92UFA7vHlL69SXKobWZnKSJm5AanW
 7VtsOBs2pbemfN3amErNLdN8OSZuKqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704961541;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8dK+fHyY422dpG7NBNYk8qBMeA87GMj9AMCQiiZ5+yU=;
 b=bKvcBPzPPM7sNJDfgjU3aWpGZDEMLskuR681ZMm0kp5WbN3j1XB444ArA9J4OdagwU2O1L
 fNmbrnpzdwsqaWAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F141138E5;
 Thu, 11 Jan 2024 08:24:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id zqyuIbiln2UiIAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 11 Jan 2024 08:24:24 +0000
Date: Thu, 11 Jan 2024 09:25:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Pengfei Xu <pengfei.xu@intel.com>
Message-ID: <20240111082549.GA1856272@pevik>
References: <cover.1704868967.git.pengfei.xu@intel.com>
 <f60daf00d0de49e54a5389c73c90994e7711a7d1.1704868967.git.pengfei.xu@intel.com>
 <20240110175931.GA1766165@pevik>
 <ZZ9aR/SEWl57q6aR@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZZ9aR/SEWl57q6aR@xpf.sh.intel.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.31 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.01)[46.81%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] keyctl05: increase dns_res_payload data
 due to kernel code changes
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
Cc: Heng Su <heng.su@intel.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Petr,

> On 2024-01-10 at 18:59:31 +0100, Petr Vorel wrote:
> > Hi Xu,

> > Good catch, merged.

> > BTW any change how to trigger autoload of dns_resolver ?

> > # ./keyctl05
> > ...
> > keyctl05.c:99: TCONF: kernel doesn't support key type 'dns_resolver'
> > ...

> > # modprobe dns_resolver
> > # ./keyctl05
> > ...
> > keyctl05.c:143: TPASS: updating 'dns_resolver' key expectedly failed with EOPNOTSUPP
> > ...

> > We consider modprobe as the last result.

> Yes, it needs to load dns_resolver module to test it.
> Or set kconfig CONFIG_DNS_RESOLVER=y.

Well, that would not work for kernels in linux distros.
Therefore I'll send a patch to add modprobe functionality.

> Due to the bundary issue fixed patch as follows, I will send another patch to
> set to 6 bytes coming data for add_key syscall for passed boundary checking:
> https://lore.kernel.org/all/1784441.1704907412@warthog.procyon.org.uk/

Thank you!

FYI we're planning LTP release in the end of month, it'd be great if you send
patch soon so that fix is included.

Kind regards,
Petr

> BR,
> Thanks!


> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
