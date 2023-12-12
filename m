Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC57C4332F
	for <ltp@archiver.kernel.org>; Tue, 12 Dec 2023 10:09:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E314E3CEE51
	for <ltp@archiver.kernel.org>; Tue, 12 Dec 2023 11:09:00 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E7923CB5FB
 for <ltp@lists.linux.it>; Tue, 12 Dec 2023 11:08:51 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4271C206C4A
 for <ltp@lists.linux.it>; Tue, 12 Dec 2023 11:08:50 +0100 (CET)
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c9f7fe6623so68718571fa.3
 for <ltp@lists.linux.it>; Tue, 12 Dec 2023 02:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1702375729; x=1702980529; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6nw5DzH0ZD1VdnWGQ2bASo0ICmcuoct/lhPX9JvfQa8=;
 b=IM4hVOwlLayYtLpN/JWvc0zzfLuQ9Dgtdyx4PUb8wCkFyfg6oViiDe9iD4whF8mS3z
 bKdyE3Tajax4L11OOGMka7cB6R7/HJMyMNKfamL6h4+JG23yMM1CZ80ZVg820sOCxiot
 JKAtsZQWxAgKQg3W7Ae2AZSb3+oHu9LCS2AxiknvrFFR+ktGdPSAsmTQafif71ZBXivs
 bP0aGKJMZSnhMhysMmySqQN8aMUdiitQFm52ApLxnKn8R9Pkly6G0HhptvGF2vF6N6VX
 kWUk082lh0/m4x1pBJy+GNlUEfv4xnaBX1QpxRb1wJnwdV0QoZ7zAMikq8XyA2x+F194
 L7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702375729; x=1702980529;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6nw5DzH0ZD1VdnWGQ2bASo0ICmcuoct/lhPX9JvfQa8=;
 b=mDtN5QktI6yhiI1uiWztGklLlSqgbLLXj6r3CRPXT5MdnRTmfNkL5Az6AH3krlg89z
 LJoJGn9aHLOUt2qNFBAe2y2ROUl629riiG3Cz0NsLVaG/40E2l6UlF85r+0LseBbTxfx
 7L+N9E6tjpJNynQlF2KQyEPzMlE9I62MtTeLXWzP4gElPcMmVKlowLRdlUPN1OHDDyCv
 WdINOAAQu2ADyMB2UPr6iDIAA/R/8k80NzhTmkvtNiWLjc6RldUGmzzaanTUnhpzbGTj
 2HyFYT9+LcErya1scQoqtCfY73p6k1uOZcZYYZpAYDRd//omzWqQLDEGqqXIVZRYSnSc
 6bpQ==
X-Gm-Message-State: AOJu0Yw+KuIbQV/g1LRqsNjqNdvnlSyFfhL1L5gKYgh7NOMKym5zozSw
 BDkbupkn8d1gKwmqAfg8OhKkqDcsGCFtE+t6HYE=
X-Google-Smtp-Source: AGHT+IHuPqinQbUnG/zTVw1PIPto3+UlUVKLpvyVToRCrkXsfQNWHzUrv1Hp1rvW8RDUHpVFuhwKHw==
X-Received: by 2002:a05:6512:2352:b0:50d:1e6f:b52c with SMTP id
 p18-20020a056512235200b0050d1e6fb52cmr1598857lfu.76.1702375728609; 
 Tue, 12 Dec 2023 02:08:48 -0800 (PST)
Received: from ?IPV6:2a02:a31b:843f:e00:d596:e8e:78c7:ff41?
 ([2a02:a31b:843f:e00:d596:e8e:78c7:ff41])
 by smtp.gmail.com with ESMTPSA id
 vx6-20020a170907a78600b00a1e852ab3f0sm6116687ejc.15.2023.12.12.02.08.48
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 02:08:48 -0800 (PST)
Message-ID: <e9c67e52-e4e6-4a15-ae7d-31995c515ba6@suse.com>
Date: Tue, 12 Dec 2023 11:08:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20231211161807.526714-1-pvorel@suse.cz>
 <20231211161807.526714-4-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20231211161807.526714-4-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] fsx-linux: Reduce log output with TDEBUG
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

Andrea

