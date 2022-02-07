Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676E4C433F5
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 11:37:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 592E83C9837
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 12:37:02 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE8F23C07BD
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 12:36:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 29DDF600768
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 12:36:52 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 4A3B4210FD
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 11:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644233812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eoip4JrZvERW6o8FWwAu6+ltRiQHgWQ7QIrgsMU1Xwc=;
 b=CkC1dIzoFdgfp3gsqyiLQIwQPvi++Fb+btjeUnvRu/+HSgn6PVvFcMmXKUEHdGQMfWdkUV
 WCN/gIYDgn0TMv+ieSuk1xEyBtxI3Z7vOLrlJ9UcxeHj9Z2LOPRGGGka1dTZy1lLNOleyF
 2g4Gc2pAFS8YJ/u7yRFKeMtdER2wVmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644233812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eoip4JrZvERW6o8FWwAu6+ltRiQHgWQ7QIrgsMU1Xwc=;
 b=mhvKmbn1kK4ypIp8CPHK0j2jgydV7MF72+3uUgtY5jY2Vhk0OsGOHk1hawaGMnGZGrqOV2
 cpt/BTbtDp2HMIAg==
Received: from g78 (unknown [10.163.24.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 18C2DA3B85;
 Mon,  7 Feb 2022 11:36:52 +0000 (UTC)
References: <20220203081820.29521-1-rpalethorpe@suse.com>
 <20220203081820.29521-4-rpalethorpe@suse.com> <YfvU6fqZK2d1PKVg@yuki>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 07 Feb 2022 11:36:21 +0000
In-reply-to: <YfvU6fqZK2d1PKVg@yuki>
Message-ID: <87pmnyx60c.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/5] API/cgroup: Add memory.min
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>>  static const struct cgroup_file memory_ctrl_files[] = {
>>  	{ "memory.current", "memory.usage_in_bytes", CTRL_MEMORY },
>> +	{ "memory.min", NULL, CTRL_MEMORY },
>
> This is obviously OK.
>
>>  	{ "memory.max", "memory.limit_in_bytes", CTRL_MEMORY },
>>  	{ "memory.stat", "memory.stat", CTRL_MEMORY },
>>  	{ "memory.swappiness", "memory.swappiness", CTRL_MEMORY },
>> @@ -896,7 +897,7 @@ tst_cgroup_group_mk(const struct tst_cgroup_group *const parent,
>>  
>>  	for_each_dir(parent, 0, dir) {
>>  		new_dir = SAFE_MALLOC(sizeof(*new_dir));
>> -		cgroup_dir_mk(*dir, group_name, new_dir);
>> +		cgroup_dir_mk(*dir, cg->group_name, new_dir);
>
> However this change should go in in a separate ptach.
>
> I guess that what we do is that we store a pointer passed to us by the
> user of the API into our structures instead of the copy we made, which
> is mostly working fine, since we pass pointers to statically allocated
> strings, but it should be fixed. But please do so in a separate patch.
>
> If you split this change into two separate patches you can consider both
> of them to have my Reviewed-by:

Ah, this should have been in the patch to make it printf like.

>
>>  		cgroup_group_add_dir(parent, cg, new_dir);
>>  	}
>>  
>> -- 
>> 2.34.1
>> 
>> 
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
