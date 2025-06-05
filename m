Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44BCC5B543
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 12:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749128198; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=VtXxt/rXGIRSyA9tE2dH/KvAdRrNMq64l1JEwEYwdKo=;
 b=jqhEqA+XASoKe/v8xF50JztArcOonvRZahF7y/vsCOTxbux64caguc2cpIWbQd5Zk1n79
 vuz+7M2aXvOBribv5t+TQwucnpC5GnaK0NCNyuekZN+Q40iGdqvmsCVuZ82YLUxtKjIDtyx
 SvHnEFw8sZWSDTu5tfXIcpXBjZuDgng=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C20A03C8EDC
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 14:56:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC3AF3CA450
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 14:53:44 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 56004600D25
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 14:53:44 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a510432236so731344f8f.0
 for <ltp@lists.linux.it>; Thu, 05 Jun 2025 05:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749128024; x=1749732824; darn=lists.linux.it;
 h=in-reply-to:references:cc:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FK9/YnMg+eTvIXwzbTjdiXkKaxdioBILIm7ezDP6hJ4=;
 b=LUTZaCTDAFUTbLCGt1GKlqFUKXMSHBd9Hg02HvoM4t4WrlqebzVdea5H/dOT0ord29
 DxW3lSEGIf8eYonuJFa2pqpzXLzZVFL682l7D2GgumxxzCECk2QY91ENGc4A9lboduJs
 nrCfmCTswP+GKPYizGgH9Fr7MAtkr+xbvoi/ZT76xsURXo71BCmcpnDUqsAdRGPILayu
 YFnipi+0q8rpGuQpBOhlnpZKARf8xGEVdO1IKD1alAvVaOMJmXD8RVj2gRizp3dO+MEG
 F890uvroc78VxHKiv4EZxY2nGhABjqx0ZBDSZ7Ci7YXlSOHcpdBUHSrxZnyChSSdufue
 I5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749128024; x=1749732824;
 h=in-reply-to:references:cc:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FK9/YnMg+eTvIXwzbTjdiXkKaxdioBILIm7ezDP6hJ4=;
 b=M3nF1GpE10BXf/gZUZcvlYwrhjJLhEmU0E8NPsJcKPcySTnwiEfLqwLjt3CHeOvJik
 pQ+LMa+oUYS1SZdvMAhe68KZWLYvY3O0O98ZyeaqBl4n+Bc4wm3UHn238cAeIMS/Xm02
 g0fkgC5MpGADAJCsYZu87y1RAJ/6G7GEUQFri10ELwBU/Ta1MsxtKmgZux50C6+cqP5a
 l/5HB686vvCpIaUT2rHYFN9OF48ziawFuLqmXOXFCrics0nAnSVo1ALAWR2LMT28OuPE
 lF82y8KEyMSOQsaaeaHALhbvlHpxcjKdy7Fy9POIMJ4w1qygcCDAtFihrmA4O87hl3WW
 qMNg==
X-Gm-Message-State: AOJu0YzAtEfzWOQ33EGqyyASd8tq480Svo+HA8MD7RjDX3qQLFFCZutH
 jaQhcNNtIgH6U5IxRoCyUX9yO+OdcsVEjy2BFhktepT0OYyC8IlVmnj1iWPMjSWArHFdUjvhzSH
 ChZUb
X-Gm-Gg: ASbGncsUBDYL0oydjmmmkp4vaBvoo4z7Ll+vYg/JBZkr8s4o2fbIpWxtytwudoQXHQS
 EOmoOl91vWwvQzlwURt8F+g159zpMrjT5Lw2jQfHnPU3kXp+xqt3Z9J1+JJppIlRWP8uzub03BP
 DWS04qh+e68aPDyVmw00Ys/5cOcPpbZqjsIlGS+AKWh4laWf2Zb6H8STuSp9HhIIflROCHbsPqs
 dAF74T//hzsm8FTG0Xiyf2Jae6TI9xNThLO7RRSZKsT8FsNFYR+h/hnTY2Vc8UlxFP5T2pZhP/z
 V7g98o2wW175oEAlWM5fTg4+EPQ/4OayzbUEjXrfvNwSbb+eyA==
