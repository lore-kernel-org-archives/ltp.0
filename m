Return-Path: <SRS0=2Bls=OD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A06BC433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 12:38:26 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67CBE60FBF
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 12:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 67CBE60FBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bell-sw.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38A4E3C86BB
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 14:38:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89EBD3C1DF5
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 14:38:13 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5C00360035F
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 14:38:12 +0200 (CEST)
Received: by mail-lf1-x12d.google.com with SMTP id x27so20788739lfu.5
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 05:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bell-sw-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hAZY4HRBz13kVFO4Uz8Faf/hM2HBr7qOoUdGrcW4PzQ=;
 b=CiGfiT/Qu7wbYfLz9aJhUT/B4MbI9ItxgqtpHcP+H7X5byeHb0J8q7MuE5ReQEsk4G
 O7AoJHfftzDM93+NBXHUs58v9JdM2FhU8vbyu+XXdYe22KbYZLxNdFuK/Xor2tGlc+D6
 EVBlrv/feCn1/KXzaBTBDO8xHf5K8JUvCDZOOIB9Dnc9tKlZcSW0I5p/RS9X//+xndc1
 CqO+T+AW5lat999YVjCsYJC+ODRztadzy39DjqnJZoW63wp/K2KrifquxBtGnmfqYCSV
 W7359Sjcn/9VmGURc7I8OIE4jGvH6IETEECmyygl3sU+QPnYTDBAqTDwk6dAIoey5Lky
 ZXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hAZY4HRBz13kVFO4Uz8Faf/hM2HBr7qOoUdGrcW4PzQ=;
 b=NbfZ7I+0JJcfV8LPoFvsRVggm0Vmd2OF0FFGUoKd7605zJHxkfvxqmd8Bnc2f5Dbta
 aZ6XA94cdFFHp27BZDFVt+AtbxuPXMViU9ahAWvOHVSI7DkAW7nFprwxrJykdGUITKpt
 x8qf7DAHJW0kYiIjXQ6g9JUxY8AtVZidu4RHGhRXtkMGSAiMw3fE8rFWev2FOrrlL7Y6
 yX6Ji8yYyTrbIjlR4SNprGFC1GznCx4f3JJS0qiX5YPixzOoM2qF02PFPL0DVLHK+mo6
 65yqIyeKEEOUROd0jwdWJ7mULGTvoA5JxPZN5A9SVUKiH1SyPf+pOtunC/a+m8Rt7dx4
 45Pw==
X-Gm-Message-State: AOAM533+GjQ8aaJ9qLXood1uNURvWCnuugjfShOdYT+RgCyzoct0ncmO
 PF3zPE2IGQZpOGevUdRMByYUWXNGR+iC
X-Google-Smtp-Source: ABdhPJxrVcHJMKKkIH10SJDnzC5rH0CNbUgZpgLEEprjidiilOinWvHmvAeBwsrRsduf/lK5YDCl3Q==
X-Received: by 2002:a05:6512:358f:: with SMTP id
 m15mr9098040lfr.36.1631536691439; 
 Mon, 13 Sep 2021 05:38:11 -0700 (PDT)
Received: from [192.168.1.52] ([95.161.221.177])
 by smtp.gmail.com with ESMTPSA id k16sm818576lfj.231.2021.09.13.05.38.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Sep 2021 05:38:11 -0700 (PDT)
To: Petr Vorel <pvorel@suse.cz>
References: <TY2PR01MB212429263FC238F44A2C1D7D89C79@TY2PR01MB2124.jpnprd01.prod.outlook.com>
 <410b2b2d-9633-7a57-527a-1663afe5f631@bell-sw.com>
 <TY2PR01MB21246C459BBCD763BD1C0CBD89CB9@TY2PR01MB2124.jpnprd01.prod.outlook.com>
 <0acf816462d49d8a6004c87e36b05d1b@suse.de>
 <8d93deac-eec1-5f87-57a5-c72b2f6e5973@bell-sw.com> <YTsnD0Uw4argiGOJ@pevik>
 <61ea98da-6746-2ad3-c2de-38e148cc9d4c@bell-sw.com> <YT9EAQfa02ytbDPr@pevik>
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Message-ID: <289d5bea-8fd5-b009-18dc-5639f3a0c0d2@bell-sw.com>
Date: Mon, 13 Sep 2021 15:38:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YT9EAQfa02ytbDPr@pevik>
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] network/mpls: sleep 1 after setup in mpls02
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
Cc: suy.fnst@fujitsu.com, ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210913123810.Ne5rNhIFxrRf9CIow22SFZtqIMAe4pvPX1aAwEOZREg@z>

On 13.09.2021 15:28, Petr Vorel wrote:
>> Hi Petr,
>> On 10.09.2021 12:36, Petr Vorel wrote:
>>>> On 09.09.2021 18:53, pvorel wrote:
>>>>> Hi Su, Alexey,
> =

>>>>> On 2021-08-30 11:26, suy.fnst@fujitsu.com wrote:
>>>>>> Hi,
>>>>>> =A0 I found that it's indeed related to ipv6 DAD as you said.
>>>>>> Calling
>>>>>> `ip netns exec ltp_ns sysctl -n net.ipv6.conf.ltp_ns_veth1.accept_da=
d=3D0`
>>>>>> or tst_wait_ipv6_dad() at end of the setup both solves the problem.
>>>>>> However there is one super strange part that the tentative address is
>>>>>> the local link adress of the ltp_ns_veth1:
> =

>>>>>> 5: ltp_ns_veth1@if4: <BROADCAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
>>>>>> state UP group default qlen 1000
>>>>>> =A0=A0=A0 link/ether f2:8f:24:d4:ba:26 brd ff:ff:ff:ff:ff:ff link-ne=
tnsid 0
>>>>>> =A0=A0=A0 inet 10.0.0.1/24 scope global ltp_ns_veth1
>>>>>> =A0=A0=A0=A0=A0=A0 valid_lft forever preferred_lft forever
>>>>>> =A0=A0=A0 inet6 fd00:1:1:1::1/64 scope global nodad
>>>>>> =A0=A0=A0=A0=A0=A0 valid_lft forever preferred_lft forever
>>>>>> =A0=A0=A0 inet6 fe80::f08f:24ff:fed4:ba26/64 scope link tentative
>>>>>> <-------------------
>>>>>> =A0=A0=A0=A0=A0=A0 valid_lft forever preferred_lft forever
> =

>>>>>> However, there is no place using the address in mpls02 test.>> It ma=
kes me wonder how could it be possible to trigger the issue..
> =

>>>> Looks like the problem here in the neighbor discovery of fd00:1:1:1::2
>>>> using link-local address, and vice verse for the other side. mpls is
>>>> using the following route with the address:
> =

>>>> fd00:23::2  encap mpls  60 via fd00:1:1:1::2 dev ltp_ns_veth1 metric 1=
024 pref medium
>>>> so the address there should be in a reachable state...
> =

>>> Thanks for info! I wonder if it's a bug in mpls or elsewhere. WDYT?
> =

>> https://github.com/iputils/iputils/issues/300
> Ah, thanks for pointing this.
> =

>> So we should be careful with the flood option in ping, especially
>> if it is the first test to run after initial test interfaces setup.
>> For example, for mpls02, it is "icmp tcp udp".
> Flooding is done with -f or -i 0. IMHO we don't do that in tst_ping(),
> what am I missing? The bug is about flooding (-i 0) with zero packet size=
 (-s 0,
> but maybe our use -s 10 would trigger the bug as well).

Actually, we do have -f option in tst_ping(), in $flood_opt var.

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
