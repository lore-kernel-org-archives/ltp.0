Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AFECCFA05
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 10:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762511848; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=MB7un4/oL2epmCqrl9Pypf7pHbIVh+YbnkT1wc9jPNA=;
 b=c0AzaCsNK2KqvFpIEw0L2DQu+uA4De2LCKWtMAGMpAmP3LiLJ96MDf4gNurfIL7M5e1Qs
 hsLhVjSpy7Dz+X6eNCgTS7aTW5r0fgQIQ8l8TMUu6zApMaREVBPSwtH2/glY79oQUs47VxL
 tYYt4vaejRfGuZChLYlBW6Xq5jvizJ4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 958873CEF03
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 11:37:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05A3C3CD4E4
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 11:37:07 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0A7971A01060
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 11:37:06 +0100 (CET)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so363788f8f.0
 for <ltp@lists.linux.it>; Fri, 07 Nov 2025 02:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762511826; x=1763116626; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5me+CdW6KkurPomOhMqKL8i6hpyp/6MssY8QrHsllYc=;
 b=RRK6sB+hno/DBeaEDydagfjD6qfj7U+C6X+RFmAWKYxSmqGZDrRw3YKqKNm5BGN9ZP
 gpZ+vDbAclLkgTF0UlWL56TRxsGi2Cff06Fpa3inRvPsyTqhjZ/IypAZlnWJlQ7xXpDd
 oGvkWUwIxL3dk5H4JNV6hyIrt9VpzZNLXnlhWfvc9RTTFGm6QDKo5HYHbovP91k8c3Zf
 /9qiuz+Isaq1jXwtpsvfk1mY+PURpjXAnTwuDa2QD1y+9VLkrngnEdrdJ60Kk/i1YDEN
 0qo+ZzLYd+yI4txJSdZjOrKq3197DEYGKjP/hgAQE21xsLksxxBeW8Fa+z6Z3qC1eBzM
 wUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762511826; x=1763116626;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5me+CdW6KkurPomOhMqKL8i6hpyp/6MssY8QrHsllYc=;
 b=GEdN6mdPVv8Hu4hBlkNC6Gpy2ww0wo15AaM9uvLN5MxtHT2A7iNOLn4BeTzKSbo477
 SIPu7KTT6yntEtD6GEdQx9YWSgV/32PPurLq19boAK95ehCCaKgf0lkv/T46fMMYXdCZ
 JrIUIagyddetgDA5Y6jz8ilPbP1nvyy/IlyHm2x2aPLUzDtes6/9MmyH+k89Ifpy0O46
 xouQ3a99LPxlKxRaQSZhdtpOm9dGqNW/2B2PQtXKgOhbbgmi+iOIK7Tpu/1reuaOLWrA
 EHG1bJrSh/Lyg5MGfPybZ7XSkuuPs0MNTPnqInv4SeDNmf2dXQz8mFZly5TEAGT7l7K8
 /9vg==
X-Gm-Message-State: AOJu0YzGkaIf4iu84ie/IHd1kWWSuf+b3Jdkmw/FGaSP6Rvgcnlodr1N
 KMhEUFEsLvrpktZrN2vWcS7wkfiSgFxS7nCAlwFscsXh+twV1LfF2jj9t3Ij0al9YB8=
X-Gm-Gg: ASbGncsExIjtxOmoMCzGZUojF7HCcJzKzKEQN71bsLtpSDQ+dJ/ijkxqT/Lz30/vwGX
 7q7AS3ZxGsov2cop6aoNI0LIsh7wZ5ZOFGgaBKEwTxKxLawVntiQm7N0oRwALviYdvm2XSxOBdR
 kqD+33qA0PDO4m7VkMT+DqCqVMpa51hjU403CdqDxj/8KsPbMhJ8YtACSWAqD6XKc8BYnQhEZJs
 wEdJXvHq+Yc3MxwhAXdOxiwP1aIpNAaD7h6areiT1TK+4VKJU3VZ3swXHHlnX8S/IxtHCG9Mh6+
 YSl1lW+o8T/M3NcXTW2AuOEOm9XzdjUr7rhjRJfrxRJ6QcXtT8KDuu1Tusegh+Grr4LQi7iJObA
 NPaz/io8xvI1a9pOgSppMc6vO0U9Svxa/00r+c7XSpXFBimKG8jZzbYtmwf8lXifqEWkm8PLVCR
 xmKekXR3vvmhOt/kP6sQBAOzLrlyNZkuM=
X-Google-Smtp-Source: AGHT+IEZ019FX1/nmFbgd1Nq1pMDFlrEl50S7v3DbO37Bv8yuQmmfrdg99WRZIzJPVLapPEA+mTJUg==
X-Received: by 2002:a05:6000:381:b0:429:a7f1:bdf2 with SMTP id
 ffacd0b85a97d-42aefb490c0mr2155974f8f.60.1762511826284; 
 Fri, 07 Nov 2025 02:37:06 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42abe63e07asm4461771f8f.17.2025.11.07.02.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 02:37:05 -0800 (PST)
Date: Fri, 7 Nov 2025 11:37:04 +0100
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <cvvobn3ncapngynjplotpft3vbbfzg6me2gq3omnclzgwdoqli@ga7vc5e6f5t3>
References: <20251106-b4-memcg_stress_rewrite-v2-1-a82b0f3f09ac@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251106-b4-memcg_stress_rewrite-v2-1-a82b0f3f09ac@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] memory: rewrite memcg_stress_test into C API
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
From: =?utf-8?q?Michal_Koutn=C3=BD_via_ltp?= <ltp@lists.linux.it>
Reply-To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea.

On Thu, Nov 06, 2025 at 09:16:06AM +0100, Andrea Cervesato <andrea.cervesato@suse.de> wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> This test will stress the cgroup implementation by allocating the whole
> free system memory inside multiple containers, one page at time.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> The previous test was buggy and up to failures. This new implementation
> deletes shell script code and the C utility used by it, merging the code
> into C API libray.

I'm not that familiar with the old test, it talks about stressing
something but there aren't many assertions where one could check it. It
likely wanted to exhaust all memory uniformly from multiple cgroups,
however, I'm not sure whether it captures something realisting or
reality approaching.

Therefore, I like all the /^-/ lines of your patch :-)
And I also appreciate that the rewrite with standard routines results
in overall shorter code.

But you changed this exhaustion attempt by serializing the processes (it
would only use mem_per_proc /= cgroups_num at likely peak, not all of
the memory because of serialization AFAICS).
That intention could be explained better in the commit message.

(When I think about it, some realistic scenarios would be:
a) starting lots of containers in parallel (and observing latencies)
b) running short-lived jobs repeatedly (and checking that it can run
   indefinitely/sufficiently long w/out accumulation of any residuals)
That'd surely deserve a separate commit from the mere rewrite.
At it becomes more of a performance test rather than binary/discrete
verification of behavior.)

Thanks and HTH,
Michal

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
