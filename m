Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963F3D44145
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 08:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765529470; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=9rQAGd1Lymd4giABktVaquyMzEWnVxPib3fHHczg0Lw=;
 b=E109kaQG0DNLyM3eTaVujDBOyXWc5QH27u75fq4cLcm5vpLjht19BgEhbdwlUJJmL8BcH
 ZaEPPhNW+IB4RgHj03GcNNevYonInU89i5uki+rK8S6M5o2tS6Mr+WRs8CFrGkjTZpqtjW6
 3jzr5LRM5zu2j0IateAKvgm2FcqUIfA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBBEF3C6A9A
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 09:51:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 560653C5373
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 09:50:46 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 85EB6600356
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 09:50:45 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47a80d4a065so6873645e9.2
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 00:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765529445; x=1766134245; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eMbPdYY8hhjSf1UINe5DZjuxa7jzdORA7oILKRZrGQY=;
 b=Z1g9ufLSEp7dRMVKb2HZnwEfd5ES0NwwiHFacl/u7wQP7MNW/2bX1zOEq6iqp7U1D9
 Np1y2rAH5Kbi2yvXmWbNgldUiT4C1cq+j/mBBMp0G9nSyW7HZF0PDePK4SmoZLcYdzp4
 oDNRq5BxO+bNAYcubqKAcT1m9zT3q8YOyj/mzBz2Nwk8r1J42QVxyO6BM09+Mrjdcsji
 MC5pWaVt52zqE4l++NT+FV1Ln7l9DApr2jnYZzkPojA//5MQ3s7jLlvm/2m5Qy/Vev7n
 O3z5phWsupULrmHxJkFArWGGyTttMdYLnD5gjRi/23ciB+NTIFNQjr7kTYrcU+e08OT9
 skMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765529445; x=1766134245;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eMbPdYY8hhjSf1UINe5DZjuxa7jzdORA7oILKRZrGQY=;
 b=o/LAN8pdxJruFhQsDKNL/o9uER79Z6nQBgVIJBSKLcmBKS2/RD+hsAfG+q2ROTR7SY
 8Jykg4yz0jUKajqP1sQ8FGDvc+vgZK4HXMhNXc1CYwgHLfUvlS4NUbPhYcTO+iyS6Bb5
 I3UvkfinyoDAmuxsgxx9Jhn0jy3UpJHC5XDVl/7oYQKvxyYiSvIXz6oMZ3Zs0tQIvjXT
 sOqkLOi8oAHX4GA4TJ6c4iAyC+uxT1I+JgMGF2BnIxDsqe27UtOtsCp579JS3ELGB65f
 Fp9ql7LqoKBGyY4JH3Bre/oLJjuIQ9StS5egfyheh8IOfMRgAGnYQqxPGgnqXExZetFN
 vUQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEnA49jdkjnMtYKUyksJ2mZEZbcq5QXCmHqLzOyuQh4KWAa5/gAFsA3cdkHsQpfuxXFKg=@lists.linux.it
X-Gm-Message-State: AOJu0YzNmxEwprL6KEF8dbUKSuO1KlPze4jMqGC8CpiM+fNu7EZDngLK
 2Ryw6s7po4HeuZS2ejwSJfk8LxOfFcqQBp53nIrZmAeCyxd6dvklyXflriMnXlNvw84=
X-Gm-Gg: AY/fxX6Pl12sHWisDeJsKNYQ3CX4oNZrc+N5gmucIay0GQw00OJ28Qd77zxKkuJqhvi
 USL7e+ucUq66GnxXLC5QNGN/C/xoN9SP0fTZjlsA5fl67e8IWmYVr2qwa+gHOZX7us3CTqb5Nwb
 SKtANIWJSvpx4qwcJp3pNeXF2vwodbjgkocy1JfB9RpZ1pXvo/2pc3Jon8cyIw4ydghYmBDCqvW
 iYe63ReHGok4gzJAMQ3S2d4MRm1a4cmWpkyX+W9S6mBpbX27K5TWUluWgG00tYFCUqXs2sGV/TB
 atyxCwm0FiEDFXFYItET5UU0seTCDynbwq7bwoQx7XQdJ4M789v4rvlrAgwe0e2vDXYn6u9lOMr
 NK3Yhv2yvliU2i5cVrU5vDzerN+xkf8IpgdNEUX+CnxNGnXRo/E9Q3aR47upU/+oyr3UufvtGm0
 LuTbNXGh6KjyJMsYTBOYA=
