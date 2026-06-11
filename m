Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A81CD98D2
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 10:20:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE2F83E2AA4
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 12:20:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 971FF3C5593
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 12:20:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 803F86002BE
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 12:20:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED5F16AF11;
 Thu, 11 Jun 2026 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781173230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zFRZe8Es71S1T9Iu8tSTbZodzKW4rWyc8sF9tFmgEVk=;
 b=ZhsQXAUTsuRxmKYjO7kaEjlV6sDw7++nRa0kH3kIsYjqEVHcUWjcZ90wIKDIUurG9Ix5gx
 HoIj000/gGJGgVN5MqXN4hjdEiUFbxzya+803oelVkOmMTdRlVRkcKQTr57YDI1ZPeRIMZ
 uFJcEPCfcWNZoivTxX6bYGQYBNLYQVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781173230;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zFRZe8Es71S1T9Iu8tSTbZodzKW4rWyc8sF9tFmgEVk=;
 b=gbNZg7o/qzExzxyL82PgVl/hbDO4R5WccEJ7JxnVuhkjR/85sE52CzCdUZB/lXcQA/dxXZ
 0nrX/aSt1NjM3ABQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iS9iPzC2;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BrjJ35kU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781173229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zFRZe8Es71S1T9Iu8tSTbZodzKW4rWyc8sF9tFmgEVk=;
 b=iS9iPzC2Nifh74z2TSCOMApj7gnM/+BdAoURyj45gi5HuYqKQwHbl1ZZKqzU3okid+xkj2
 zoQUk17s19rBJn5pzinpVir2aajvnZpWvRZHntIqmZh5WwckoGkHC/YAAxIcLH1uL6u78V
 l0CyM9a2jzTu4yIIXwnmTMCNDmdeLmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781173229;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zFRZe8Es71S1T9Iu8tSTbZodzKW4rWyc8sF9tFmgEVk=;
 b=BrjJ35kUamFKIf0JfgSHxYS0VjVJx6uVgLgd1F8YE6/nryeCc+PFsQGdiV4oqM7UAzgoyn
 f+AyqD5XmcxoyoAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D001A779A7;
 Thu, 11 Jun 2026 10:20:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8WSIMe2LKmoUVwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 11 Jun 2026 10:20:29 +0000
Date: Thu, 11 Jun 2026 12:20:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <aiqL5GmstN8tWU75@yuki.lan>
References: <20260609143237.1246776-1-chrubis@suse.cz>
 <CAASaF6wcvPUD38N=9o+MSv6e0oFkURCiCB-s5o+ip-hVg-x4Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6wcvPUD38N=9o+MSv6e0oFkURCiCB-s5o+ip-hVg-x4Ew@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: ED5F16AF11
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim, intel.com:email,
 yuki.lan:mid, imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_test: Add needs_cpu_vendor to struct tst_test
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
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > CC: Piotr Kubaj <piotr.kubaj@intel.com>
> 
> Acked-by: Jan Stancek <jstancek@redhat.com>

I've fixed the issues reported by the ltp-agent and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
