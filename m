Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A4EC433F5
	for <ltp@archiver.kernel.org>; Wed, 24 Nov 2021 10:06:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6946A3C60B1
	for <ltp@archiver.kernel.org>; Wed, 24 Nov 2021 11:06:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 349AA3C0894
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 11:06:36 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9354F601F62
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 11:06:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A109C1FD62;
 Wed, 24 Nov 2021 10:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637748394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=37GSqjUyO0F50GEYFnIPwIgS9mL2VXBBFSn4KkmBmZc=;
 b=BhCqmuasFlnfZFmaYj3g5O/EU1zKyUtmTi3fK15QW5b0rGU+g/HTdEdGkm0PrXkP1xrsK/
 4uxdTCGGHb6f/1rKf6m4NtBB/ommhttVg38UjNeAb/gcXJhknSj3lv6ePM86MzZHVU0hyI
 6Z+1waVB46z1sX+69DR9puMvRnl7UpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637748394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=37GSqjUyO0F50GEYFnIPwIgS9mL2VXBBFSn4KkmBmZc=;
 b=9QjIXK9ayY8DOlzs3ssGo5DP0hQ7M3yogt14Ebrz3okGhKlW7I7P7DhLkVgqIyhlFBxA/V
 DH7nloetyFMw4SDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8769C13EE7;
 Wed, 24 Nov 2021 10:06:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VySvH6oOnmGGWQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 24 Nov 2021 10:06:34 +0000
Message-ID: <53cbb0b6-0744-d6e8-3f7b-5991b17e915f@suse.cz>
Date: Wed, 24 Nov 2021 11:06:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20211123151537.14913-1-mdoucha@suse.cz>
 <20211123151537.14913-3-mdoucha@suse.cz> <YZ1Dmbh+m6blfLzZ@pevik>
 <9d0f2161-4c10-6318-5a15-470cc12fe76c@suse.cz> <YZ4LAN2RrJntGlFq@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <YZ4LAN2RrJntGlFq@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] Add test for NFS directory listing
 regression
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

On 24. 11. 21 10:50, Petr Vorel wrote:
> Hi Martin,
> 
>>> -	echo "-n x    Create x files and x directories, default is 5000"
>>> +	echo "-n x    Create x files and x directories, default is $FILE_COUNT"
>>>  }
> 
>> If you run `nfs07.sh -hn 123`, your version will print that the default
>> is 123.
> 
> Out of curiosity (as it's not anything important) not sure what's wrong on my
> side (I tested it before I suggested it, I also reinstalled LTP to make sure
> it's updated), but it works as expected:

Ah, sorry, I've put the arguments in the wrong order.
`nfs07.sh -n 123 -h` will overwrite $FILE_COUNT before printing usage info.

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