On 12/11/23 17:18, Petr Vorel wrote:
> Log output is very verbose thus silent with changing most verbose
> TINFO messages to TDEBUG. Given how many times the test tries it's a
> significant time spent for printing output. This change also helps to
> run on slower SUT without need to set LTP_TIMEOUT_MUL environment
> variable.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testcases/kernel/fs/fsx-linux/fsx-linux.c | 33 ++++++++---------------
>   1 file changed, 11 insertions(+), 22 deletions(-)
>
> diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c b/testcases/kernel/fs/fsx-linux/fsx-linux.c
> index 23e608189..658fc99c3 100644
> --- a/testcases/kernel/fs/fsx-linux/fsx-linux.c
> +++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
> @@ -98,8 +98,7 @@ static void update_file_size(struct file_pos_t const *pos)
>   {
>   	if (pos->offset + pos->size > file_size) {
>   		file_size = pos->offset + pos->size;
> -
> -		tst_res(TINFO, "File size changed: %llu", file_size);
> +		tst_res(TDEBUG, "File size changed: %llu", file_size);
>   	}
>   }
>   
> @@ -114,8 +113,7 @@ static int memory_compare(
>   	for (long long i = 0; i < size; i++) {
>   		diff = a[i] - b[i];
>   		if (diff) {
> -			tst_res(TINFO,
> -				"File memory differs at offset=%llu ('%c' != '%c')",
> +			tst_res(TDEBUG, "File memory differs at offset=%llu ('%c' != '%c')",
>   				offset + i, a[i], b[i]);
>   			break;
>   		}
> @@ -135,10 +133,8 @@ static int op_read(void)
>   
>   	op_file_position(file_size, op_read_align, &pos);
>   
> -	tst_res(TINFO,
> -		"Reading at offset=%llu, size=%llu",
> -		pos.offset,
> -		pos.size);
> +	tst_res(TDEBUG, "Reading at offset=%llu, size=%llu",
> +		pos.offset, pos.size);
>   
>   	memset(temp_buff, 0, file_max_size);
>   
> @@ -176,10 +172,8 @@ static int op_write(void)
>   		temp_buff[i] = data;
>   	}
>   
> -	tst_res(TINFO,
> -		"Writing at offset=%llu, size=%llu",
> -		pos.offset,
> -		pos.size);
> +	tst_res(TDEBUG, "Writing at offset=%llu, size=%llu",
> +		pos.offset, pos.size);
>   
>   	SAFE_LSEEK(file_desc, (off_t)pos.offset, SEEK_SET);
>   	SAFE_WRITE(SAFE_WRITE_ALL, file_desc, temp_buff, pos.size);
> @@ -194,10 +188,9 @@ static int op_truncate(void)
>   	struct file_pos_t pos;
>   
>   	op_file_position(file_max_size, op_trunc_align, &pos);
> -
>   	file_size = pos.offset + pos.size;
>   
> -	tst_res(TINFO, "Truncating to %llu", file_size);
> +	tst_res(TDEBUG, "Truncating to %llu", file_size);
>   
>   	SAFE_FTRUNCATE(file_desc, file_size);
>   	memset(file_buff + file_size, 0, file_max_size - file_size);
> @@ -218,10 +211,8 @@ static int op_map_read(void)
>   	op_file_position(file_size, op_read_align, &pos);
>   	op_align_pages(&pos);
>   
> -	tst_res(TINFO,
> -		"Map reading at offset=%llu, size=%llu",
> -		pos.offset,
> -		pos.size);
> +	tst_res(TDEBUG, "Map reading at offset=%llu, size=%llu",
> +		pos.offset, pos.size);
>   
>   	addr = SAFE_MMAP(
>   		0, pos.size,
> @@ -261,10 +252,8 @@ static int op_map_write(void)
>   	if (file_size < pos.offset + pos.size)
>   		SAFE_FTRUNCATE(file_desc, pos.offset + pos.size);
>   
> -	tst_res(TINFO,
> -		"Map writing at offset=%llu, size=%llu",
> -		pos.offset,
> -		pos.size);
> +	tst_res(TDEBUG, "Map writing at offset=%llu, size=%llu",
> +		pos.offset, pos.size);
>   
>   	for (long long i = 0; i < pos.size; i++)
>   		file_buff[pos.offset + i] = random() % 10 + 'l';



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
