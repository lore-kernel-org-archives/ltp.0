Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8956E77182
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 14:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1734012189; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=PvW474c46PFu5EsYaDOLiworjjGzEua5S4gOvW0GuUk=;
 b=E7ciB2FUSdbouUGlwu7UnU7bKJmNa33NF1QIZrurManJWp4otocLM/NnLUet9Nv6G0rUf
 7yZCI4BVdZTtHn6Nh+7YvpgGp98VIkFAZo9pwgJDaNdlmySsCzHD2gClQtfhj5IDEUxgOE4
 UgNBHM8DdBh0mz4DZF5hWv8QYdhlJhw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C4E33E98F9
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 15:03:09 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF8B53E8848
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 15:02:46 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E510B633863
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 15:02:45 +0100 (CET)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5cec9609303so887301a12.1
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 06:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1734012165; x=1734616965; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A8g4TtZK0k/uWS7ADAjAf5n+YvqxdlK47dj2urxAT4g=;
 b=FWzPwAvZwbTcfPqF1Rcj0+Bbns0eS/2RTD+eG2uiBXcly2aGAv0XmFaRSxmyhoY7aA
 DG17v1GXR8dJA3k4ZXfoQRcdU6utwzCoww1r2RUSpSRyenfz7lJqgsNlnn6e5vM9yFUa
 QKtRC9mrnMFQbFl83r/E5jTqJmSymS2UDyiydvLI0hLlhAtJUJUmZmcdalyKkEMJiXeX
 X13NvxyT2QMZ+bj+Gx7Irw9znBxk1145qoE+spcqpoL4mSrNCSLZ6q07ZQHyy04ePf0K
 WZsH/K1s5CtY8P/VqQX+0InBKykLOCTQLvTCxJg0894tmeYc5ncEuw44B7VWmVXOr4ew
 bcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734012165; x=1734616965;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A8g4TtZK0k/uWS7ADAjAf5n+YvqxdlK47dj2urxAT4g=;
 b=plRKwec3PorfZvenZNtfXK1l0rjoX6+MBuqY3ifSV/NzPifNDalBf9QpN0NpySKqiF
 U3FH/5O/r0y7QeVIX4whYkexnXjTl/FEqx4M/deSHo34qJQxDydGmhOOosETaQ7sNoL6
 Pm5Pus2Y+hLsG9sp3QOh+vk8DnFCMB9ScmraOrMJCRswQ15lctm6xLMVssi1kzCLXxy0
 NCbJh1iCfmy1KyNynCJhoiNvoSxxTq46bz5jSI2VJYmtrznysIPo3vvurtVCTM2WXO9S
 wjczLATGgB7UnLfB+sPJsIyJJ/yu7dtZi+sRqVWQyKVocSZy5HGEDwLkKcQa9bQhNSTc
 2zMg==
X-Gm-Message-State: AOJu0Yz5sxDJby8Wn2d7j0waFZEDADR2EUhgCiWGOyMRpZz7fONNmf2Q
 WY/N1wnSZTIfbN4yzCR0VjwejtD60XYOlpWT64+rWbRUekUFSep5+zo7kmeLu8E=
X-Gm-Gg: ASbGnct+Cn4SxeP+As2Gim86IJzQ3Pu4OpZV4S+MEjrrNxzBC+0V7w3mjhzOQSpAo3z
 9eFx4RFuD/ZkgT5qOLS9e7d5tPlyAWNSUZ6eq0BVgSQiN5JdvIiGBCbSVE2a/2wH6IQQDQra5C+
 b7SSvA3wjslPQn8I8qd7JdUQ3BvUQL8AOBrHrRY5kufw1ncb3gqn1qPIH7dK4zq3Sf14Z+KhqmR
 g6uWGQMFac+/IcxvHt9lSny4uz4wIdCH2AGB56xGxa4kxiuKcbBJCNLA/0lZihA7XH9hOaCfOPV
 GPE3HFK0iy91I7dWos0WSDIjMM4Mr6LFInT8LEbKW2RGi/L7yyiEHx8yMZWiubGlitWYjy35Ydq
 K093d9BttwcyRbFkQoho=
