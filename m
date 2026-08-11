Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E01C5CFCF
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 08:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786438128; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=ir6CvjccbpMEF4jTL/gxwmql64yLO04slNnUkNN8s/g=;
 b=dZ0HInq4R1IjFJ6PpPHUsrTlHW8Il29k/O5TDVIl5ONKZ8YSXv9MKFSflk2CeEPZ8CVlr
 zZsynq2eWeM+Ti78NIwTQtmQTfOyzcBo2dpjqTyo2Ewpg/hQ97PUiYtQhKbACsBbw3f+EUY
 OSdUskCQ1uN71HJaBF5vb88a4N03zkU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B8783D06EA
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 10:48:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CA0B3CB2E9
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 10:48:28 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EF5666005C9
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 10:48:26 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so2294778f8f.0
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 01:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786438106; x=1787042906; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ECnEsA1bbFwAX2MzfQFWuorupG4+NL2LlRM0Qr1Dl4A=;
 b=NiWVI4qCZ6cBzKhs0VgzkE3f7wfgYqFo6bouBH4wHoTsuJDDY+fHtCLSjantV8wkpY
 oXJzbdsvPt35si+QF8uxWNEnEZup3+QKZu32WniwckpdoFFuT6lypzooMjjkxEUsj50s
 UDH1WTMUTkXXh5MmcvLCkwMMz9hkMQC/IQFiXw3IinfMrIizvvEnmUHzND2MhituMtPO
 kPbe2nczto70jdb2fj36SpCanD66xJjMzYL8MhbhfyRpU/F7whd8EyOD59LnCI70ncNn
 DKDwHWEoMCv9KWKB9Zu5sDR5gFB0qeL2waz4GADHO/iFVstfVvYJaepzamSPoMsGOtqC
 kqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786438106; x=1787042906;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ECnEsA1bbFwAX2MzfQFWuorupG4+NL2LlRM0Qr1Dl4A=;
 b=RXxxPjtI4ZJPp0H+pA1hUjj1cslVVlr5ykKcwxial73o8Z4MrVbgQsHDqoa7oI+X76
 NhHsbW3s7420PKPW4pGZc8Ws6+MfetK06jOCWXUD+hYjZD0MUom8UKz4F3H/jBHDvFX8
 /F+8hCmIltmZItJAy+IerOGDmfjTF4OUvBFxUhoiJS6316NuVZFioPFDNVR19tFCeJL1
 Isb+1lFbX5qngCyZwk6MkYbs4cQHXueGyxAnfM5ytCVQqv6IO+O3SNIQTrLwgK+gTLKK
 GSfG8pB4iCU6S+V1zYtGFwdeJ/jPAwtpnQEqQxkGjOVFwvXQmH5/kKK3SEBPYzirCsOJ
 aj6Q==
X-Gm-Message-State: AOJu0Yy9ObbUF8wCuN1MmogNDXzDXcSqVbjRB/pk4rz72xTW+biLLwmT
 l2NK7amRgGtNjIwV6KqjAKM7v4m/4/e33hTcv7UQkqMPMqauGKweXBjI4GStFi+TioE=
X-Gm-Gg: AR+sD13t+CkNG3vUK77HeBD/L9F9RXz16u+P3oQ0WRm+X1xDrcbLznqK7vCQjvaFfVj
 iKIIwSOqOz+KsF738Gdvd1HIeIsNlX5FtRobZq3qH442adTI6n1aeZf7KzCL4dtKIu0z8uhbA2E
 JFaIyl4/GWSQ2nxhgWB8qxonLGG3OSlqv4xYrSN0rxYAHjPVkTHwCiVPzxjqPHuVJMj+1LRiO7y
 YLW664ll8btUFNAMBcjVYYA001yoUMwcXLZz/CbSRVvTP6l79duUa2QgfDTKCNC2DPEtPknUcla
 ZvjOsTnXa05MfJitP+J25y0vOmL6/dZfqxTUZ6RrujFXN3+CvU+92jIJKmH4bW6mMz+/fJmjObF
 16mZKGhSGTG2H3EcdeEMa2d5hXdl1jEnAEFQnfkrRVRDY0oq2pPurBEHvW/LnSyOG/KTGdpVhPq
 dQQ02PHQ2hhNKp1spSBEVv+/wQhtxXFPQMw2Ob++OCwvYN0KslHdNkUZVc+7omeZwGz60aLweT3
 9PxnrMnOpvrYo3C
X-Received: by 2002:a05:6000:4603:b0:47f:96e3:5309 with SMTP id
 ffacd0b85a97d-4814ad8a4d5mr2823100f8f.9.1786438106207; 
 Tue, 11 Aug 2026 01:48:26 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a5ac856sm2752871f8f.8.2026.08.11.01.48.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 01:48:25 -0700 (PDT)
