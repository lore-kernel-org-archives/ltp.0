Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03361C433F5
	for <ltp@archiver.kernel.org>; Fri,  6 May 2022 14:55:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF0283CA8BA
	for <ltp@archiver.kernel.org>; Fri,  6 May 2022 16:55:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B8D33CA8A6
 for <ltp@lists.linux.it>; Fri,  6 May 2022 16:55:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2098F600860
 for <ltp@lists.linux.it>; Fri,  6 May 2022 16:55:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 62CD921A7A;
 Fri,  6 May 2022 14:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651848901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhj9Nw0De0OV+TKBbu9Q6M/FwMhbC5k0FwAteSFYhk0=;
 b=LjsEVHPtg559SahHPXxrDmkNdN9DUfN4JN4c2laIT18SR9plj1fAFR8BJuzpGo7U5cjBJt
 VhZhahW9RpC2zEQFPQJFOknQt6aVOdAKTUJwM00v5Om/gFBry5vuYpFc+cQgTdgcOfl57O
 zKBT1sQcqh51i061sgFNPtrbJpkau3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651848901;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhj9Nw0De0OV+TKBbu9Q6M/FwMhbC5k0FwAteSFYhk0=;
 b=Gp2+pp3O6/NVsHaEVMk0/ZPOY2SpR8CMoO9zZu8u6z6pzk96Xv0d6OHm1mFdx3mYZoYRTs
 ocUWWFeUtf+OgKBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D66F13A1B;
 Fri,  6 May 2022 14:55:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Wy2XDcU2dWKsfgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 06 May 2022 14:55:01 +0000
Message-ID: <d4552f0b-9f73-ec2b-0c81-3d86eeb36fc1@suse.cz>
Date: Fri, 6 May 2022 16:55:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
References: <20220427125003.20815-1-pvorel@suse.cz>
 <20220427125003.20815-5-pvorel@suse.cz> <YnU0XII0YSf0CUnb@yuki>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <YnU0XII0YSf0CUnb@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/5] tst_test.sh: Cleanup getopts usage
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

On 06. 05. 22 16:44, Cyril Hrubis wrote:
> Hi!
>> diff --git a/testcases/kernel/containers/netns/netns_breakns.sh b/testcases/kernel/containers/netns/netns_breakns.sh
>> index 1ce5d37ef..b7f255cb8 100755
>> --- a/testcases/kernel/containers/netns/netns_breakns.sh
>> +++ b/testcases/kernel/containers/netns/netns_breakns.sh
>> @@ -29,11 +29,6 @@
>>  TST_POS_ARGS=3
>>  TST_SETUP=do_setup
>>  TST_TESTFUNC=do_test
>> -. netns_helper.sh
>> -
>> -PROG=$1
>> -IP_VER=$2
>> -COM_TYPE=$3
>>  
>>  do_setup()
>>  {
>> @@ -49,4 +44,10 @@ do_test()
>>  	EXPECT_FAIL $NS_EXEC $NS_HANDLE0 $NS_TYPE ifconfig veth1 $IFCONF_IN6_ARG $IP1/$NETMASK
>>  }
>>  
>> +. netns_helper.sh
>> +
>> +PROG=$1
>> +IP_VER=$2
>> +COM_TYPE=$3
> 
> Can't we just keep these at the top along with the rest of the
> variables? I do not see them redefined anywhere but maybe I miss
> something.

tst_test.sh has to process command line arguments before these variables
can be set. Otherwise you'd have to put all command line switches
*AFTER* the positional arguments.

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
