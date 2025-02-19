Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84708C021AA
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 09:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739958701; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=dWstI7LRDHdx7yrJTMTLF5z7jJUW0kpmxRjgTvgtE0k=;
 b=mwDjas3d/dZbYjg0VfLBkxgGvutRcezXZS1SNStaxQVrQe4H6JmCcS2+1r5bIycltC0d6
 bJZ2F6cQGwH6NxnAZFKEkVNEyD3vp8KDNObmnXx2CxzdK0GZsgQVhkcq4E5SxUYh52zdA09
 zdzAiEWfge1mM72R7x6hSICIBZdfLEw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88FCE3C2CCC
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 10:51:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 503E23C25C7
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 10:51:18 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3FF6B620974
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 10:51:18 +0100 (CET)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38f325dd90eso2781061f8f.3
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 01:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739958677; x=1740563477; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uVDPoAJGsJIF84iCRldDIglLiz6JtICnse/WsEZnnxI=;
 b=AtOMZlB7pEwKc6rA0CfiyGKENsAr3fK+gFonry6Sl4HtFNzkPd9f1dbGfm4ti7kpZy
 NtJdH5TiBKTQJXdAiXkMJmWTsV58HGS7UzV+yP0TWCcLkKzz5XwnFIYBvkRF7hheOVhU
 jtQedSkXK5g96LkLM330RHWW4hoI2DvQ9BkBY0D8RmOnvkSWgoV6/bhCHduWrUS4ew46
 D9uRkNvFcfTg5STjOzJQ3OT5ygwj/yQ7qtXcmuZIIzhQX8LfeTU4BiKih0wgTTzw9Kgu
 ieQgQmqqLdvXNpT0eGlK7WOu9n0OiPUHcvxTjeGAgcVc/dX1JgXhQhh/yLnYqurQLjoY
 xz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739958677; x=1740563477;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVDPoAJGsJIF84iCRldDIglLiz6JtICnse/WsEZnnxI=;
 b=sQPpFMR4XTTgjyCcD0YJnrozmgM2GNd6rtyuxyYdHHk6apH78yo5MubjrpEnwmVi8d
 uRHi1jodW4sSvguu5xYzc/LcWmjzdf7FrhNcLach3wIupvVzsVX9V1WusjGpCNP07+w0
 ldVFsD/B1Eu6BhfOYU5lBjySdZAwhiERCXQP3bitBYTghTI/l37oaF/tFhjOOxO7GIP6
 WMfq2ug8PDvMI8YO0wvyn4TSIT7b2/R1CMEiQ85dr8fXliVIEGHg5+SqnUaCMEfq69F+
 7C5seuF5k0+Epgzgqog38aizJ6d4mV1ltXsF4mcqdy0oDXadrU+xAdi1setQGwMWxJp3
 +5nQ==
X-Gm-Message-State: AOJu0YzQ9xeesiqhuQEQl4P0sHMqX+1QF+CQ1bQfbRPudtqOd/4rrLU2
 6fN3FR+Xj/nZm2cGq57OqrPJMmpXEEgnAJ7VTOUvZkNUIJlXfpsM7flo7DWmfjXes6HFMiUMq9Q
 =
X-Gm-Gg: ASbGncvASiNIQYfy8z1W4wdI98wL8fRPoY95q1kwv6XIwYRLJer3MN7aXCQ2Q8cf7t5
 3oDeFGMBHRjZUTeu7fwsG2J3HzuIrlPEVrTphTDEBJ9umgR+9PmJoWrXeELuBDNoAjnZ4SkLkw9
 tPCu2ox9eR1EK0ydxRMIJ+crRjK//6KF0VJ0j4NFQZIYGstO2cv/Tp1fpEVoTzdOWpsHxdqEW3D
 qNbB9LanlWmaCHryTiNUsIhlPDL6vzb6SH//jNgO64RcN74vM7teQVJ2Py257H3pmvZcMiPFDc=
X-Google-Smtp-Source: AGHT+IHQcZc0jjn0P5npSwBLWNEXB+eDZwwhuWGZviRP66Cxe8+WrC9gQyNvEjjjlhnH59vLwk6WEA==
X-Received: by 2002:a5d:6daa:0:b0:38f:394f:d83 with SMTP id
 ffacd0b85a97d-38f394f9d8fmr15584277f8f.48.1739958677601; 
 Wed, 19 Feb 2025 01:51:17 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ddbb2sm17059426f8f.40.2025.02.19.01.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 01:51:17 -0800 (PST)
Date: Wed, 19 Feb 2025 04:51:12 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z7WpkIMnaQPb5yeh@wegao>
References: <20250217020423.31602-1-wegao@suse.com>
 <20250218151858.GA2492575@pevik> <Z7WajlVc0xMSztSe@wegao>
 <20250219090536.GB2544812@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250219090536.GB2544812@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mount_setattr02.c: Check mount_setattr
 attr.propagation
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Feb 19, 2025 at 10:05:36AM +0100, Petr Vorel wrote:
> > On Tue, Feb 18, 2025 at 04:18:58PM +0100, Petr Vorel wrote:
> > > Hi Wei,
> 
> > > nit: I guess you want to replace dot with space in subject.
> > You mean i s/attr.propagation/attr propagation ?
> 
> Yes.
Will update it in v3
> 
> ...
> > > > +#define DIRA "/DIRA_PROPAGATION_CHECK"
> 
> > > Is it necessary to to use directory under root?
> > Yes. Otherwise failed will happen during mount_setattr.
> > But i have not check for detail.
> 
> Ideally we would create files in TMPDIR. Specially if bug in the code leave
> /DIRA_PROPAGATION_CHECK kept.
Got it, will try using TMPDIR and investigate why it report error.
> 
> > > ...
> Sure, it should not block your work on the test.
> 
> Kind regards,
> Petr
> 
> > > Kind regards,
> > > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
