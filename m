Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E625C3600B
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 04:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742962508; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=LW07K4Utl/tfgJ2jcqJg/Q/Fdu+FEEWxDEN+UCxAyzM=;
 b=RXmSfqE76TDkZq8Tk6yMhZRKuMtWQVOBfl3W+JvMffBZb+sn1J21obnv3gQ257dV5JXg+
 ZnmZ4XqRM8HuUME3lTQNe6LFWYNPtOXNwG7XCu61hU6LO8oRSkjxLlfB2N21dbRC31o80RL
 /5QbL/FfVXW8aQ2Hh7s0sfGrjfyrMv0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 060EC3C9C13
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 05:15:08 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D2F13C9AEF
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 05:14:47 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 27BFF140055D
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 05:14:46 +0100 (CET)
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-391342fc148so4403395f8f.2
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 21:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742962485; x=1743567285; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EfVs8xBsdoIJ6a0pqRJ+VVmScFERHYhciBQcCbi38jc=;
 b=PxBNijJjT7xEP6gj0q9G/F+dmdOp1aHyLD7p3bHLa8SdMSWP20q9q288eZpo3apEtO
 M93qHJS/gQvtU+JKij06bkdEKzQTFFtnE/AuJDq/49ht0V69g9vDsj6Qhs8zgH+eB3ha
 Egdn8T7vxS+IR8boXtvLa02bvxldHO605avMSjcXM7DTFOIXsQ4y2zgd4xaPPK4VNeAy
 egW33TOgHFGRmf3VJ0EzH0NSkq2syHbVJaoSIOh6HWYRuFPyorO7oLG9rTwakW4Gpedg
 YXC9V8/fOt1EIem2yOpBiPeLuYirCLRPBNvFtVMPWkUcRNI7boh9tUOtC8tqjWT3G4mi
 0ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742962485; x=1743567285;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EfVs8xBsdoIJ6a0pqRJ+VVmScFERHYhciBQcCbi38jc=;
 b=JyUcyfXQdFOaj6S81Je88Xu1Q3AdM7M1eOfp64j2hRcX/xmG56WUSBfCMz7j7MvMFh
 Z8frgf0d+7ZqNBJz6fDum7T8vWzofFG1ckSYagAIAYKYVGpy+j30B9GMiGyunDYahDzO
 fUEwA18qkaxG8TNtdSmavdvRagT43rLF/Gx0xny/9P+9maH7Me9dykaTEaCNGaXmsPhD
 PfQRGI29at12F9pXcpZs1IaKyQr7fRIOybPSXwYaN+23YXeFkLGWw5IfIBHJ6HbUOEYs
 zx9xBgrFlMuO1iOaPWSiAj0IZTic8x3wx3vU9yZPId0oe3L3hz38zfi164pNRgDnIZ6p
 YikA==
X-Gm-Message-State: AOJu0YxSghpu4hc3ZQ1DmkIo0jEnQZ1Kw7GCxZ9bU3hSyyXFs0dE9hLL
 +eso9KDRKhywpa6BpeNhjibMlWq58+jAQEJOMMDjRS5FlL8l8muYT5lIvPhbq21150DP7Y8uXfI
 pSNks
X-Gm-Gg: ASbGncuWnu1elQcKqyQDeP5pjMmnmHI6Dj7VKEZSSuNmSxUolhlF/4owuq3X5DLAsDq
 qd525qI/6XDQjTFzjRMkRBLNvqYujlK5fwuL0VF5uwhUItcoMTIMvAXjcSkTZ2CFMexArr7Tia9
 Cv0sb0bAqzsfOT1ehCZCAnXhAQQd/yUQyZpDb0ydyhTVDW/Scv1zZjj7BxyDh5fJ5Z7JShURT43
 4FC8FpZ7DCV9o0UC3zt6c/xWBQRs+NtFnZdrYqVzC49khK561OWRKzwSEG7bwVk7GgniFolVNhR
 p+xNRhGhWLvA0+JI4kk0TKLj4kqd
X-Google-Smtp-Source: AGHT+IGEqI7is5mpKZMgA6h6QfB+QtwbDMH9q4oYyN6Se/oeVkW76uzXtTlmPR0YGndy9Y2bn2Ff6w==
X-Received: by 2002:a05:6000:2b08:b0:391:13ef:1b1b with SMTP id
 ffacd0b85a97d-3997f90ecd8mr11614373f8f.30.1742962485434; 
 Tue, 25 Mar 2025 21:14:45 -0700 (PDT)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39abfc2115asm9521864f8f.4.2025.03.25.21.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 21:14:45 -0700 (PDT)
Date: Wed, 26 Mar 2025 00:14:38 -0400
To: Petr Vorel <pvorel@suse.cz>, chrubis@suse.cz
Message-ID: <Z+N/LjYbZJKq3qsS@wegao>
References: <20250305050805.7905-1-wegao@suse.com>
 <20250324120049.29270-1-wegao@suse.com>
 <20250324120049.29270-2-wegao@suse.com>
 <20250325140018.GA448693@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250325140018.GA448693@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/2] cpuset02: Convert the test6 from
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

On Tue, Mar 25, 2025 at 03:00:18PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> ...
> > +static void run_test(void)
> > +{
> > +	int pid;
> > +	char node_id_str[256];
> > +
> > +	cg_cpuset_0 = tst_cg_group_mk(tst_cg, "0");
> > +
> > +	sprintf(node_id_str, "%u", check_node_id);
> > +	SAFE_CG_PRINT(cg_cpuset_0, "cpuset.mems", node_id_str);
> > +	SAFE_FILE_PRINTF("/proc/sys/vm/nr_hugepages", "%d", 1);
> 
> You changed the /proc/sys/vm/nr_hugepages to 1, because Cyril objected the code
> in v6:
> 
> SAFE_FILE_PRINTF("/proc/sys/vm/nr_hugepages", "%d", 2 * node->cnt);
> 
> But as I note there [1], the original shell test did it this way and kernel docs
> allows more than 1 to allocate. I'm obviously missing something.
> 
> [1] https://lore.kernel.org/ltp/20250325133611.GB372417@pevik/
> 
My understanding from Cyril's comments is no need reserve more hugepages, since
this test case ONLY allocate 1 page through mmap. 
@Cyril could you help confirm this?

> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
