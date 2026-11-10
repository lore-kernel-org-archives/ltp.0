Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50675606BFEE
	for <ltp@archiver.kernel.org>; Tue, 10 Nov 2026 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RNLMLTvy
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6CA2E3EA14C
	for <ltp@archiver.kernel.org>; Tue, 10 Nov 2026 14:07:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A97B3E1B79
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 14:06:54 +0100 (CET)
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 23A5820097C
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 14:06:54 +0100 (CET)
Received: by mail-oo2-x02.google.com with SMTP id
 46e09a7af769-849c2965b9eso890600a34.1
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 05:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794316013; x=1794920813; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RFjBMg0giLR1uetTRkudwb05Bf8iLuE/0T3Q8YVvvoY=;
 b=RNLMLTvykpyXN3BL0AhXtE+kXq/fRaCGLRvpaq7vj/K8uaPptUwJTo4Mw9s4ksKtUi
 MfhUOV4NI+Ub/zAg6dgLNvwwegGEzLZUdMiGchq6W5H3dqCJnFMF5PwpwCzNmaKDgnWC
 lBzp18kmTCPZ5hvutlI5CxQsNhw8aW+Cjk4fr+Old4wcfLLBJ9C4PQV9iqm3B9w+VWYS
 FRWqUN76peTOASFQkBoP4DQITGPHfb/Jv9h7fmGy2CllUzyMq50tKftnpVF4CZKB/bSN
 0rnnjXzhusCsdRe+wOZlPOUuNfhRgEyjjDISn+S4bhmf9Z1D2QoQWvPO8g+fQWDC5I7E
 833Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794316013; x=1794920813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RFjBMg0giLR1uetTRkudwb05Bf8iLuE/0T3Q8YVvvoY=;
 b=SY/qmCLKXJhlEQBFyFm49OwibbxRFWPUoQkjboqvqNtqwa3AoeAt61V0UQ/JSmkoAZ
 xeRPZHErqh3X9YpzfaK+t8HljrFkbqRpGy8IOyJf6R6aj0sK6U+32mKRtTgMO8c7ayoS
 m/pIgxMpl23xpMOo9HzsfBRJ6G2KdT+LNO32xzxH1s/IWXLvMMTd+Ye0ju8b8rQvh3bS
 dhf6opb4eFu36r/ScIaO2aqzt/Pnsi+laLmU43yKDnzg6tHW+HbhXwqk4roMnpb1YOtb
 3yUna2TfjQOqShtzfGRIOO7zrmeEZUBgGCiW3kJhNMOOYxipYqECXE3b0obXdo6quDzl
 bSZg==
X-Gm-Message-State: APuU4Z/ZN7HLSXoQee4aE7Yv/hs0GI+jbfe9Rurz+y74h6CGKYox4NMj
 U8ROCsX4V0BFGEgubb2ZkjDc+Vd46Hvn+wl1u73B2SrP6ZqvyqGnxAy6tZFjB1k0svE=
X-Gm-Gg: AYBFou1tZkgxWeCXpkENo1VNWkXj4kbMck2gxH8UiFtGGtFjP6WWI9Vv1BEOPc687vA
 NYIynH4bB3d3T7Gz39QJLXnNQbn5jKT+y3C6Vyu24i9LjIEjoZqjsA+BUBWgB4iCsDl0VJ62giL
 bYSWczM6WFKiAH/A4jeG359MszbMN4lM38c1ShLVqXMfAcNnjyQbFfeK+dKfpXX9R7i+O+hISLO
 vQfVeGpAJtEmlSquAaCaJtWxsoNFjL+N1DFp2qHb9etdePfRFcVep4mgngRMabiohBYLDpe45TF
 uN5FhFKFXoNiGtmUc5dSy8I0qPkW1i38KY+LkSkMQdjejl9uTOPtjlkXF/dtWdmZ9s1aqfC3Q4I
 hkYAhj3x8DIu60I6qEexbgDNR82H8pSAiqnc/hVQWIQTbn4g/ilv2PFAAR7ozHgB9/I3aHdNYtJ
 JKdKRqwQN4s7EfWLJA9xXqsQ9eaKYhjD6VeusSgyBbmTZ2FYFKU6uX72F7Fs345aEWqG1LlrEkT
 iPJP2qmXGlDflyv/Ms6gHDLH1N5oheqRqVN2eCLT4Zqa9MbOZ3XJ3BRLEC9ws9O+3BezV7+rJcV
 DH4QHtHoEbjY22F7GnPhXqwKV1lXv/UH34gtDLMqQJnKI2qa/U/SoHwn8XV+p/hsVKOtyahHxN5
 ZJRqdXp+umiSEh4dxlX0Mgd+qXj5uWtv0CGclpyaCxzeHWR/n4VF6Ii03biaJFS8=
