Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2236CC5475B
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 10:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709721579; h=message-id :
 date : mime-version : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-transfer-encoding : content-type : sender : from;
 bh=09gtoWp8BUjgRCYxeJebywR+61z7BUgirq86lHXmxBI=;
 b=mW34j8ZxuA3jRzA6LvpVORUIxsoMBpFFr+lYqVsbIdhA71HhkBHxsgsxUiE8QxSIerXDI
 ah8clq2kKJdQNeZu0kQL8RVfTSNYEGkXABsjdr1S2Tb8yOFHm8nyDS5V/grCFxOt2vBtd9n
 jk08TLjJMjaOYIViBASFsUF2lgwepQg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7605E3CE9D7
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 11:39:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66D293C3320
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 11:39:18 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1459B14088DD
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 11:39:17 +0100 (CET)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a45670f9508so400988566b.0
 for <ltp@lists.linux.it>; Wed, 06 Mar 2024 02:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1709721556; x=1710326356; darn=lists.linux.it;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7dhATQFwFM+dGo9Jiphsv8ZkG3stGmGCxTl3A0zNoiI=;
 b=M2kX0i+06g394YztqK5IBOFK0LryNHva5nhiFlL2Oqla9C2UPg12WwZSOAX2lPy489
 lQ5qmsXA/ia1JvCB9k4WTOd7R+7IopqLudM+0VPB9A1gyA+crNtXlJcZV42O7z/C5l3r
 DN6YFR6Egl7PVmcPYftfSTmo8n+l0q2PP0BJBG/qle6OqNZxQ2CgyUTH2E+oUUwoQQfv
 MY2RAjrKjSltc9A9dIdA2BJm4WiEQs4hrIjck7k2JW/y2lNWm4FfloL0BbR+jMZHHAGH
 ZoKLi/n9JFjUVh+gA0yvbBplHnUl9Mrybaw8FFlEGu71vXMgFqxZI/FbxHravwNHAKAN
 r57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709721556; x=1710326356;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7dhATQFwFM+dGo9Jiphsv8ZkG3stGmGCxTl3A0zNoiI=;
 b=GjcsjxxPJXPkNO3Bvb9PmySS5DF1lW4HH69pWHY+SFhpyTYDYO/Ovu5Bm16GeBS6u1
 kXeKozsERjThqdB8e6mO/VtgKlapp4EC/x0Dy7oNIld1nHye1wHGeXtBcJLiIG9ra8Sb
 csnDs7g1FRzi4jZBkaAM0Oa60mZa9M/ELZL0kjEK3tlVDDvQj3Mbu43XDoOcOe1oZ5Ih
 yyxUJ0EvyedrHu+gCKaVhd6KtcpMdjtrEoSxr9vJMTDrwI+X7jtHb+OVShlaVqgBUk8H
 tA/ozXLXegLPSRY2QOKv7tpsMxjZGt4KLF1CxrEuiswO5jTyCMe9m4rsfhujRy4NED8A
 TjJg==
X-Gm-Message-State: AOJu0YyIDpTvbt+ySJA+dtyQBtwIKbdStzhYZ8Mt/7jVCdPwcFMI+gsT
 pi7PXbMf4WZ8RdQ5jQD4WoFlnRnFO8K8nnGMuMYEfTl5oIywfQiNzA/xCqaIoro1UnPTrS4MSit
 J
X-Google-Smtp-Source: AGHT+IF7sIHhRoEuvKusdKOrem7ZGI0Ciy6nPiK5/wQvxMwyeuWAv1EaYSL5HS2v2H1v78lNvG7T7g==
X-Received: by 2002:a17:906:5295:b0:a44:55e8:53b6 with SMTP id
 c21-20020a170906529500b00a4455e853b6mr10909652ejm.32.1709721555638; 
 Wed, 06 Mar 2024 02:39:15 -0800 (PST)
Received: from [10.232.133.85] ([88.128.88.134])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a1709060dc500b00a4537466591sm3511958eji.32.2024.03.06.02.39.15
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 02:39:15 -0800 (PST)
Message-ID: <7509ec18-035e-4cdd-824f-5d8eac4bf3ff@suse.com>
Date: Wed, 6 Mar 2024 11:39:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] March meeting summary
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Thanks to all participants of our monthly LTP meeting. A short summary 
on what we talked about:

- we have ~300 tests to refactor into the new LTP API, which 2/3 of them 
are really low to slightly mid complexity

- in order to attract more developers and reviewers, we need to provide 
more documentation about the LTP project. This can be achieved by 
sharing workshops, blogs and documentation that can help junior 
developers to start working on small LTP tests. In short, to simplify 
documentation reachability

- to improve our documentation we can try "readthedocs.io" that is 
similar to what kernel devs are using (check 
https://korg.docs.kernel.org/docs.html). In this way we can also provide 
a more readable LTP website

- to introduce a special flag to communicate with tests runner (kirk) 
when we need to reboot the machine during tests

- we discussed about some tooling, AI, reviewing tools, bots


Thanks for all the suggestions and improvements.
Have a good day and see you the next month!

Best regards,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
