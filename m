Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C6DC5B543
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 20:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749067579; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=5yY+cRnNGyhLfIYWksTQRAg/KhYzApUhadKOafVVIdA=;
 b=EnYfL1xtWZD0XjRbNGNwyi9gUDF0w1EkQchSQHE7I8LTiaAnFsAfb9d3DgaBZXyjb/aZm
 /IiXoGAPNR4LNR+U5DsTegR4Jtq8u7nrrLxfFyMqWWRriRsTzLMeyMzvqxUD3fi/iRdAmCk
 17kGJ4NsrVmdaBpPTq2IKR66lNg1iKo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06B2F3CA167
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 22:06:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8DE33C9DB9
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 22:05:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3279A1A0088F
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 22:05:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749067552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8XHV0cDOgBg5ogcUU9mk7828v98sokJupoWg1rauZhI=;
 b=DDbFW60MIncMqrFHlch0o92ZVZVYVZWIQ/mpA8FY+yvDGacQu1vE8V3WcbJxh1BFQnX+Sy
 WSEbgP2FBlwTyZwsKsBJaJHgQdR+eEb5DtwSjeoK5uF6bhrfzGXRjp3UxGWEpJX852X2iu
 BEtR2pLZRsDBeZ6sULGc2kJU8IRQfuY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-IGQiaJIJM_WR2UKzPsXiHg-1; Wed, 04 Jun 2025 16:05:49 -0400
X-MC-Unique: IGQiaJIJM_WR2UKzPsXiHg-1
X-Mimecast-MFC-AGG-ID: IGQiaJIJM_WR2UKzPsXiHg_1749067549
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c5f876bfe0so43320285a.3
 for <ltp@lists.linux.it>; Wed, 04 Jun 2025 13:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749067549; x=1749672349;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8XHV0cDOgBg5ogcUU9mk7828v98sokJupoWg1rauZhI=;
 b=LOYbo0biTjedmjHGjeSC+XshNlMRIUpyqdWPupVzUMrf2EMG7l8TGx2QSE9M28hLWo
 8hiDKORQOrAfXuUWe1y3tIDqR8fOfSUyWLOSm4jGR3mmS0y0UfU20T0yRm2hMZg7WI4q
 lfHvKwAxF7OVV0igHKIqpjQROD/qP6pXSVjmNzkSdLVQfcWgNfn/9jMlPNOjX17yEnrF
 Rv8zj4K5UpGB7W49odHsUJ01VckBEqFwiFAehf0vHak8zm2U/GeP+nmj4mG9z+7hU4UG
 IbwbzR3jBEFHODf0brC5osyv5AwjOYuZY/BAw1wbU8HONxahcSN+E3xqhYCjzzXalQHE
 IJKg==
X-Gm-Message-State: AOJu0Yxx6gvDAVgEPyFZKJdTjcSsjh+pFK59QXTdroaJfTdnljjmc1M9
 3yjNqc2caH6slhmEv2cH/2fIsZ7E834c3xFKyPc0n44s6j4YpO4YBc7hhqnGs0rnp6tigSKMwKr
 OFk8e0ge14XaH8oHOdHsY6N1U5k0Y7itihA8PG0GoyaBRoUoVadVV
X-Gm-Gg: ASbGncssrho7BJiTwBSbHab+j+kI1IaQoc5ROY7N23yDTKBuUahSjAgRcSIITHil2zm
 q9FaqsL6w6AaCbNLVxAeGObtC19TFnnjjC50Gpiof8WhhE6XuOlbLsDiED+EID9l4A6KoedRxys
 TSkqOoWFNMFD/A1iDCz524m92OWuTJXRNL32Z8/AaFxZOIiIjVbC8+5YmzV039MvPQi4KOMrM/K
 IUwjjvVMOTSMCL4j82XwZwrQTYKYg6UUZDkqnKoVPUGChUnbeR3F4x7YWd7PN7ThShhHmJtbL1v
 A6fw3GDIhYc=
X-Received: by 2002:a05:620a:8809:b0:7d0:a1db:9d7a with SMTP id
 af79cd13be357-7d2198cd0camr696996085a.40.1749067548713; 
 Wed, 04 Jun 2025 13:05:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKsEIPGpq1PbZE4O+fEKmN8unHmkeiLXm+Gb5zjfAEcyXQkzLvosyCAhjVj/P9G0pPvACzIA==