X-Received: by 2002:a05:6830:4108:b0:81d:54f9:d6a3 with SMTP id
 46e09a7af769-860dc6362cbmr1997089a34.4.1794316012434; 
 Tue, 10 Nov 2026 05:06:52 -0800 (PST)
Received: from
 runnervmwuk1x.y3en5ldd3b2ebobdorhaggvslg.jx.internal.cloudapp.net
 ([40.124.227.64]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860dcbc7eecsm1986990a34.15.2026.11.10.05.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 05:06:51 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Nov 2026 13:06:50 +0000
Message-ID: <20261110130650.3722-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109163222.1488772-1-chrubis@suse.cz>
References: <20261109163222.1488772-1-chrubis@suse.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: ujson: Update to ujson 1.0
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On Mon Nov 9 17:32:22 2026 +0100, Cyril Hrubis <chrubis@suse.cz> wrote:
> lib: ujson: Update to ujson 1.0

> diff --git a/include/ujson_common.h b/include/ujson_common.h
> index 1eaf3fc72..ed31c090d 100644
> --- a/include/ujson_common.h
> +++ b/include/ujson_common.h
> @@ -8,12 +8,12 @@
>   * @brief Common JSON reader/writer definitions.
>   */
>  
> -#ifndef UJSON_COMMON_H__
> -#define UJSON_COMMON_H__
> +#ifndef UJSON_COMMON_H
> +#define UJSON_COMMON_H
>  
>  /** @brief Maximal error message length. */
>  #define UJSON_ERR_MAX 128
> -/** @brief Maximal id string length including terminating null element. */
> +/** @brief Maximal id string lenght including terminating null element. */

This hunk (along with the comment changes in include/ujson_reader.h,
include/ujson_utf.h, and include/ujson_writer.h) reverts the spelling fixes
from commit f6933a16f304 ("include: Fix API comment spelling and style"),
reintroducing "lenght", "intializer", "An user", "An union", and
"an unicode".

> diff --git a/include/ujson_reader.h b/include/ujson_reader.h
> index 3722fffea..273fe624a 100644
> --- a/include/ujson_reader.h
> +++ b/include/ujson_reader.h
> @@ -540,4 +540,4 @@ static inline int ujson_reader_consumed(ujson_reader *self)
>  	return self->off >= self->len;
>  }
>  
> -#endif /* UJSON_H__ */
> +#endif /* UJSON_H */

The closing guard comment should be /* UJSON_READER_H */ to match the
#ifndef UJSON_READER_H guard at the top of the file.

> diff --git a/libs/ujson/ujson_common.c b/libs/ujson/ujson_common.c
> index 639955229..c9cada9a9 100644
> --- a/libs/ujson/ujson_common.c
> +++ b/libs/ujson/ujson_common.c
> @@ -35,3 +35,4 @@ const char *ujson_type_name(enum ujson_type type)
>  		return "invalid";
>  	}
>  }
> +

This adds a trailing blank line at EOF (also in libs/ujson/ujson_writer.c).

