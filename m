Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E0BC5475B
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 10:03:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39FC13CFE05
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 11:03:46 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 359603C802B
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 11:03:30 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B32FA600668
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 11:03:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 49BC617049;
 Fri,  8 Mar 2024 09:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709890320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9XbNEoPhTuZKOx54VKPZGR+X/HPOj8TI4W99YA3m1Qs=;
 b=iASJR/aRSJlTW3nhdbpBxQlH4AypmssnEGOZzPwrBkx4/Ivq/O7E7M1Jm5x0kxXA9nj6AO
 ldldNG1qKugspbvwdAcV/OB+MFdD1CpAeefvQyLs8NMrUPHMFF6rlsWd75gxG5ybuEXJP2
 hy4RxmiAD2VNEJb3f0+VDmJ+pjaHQ5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709890320;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9XbNEoPhTuZKOx54VKPZGR+X/HPOj8TI4W99YA3m1Qs=;
 b=DqH/1DSUvS3FqF8QslT9S9k1QCv+gNtcnLxCqFy5OA3Z5X0wGFN0ukwYIYvbjrEcnzwbp/
 Fmrqsq6QMhFBhyAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709890319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9XbNEoPhTuZKOx54VKPZGR+X/HPOj8TI4W99YA3m1Qs=;
 b=jcz8hVaxWpgpfx3wZsvwyRKId7i1iJEugWa4tpe6ro+rk37ERA/bykYlwu5g3aoQxNbod/
 ChBAe9mwBZv8Wgzn0KbomusNSBnKbOaEjFbv3Td6ZZD04JqdQXX35EJ/Jb8Mdh69PajHVl
 oNISsIpxIiqzcyZzDNsTcaZmsAI95cU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709890319;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9XbNEoPhTuZKOx54VKPZGR+X/HPOj8TI4W99YA3m1Qs=;
 b=X2pQ3fmUd9tjHrXRXJe+oSvE00hPv8Jp//1SXvumFlXn6Ox03VxuCAk7uEeVca9wNsVJ4t
 qY6Ei2FSXdWzqzDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4003913310;
 Fri,  8 Mar 2024 09:31:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yG9UDw7b6mVIYAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Fri, 08 Mar 2024 09:31:58 +0000
Message-ID: <c7027971-9aab-4261-bbd7-f9f221c9387c@suse.cz>
Date: Fri, 8 Mar 2024 10:31:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>
References: <20240306104609.17141-1-wegao@suse.com>
 <6285aaad-79ca-4d7c-8be0-6d846d165df2@suse.cz> <ZepL4jcbj6zmc0E1@wegao>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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
In-Reply-To: <ZepL4jcbj6zmc0E1@wegao>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.34 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; XM_UA_NO_VERSION(0.01)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-0.25)[73.35%];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] chdir01.c: set umask to 0 within setup
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 08. 03. 24 0:21, Wei Gao wrote:
> On Thu, Mar 07, 2024 at 04:18:35PM +0100, Martin Doucha wrote:
>> Hi,
>> you're trying to fix a vfat mount quirk. We should fix that in the LTP
>> library instead, e.g. by setting umask(0) and then restoring the original
>> value inside safe_mount().
> 
> Thanks for your feedback.
> 
> For chdir case i just use Petr's below suggestion(Detail info you can check patch link
> in below):
> 
> "2) tests, which set .mount_device = 1 and have more restrictive umask will not
> work. Workaround would be to not use it and mount manually in the setup().
> Or, reset umask with umask(0)."
> 
> https://patchwork.ozlabs.org/project/ltp/patch/20240219134845.22171-1-wegao@suse.com/

I'd rather avoid mounting in setup unless you need to set special mount 
parameters.

Mount-time umask does not matter for most filesystem. The exception are 
vfat and exfat which don't have any internal concept of access 
permissions and instead you need to either pass mount options that'll 
define access permissions for all files and directories, otherwise 
current process umask value will be used as the default.

So resetting umask to 0 before mount and restoring immediately after is 
perfectly safe. But we should later fix it properly by implementing 
per-filesystem mount options.

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