X-Google-Smtp-Source: AGHT+IEot51fV1XuhhzpDjaBLInagGJR3TRig9d2wZ0T8SctRGmjflzz9F+X3aAjzo6rTEr9Tf7eoA==
X-Received: by 2002:a05:6000:40e1:b0:3a4:fcc3:4a14 with SMTP id
 ffacd0b85a97d-3a51d95a0f7mr6354867f8f.34.1749128023659; 
 Thu, 05 Jun 2025 05:53:43 -0700 (PDT)
Received: from localhost ([189.99.237.136])
 by smtp.gmail.com with UTF8SMTPSA id
 71dfb90a1353d-53074b06741sm12547141e0c.21.2025.06.05.05.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 05:53:43 -0700 (PDT)
Mime-Version: 1.0
Date: Thu, 05 Jun 2025 09:53:38 -0300
Message-Id: <DAEM4UHX9H2H.1AK4OWLJUVE33@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?=
 <rbm@suse.com>
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250425-conversions-mknod-v4-0-222e0d2e7ef1@suse.com>
 <20250425-conversions-mknod-v4-8-222e0d2e7ef1@suse.com>
 <20250605072342.GA1190804@pevik>
In-Reply-To: <20250605072342.GA1190804@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 8/8] syscalls/mknod08: Convert to new API
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu Jun 5, 2025 at 4:23 AM -03, Petr Vorel wrote:
> Hi Ricardo,
>
> ...
>> -/*
>> - * Test Name: mknod08
>> - *
>> - * Test Description:
>> - *  Verify that mknod(2) succeeds when used to create a filesystem
>> - *  node on a directory without set group-ID bit set. The node created
>> - *  should not have set group-ID bit set and its gid should be equal to that
>> - *  of its parent directory.
>> - *
>> - * Expected Result:
>> - *  mknod() should return value 0 on success and node created should not
>> - *  have set group-ID bit set.
>> - *
>> - * Algorithm:
>> - *  Setup:
>> - *   Setup signal handling.
>> - *   Create temporary directory.
>> - *   Pause for SIGUSR1 if option specified.
>> - *
>> - *  Test:
>> - *   Loop if the proper options are given.
>> - *   Execute system call
>> - *   Check return code, if system call failed (return=-1)
>> - *	Log the errno and Issue a FAIL message.
>> - *   Otherwise,
>> - *	Verify the Functionality of system call
>> - *      if successful,
>> - *		Issue Functionality-Pass message.
>> - *      Otherwise,
>> - *		Issue Functionality-Fail message.
> ...
>> +/*\
>> + * Verify that mknod(2) succeeds when used to create a filesystem node on a
>> + * directory without set group-ID bit set. The node created should not have
>> + * set group-ID bit set and its gid should be equal to that of its parent
>> + * directory.
>>   */
>
> ...
>> -#define MODE_RWX	S_IFIFO | S_IRWXU | S_IRWXG | S_IRWXO
>> +#define MODE_RWX 0777
>
> I'm not sure if that's omitted by accident or intentional, but I don't think
> it's ok to drop S_IFIFO:
>
> man mknod(2):
>
>        The file type must be one of S_IFREG, S_IFCHR, S_IFBLK, S_IFIFO,
>        or S_IFSOCK to specify a regular file (which will be created
>        empty), character special file, block special file, FIFO (named
>        pipe), or UNIX domain socket, respectively.  (Zero file type is
>        equivalent to type S_IFREG.)
> => we don't test on named pipe but on a regular file.
>
> Could you please use the same approach as you use in mknod06.c?
> #define MODE_FIFO_RWX (S_IFIFO | 0777)

Ah sure thing, sorry about overlooking this.

>
> ...
>> +uid_t nobody_uid;
>> +gid_t nobody_gid, free_gid;
>
> make check reports:
>
> mknod08.c:24:7: warning: Symbol 'nobody_uid' has no prototype or library ('tst_') prefix. Should it be static?
> mknod08.c:25:7: warning: Symbol 'nobody_gid' has no prototype or library ('tst_') prefix. Should it be static?
> mknod08.c:25:19: warning: Symbol 'free_gid' has no prototype or library ('tst_') prefix. Should it be static?

oops, good catch

>
> With that fixed you can add:
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks for reviewing,
-	Ricardo.


>
> Kind regards,
> Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