X-Received: by 2002:a05:620a:8809:b0:7d0:a1db:9d7a with SMTP id
 af79cd13be357-7d2198cd0camr696992385a.40.1749067548295; 
 Wed, 04 Jun 2025 13:05:48 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.242.209])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d09a1bb27fsm1088524885a.116.2025.06.04.13.05.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 13:05:47 -0700 (PDT)
Message-ID: <96107ae9-4b95-4ce3-b163-d91251ae9439@redhat.com>
Date: Wed, 4 Jun 2025 16:05:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20250602133741.GA324895@pevik>
 <bc6adca9-a7c0-4545-b32b-640994d135cb@redhat.com>
 <20250604194241.GA1159049@pevik>
In-Reply-To: <20250604194241.GA1159049@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TUVLCHDTBnexFXk9Ghiiz_CDfz8HnOwM-anSYVgX3BY_1749067549
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] rpcbind: detect support of remote calls
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
From: Steve Dickson via ltp <ltp@lists.linux.it>
Reply-To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, "Ricardo B. Marliere" <rbm@suse.com>,
 ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 6/4/25 3:42 PM, Petr Vorel wrote:
> Hi Steve,
> 
>> Hey!
> 
>> On 6/2/25 9:37 AM, Petr Vorel wrote:
>>> Hi Steve,
> 
>>> Ricardo found that TI-RPC rpc_pmap_rmtcall [1] tirpc_rpcb_rmtcall [2] tests are
>>> failing when they use rpcbind *without* --enable-rmtcalls (the default since
>>> 2018, see 2e9c289 ("rpcbind: Disable remote calls by default") [3]).
> 
>>> TL;DR: Is there a way to detect missing support from rpcbind? Because we cannot
>>> blindly expect that timeout means disabled remote calls (it could be also
>>> caused by regression). Other option is just to disable these tests by default
>>> (detection is preferred).
>> No there is not a way, that I know of, to see if remote calls
>> are or are not enabled since it is a compile time flag.
> 
> How about rpcbind to print version via new -v or -V command line option.
> Then compiled options could be printed as part of the output.
That is not a bad idea... It could be a bit messy since they're
close to 20 different ifdefs...

> 
> Nobody needed to know rpcbind version, therefore I'm not sure if testing justify
> it, but that would be an easy way to provide the info.
No testing would be needed... as long as rpcbind does not
drop core with the -v option :-) also there would be a
manpage up date... but it would not be very invasive.

> 
>> I really don't know what to say... In Fedora we disabled rmtcalls
>> which broke NIS and in RHEL we left it enable which drives
>> SELinux (and a few customers) nuts.
> 
> Thanks for info, I fully understand the chosen solution.
I wish other people would!!! 8-)

steved.