Message-ID: <aa02bbd8-c908-4f34-82c5-acd7a361ce94@suse.com>
Date: Tue, 11 Aug 2026 10:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20260806074713.158271-1-avinesh.kumar@suse.com>
 <20260810103134.GA918586@pevik>
Content-Language: en-US
In-Reply-To: <20260810103134.GA918586@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nfs_lib: Skip NFS versions disabled on server
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

Thanks for your review.

> 
> Thanks for handling this!
> 
> LGTM? few notes below.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ...
> 
>> -get_socket_type()
>> +get_socket_type_raw()
> very nit: slightly confusing type, because there is a "raw" socket SOCK_RAW.
> I guess any network programmer seeing this will think of that socket, e.g.:
> socket(PF_INET, SOCK_RAW, ...);
> socket(PF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
> 
> But of course it can stay.

How about get_socket_type_bare() ?

> 
>>   {
>>   	local t
>>   	local k=0
>>   	for t in $SOCKET_TYPE; do
>>   		if [ "$k" -eq "$1" ]; then
>> -			echo "${t}${TST_IPV6}"
>> +			echo "$t"
>>   			return
>>   		fi
>>   		k=$(( k + 1 ))
>>   	done
>>   }


>> +nfs_server_vers_enabled()
>> +{
>> +	local vers="$1"
>> +	local versions=" $(tst_rhost_run -c 'cat /proc/fs/nfsd/versions 2>/dev/null') "
>> +
>> +	case "$versions" in
>> +	*" -$vers "*) return 1;;
>> +	esac
> 
> very nit: I was thinking if having the space in case would be slightly more
> readable, but probably not. I consider spaces in both versions as unnecessary
> (i.e. formatting error) but of course they are necessary.
> 
> 	local versions="$(tst_rhost_run -c 'cat /proc/fs/nfsd/versions 2>/dev/null')"
> 
> 	case " $versions " in
> 
>> +
>> +	return 0
>> +}
>> +
>> +# Drops NFS versions the server explicitly disabled from $VERSION, keeping
>> +# $SOCKET_TYPE entries aligned by position with what remains.
>> +nfs_filter_versions()
>> +{
>> +	local v type
>> +	local n=0
>> +	local new_version=
>> +	local new_socket_type=
> nit: it should be safe to use it without '=', right?
> local v type new_version new_socket_type
+1

> 
>> +
>> +	for v in $VERSION; do
>> +		type=$(get_socket_type_raw $n)
>> +
>> +		if nfs_server_vers_enabled "$v"; then
>> +			new_version="$new_version $v"
>> +			new_socket_type="$new_socket_type $type"
>> +		else
>> +			tst_res TINFO "NFSv$v disabled on server, skipping"
> 
> Could this be TCONF so that results summary at the end shows some TCONF?
> That indicates something was skipped.
+1

> 
> +			tst_res TINFO "NFSv$v disabled on server, skipping"
> +			tst_res TCONF "NFSv$v disabled on server, skipping"
> 
>> +		fi
>> +
>> +		n=$(( n + 1 ))
>> +	done
>> +
>> +	[ -z "$new_version" ] && \
>> +		tst_brk TCONF "none of the requested NFS versions ($VERSION) are enabled on server"
> nit: I would expect this would quit the test on system with
> set -o errexit (equivalent of set -e), but magically it works.
> FYI normally it's better if any test line exit with 0 => use || (or if ...; then
> ... fi) instead &&  i.e.
> 
> [ ... ] || tst_brk TCONF
> 
> But because it works it can stay.
+1. I will switch to below for consistency.
	[ "$new_version" ] || \
		tst_brk TCONF ...
> 
>> +
>> +	VERSION="${new_version# }"
>> +	SOCKET_TYPE="${new_socket_type# }"
> 
> Fortunately removing leading space works also on dash, although at least some
> string operations aren't part of POSIX [1].
> 
> If this is ever problematic, we can fix it with:
> 
> 	[ "$new_version" ] && new_version="$new_version $v" || new_version="$v"
> 	[ "$new_socket_type" ] && new_socket_type="$new_socket_type $type" || new_socket_type="$type"
> 
> But because removing leading space is not needed, because later code for t in
> $SOCKET_TYPE; do will handle that, I'd remove this part entirely.
Actually we need to remove the leading space, otherwise we break
nfsstat01 where $VERSION is being used as whole scalar value.
case $VERSION in

I can switch to the solution you suggested here.

> 
> FYI: (no leading/trailing space in parameters, no $t having just empty space:
> SOCKET_TYPE=' udp tcp  '; for t in $SOCKET_TYPE; do echo "'$t'"; done
> 'udp'
> 'tcp'
> 
> [1] https://mywiki.wooledge.org/Bashism#Parameter_Expansions
> 
> Kind regards,
> Petr

Regards,
Avinesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
