Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D8BC0219D
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 12:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739190374; h=message-id :
 date : mime-version : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-transfer-encoding : content-type : sender : from;
 bh=YmtdIwS7a0O4M8CQ/efV1/4CTxPTqKUllI+EOYifFu0=;
 b=G1sLFoArXCBXerOZ6YwX4pht9ZApFe5Oa8LfEApUf8bpFB+GyRcxOdBy4045s4ykVd8oQ
 Niq07+a6nV/rmILg4JiYaqutYUM9t3wpf8V6xBz+rUaJzZMrBWxn3Z/bk59CrdPYbyubraT
 JAmoHfa7t9sVBVP79rg4p0JjLlpBtm8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E0CE3C98B2
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 13:26:14 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B32F3C9363
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 13:25:52 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 066D91A0111F
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 13:25:51 +0100 (CET)
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso29151545e9.0
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 04:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739190350; x=1739795150; darn=lists.linux.it;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YfRHx4k7PD/e+hDxstqu9cZPhncAg+U4HdQu075jFj8=;
 b=ebn1VAEEl9w4TfnM/6+LTboP1uaZ0v1YyXPyOWoJuFq4iZAmJVsof/7Mv8A2mOGm2Z
 i7c7bOpyJbmoV7I2VWuL4nqqIxWUQKHTNNwtbd7zvAp81OstI8ly1amYjyYkOGdYhn2L
 aHP/BTZF1yZnR84liMudVVJIh+M80CQY69H4DARbZFpYrhj0EGtmwlouUD1STO3pljPL
 f/zX38Ehw1uKAp5jeHKA0K7eeic/NymxfHiNHTGCWShmMMj/EIedla8MNyL9y2RqdAyw
 mIqLwE8kPqktP0dn2h0UUOesWmPWqD33tuvBCD+lBhczOYU5c3Y6/eu80ta7xyWN5o9o
 eGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739190350; x=1739795150;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YfRHx4k7PD/e+hDxstqu9cZPhncAg+U4HdQu075jFj8=;
 b=FMC0S7YmyZNLhtHe1HuQpcp0neeHiSKAe5CuiLjwIeC1KlJA5vttxTBbqm9eEPAkEY
 OaNiWfOvSjWjrdXwS73WZlGj+TgDiSknppVXXHh6evtjAD5Cp1/MQhjF6XORz/SANLlR
 4l8VfDeagJkVthrI0XBf63ielSpzDiW0vNVsboOXHATLMCydDtw/yx5T7993x+qG6N/6
 BudYMcnAAVvxom+VFZUHi0rUdr6uCjIemL0SmQKdykAuj5dwrpZHGLuy1PeledrOGIgS
 gpUFiF8Gu0y9X0W3HmhBcGkyrXCILCw098m/8iviuJxn6R8iEvvCfwQWq1PeuePWpB26
 I7dw==
X-Gm-Message-State: AOJu0Yxe+xOI8SpcbTvB2A00ASxV9oF4oIY6qw5Aq9LY2HSLz+NZ59YI
 WxxV+GKU9wtVOXBVa+1004g/kXH2SoesI0kx6KXs4t/Fl2vh4X4BZewhLEP99/61Nk5c9vjCWUm
 zeZI3Ew==
X-Gm-Gg: ASbGncs9uG3EgBxLL+8kVhIjpMHAV9/5gYr3vGyDgsw82E63w/0GxPUSpEVseHY7i+q
 nyeijWeIumqbOKHUIhqhZFgMev0EojtWYPdAcRzxNKhMzM9uIW/1l2QtgGZnU3zH6jWEQj79LpY
 ewanrSHjzd5pe1kDhtc4L41TZUC/VVJAUPhnm6IQOKii19/Q+a+IhNdJ7MCmx16usvS63weGKFe
 mGYY///Zx9K5TGkyimz3ubVGMhF3rq+2SaqogQN68ha3nTd7ESu9ipp7fjDTTNlA/qcHBMkc/mC
 2KlpTw63ha0mlbQ6X61wsSBnyCxlDLip0XZnAnP0BCGOvQTjZUoVp4h2geYkcKyvWEDF6gb66gf
 eI6BuN8TkrDFLpgFIV3wPi3UdQ5sHyV0HYR0mP6iC+NsRSPHkSdM=
X-Google-Smtp-Source: AGHT+IHNdFGyyjVvyuLLzYh/E/MG9+TvKBeYPp0BNhQnb8qIJDOEpToaXe0Y+grPKPMxpBIJTQJeMw==
X-Received: by 2002:a05:600c:4f90:b0:434:a4b3:5ebe with SMTP id
 5b1f17b1804b1-439249b2aecmr100573835e9.24.1739190349875; 
 Mon, 10 Feb 2025 04:25:49 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390db11750sm183172865e9.40.2025.02.10.04.25.49
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 04:25:49 -0800 (PST)
Message-ID: <34c1451a-2adb-4efd-874b-e2d9b660e56f@suse.com>
Date: Mon, 10 Feb 2025 13:25:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Test Project <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [Open discussion] docparse handling
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

Hi all,

we just added a test catalog in the LTP documentation [1], but most of 
the tests are still using asciidoc as the main tests' description 
syntax. Obviously, we need to switch to RST [2] syntax, that is now used 
in the whole LTP documentation along with sphinx [3] support.

I would like to introduce a discussion on this topic, since I seen a few 
patches meant to adapt old tests' descriptions [4] into asciidoc and we 
don't really want to double our job. In particular:

- is [Description] tag still needed? Shall we use **Description** instead?
- shall we start to convert all tests' descriptions into asciidoc? If 
yes, how? Automatically or manually?

Best regards,
Andrea Cervesato

[1] 
https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html
[2] https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html
[3] https://www.sphinx-doc.org/en/master/index.html
[4] 
https://patchwork.ozlabs.org/project/ltp/patch/20250210091044.359274-1-maxj.fnst@fujitsu.com/


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
