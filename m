Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B90C3600B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 11:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743420688; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=HGCX53bjwJ1zYtwMySKuyMx9gqIHU8ZkxBBjBTtFyks=;
 b=UFzIpFyBdgmL9OkHO7sWxu8BpFoKs9Nx1hF7TIZRb8/r2u60PNAHBOEmIMl6SfrSMZMjc
 YDkwk65LXmZlXNPTrewyU64ayhqJr1awPBroNDRFbeM5xFV8tylAW/fLuVu5II6UCHLGPRg
 PEpzP3CymyEM96c227pKxkDNONDGeDg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48A393CABC3
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 13:31:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89D0C3CA84B
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 13:31:07 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4FFFB10007C7
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 13:31:06 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so3609529f8f.3
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 04:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743420666; x=1744025466; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Hdc+xBN146pkCAeTvQ+hOSg3EVuGVtz4zxf1i2nqkOA=;
 b=d9K7fbjt+1QBtooqlLNXpxVmpNEb6jlocOd7p++1WjfJyz5oLogPPg78uw9+zWB0QP
 BLINa4QRA68CCdqpSB22zC9qxNb8rKUBgwdv4kLrOcMJxCs5Ola5jH6gMQ5EgXd9XIVn
 U+ie3elSswOu7B8iRqF9MrrqeZ73XhYcoK0jww5VbGHxO6QGSm2/j+n1baeG81908mVF
 4ewtjrCvBs+hShrKXEBc6jl2w+z18NqkaYaJQWQgeEL0osL43cWzijS4z7tn+QJC7IRk
 +vq0G9JTyeBN3oh2PAVBzL45itQuSg1zLtjiQxQ6TvcyRL1lf/HDKZcO0GmGFjv1n0Y1
 m0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743420666; x=1744025466;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hdc+xBN146pkCAeTvQ+hOSg3EVuGVtz4zxf1i2nqkOA=;
 b=BudtJh0P3NDtzgtRugSwFC8YDebuSipP0bL0qukf9Z25jnbKoZq/KuhLWyYgAN8qvj
 Gucm57fQ2G+vdniUFJbrPWkX/H51rVUd3doIivz49o7lxJmx5UcMrB/IJZ4G3h2sH3Cc
 //f7c61iTLdc51RacB8vQUzagp1RJpWFj40ZSk356GqD9jmx3i5Qsm/l3aBfoMJhbwZ6
 WSJ4j2/q4YFcbgR+M7dJgmotZTAHBraD7zcutJVuGj4anOy3DLWG10CDu7CRjmMC4x3g
 5c8Gl+Qe8sZhDFwMmCLB6CujfW3TsckV/fnLPAFXxRemAWIcvlDLbYLrmyqHf20sYhpf
 +K7A==
X-Gm-Message-State: AOJu0Yxr3DoAdTL/sRSKn1I3jIma9cwoA7ajl4FVll4kZIsCHcXHxt5V
 aIadoKqKWw+MBXnBN57w6cmWVpzzvlPp6sCoEMquE8DUWL5CqVf0E2f4+dJ35w==
X-Gm-Gg: ASbGncs6rYUMPVhQDYw4g8ZGS4h1LfnIJwSI9DCD+A+25lfgMN6GUSXi3QkpyXRJTkI
 hihMaFkPbXeGNtMyqLV7RHrOVsvucTm6ynZtdTUvFAUJ3JhDSm8N5JmY6YukhuIhW3fZhns1rZ6
 55gmDKwZ+Fl6blZ+61PIBP6o4LY1/Ln/n0teAopsx7XBu+HlCgwzN5HSvf6HDLoQKQA1xoZq96/
 /hk5PnlvIQFCTQmq7YEPG9GIks3bw+T+zmfncQ74jdsjO2M8hH7wDuPt9xwStBg27Rd/DWJ/NkE
 iEVQM6fslDd0L8nl+n8+QQCG9/Je
X-Google-Smtp-Source: AGHT+IES5bi9U5TS4T7URmaOGUXeHu557mWy3/FG7T66QldoA8ZJVrGRH8b3psnZWvuICVsYl64TIQ==
X-Received: by 2002:a05:6000:2807:b0:390:dfa1:3448 with SMTP id
 ffacd0b85a97d-39c12117a67mr5162632f8f.43.1743420665618; 
 Mon, 31 Mar 2025 04:31:05 -0700 (PDT)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fbc10f7sm120411005e9.14.2025.03.31.04.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 04:31:05 -0700 (PDT)
Date: Mon, 31 Mar 2025 07:30:59 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z+p8wSoc83cH2Hub@wegao>
References: <20250328075958.7616-1-wegao@suse.com>
 <20250331031945.5948-1-wegao@suse.com>
 <20250331031945.5948-2-wegao@suse.com>
 <20250331103751.GB244431@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250331103751.GB244431@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 1/2] cpuset02: Convert the test6 from
 cpuset_memory_testset.sh to C code
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

On Mon, Mar 31, 2025 at 12:37:51PM +0200, Petr Vorel wrote:
> Hi Wei, Li, Cyril,
> 
> ...
> > +static void setup(void)
> > +{
> > +	node = tst_get_nodemap(TST_NUMA_MEM, getpagesize() / 1024);
> > +	if (node->cnt <= 1)
> > +		tst_brk(TCONF, "test requires at least 2 NUMA memory nodes");
> Naive question: why test requires 2 memory nodes? Wouldn't be 1 enough?
Depend on what test's purpuse, if you need check kernel select correct node, i
suppose we need at least 2 nodes. Of course, test case also can support 1 node check.

> 
> Kind regards,
> Petr
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
