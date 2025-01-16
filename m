Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AC0C02183
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 09:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1737018390; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=XDgNRUD3hoBMbCArsc/+oHLJJTEGraKdLCTPXN4Da5c=;
 b=aThcbAIbXU1i9HFhYr1/2120JRvs6K6BBBB5EZr+X2FUL+3hD35riMNCkSY8bAMtZM/Bq
 h+3GoPc34fL34c69sOxf0JsPaWk8fHtsY9YNJJ6xBxPpgcBycGoqJLT0Xgmp5u8aQEF5o+l
 2xu4NfFfS3Ag9MmBSfqVlhNiu1/sSUI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB5113C7BB4
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 10:06:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F4333C7A13
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 10:06:10 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6048564AD32
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 10:06:06 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso3537355e9.3
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 01:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1737018366; x=1737623166; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rvLoYGW797Wwa5tA/CyXEnf4NFivauTHwpj75TV5TX0=;
 b=KMG7ttp6FpzT9l3nxSw6oJn3OIRYCzSH3eXck0+EkcJTR49ZBnuaseF0AoRVVECfnA
 nIGcsLaqaaTKJ5AsQjINYWOfdI+k4Viby2mQZdOezwzo2uwDZR03+ARWS4eLMf4GwWjW
 2Wh9LEB3i9smB++34Kc+VRRGiuSBhlufELmPHboAGUbiWHHBUDbQzDdqe2w95TtXwYdY
 LAiD3UNQ9oj3WNy3rfFNQ8jsE9Zb1TVpxEa0UQu6u8gtNnqzVNEVpR5NK2DnWjrDnA0S
 XUyKzVV48dZKyvB/kfCgcK2bl0Qmb14xtd8UTMDz3zl8qNi1HJ4jY3UonCi1nx70yH3o
 A1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737018366; x=1737623166;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvLoYGW797Wwa5tA/CyXEnf4NFivauTHwpj75TV5TX0=;
 b=jM1sTAcahb4mxc6D3LVgPshPQObSwGsJGMV8frTbmrwc8NZhQw50RorFvZ+cjZglYV
 S1LjJc23m6d7QRoGvU5aHXvmduQHbkcwNTRMZpTX9kVhAS1ChbfXGd1Z8t6o7Vt6D1U4
 vrAOwaiJxWmvnEI3marLBleMqeKnlZ0kSI9oBHJMToOX4tcAasUvc5A1Bpi4hsIrkUga
 Zrgcg7IKGWxn2XTkhuXP7qXYyZm9wHk+KwlfyMZbPd2MBdIFPk11Bf/qFbkXtB1x/Vd0
 NbecX19JhpPJNvXsfMNsYdOtJIdNsTRAtDUX+rQrssoFjNFhaqrqwn4vPXcIDmf/17+l
 ztxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvxvktBBUx9UEG2a9in3h+8zvZPZCf7DfEu8Idwo9NWtFANUJJGQ/N1sVpK5weOvC0vg0=@lists.linux.it
X-Gm-Message-State: AOJu0YySyUWK7UtISdtPH9OAA7bfo5P2WPBYa8i4UCb2Q4V+OqmOYjd4
 4/JBTsvQ8gG8Ow6pLa5j5pk4ePrkutKJlSC0nouffbGzu6FBa+P/W2xBZsz/K30=
X-Gm-Gg: ASbGncsMqcC+kLL4xAcOX/ztfr1ICfsBKTLtLrpzdqsQRiY6qmfW4Y3P7Y9Gay5k/Yi
 THJA1v4+wuPhmaABIRFl6plzrGaB5dMR1EejF7lXeaDstIedry2jKErzFVyM1w7J7pYfrzRHCad
 4xl4oMskO4K2k6UDpKLktZimYWP8h+7op8AQflwItt7gRK7TIIe8dQsSSH2hc/WvhZ3aHwnvuyK
 dU1PM9hT/+eByKyc1DYP0cLQgDL/GNPOzoZe9b5Ss52ST7+CSvAvUh1AXWZKhvk5yyYRw==
X-Google-Smtp-Source: AGHT+IEZEzn28CIcCG4IS7Ndr+zHZ02erH6CBGKsMWizQ+Tszr6rCV5A6NnVL5PjMhYeMeFv5lQt7Q==
X-Received: by 2002:a05:6000:4011:b0:385:f47b:1501 with SMTP id
 ffacd0b85a97d-38a87312d58mr26734400f8f.32.1737018365807; 
 Thu, 16 Jan 2025 01:06:05 -0800 (PST)
Received: from localhost (109-81-84-225.rct.o2.cz. [109.81.84.225])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74ac5f9sm51057375e9.11.2025.01.16.01.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 01:06:05 -0800 (PST)
Date: Thu, 16 Jan 2025 10:06:04 +0100
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Message-ID: <Z4jL_GzJ98S_VYa3@tiehlicka>
References: <e66fcf77-cf9d-4d14-9e42-1fc4564483bc@oracle.com>
 <PH7PR10MB650583A6483E7A87B43630BDAC302@PH7PR10MB6505.namprd10.prod.outlook.com>
 <20250115125241.GD648257@pevik> <20250115225920.GA669149@pevik>
 <Z4i6-WZ73FgOjvtq@tiehlicka>
 <6ee7b877-19cc-4eda-9ea7-abf3af0a1b57@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6ee7b877-19cc-4eda-9ea7-abf3af0a1b57@oracle.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Issue faced in memcg_stat_rss while running mainline
 kernels between 6.7 and 6.8
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
From: Michal Hocko via ltp <ltp@lists.linux.it>
Reply-To: Michal Hocko <mhocko@suse.com>
Cc: ltp@lists.linux.it, cgroups@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu 16-01-25 13:37:14, Harshvardhan Jha wrote:
> Hello Michal
> On 16/01/25 1:23 PM, Michal Hocko wrote:
> > Hi,
> >
> > On Wed 15-01-25 23:59:20, Petr Vorel wrote:
> >> Hi Harshvardhan,
> >>
> >> [ Cc cgroups@vger.kernel.org: FYI problem in recent kernel using cgroup v1 ]
> > It is hard to decypher the output and nail down actual failure. Could
> > somebody do a TL;DR summary of the failure, since when it happens, is it
> > really v1 specific?
> 
> The test ltp_memcg_stat_rss is indeed cgroup v1 specific.

What does this test case aims to test?

-- 
Michal Hocko
SUSE Labs

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