X-Google-Smtp-Source: AGHT+IHf64SbPewUIVKnFcsOR3pZ6Nc/bZ27kUpb1X6IhV9YxemjEIm+F5msk/lMD8DTC9dFV2ChXg==
X-Received: by 2002:a05:600d:844f:10b0:477:9cdb:e336 with SMTP id
 5b1f17b1804b1-47a90019d50mr7404895e9.21.1765529444889; 
 Fri, 12 Dec 2025 00:50:44 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a66b1fsm11374379f8f.9.2025.12.12.00.50.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 00:50:44 -0800 (PST)
Mime-Version: 1.0
Date: Fri, 12 Dec 2025 09:50:43 +0100
Message-Id: <DEW3YDE8MMBT.DEEW2VO31X0G@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251211111046.87297-1-pvorel@suse.cz>
In-Reply-To: <20251211111046.87297-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ima_violations.sh: Another fix of condition
 evaluation
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Thu Dec 11, 2025 at 12:10 PM CET, Petr Vorel wrote:
> c0c35509f9 was not enough to fix evaluation against empty
> $expected_violations:
>
> ima_violations 1 TINFO: verify open writers violation
> /opt/ltp/testcases/bin/ima_violations.sh: line 96: [: 0: unary operator expected
>
> Therefore split checks into two if.
>
> Also improvements (readability)
> * shorten line length with saving subtraction into variable
> * evaluate empty variable with ${:-}
>
> Fixes: 726ed71905 ("ima_violations.sh: Update validate() to support multiple violations")
> Reported-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> NOTE: this was found on old SLES 4.4 based kernel which does not log
> validations. But missing validations might be just a Secure Boot related
> setup problem:
>
> $ mokutil --sb-state
> Secure Boot: EFI variables not supported on SUT
>
> Events are logged when Secure Boot is off:
> $ mokutil --sb-state
> SecureBoot disabled
>
> Or maybe violations worked differently on the old kernel (I remember
> only 6.15 change).
>
> Kind regards,
> Petr
>
>  .../integrity/ima/tests/ima_violations.sh     | 21 ++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> index 1d2f1d9447..a8476e6b59 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> @@ -87,23 +87,30 @@ validate()
>  	local search="$3"
>  	local expected_violations="$4"
>  	local max_attempt=3
> -	local count2 i num_violations_new
> +	local count2 diff i num_violations_new pass
>  
>  	for i in $(seq 1 $max_attempt); do
>  		read num_violations_new < $IMA_VIOLATIONS
>  		count2="$(get_count $search)"
> -		if [ -z "$expected_violations" -a $(($num_violations_new - $num_violations)) -gt 0 ] || \
> -		   [ $(($num_violations_new - $num_violations)) -eq $expected_violations ]; then
> -			[ -z "$expected_violations" ] && expected_violations=1
> +		diff=$(($num_violations_new - $num_violations))
> +
> +		if [ "$expected_violations" ] && [ $diff -eq $expected_violations ]; then
> +			pass=1
> +		fi
> +		if [ -z "$expected_violations" ] && [ $diff -gt 0 ]; then
> +			pass=1
> +		fi

Maybe readability can be improved (well..shell scripts are pretty ugly
by nature anyway):

	diff=$((num_violations_new - num_violations))

	if [ "$expected_violations" ]; then
		[ $diff -eq $expected_violations ] && pass=1
	else
		[ $diff -gt 0 ] && pass=1
	fi

> +
> +		if [ "$pass" = 1 ]; then
>  			if [ $count2 -gt $count ]; then
> -				tst_res TPASS "$expected_violations $search violation(s) added"
> +				tst_res TPASS "${expected_violations:-1} $search violation(s) added"
>  				return
>  			else
>  				tst_res TINFO "$search not found in $LOG ($i/$max_attempt attempt)..."
>  				tst_sleep 1s
>  			fi
> -		elif [ $(($num_violations_new - $num_violations)) -gt 0 ]; then
> -			tst_res $IMA_FAIL "$search too many violations added: $num_violations_new - $num_violations"
> +		elif [ $diff -gt 0 ]; then
> +			tst_res $IMA_FAIL "$search too many violations added: $diff ($num_violations_new - $num_violations)"
>  			return
>  		else
>  			tst_res $IMA_FAIL "$search violation not added"

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
