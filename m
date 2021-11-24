Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D850C433F5
	for <ltp@archiver.kernel.org>; Wed, 24 Nov 2021 14:07:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE27D3C641A
	for <ltp@archiver.kernel.org>; Wed, 24 Nov 2021 15:07:40 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5645F3C07C1
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 15:07:31 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 84BA61000415
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 15:07:30 +0100 (CET)
Received: by mail-lf1-x12c.google.com with SMTP id m27so7500417lfj.12
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 06:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bell-sw-com.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LEANiyFPrRZ+lzV4p7XWYrT09QKW6jMCQ8hnhqhYXMs=;
 b=FnJI4h1cwrQUdHYJAmg2tcKVCQ+0D7G+uN6pICdnx8URWwl99xvbyJOPP/y7cfLCcf
 ApVn9rETKnpwpKRYyhbdKfnxC0LUTiaFN60h8OWXTleD8xQcRwlh1U43gZG6YjcoUteL
 QbFOve3C5MYRpprlJ6I5ivBxeHMnjd4ITflI2K5RsyZ5ByQwh9r/YBOgXg7xGRcJ0r/B
 VKM++Nrwjb9NCO2wjA4o31lwAStDq76Fo+w80hChV/gfJAVcLzvo1ZKhZ+JDtytNVHwT
 7pXdGUGgUTm6Uic1+V+xjVgpwJau2bgtu/6PiYB0pMxdEFOe9JhOLvEEL3K83wUWirau
 OQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LEANiyFPrRZ+lzV4p7XWYrT09QKW6jMCQ8hnhqhYXMs=;
 b=1H4ZaicFE/3ioLi20Fkila0vXYIXTtef3fveI9YStw1tUAnk/HLTSKXmrP36jJxLIW
 Q3xP3VCpQnK5Wm3dwsV4wEJ5q9iiZgonlazYswRIX9mRVrFSC4L4YweMCbU3t96mBaCp
 wfwq1xM3Z4q/TXK6DXB+MgmGnFnxOsk44i8mNJAldHgv+URnbggiO0jdfvpt1QLEXmJ3
 YW38jwstwuGK1d90K/+kQb50Y2gocU4CEwhsEj2aoAH9Qjb0Ld7PmZJ9CLak2cKwIvA4
 oPmjBEMlvGrLWEWVP2Hz3fgfzI++ns1/XKMmtCJr7ILzoBaQKSp/IJA3cYKCMWl3Lh/4
 5wVw==
X-Gm-Message-State: AOAM533NqF9jEP5PVsAKkW/d42/6KyzB4w0dsXcU6w6ZLlPo6bRTi/kM
 1WH9hWH9GhYrpdJIdDRSGpFymYA5daxj
X-Google-Smtp-Source: ABdhPJxsPafsSX3UJBsrTsr15Ql5ClF9nL3sozTJyGgZaDdFkkpZ21rcP/mgaXfMVH2PY5qqChk6yg==
X-Received: by 2002:ac2:4d29:: with SMTP id h9mr15153290lfk.633.1637762849535; 
 Wed, 24 Nov 2021 06:07:29 -0800 (PST)
Received: from [192.168.1.33] ([95.161.221.177])
 by smtp.gmail.com with ESMTPSA id f17sm1056512lfl.117.2021.11.24.06.07.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Nov 2021 06:07:29 -0800 (PST)
To: Petr Vorel <pvorel@suse.cz>, Martin Doucha <mdoucha@suse.cz>
References: <20211123151537.14913-1-mdoucha@suse.cz>
 <20211123151537.14913-3-mdoucha@suse.cz> <YZ1Dmbh+m6blfLzZ@pevik>
 <9d0f2161-4c10-6318-5a15-470cc12fe76c@suse.cz> <YZ4LAN2RrJntGlFq@pevik>
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Message-ID: <8b239e34-14cc-dfab-cdf4-bec9148a3a42@bell-sw.com>
Date: Wed, 24 Nov 2021 17:07:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YZ4LAN2RrJntGlFq@pevik>
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] Add test for NFS directory listing
 regression
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

On 24.11.2021 12:50, Petr Vorel wrote:
> Hi Martin,
> 
>>> -	echo "-n x    Create x files and x directories, default is 5000"
>>> +	echo "-n x    Create x files and x directories, default is $FILE_COUNT"
>>>  }
> 
>> If you run `nfs07.sh -hn 123`, your version will print that the default
>> is 123.
> 
> Out of curiosity (as it's not anything important) not sure what's wrong on my
> side (I tested it before I suggested it, I also reinstalled LTP to make sure
> it's updated), but it works as expected:
> 
> # PATH="/opt/ltp/testcases/bin:$PATH" ./nfs07.sh -hn 123
> nfs07 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
> nfs07 1 TINFO: add local addr 10.0.0.2/24
> nfs07 1 TINFO: add local addr fd00:1:1:1::2/64
> nfs07 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
> nfs07 1 TINFO: add remote addr 10.0.0.1/24
> nfs07 1 TINFO: add remote addr fd00:1:1:1::1/64
> nfs07 1 TINFO: Network config (local -- remote):
> nfs07 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
> nfs07 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
> nfs07 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
> -t x    Socket type, tcp or udp, default is udp
> -v x    NFS version, default is '3'
> -n x    Create x files and x directories, default is 5000
> -h      Prints this help
> -i n    Execute test n times
> 
>>>  do_setup()
>>> @@ -45,7 +45,7 @@ do_test()
>>>  {
>>>  	local count
> 
>>> -	# Pass the list of files through `sort -u` in case `ls` doesn't fitler
>>> +	# Pass the list of files through `sort -u` in case `ls` doesn't filter
>>>  	# out potential duplicate filenames returned by buggy NFS
>>>  	count=`ls | grep '^file' | sort -u | wc -l`
> 
>>> @@ -61,7 +61,7 @@ do_test()
>>>  		return
>>>  	fi
> 
>>> -	tst_res TPASS "All files and directories were correctly listed"
>>> +	tst_res TPASS "All $FILE_COUNT files and directories were correctly listed"
>>>  }
> 
>> That would make the line over 80 characters and the number isn't that
>> important. Let's fix just the "fitler" typo.
> I don't consider 80 as an issue as long as it's not over 100 chars (barier
> increased also in mainline checkpatch.pl), but sure, these are really minor
> issues, thus agree to fix just the typo.
> 
> Waiting little longer if Alexey has any comments and then merge.

Hi Petr, Martin

Overall the new test looks good, and I would only replace the old style
command substitution count=`ls ...` with count=$(ls ...).

Thanks,
Alexey

> 
> Thanks a lot for very useful test case!
> 
> Kind regards,
> Petr
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
