Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A24C369AB
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 13:09:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0921E3CB874
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 15:08:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B892F3C0EF7
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 15:08:42 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 95C64601019
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 15:08:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F0D5A21134;
 Tue, 15 Apr 2025 13:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744722520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0FsAhAsuF17BNj0xifYIH6ij0AF2krflrsxx+Tdtf7A=;
 b=PKMnN6dFSlAj4xG4Y3mDWhWIoVh7ffmb244IoxGOR5wGztiN2vNhUwoWIWqFiDqmG9YfOX
 j+grHzVz0Ldo6EUCwl5nj3r3cgl/ABaWRtFTMr7ValUpd5esNt7cKYFGOHxXgPHBz5ujBQ
 PtBPKdNg366YHcG9e9CpNAp7VRnNDCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744722520;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0FsAhAsuF17BNj0xifYIH6ij0AF2krflrsxx+Tdtf7A=;
 b=x5uHcNTvyM8LkVWt+EFMTdhAGIwH2Yveh/ZxrIGZPlTMMuLOh7PtvDH8Z+VszbtL7sjye1
 7zjVZnQZMuLtbvDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PKMnN6dF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=x5uHcNTv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744722520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0FsAhAsuF17BNj0xifYIH6ij0AF2krflrsxx+Tdtf7A=;
 b=PKMnN6dFSlAj4xG4Y3mDWhWIoVh7ffmb244IoxGOR5wGztiN2vNhUwoWIWqFiDqmG9YfOX
 j+grHzVz0Ldo6EUCwl5nj3r3cgl/ABaWRtFTMr7ValUpd5esNt7cKYFGOHxXgPHBz5ujBQ
 PtBPKdNg366YHcG9e9CpNAp7VRnNDCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744722520;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0FsAhAsuF17BNj0xifYIH6ij0AF2krflrsxx+Tdtf7A=;
 b=x5uHcNTvyM8LkVWt+EFMTdhAGIwH2Yveh/ZxrIGZPlTMMuLOh7PtvDH8Z+VszbtL7sjye1
 7zjVZnQZMuLtbvDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E60D5137A5;
 Tue, 15 Apr 2025 13:08:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7N7PN1da/meSHwAAD6G6ig
 (envelope-from <pvorel@suse.de>); Tue, 15 Apr 2025 13:08:39 +0000
MIME-Version: 1.0
Date: Tue, 15 Apr 2025 15:08:39 +0200
From: pvorel <pvorel@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
In-Reply-To: <549aa0bf-86b0-4a06-b4a2-0c158a17b8ba@suse.com>
References: <20250408114432.220841-1-pvorel@suse.cz>
 <549aa0bf-86b0-4a06-b4a2-0c158a17b8ba@suse.com>
User-Agent: Roundcube Webmail
Message-ID: <74b96111220702ca1d5df4e2b4401e07@suse.de>
X-Sender: pvorel@suse.de
X-Rspamd-Queue-Id: F0D5A21134
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; XM_UA_NO_VERSION(0.01)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:mid, suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] sphinx: Update to 7.2.6, python 3.12,
 ubuntu-24.04
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

Hi Andrea,

On 2025-04-15 12:07, Andrea Cervesato wrote:
> Hi Petr,
> 
> feel free to merge.

Thanks for your ack.

FYI You did not Cc LTP ML, therefore I noticed this after push to 
master. But as it was just few minutes after the push, I dared to force 
push the master with amended commit message.

Kind regards,
Petr

> 
> Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> On 4/8/25 13:44, Petr Vorel wrote:
>> Update sphinx to 7.2.6, python 3.12. This requires to update
>> .readthedocs.yml to use ubuntu-24.04 [1], because keep in sync sphinx 
>> in
>> readthedocs with with the one for local development and github CI.
>> Raising python makes sense, as development is usually done on newer
>> distros, we were still using old python 3.6.
>> 
>> This fixes the problem on local development trying to run older sphinx
>> 5.3 on python 3.13 requires to use imghdr, which was removed from
>> standard library (alternatively we'd need to install it from pip via
>> adding standard-imghdr into requirements.txt).
>> 
>> [1] https://about.readthedocs.com/blog/2024/06/ubuntu-24-04/
>> 
>> Fixes: b900b790e9 ("doc: Add sphinx to requirements.txt")
>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>> ---
>> Hi,
>> 
>> first, I'm sorry for a regression. I tested all the previous versions
>> carefully even locally, but in the end the final variant I obviously
>> omit to test.
>> 
>> Tested:
>> https://app.readthedocs.org/projects/linux-test-project/builds/27784588/
>> 
>> Alternatively, we could keep old distros and just add standard-imghdr
>> (without version) to doc/requirements.txt. But sooner or later we will
>> need to upgrade thus I'm sending this version.
>> 
>> Kind regards,
>> Petr
>> 
>>   .readthedocs.yml     | 4 ++--
>>   doc/requirements.txt | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/.readthedocs.yml b/.readthedocs.yml
>> index 5434ef49d6..51825da77f 100644
>> --- a/.readthedocs.yml
>> +++ b/.readthedocs.yml
>> @@ -1,9 +1,9 @@
>>   version: 2
>>     build:
>> -  os: "ubuntu-22.04"
>> +  os: "ubuntu-24.04"
>>     tools:
>> -    python: "3.6"
>> +    python: "3.12"
>>     apt_packages:
>>       - autoconf
>>       - enchant-2
>> diff --git a/doc/requirements.txt b/doc/requirements.txt
>> index 6302ecd9f2..1b9a984547 100644
>> --- a/doc/requirements.txt
>> +++ b/doc/requirements.txt
>> @@ -1,6 +1,6 @@
>>   # Use the same sphinx as on readthedocs.org. When updated, make sure
>>   # sphinx-rtd-theme is compatible with sphinx.
>> -sphinx==5.3.0
>> +sphinx==7.2.6
>>   sphinx-rtd-theme==2.0.0
>>     linuxdoc==20231020

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