> diff --git a/libs/ujson/ujson_reader.c b/libs/ujson/ujson_reader.c
> index 9f86f25b7..964878b51 100644
> --- a/libs/ujson/ujson_reader.c
> +++ b/libs/ujson/ujson_reader.c
> @@ -229,31 +258,15 @@ static int copy_str(ujson_reader *buf, char *str, size_t len)
>  
>  static int copy_id_str(ujson_reader *buf, char *str, size_t len)
>  {
> -	size_t pos = 0;
> -
>  	if (eatws(buf))
>  		goto err0;
>  
> -	if (!eatb(buf, '"'))
> +	if (peekb(buf) != '"')
>  		goto err0;
>  
> -	for (;;) {
> -		if (buf_empty(buf)) {
> -			ujson_err(buf, "Unterminated ID string");
> -			return 1;
> -		}
> -
> -		if (eatb(buf, '"')) {
> -			str[pos] = 0;
> -			break;
> -		}
> -
> -		if (pos >= len-1) {
> -			ujson_err(buf, "ID string too long");
> -			return 1;
> -		}
> -
> -		str[pos++] = getb(buf);
> +	if (copy_str(buf, str, len)) {
> +		ujson_err(buf, "Unterminated ID string");
> +		return 1;
>  	}

Every error path in copy_str() already sets a specific error via
ujson_err() (such as "String buffer too short!" when the ID exceeds
UJSON_ID_MAX, or "Invalid escape \\%c"). Calling ujson_err(buf,
"Unterminated ID string") here overwrites that error message even when the
ID string is properly terminated; drop the extra ujson_err() call.

> @@ -299,17 +312,28 @@ static int get_int(ujson_reader *buf, struct ujson_val *res)
>  		return 1;
>  	}
>  
> +	unsigned long max = LONG_MAX;
> +
> +	if (sign < 0)
> +		max++;
> +
>  	while (is_digit(peekb(buf))) {
> -		val *= 10;
> -		val += getb(buf) - '0';
> -		//TODO: overflow?
> +		unsigned int d = getb(buf) - '0';
> +
> +		if (val > (max - d) / 10) {
> +			ujson_err(buf, "Integer overflow");
> +			return 1;
> +		}
> +
> +		val = val * 10 + d;
>  	}
>  
>  	if (sign < 0)
> -		val = -val;
> +		res->val_int = -(long)val;
> +	else
> +		res->val_int = (long)val;

When parsing LONG_MIN, val is (unsigned long)LONG_MAX + 1, so -(long)val
casts to LONG_MIN first and then negates LONG_MIN in signed long
arithmetic, which is signed integer overflow UB. Negate before casting
with (long)-val to perform the negation in unsigned long arithmetic.

> diff --git a/libs/ujson/ujson_writer.c b/libs/ujson/ujson_writer.c
> index c86a3b2af..214e20846 100644
> --- a/libs/ujson/ujson_writer.c
> +++ b/libs/ujson/ujson_writer.c
> @@ -389,15 +396,25 @@ struct json_writer_file {
>  
>  static int out_writer_file_write(ujson_writer *self, int fd, const char *buf, ssize_t buf_len)
>  {
> +	if (!buf_len)
> +		return 0;
> +
>  	do {
>  		ssize_t ret = write(fd, buf, buf_len);
> -		if (ret <= 0) {
> +		if (ret < 0) {
>  			err(self, "Failed to write to a file");
>  			return 1;
>  		}
>  
> +		if (ret == 0) {
> +			err(self, "The write() syscall returned 0");
> +			errno = EAGAIN;
> +			return 1;
> +		}
> +
>  		if (ret > buf_len) {
>  			err(self, "Wrote more bytes than requested?!");
> +			errno = EIO;
>  			return 1;
>  		}
>  
>  		buf_len -= ret;
>  	} while (buf_len);

If write() completes a partial write (0 < ret < buf_len), buf is not
advanced before the next iteration, so the loop writes the start of buf
again instead of the remaining bytes. Advance buf += ret alongside
buf_len -= ret.

Verdict - Needs revision

Pre-existing issues:
- In libs/ujson/ujson_writer.c, ujson_writer_file_open() checks
  if (!writer_file->fd) instead of if (writer_file->fd < 0), which fails
  to detect open() returning -1 and treats valid fd 0 as an error.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
