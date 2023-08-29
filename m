Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6893AC83F12
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 10:29:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4495A3CC060
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 12:29:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C03D63C8948
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 12:29:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9D858200AD3
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 12:29:18 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 072EB1F750;
 Tue, 29 Aug 2023 10:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693304957;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b9S9x88v5UKRuylyJFfr6TXOWQe0lHSASBPH+emyDxY=;
 b=PWxXKP8F+PpFTxqs1Cvem51wdYo+dpDTQdJppVku6yxpceZp9r77+N3rswzgxhTPOZbkTt
 Maef4kKKBYXz3QVUX2DXQK6Jew/quviWdCyXUPmkSsbRruA83wDtIZsMcEPU8lWIQmI5eg
 YCmgztsOZO9NmeA8VR/ya1Eo+XWsNak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693304957;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b9S9x88v5UKRuylyJFfr6TXOWQe0lHSASBPH+emyDxY=;
 b=Q7I4IkA7++jKA+WoI3Je+aSKIg8AKqFEd4ZcwkEXVXfS4u7DERLeCFJZ735M9zd11juGoA
 HlI/fJvDw4U9kCDw==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 341C72C143;
 Tue, 29 Aug 2023 10:29:16 +0000 (UTC)
References: <20230721071831.83546-1-limin154@huawei.com>
 <20230720152607.GA1339322@pevik>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Aug 2023 11:25:18 +0100
Organization: Linux Private Site
In-reply-to: <20230720152607.GA1339322@pevik>
Message-ID: <87v8cyi1l1.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH]utils/sctp: bugfix for testlib/sctputil.h
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

Petr Vorel <pvorel@suse.cz> writes:

> Hi Li,
>
>> The socket is created and bound immediately without waiting for the handshake after close(sk).
>> "bind(): errno=EADDRINUSE(98): Address already in use" may be reported.
>> Use SO_REUSEPORT to allow multiple sockets to be bound to the same port.
>
> How this can happen? Running tests too quickly one after the other?
> Or what is different on your SUT? I'm not sure if it's good idea to always test
> with SO_REUSEADDR and SO_REUSEPORT.
>
>> Signed-off-by: Min Li <limin154@huawei.com>
>> ---
>>  utils/sctp/testlib/sctputil.h | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>
>> diff --git a/utils/sctp/testlib/sctputil.h b/utils/sctp/testlib/sctputil.h
>> index 176d623f0..b51a3f9b0 100644
>> --- a/utils/sctp/testlib/sctputil.h
>> +++ b/utils/sctp/testlib/sctputil.h
>> @@ -133,6 +133,15 @@ extern int TST_CNT;
>>  static inline int test_socket(int domain, int type, int protocol)
>>  {
>>  	int sk = socket(domain, type, protocol);
>> +	int true_const=1;
> What is this unused variable for?

It's used as the socket option value.

>
>> +
>> +	if(setsockopt(sk, SOL_SOCKET, SO_REUSEADDR, &true_const, sizeof(int))){
>> +		printf("set addr err\n");
> Besides missing spaces in if (if (..) { ), we have SAFE_SETSOCKOPT().
> Or tst_brkm(TWARN, ...) could be used (we don't use printf directly in
> LTP).

+1 for SAFE_SETSOCKOPT

>
> Kind regards,
> Petr
>
>> +	}
>> +
>> +	if(setsockopt(sk, SOL_SOCKET, SO_REUSEPORT, &true_const, sizeof(int))){
>> +		printf("set port err\n");
>> +	}

We don't need to set it twice.

Setting patch as changes requested.

>
>>  	if (sk == -1) {
>>  		if (errno == EAFNOSUPPORT)


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