X-Google-Smtp-Source: AGHT+IFlZU5hPBGpvBxnqnK99Oq0jOBjBo8/ue0FuWnjbN7ODQBZ+XUx9bQHlyg1UIVOmwVpyo5rmA==
X-Received: by 2002:a17:907:9518:b0:aa6:5201:7ae3 with SMTP id
 a640c23a62f3a-aa6c1ce666emr386681766b.40.1734012164892; 
 Thu, 12 Dec 2024 06:02:44 -0800 (PST)
Received: from ?IPV6:2003:ef:2f27:8800:6a22:ade0:fb79:fefa?
 (p200300ef2f2788006a22ade0fb79fefa.dip0.t-ipconnect.de.
 [2003:ef:2f27:8800:6a22:ade0:fb79:fefa])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa69d1e0710sm446580166b.40.2024.12.12.06.02.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 06:02:44 -0800 (PST)
Message-ID: <cf7cdca3-d0eb-46b9-8943-bd7473923565@suse.com>
Date: Thu, 12 Dec 2024 15:02:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241212-doc_syscalls_link-v1-0-69a916958ba9@suse.com>
 <20241212-doc_syscalls_link-v1-2-69a916958ba9@suse.com>
 <20241212133455.GB1476154@pevik>
Content-Language: en-US
In-Reply-To: <20241212133455.GB1476154@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] doc: support for clickable syscalls under
 stats
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 12/12/24 14:34, Petr Vorel wrote:
> Hi Andrea,
>
> TL;DR
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> I'm glad that my original idea to have links did not get lost :).
>
>> From: Andrea Cervesato <andrea.cervesato@suse.com>
>> Under statistics tab, add possibility to click on a syscalls and
>> being redirected to the source code which is testing them.
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   doc/conf.py | 120 ++++++++++++++++++++++++++++++++++--------------------------
>>   1 file changed, 69 insertions(+), 51 deletions(-)
>> diff --git a/doc/conf.py b/doc/conf.py
>> index 1c6a7f74c9401842c01f33dd34a5171d5328248c..258a1b9e285581e40c03caaf643e295fb90cb0c5 100644
>> --- a/doc/conf.py
>> +++ b/doc/conf.py
>> @@ -61,39 +61,38 @@ def generate_syscalls_stats(_):
>>       # because in some cases (i.e. io_ring) syscalls are tested, but they are
>>       # part of a more complex scenario. In the following list, we define syscalls
>>       # which we know they are 100% tested already.
>> -    white_list = [
>> -        'epoll_pwait2',
>> -        'fadvise64',
>> -        'fanotify_init',
>> -        'fanotify_mark',
>> -        'getdents64',
>> -        'getmsg',
>> -        'getpmsg',
> You removed getmsg, getpmsg, putmsg and seccomp.
>
> I originally put them in my patch to black_list (or I wanted)
> https://patchwork.ozlabs.org/project/ltp/patch/20241115033916.1707627-1-petr.vorel@gmail.com/
>
> You haven't noticed you removed them (ok, not everything must be documented),
> but still it would be nice to remove them from "Untested syscalls" table,
> therefore I sent v2.
> https://patchwork.ozlabs.org/project/ltp/patch/20241212133024.1480177-1-pvorel@suse.cz/
Sure, I will send your follow up patch, thanks.
>> -        'inotify_add_watch',
>> -        'inotify_rm_watch',
>> -        'io_uring_enter',
>> -        'io_uring_register',
>> -        'io_uring_setup',
>> -        'landlock_add_rule',
>> -        'landlock_create_ruleset',
>> -        'landlock_restrict_self',
>> -        'lsetxattr',
>> -        'newfstatat',
>> -        'putmsg',
>> -        'putpmsg',
>> -        'pkey_alloc',
>> -        'pkey_free',
>> -        'pkey_mprotect',
>> -        'prlimit64',
>> -        'pread64',
>> -        'pselect6',
>> -        'pwrite64',
>> -        'quotactl_fd',
>> -        'rt_sigpending',
>> -        'seccomp',
>> -        'semtimedop',
>> -        'sethostname',
>> -    ]
>> +    ltp_syscalls_path = "testcases/kernel/syscalls"
>> +    white_list = {
>> +        'bpf': f'{ltp_syscalls_path}/bpf',
>> +        'epoll_pwait2': f'{ltp_syscalls_path}/epoll_pwait',
>> +        'fadvise64': f'{ltp_syscalls_path}/fadvise',
>> +        'fanotify_init': f'{ltp_syscalls_path}/fanotify',
>> +        'fanotify_mark': f'{ltp_syscalls_path}/fanotify',
>> +        'futex': f'{ltp_syscalls_path}/futex',
>> +        'getdents64': f'{ltp_syscalls_path}/gettdents',
>> +        'inotify_add_watch': f'{ltp_syscalls_path}/inotify',
>> +        'inotify_init': f'{ltp_syscalls_path}/inotify',
>> +        'inotify_rm_watch': f'{ltp_syscalls_path}/inotify',
>> +        'io_uring_enter': f'{ltp_syscalls_path}/io_uring',
>> +        'io_uring_register': f'{ltp_syscalls_path}/io_uring',
>> +        'io_uring_setup': f'{ltp_syscalls_path}/io_uring',
>> +        'landlock_add_rule': f'{ltp_syscalls_path}/landlock',
>> +        'landlock_create_ruleset': f'{ltp_syscalls_path}/landlock',
>> +        'landlock_restrict_self': f'{ltp_syscalls_path}/landlock',
>> +        'lsetxattr': f'{ltp_syscalls_path}/lgetxattr',
>> +        'newfstatat': f'{ltp_syscalls_path}/fstatat',
>> +        'pkey_alloc': f'{ltp_syscalls_path}/pkeys',
>> +        'pkey_free': f'{ltp_syscalls_path}/pkeys',
>> +        'pkey_mprotect': f'{ltp_syscalls_path}/pkeys',
>> +        'prlimit64': f'{ltp_syscalls_path}/getrlimit',
>> +        'pread64': f'{ltp_syscalls_path}/pread',
>> +        'pselect6': f'{ltp_syscalls_path}/pselect',
>> +        'pwrite64': f'{ltp_syscalls_path}/pwrite',
>> +        'quotactl_fd': f'{ltp_syscalls_path}/quotactl',
>> +        'rt_sigpending': f'{ltp_syscalls_path}/sigpending',
>> +        'semtimedop': f'{ltp_syscalls_path}/ipc/semop',
>> +        'sethostname': f'{ltp_syscalls_path}/sethostname'
>> +    }
>>       # populate with not implemented, reserved, unmaintained syscalls defined
>>       # inside the syscalls file
>> @@ -134,6 +133,7 @@ def generate_syscalls_stats(_):
>>       if error:
>>           return
>> +    syscalls_base_dir = "https://github.com/linux-test-project/ltp/tree/master"
> nit: we already have some variables for various https://github.com/linux-test-project/ltp
> paths. I would personally define at the top variable holding
> "https://github.com/linux-test-project/ltp" and deriver others from it
> (as a separate commit or a part of previous commit).
Good catch, I will include it in the last patch since it's required by 
stats generator specifically.
>
>>       text = [
>>           'Syscalls\n',
>>           '--------\n\n',
>> @@ -145,15 +145,33 @@ def generate_syscalls_stats(_):
>>       with open("syscalls.tbl", 'r', encoding='utf-8') as data:
>>           for line in data:
>>               match = regexp.search(line)
>> -            if match:
>> -                ker_syscalls.append(match.group('syscall'))
>> +            if not match:
>> +                continue
>> +
>> +            ker_syscalls.append(match.group('syscall'))
>>       # collect all LTP tested syscalls
>> -    ltp_syscalls = []
>> -    for _, _, files in os.walk('../testcases/kernel/syscalls'):
>> +    name_patterns = [
>> +        re.compile(r'(?P<name>[a-zA-Z_]+[^_])\d{2}\.c'),
>> +        re.compile(r'(?P<name>[a-zA-Z_]+[1-9])_\d{2}\.c'),
> Using regexp is probably better than my way to set paths (fewer things to
> maintain).
>
> Thanks!
>
> Kind regards,
> Petr

I will push with the given suggestions and follow up patch, thanks.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
