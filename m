Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B539BC021B1
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 12:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740055382; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=Ev+660/WD2wEx5CIzjoriuN+8iuDkQwFrUMEUgfShFE=;
 b=Y6EalpDlwVjwFivzCM4s3f7AKRyI9pip6HPcFz0MFTRVhy5sBikYJcYRlCaKh6XVBI3ws
 ZRv8dmH8L76POn9N0grRt6Vb8YwePuDn+lmLI14k0FQWEQCrtGWY8jv0aRNmclMPn2NWHzF
 IQ94Kc5L28qzWAQR4Ok+OaKMWYm+WzI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D60F3C6803
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 13:43:02 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 044103C00B1
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 13:42:39 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0026821BDA5
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 13:42:38 +0100 (CET)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-abb75200275so147436166b.3
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 04:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740055358; x=1740660158; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RLyAk7gBmgbs/H2fIHLoE/Ts03jORQtY5j86FjglxL0=;
 b=XnhCaZva2vkucT3RBwOnpLqIgvPePWY7k2SvJ3YeNu0NYB6Nr977VriSLrEA3T8Mf3
 EVV6I/19g1nn8iSODW44Nua/+qlWfT0HLHzPmTkpZz8YL29HfX7ekjm+b4ynPtzlqgKL
 LuEQ6lEAZjRq6VKjR1obhHO81yH1r7rvQrRA7l2awncZdNRxrVVThWbaVXy0AeqrRcgK
 8t7QXMwPunVe79cx/5owkq9DrCJWEemZ9lGU8jp5IlkoDBgJWxeAw1/NnClYWDEmQ+E6
 EGdidIMnWtTz8WQlPfAS+AbZz1NHayWnmRj4d2KGWBQZmt1Oz+EhyABEBvqIGKNmPLAG
 tQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740055358; x=1740660158;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RLyAk7gBmgbs/H2fIHLoE/Ts03jORQtY5j86FjglxL0=;
 b=Yv4k5iR9C61wXsu4n40k5BhUdb/boboZz5uINtiVdbq/eQvKvTs9iN8+2CVSnKqBXI
 DQI2SHvrfgRK13uUpEVwePb101QQhplPh7rUm+q5kysor2zwSYuzmyYJobTrvkFFIr5L
 YZTbalh6yCO0ChZRl9pqvJI/hbhI+108vmsHUUNJMSdbB4N+dAAxYs1/R3385vYuXuTG
 atsjElP++gmmfeAQKLT3VQ3che1SfeUN9NjI0mCViXU+FAb9sSvMlFweA0lVQFbqXxHi
 uJ8FihVC3bbUY2Z4K/S/0os1LWuOhkk5kVY2tqeWcz9Wxz0q3ik/QgkjdU6MAquVLfzf
 Re/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUjihCKOvV2dST/L5E5pPBrE+x/v1ggpe7W1wvBY2fPXHcsfc3pggVnBd08woyENeNySk=@lists.linux.it
X-Gm-Message-State: AOJu0YzrYh7PbviXdS9IwgA8INBhjdNYfqjPNIUGhJ6TUtQZWg8JSlxW
 TrDwBg5q+wKD94wOx5aPuQsMuq+X0M9q26EkcBYg+iVP2aZHiKBThLR/AnFx/7Q=
X-Gm-Gg: ASbGnctzsXSgSvK19YLB4IA6cS8pkb/8NfbHFGZhNTyQDx2nY6uUJDBZmChQ8jkqJa5
 EPY8s76ASOKZCod/P0oqFdmauqeGQzMb+2Io5ePeWSbdSbANwyWvRR2LEKIVu24ODZ9Nm5ZCZSn
 fcE+NlAPnTWwMW8XSku0CSzEfQiewIMGxmpmgukgNfZ2ztOiSFrT6btyjweW0wZj/om2nPtZvJa
 Sh7VGA+AGSckxTBKio4aCDCQmfNhoLJhdLRkA/+J/n827tIH7SnRgZ92bDma4YXIbPOsMDUcXZB
 93L8AZ0NWZ/GIBLLzc7pABZT4YBo1aThUDuVymfdzbMa3py8akkEJiqLszCehR/yvVWNjUMymN1
 ti1DeruHR3oXcyczTRr/squ8UTHggTZYpEzq0JuS+m4NNIW6XLfA=
X-Google-Smtp-Source: AGHT+IHj97byDdmfeuVK0lmoBxb3j6Ie/ZORsIPA6M8SFSvhHaMSsnvu6+4ICwZqJfAchAhdVEcl0A==
X-Received: by 2002:a17:907:7704:b0:ab7:eeae:b23b with SMTP id
 a640c23a62f3a-abbf329e965mr212309066b.0.1740055358355; 
 Thu, 20 Feb 2025 04:42:38 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb71400460sm1062167766b.154.2025.02.20.04.42.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 04:42:38 -0800 (PST)
Message-ID: <f2a0be74-94c4-480f-b53c-7ba4673014f1@suse.com>
Date: Thu, 20 Feb 2025 13:42:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250219160143.2589026-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250219160143.2589026-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: Link struct tst_test and tst_tag
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

Hi,

mmh..result looks really weird. Basically every table item is a link to 
tst_test. Did you check if it's possible to extend the struct parser in 
order to have a link for each attribute?

Andrea

On 2/19/25 17:01, Petr Vorel wrote:
> Although it's currently impossible to link to tst_test members,
> it's still useful to make links to allow user to read the actual code.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   doc/conf.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/doc/conf.py b/doc/conf.py
> index 2be847d90b..8cc890fcc8 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -286,7 +286,7 @@ def _generate_tags_table(tags):
>               tag_val = f'`{tag_val} <{tag_url}{tag_val}>`_'
>   
>           table.extend([
> -            f'   * - {tag_key}',
> +            f'   * - :c:struct:`{tag_key} <tst_tag>`',
>               f'     - {tag_val}',
>           ])
>   
> @@ -331,6 +331,7 @@ def _generate_table_cell(key, values):
>       Generate a cell which can be multiline if value is a list.
>       """
>       cell = []
> +    key = f' :c:struct:`{key} <tst_test>`'
>   
>       if len(values) > 1:
>           cell.extend([

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