> 
> Kind regards,
> Petr
> 
>> There is no clear answer... IMHO.
> 
>> steved.
> 
> 
> 
>>> # export PATH="/opt/ltp/testcases/bin:$PATH"
>>> # rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
>>> ...
>>> tirpc_rpcb_rmtcall 10.0.0.2 536875000
>>> rpc_test 1 TFAIL: tirpc_rpcb_rmtcall 10.0.0.2 536875000 failed unexpectedly
> 
>>> As the name of the test suggests they are using pmap_rmtcall() and rpcb_rmtcall().
>>> A bit debug info.
> 
>>> Modified rpc_test.sh to use strace:
> 
>>> +++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
>>> @@ -87,6 +87,8 @@ do_test()
>>>    		done
>>>    	fi
>>> +	echo "$CLIENT $(tst_ipaddr) $PROGNUMNOSVC $CLIENT_EXTRA_OPTS" # FIXME: debug
>>> +	EXPECT_RHOST_PASS strace -o /tmp/a $CLIENT $(tst_ipaddr) $PROGNUMNOSVC $CLIENT_EXTRA_OPTS
>>>    	EXPECT_RHOST_PASS $CLIENT $(tst_ipaddr) $PROGNUMNOSVC $CLIENT_EXTRA_OPTS
>>>    }
> 
>>> I see the test timeouts (full strace output below):
> 
>>> # rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
>>> ...
>>> sendto(5, "h=\r}\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\4\0\0\0\5\0\0\0\0\0\0\0\0"..., 60, 0, {sa_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("10.0.0.2")}, 16) = 60
>>> poll([{fd=5, events=POLLIN}], 1, 1000)  = 0 (Timeout)
> 
>>> Using rpcbind 1.2.7-1.2 (from Tumbleweed), output when run with debug mode:
> 
>>> # /usr/sbin/rpcbind -w -f -d
>>> rpcbind: PMAPPROC_DUMP
> 
>>> rpcbind: RPCB_UNSET request for (536875000, 1, ) :
>>> rpcbind: RPCB_UNSET: succeeded
>>> rpcbind: RPCB_SET request for (536875000, 1, udp, 0.0.0.0.223.168) :
>>> rpcbind: RPCB_SET: succeeded
>>> rpcbind: RPCB_GETADDR req for (100000, 2, tcp) from 127.0.0.1.3.98:
>>> mergeaddr: contact uaddr = 127.0.0.1.0.111
>>> addrmerge(caller, 0.0.0.0.0.111, 127.0.0.1.0.111, tcp
>>> addrmerge: hint 127.0.0.1.0.111
>>> addrmerge: returning 127.0.0.1.0.111
>>> mergeaddr: uaddr = 0.0.0.0.0.111, merged uaddr = 127.0.0.1.0.111
>>> rpcbind: getaddr: 127.0.0.1.0.111
>>> rpcbind: PMAPPROC_DUMP
> 
>>> rpcbind: RPCB_GETADDR req for (536875000, 1, udp) from 10.0.0.1.3.105:
>>> mergeaddr: contact uaddr = 10.0.0.2.0.111
>>> addrmerge(caller, 0.0.0.0.223.168, 10.0.0.2.0.111, udp
>>> addrmerge: hint 10.0.0.2.0.111
>>> addrmerge: returning 10.0.0.2.223.168
>>> mergeaddr: uaddr = 0.0.0.0.223.168, merged uaddr = 10.0.0.2.223.168
>>> rpcbind: getaddr: 10.0.0.2.223.168
>>> rpcbind: RPCBPROC_BCAST
> 
>>> rpcbind: rpcb_indirect callit req for (536875000, 1, 1, udp) from 10.0.0.1.3.105 :
>>> rpcbind: found at uaddr 0.0.0.0.223.168
> 
>>> addrmerge(caller, 0.0.0.0.223.168, NULL, udp
>>> addrmerge: hint 127.0.0.1.0.111
>>> addrmerge: returning 127.0.0.1.223.168
>>> addrmerge(caller, 0.0.0.0.223.168, NULL, udp
>>> addrmerge: hint 10.0.0.1.3.105
>>> addrmerge: returning 192.168.122.43.223.168
>>> rpcbind: merged uaddr 192.168.122.43.223.168
> 
>>> rpcbind: RPCB_UNSET request for (536875000, 1, ) :
>>> rpcbind: Suppression RPC_UNSET(map_unset)
>>> rpcbind: rbl->rpcb_map.r_owner=superuser
>>> rpcbind: owner=superuser
>>> rpcbind: RPCB_UNSET: succeeded
> 
>>> Obviously, if I compile rpcbind with --enable-rmtcalls and run it, both tests work:
> 
>>> $ ./autogen.sh && ./configure --enable-debug --enable-warmstarts --enable-rmtcalls --with-rpcuser=rpc --with-nss-modules="files usrfiles"
>>> $ make -j`nproc`
>>> # ./rpcbind -w -d -f
> 
>>> # rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
>>> ...
>>> rpc_test 1 TINFO: using libtirpc: yes
>>> tirpc_rpcb_rmtcall 10.0.0.2 536875000
>>> rpc_test 1 TPASS: tirpc_rpcb_rmtcall 10.0.0.2 536875000 passed as expected
> 
>>> # rpc_test.sh -s rpc_svc_1 -c rpc_pmap_rmtcall
>>> ...
>>> rpc_pmap_rmtcall 10.0.0.2 536875000
>>> rpc_test 1 TPASS: rpc_pmap_rmtcall 10.0.0.2 536875000 passed as expected
> 
> 
>>> And the rpcbind outpt contains also:
> 
>>> rpcbind: rpcbproc_callit_com:  original XID 683f1705, new XID f68e200
>>> rpcbind: my_svc_run:  polled on forwarding fd 7, netid udp - calling handle_reply
> 
>>> Also, wouldn't it be worth mention --enable-rmtcalls in functions' man pages?
>>> (Or have I overlooked that in man?)
> 
>>> Thanks for any hint.
> 
>>> Kind regards,
>>> Petr
> 
>>> [1] https://github.com/linux-test-project/ltp/tree/master/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall.c
>>> [2] https://github.com/linux-test-project/ltp/tree/master/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c
>>> [3] https://git.linux-nfs.org/?p=steved/rpcbind.git;a=commitdiff;h=2e9c289246c647e25649914bdb0d9400c66f486e
> 
>>> Full strace on rpcbind compiled without --enable-rmtcalls (the default, thus
>>> how it's shipped to the new distros):
> 
>>> # rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
> 
>>> execve("/opt/ltp/testcases/bin/tirpc_rpcb_rmtcall", ["tirpc_rpcb_rmtcall", "10.0.0.2", "536875000"], 0x7ffee8701b10 /* 228 vars */) = 0
>>> ...
>>> openat(AT_FDCWD, "/etc/services", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
>>> openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 5
>>> ...
>>> openat(AT_FDCWD, "/usr/etc/services", O_RDONLY|O_CLOEXEC) = 5
>>> fstat(5, {st_mode=S_IFREG|0644, st_size=868338, ...}) = 0
>>> read(5, "#\n# Network services, Internet s"..., 4096) = 4096
>>> read(5, "[Jon_Postel]\ndaytime            "..., 4096) = 4096
>>> read(5, "gs          44/udp       # MPM F"..., 4096) = 4096
>>> read(5, "emote Job Service \nnetrjs-2     "..., 4096) = 4096
>>> read(5, "Jon_Postel]\nhostname           1"..., 4096) = 4096
>>> close(5)                                = 0
>>> socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP) = 5
>>> getsockname(5, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
>>> getsockopt(5, SOL_SOCKET, SO_TYPE, [2], [4]) = 0
>>> openat(AT_FDCWD, "/etc/bindresvport.blacklist", O_RDONLY) = 6
>>> fstat(6, {st_mode=S_IFREG|0644, st_size=415, ...}) = 0
>>> read(6, "#\n# This file contains a list of"..., 4096) = 415
>>> read(6, "", 4096)                       = 0
>>> close(6)                                = 0
>>> getsockname(5, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
>>> getpid()                                = 28530
>>> bind(5, {sa_family=AF_INET, sin_port=htons(722), sin_addr=inet_addr("0.0.0.0")}, 16) = 0
>>> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
>>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>>> getsockname(5, {sa_family=AF_INET, sin_port=htons(722), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
>>> getsockopt(5, SOL_SOCKET, SO_TYPE, [2], [4]) = 0
>>> gettimeofday({tv_sec=1748867467, tv_usec=890549}, NULL) = 0
>>> getpid()                                = 28530
>>> setsockopt(5, SOL_IP, IP_RECVERR, [1], 4) = 0
>>> ioctl(5, FIONBIO, [1])                  = 0
>>> ...
>>> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
>>> sendto(5, "h0`M\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\4\0\0\0\3\0\0\0\0\0\0\0\0"..., 88, 0, {sa_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("10.0.0.2")}, 16) = 88
>>> poll([{fd=5, events=POLLIN}], 1, 15000) = 1 ([{fd=5, revents=POLLIN}])
>>> recvfrom(5, "h0`M\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\02010.0"..., 8800, 0, NULL, NULL) = 44
>>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>>> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
>>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>>> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
>>> close(5)                                = 0
>>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>>> socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP) = 5
>>> getsockname(5, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
>>> getsockopt(5, SOL_SOCKET, SO_TYPE, [2], [4]) = 0
>>> getsockname(5, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
>>> getpid()                                = 28530
>>> bind(5, {sa_family=AF_INET, sin_port=htons(722), sin_addr=inet_addr("0.0.0.0")}, 16) = 0
>>> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
>>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>>> getsockname(5, {sa_family=AF_INET, sin_port=htons(722), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
>>> getsockopt(5, SOL_SOCKET, SO_TYPE, [2], [4]) = 0
>>> gettimeofday({tv_sec=1748867467, tv_usec=892984}, NULL) = 0
>>> getpid()                                = 28530
>>> setsockopt(5, SOL_IP, IP_RECVERR, [1], 4) = 0
>>> ioctl(5, FIONBIO, [1])                  = 0
>>> ...
>>> sendto(5, "h0V\302\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\4\0\0\0\5\0\0\0\0\0\0\0\0"..., 60, 0, {sa_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("10.0.0.2")}, 16) = 60
>>> poll([{fd=5, events=POLLIN}], 1, 1000)  = 0 (Timeout)
>>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>>> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
>>> close(5)                                = 0
>>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>>> fstat(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
>>> write(1, "1\n", 2)                      = 2
>>> exit_group(1)                           = ?
>>> +++ exited with 1 +++
> 
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
