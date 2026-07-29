Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A92C53219
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 16:26:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D06B3E527F
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 18:26:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47D093E29BF
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 18:26:36 +0200 (CEST)
Received: from mail-yx2-x04.google.com (mail-yx2-x04.google.com
 [IPv6:2607:f8b0:4864:41::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E60812002B8
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 18:26:33 +0200 (CEST)
Received: by mail-yx2-x04.google.com with SMTP id
 956f58d0204a3-667d3ada410so774610d50.0
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 09:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785342392; x=1785947192; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JNh/jgQsYQzbT3RWGEbVKs+wWnafOYN5BVfMkmocDls=;
 b=skXhT0eJtcnSWZ2tmtmMDFCPuMApvQGuAJCL65lmqpFqwPqohifc29COUVxeFeS0rY
 w5uYrYRjzLshBjIItnrxK8S4lr+EbVlInla2+lSrcNbKIW9bZpbIYTFljKTuy1yRg0m1
 8yHkhVoSzoPS4KCeTlFosX3MWr45NKUPtoaAOwhDBwvbNPfYrdvq/LmpKp/Zz4+zd4Na
 FOtoky7JySep2f5aEyAPIxlzBEBIsYHcKgtybqgbu0C3t4/ReKPfKIOMH+nYwo1/jU3p
 cfOlhsBwWlWWUi3e/YzvDuXwmuc+q1jep+Cw8nnhW//zgDk7Ljps5FSlHuP+8sdpC6Hf
 V6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785342392; x=1785947192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JNh/jgQsYQzbT3RWGEbVKs+wWnafOYN5BVfMkmocDls=;
 b=pgpPEMev4KmrRo3NhPNYIBBdHUFCDzXbA8+dHxWWQxjgJmAny8OUMX+AfzvGxoAkx1
 ONx5k1Vqb5l+IWz1FBQfP0xkpUAPgFlUESqevJkmtOMsEWgCjWEmPBjs99sgZPn+e1jq
 BQKMd4TvKSXg7EdMx1tJ/aXbKnxuf3QJgQhwwyVInpWcFMR+xeCYpQYOaYRe3z0FI6eI
 hp1vbH+wd8sjXjQB5vunzqWwmN8mTwqWGUvTYWzOQP1VNkhBz9QCtGcnWwjmornGuXLQ
 3Kt4XTSTs/1FaTqUlEPsGehsjyB7zJJQJZGu/0JzJ9apO59f3X/pTPAkuBGSCNqOMqb/
 qT4w==
X-Gm-Message-State: AOJu0YyeCUC7+APUsccUfERaYx1v4Q9pfcxzsioyclkP083/jHXbS+PB
 HvyQiMbSCUCbmLwNqUIHJyf22oRSQTX0hnzVZIWlrVu0xZjQvkr5Crg+
X-Gm-Gg: AR+sD13IWqgJTcf0/vMI9wBwIEQ2ivyUxZ7zkByjJbq25MU6AkXnuMLKABo03on+QRq
 fvPExfP2sRF25PFKoj4SAdIXr8Upj0w4FecoBDSavbp+9sLAsE8MvTGU16+PrqHbeJEkgaphryX
 b2naOIa1R7OLTQbKbJr6jPW0PvmCAcu9ni7zBhbhs0pUkdOEUaQO7S/9lWRUz+1ucfX64YFn4EQ
 JaRblRfnT3Axi3VRtlwjcWipoxnT88lOXC3n/JOREPkpiXL2S+W2xId5wh+ELz1KlUOXRpl7PD/
 ilVjsQy6PUCndoO8MirOVZy4ceUdnvrzdTyuDoaKncExuw3tKmX/GfVSR93AA3+Nic6mtsw0bJt
 hax1n52lA1IIl8gistRoKOL5sykSdUrC+mdWKiapxW93lXRrEZHQA2FEKEuanN/y+DWlrBuuIWX
 i59htg9Jw+jInvxYQZTW0w9B6h6Equjr6+g+oUIaGSgesT3Hm9SwxK83gjcKLsuy8/9yVbI/xKt
 szD5Q3GyaLUdImsp8JQgoWzECesKjYUhOrAz+FdAolb8we5JnfZNCRiL0WbKlBEHvUBI+Ao82tE
X-Received: by 2002:a05:690e:154b:20b0:668:8d0:221 with SMTP id
 956f58d0204a3-669057fe579mr2769107d50.69.1785342392493; 
 Wed, 29 Jul 2026 09:26:32 -0700 (PDT)
Received: from
 runnervmvrwv9.boxd22kimeteppxqnve2ae5iyd.ex.internal.cloudapp.net
 ([130.131.71.24]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-669122b2387sm2174386d50.6.2026.07.29.09.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 09:26:32 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Wed, 29 Jul 2026 16:26:31 +0000
Message-ID: <20260729162631.8574-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729145321.4115712-1-sbertram@redhat.com>
References: <20260729145321.4115712-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] semctl01: fix SEM_STAT failures under parallel LTP runs
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Stephen,

On Wed, Jul 29, 2026, Stephen Bertram wrote:
> semctl01: fix SEM_STAT failures under parallel LTP runs

>  static void func_iinfo(int hidx)
>  {
> -	if (hidx >= 0) {
> -		sem_index = hidx;
> +	if (hidx >= 0)
>  		tst_res(TPASS, "the highest index is correct");
> -	} else {
> -		sem_index = 0;
> +	else
>  		tst_res(TFAIL, "the highest index is incorrect");
> -	}
>  }

hidx comes from SAFE_SEMCTL(..., IPC_INFO, ...) in verify_semctl().
safe_semctl() already calls tst_brk(TBROK) when the return value is
negative for IPC_INFO (sem_ret_check() falls into the default branch,
"return ret < 0"), so hidx cannot be negative here.

That means the TFAIL branch is unreachable and the IPC_INFO test case
can only ever report TPASS.

Before this patch the function at least had the side effect of
publishing sem_index. Now that this is gone, is there anything left for
this test case to verify? Comparing hidx against the index returned by
the new lookup helper would give it some meaning, otherwise it is just
a check that the framework already made.

> -	if (semidx >= 0)
> +	if (semidx == sem_id)
>  		tst_res(TPASS, "id of the semaphore set is correct");
>  	else
> -		tst_res(TFAIL, "id of the semaphore set is incorrect");
> +		tst_res(TFAIL, "expected sem_id %d, got %d", sem_id, semidx);

The parameter is the SEM_STAT return value, which is a semid and not an
index, and it is now compared against sem_id. Would renaming it to
semid (or rval) match what it holds? "expected sem_id %d, got %d" reads
oddly against a variable called semidx.

> +/*
> + * SEM_STAT takes an index into the kernel's internal array, not a semid.
> + * Return the index that maps to this test's set.
> + */
> +static int get_sem_idx_from_id(int id)

This sits between the tests[] table and verify_semctl(), which splits
the table from its only consumer. All other helpers in this file are
defined above tests[] - could this one go there too?

shmctl01.c uses the same get_shm_idx_from_id() idiom and additionally
prints the mapping:

	tst_res(TINFO, "shm_id=%i maps to kernel index=%i", shm_id, shm_idx);

Adding the equivalent TINFO here would help when the SEM_STAT case
fails on a busy machine.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
