Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE34C43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 15:25:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDEAC3E6944
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 17:25:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B39C43E1CD7
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 17:25:37 +0200 (CEST)
Received: from mail-qv2-x00.google.com (mail-qv2-x00.google.com
 [IPv6:2607:f8b0:4864:33::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5D49B600677
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 17:25:36 +0200 (CEST)
Received: by mail-qv2-x00.google.com with SMTP id
 6a1803df08f44-8e9c06149e2so2187896d6.1
 for <ltp@lists.linux.it>; Wed, 08 Jul 2026 08:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783524335; x=1784129135; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QxMZlWKPzyhMpJJGgOmrB5A6Zkct2d9TnCH9diKyUgM=;
 b=BwpvbVY6+l24sgpGDdWbbRYDKwRSZjA9I27zpUA0Er0UV8AUzvBYZvQFNWB5BzCEoH
 cd5xXkJwp+VJUy5p7D9tpHmfToYbkYsoI15BkZxGl2fqRwZOO3QDHPDcMVbR/WGFDp5h
 aNSkz3Hl4MKWdghzwQvv4ElpxZSxjjfz6t1DkfdrFQPCrJzb57a/19oH/tAXtVsHn8rO
 UBWY/OUGPkfwU2nD9f6KQcdMbLO1xJTMcZAn4wCoMDw7AoRHJ/j4zXkPUcVXJkuUFQCR
 MELuuOu2sJbQIkXLroWuusNIcoEVT6SIrOKdbTlK6nGARIEu1SgxqqN7H3ZzxpNrjcZG
 aXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783524335; x=1784129135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QxMZlWKPzyhMpJJGgOmrB5A6Zkct2d9TnCH9diKyUgM=;
 b=Q0E/YInYa8NYFiOk9ya0i1BuOOLwfMiNEwGdzaj1qIl56TKDVUF+vgai+HTkiCCpSv
 gwCwcZ1S3MQ2W4VfaYDB/b3Z53VNlpmUiCOttaySEctJWMyelVAR3KF0NdYyC7FrkUnl
 K4b7XXWSn4qJvu8id1R8gub0XnhJI4ydaHr1Q6y+0JyvtZahXZcyZ/W9mz9OlWxrfzGp
 TmJuNXNvQQRt7w/L+2CYP6co+VwW2t1f2L+34enaHN0PKVFpHnLPeyfcemaFTApPMXEf
 5cBkM3B7wtnmFHT7+9TIeJxSzuePacp2BVlIRu+/UwsM3Oj7vCd39Cw3vl63evdGcIlS
 HQoA==
X-Gm-Message-State: AOJu0Ywu2if4nB1hvRPsz371AunpsPc1n4i6GWBjF+maPSw1rC0AVqc8
 zUFm6qqT7N6xScjEmyFxSajxR4xNAyRrwqYxUQoasO4EZMy7pVhGjcsO
X-Gm-Gg: AfdE7cka0UryQxN63t/vwoaZ90zOG2Qd0nwjcZ6+LM/Q1sxHN7R47NS7P8NXHR3q0iz
 +bZbGBnxj6HHpNMdEw7CUngDLN6YHOzfvehjxxLykf+DFiqRAoLmwAWBsOHja5xKotDsB6ZftN2
 R5YRqNtYv1QSlNUCjJnP5rhc30gKWEqnld4Bb0lsnmEbSOXdH87NON3V/FmcBIWr4hbPGq78sjo
 7Z2Psu/bq4ZbaQqBS/lldpt8pKDisSjQG8litsw/y1S3V/d8CastIlQuz9Ambt8+pfAAB+wkLYY
 ew+48WQEjjTP9ExoVZvFdn2F05jVJml2Qy+Ywb4beUg+hAetVPsNzo4VkXlrI2qAv/6ej8N8ndo
 de36Qw65vZZZs2V9dMOyAVFK8hbTktzu3Dapny87iYpPr77oLzt8Yt9Ibnh3cQLR/iNPvqNKaqM
 TC2LzEetK4AGjs6gDCMB9NJqdDlit00n/bdBOioNwFSTrPFRBCSu1QQIhRF4yy0JUTXKitR0DYG
 +F3lpx743VmNGiA9FHcjICg8jEC
X-Received: by 2002:a05:6214:262f:b0:8e8:b302:8afb with SMTP id
 6a1803df08f44-8fec1d7abd3mr30105166d6.0.1783524335043; 
 Wed, 08 Jul 2026 08:25:35 -0700 (PDT)
Received: from
 runnervmkkn4f.yo2jsnv3aaiufmiidgoerdg2xa.bx.internal.cloudapp.net
 ([172.174.165.3]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f471fdc708sm184710366d6.38.2026.07.08.08.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 08:25:34 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Wed,  8 Jul 2026 15:25:34 +0000
Message-ID: <20260708152534.3979-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708124205.7409-1-sachinp@linux.ibm.com>
References: <20260708124205.7409-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mem/min_free_kbytes: Fix incorrect pass/fail accounting
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

Hi Sachin,

On Wed, 08 Jul 2026 18:12:05 +0530, Sachin Sant wrote:
> mem/min_free_kbytes: Fix incorrect pass/fail accounting

> @@ -57,8 +57,7 @@ static void min_free_kbytes_test(void)
>  	pid = SAFE_FORK();
>  	if (pid == 0) {
>  		/* startup the check monitor */
> -		check_monitor();
> -		exit(0);
> +		exit(check_monitor());
>  	}

> +	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
> +		if (WIFEXITED(status) && WEXITSTATUS(status) == 1)
> +			tst_res(TFAIL, "MemFree dropped below min_free_kbytes");
> +		else
> +			tst_res(TFAIL, "check_monitor child failed: %s",
> +				tst_strstatus(status));
> +	} else {
> +		tst_res(TPASS, "min_free_kbytes test pass");
> +	}

The fix works in practice, but the design trades one problem for another:
encoding pass/fail as a child exit code and interpreting it in the parent
is explicitly the pattern LTP asks to avoid.

The test already sets .forks_child = 1, so the framework's shared-memory
result propagation is active.  tst_res() calls made inside check_monitor()
are automatically visible to the parent's result accounting -- no exit-code
relay needed.

> -static void check_monitor(void)
> +static int check_monitor(void)
>  {
> +	int violated = 0;

The 'violated' flag is fine for deciding when to emit the TINFO line, but
the TPASS/TFAIL themselves should be emitted by the child rather than
signalled through exit():

  if (violated)
      tst_res(TFAIL, "MemFree dropped below min_free_kbytes");
  else
      tst_res(TPASS, "min_free_kbytes test pass");

With that, check_monitor() returns void and the child exits 0 always.
The parent's wait block only needs to guard against truly unexpected
termination (signal, unknown non-zero exit), and must not re-emit a
TPASS/TFAIL for the violation outcome:

  SAFE_KILL(pid, SIGUSR1);
  SAFE_WAITPID(pid, &status, WUNTRACED | WCONTINUED);

  if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
      tst_res(TFAIL, "check_monitor child failed: %s",
          tst_strstatus(status));
  /* pass/fail already reported by the child */

This also solves the original double-accounting bug because the parent
no longer emits any result for the monitor outcome at all.

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
