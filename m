Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF982C4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 15:10:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D32823CBE77
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 16:10:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAA3D3C2B4D
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 16:09:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0CEEB6002B0
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 16:09:48 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 5583633750;
 Mon, 12 Dec 2022 15:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670857788;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HgrBF0Fn0tzq0AZihtfTMeepnZhBRM3Uih+ARML2gWg=;
 b=V2lT/fdL3d2TK1aIyDUoeRizDHcj+aTvzx1Cn1DEzc9b+4H+ibAffkx3y6P/ZLVn504jYl
 fYRTLeZEzHtp4omQ8yHSguYCGlEWsu1PJljRO+/F/2ags3ClWADb1Xa/Kd5EqByqMp20fc
 geZ4NxMaNPe65UCS3E9gs3bd8WNrBsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670857788;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HgrBF0Fn0tzq0AZihtfTMeepnZhBRM3Uih+ARML2gWg=;
 b=7k+rlvRPR20361HE5QvzUfHHZp8rwEGnOU6edWW0fVyRogxa5491cDrI4rxymgHQ2lw8fL
 DYOrkulhk+rjpUAg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 1F78E2C141;
 Mon, 12 Dec 2022 15:09:48 +0000 (UTC)
References: <20221202103011.12206-1-andrea.cervesato@suse.com>
 <87h6yauu9v.fsf@suse.de>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: rpalethorpe@suse.de
Date: Mon, 12 Dec 2022 15:06:51 +0000
Organization: Linux Private Site
In-reply-to: <87h6yauu9v.fsf@suse.de>
Message-ID: <875yegu090.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add runltp-ng to upstream
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

Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hello,
>
> Andrea Cervesato via ltp <ltp@lists.linux.it> writes:
>
>> runltp-ng is the next generation runner for Linux Testing Project and it
>> will replace the current obsolete runltp script in the next future.
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>  .gitmodules     | 3 +++
>>  tools/runltp-ng | 1 +
>>  2 files changed, 4 insertions(+)
>>  create mode 160000 tools/runltp-ng
>>
>> diff --git a/.gitmodules b/.gitmodules
>> index a3c34af4b..e85fc6279 100644
>> --- a/.gitmodules
>> +++ b/.gitmodules
>> @@ -4,3 +4,6 @@
>>  [submodule "tools/sparse/sparse-src"]
>>  	path = tools/sparse/sparse-src
>>  	url = git://git.kernel.org/pub/scm/devel/sparse/sparse.git
>> +[submodule "tools/runltp-ng"]
>> +	path = tools/runltp-ng
>> +	url = https://github.com/acerv/runltp-ng
>
> NACK
>
> We should move the project into the linux-test-project org first.

I am in favor of doing this, but set to "changes requested" in
patchwork.

>
>> diff --git a/tools/runltp-ng b/tools/runltp-ng
>> new file mode 160000
>> index 000000000..b08471158
>> --- /dev/null
>> +++ b/tools/runltp-ng
>> @@ -0,0 +1 @@
>> +Subproject commit b0847115891bd3dddbe920a716342917e7088379
>> -- 
>> 2.35.3
>
>
> -- 
> Thank you,
> Richard.


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
