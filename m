Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82649C5B549
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 18:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749063052; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=7OlIk1k/Fdj6QGljxD2vs+hM4NbsmgXFNTfkd4s1d10=;
 b=n7Y97SN9gixfNtkLi7lJNfH5NAy5xpVeirPxF/3dtvZ/fcXeJLZMR6+cpgd65eroyuYnb
 /IZP1WHMMjU53Qu0DfFBwE9USiMTL8gUKZD8o4nmJekW0F27mVoRW2UCtO9AN0OBivnSreO
 5MQDvyE7mZruoymuPzbHzVKIbWHTJzA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E96D13CA1CC
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 20:50:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B20DA3CA17E
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 20:50:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8CB5D1000B66
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 20:50:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749063025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OnG065Mod7tSUZA5kQthnYI4AucjEn1rDu4cap+gNHk=;
 b=gQ/TpVurD4zd4evynhlcFcPFaP37ERXBaRJ1jtdvfv27+RWlVKbz/65OQuknZjec0BsxBm
 XoiUEFn+nRRYbwng3HFZRiskvgweaw5ncmagczt6LWTz/a3OADhWdrr15O2hwv6S8Irlkw
 IDGVzv6TQtGW2u+Xqp0sCowK+sclGIU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-QjYoCZvJNZ63hpFqSGioZg-1; Wed, 04 Jun 2025 14:50:24 -0400
X-MC-Unique: QjYoCZvJNZ63hpFqSGioZg-1
X-Mimecast-MFC-AGG-ID: QjYoCZvJNZ63hpFqSGioZg_1749063023
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6faca0f2677so5180726d6.1
 for <ltp@lists.linux.it>; Wed, 04 Jun 2025 11:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749063023; x=1749667823;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OnG065Mod7tSUZA5kQthnYI4AucjEn1rDu4cap+gNHk=;
 b=g5Y7fDS32SU4g2jIQVNItMGTUzsJ0tnWq3DOONpqgqEyCyxYmKxIJd9gt+4XWhNrL3
 MyPZLM1LZFC9wDZiFGuLIqshJNY7sRiUKRp2nadrxnlE+mx/1p/aG0ZPP3K7uQA1+rbc
 O8VSlOY0iZUpmIgdQCGUXTuHS4F0sUycexFlG1RgUV2yY0dTGEUgahXKGx6qBl2mq2Rw
 cW13LeJWVijxUvY3hzYoskydRTiSw4GMNRjwxUTaEtfSgwOCCj26mWLLIGTMXYGlXC8P
 7vqtV+5++up5OKywOEsSF7nT6mM9ODyYhXx/9zskLwLwhcx9hzoHazkwgyrJ5lEdkWkA
 19Gw==
X-Gm-Message-State: AOJu0Yx/HpIN1w9BGz/s1Sk9zjGjjVO026C8n00GmmsmetNYF7iVic4M
 gv+9vSZmZTg60QvIV/N6BMyjJ+R1iF4fl0suRW9T3Oom6Iom4nYaAoT0AX22btpCRhlNkOO3HzE
 COAaFk98eI+hjXM8tT5uyy0OLYJWloeqPzeDRWFqpWmWgZkaVRjuJ
X-Gm-Gg: ASbGncs/FhBeM+M7LHzrpvGsv9R1XR9WMCoS3Ag4f2IBcPC11yPx6MLFiVgTSxomIWV
 Wysdv/0oyYuGV9nz+y2qK4T6PEVcTJ+O5vfOfoTgeZIlkTbgWvng3CoZmQluLlxd7vd6iBp7uw4
 UxkuLw1zMxekyAPbfB+N50GlC8DN8fIQL94+jXR+GVpath/dcatALlzywjbMJmA+ARC8NfCzI9k
 xmQ0k0Nb/HxCNU41IHi5iOgWk09mjgpMlQ6N15aqCQUEet4c4sM4A7BDTkchSEhV7kH9XcoYFx6
 1HIk/T4852o=
X-Received: by 2002:a05:6214:1c8b:b0:6e8:fa72:be4c with SMTP id
 6a1803df08f44-6faf6fd5a15mr53271176d6.1.1749063023561; 
 Wed, 04 Jun 2025 11:50:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfrIozx3xU88ElE66wQ8jVTPV42kNsXwTQBLxVRo0ESBezfP6ZQYNG0h5WdUEOkkg1P4rR1Q==
X-Received: by 2002:a05:6214:1c8b:b0:6e8:fa72:be4c with SMTP id
 6a1803df08f44-6faf6fd5a15mr53270736d6.1.1749063023136; 
 Wed, 04 Jun 2025 11:50:23 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.242.209])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d09a195c73sm1078385385a.69.2025.06.04.11.50.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 11:50:22 -0700 (PDT)
Message-ID: <bc6adca9-a7c0-4545-b32b-640994d135cb@redhat.com>
Date: Wed, 4 Jun 2025 14:50:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20250602133741.GA324895@pevik>
In-Reply-To: <20250602133741.GA324895@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AZOT--HgLb3WEcnxo7ICdc9ZzEFTh9BBAVhhrnjbrHg_1749063023
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
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

Hey!

On 6/2/25 9:37 AM, Petr Vorel wrote:
> Hi Steve,
> 
> Ricardo found that TI-RPC rpc_pmap_rmtcall [1] tirpc_rpcb_rmtcall [2] tests are
> failing when they use rpcbind *without* --enable-rmtcalls (the default since
> 2018, see 2e9c289 ("rpcbind: Disable remote calls by default") [3]).
> 
> TL;DR: Is there a way to detect missing support from rpcbind? Because we cannot
> blindly expect that timeout means disabled remote calls (it could be also
> caused by regression). Other option is just to disable these tests by default
> (detection is preferred).
No there is not a way, that I know of, to see if remote calls
are or are not enabled since it is a compile time flag.

I really don't know what to say... In Fedora we disabled rmtcalls
which broke NIS and in RHEL we left it enable which drives
SELinux (and a few customers) nuts.

There is no clear answer... IMHO.

steved.


> 
> # export PATH="/opt/ltp/testcases/bin:$PATH"
> # rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
> ...
> tirpc_rpcb_rmtcall 10.0.0.2 536875000
> rpc_test 1 TFAIL: tirpc_rpcb_rmtcall 10.0.0.2 536875000 failed unexpectedly
> 
> As the name of the test suggests they are using pmap_rmtcall() and rpcb_rmtcall().
> A bit debug info.
> 
> Modified rpc_test.sh to use strace:
> 
> +++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
> @@ -87,6 +87,8 @@ do_test()
>   		done
>   	fi
>   
> +	echo "$CLIENT $(tst_ipaddr) $PROGNUMNOSVC $CLIENT_EXTRA_OPTS" # FIXME: debug
> +	EXPECT_RHOST_PASS strace -o /tmp/a $CLIENT $(tst_ipaddr) $PROGNUMNOSVC $CLIENT_EXTRA_OPTS
>   	EXPECT_RHOST_PASS $CLIENT $(tst_ipaddr) $PROGNUMNOSVC $CLIENT_EXTRA_OPTS
>   }
>   
> 
> I see the test timeouts (full strace output below):
> 
> # rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
> ...
> sendto(5, "h=\r}\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\4\0\0\0\5\0\0\0\0\0\0\0\0"..., 60, 0, {sa_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("10.0.0.2")}, 16) = 60
> poll([{fd=5, events=POLLIN}], 1, 1000)  = 0 (Timeout)
> 
> Using rpcbind 1.2.7-1.2 (from Tumbleweed), output when run with debug mode:
> 
> # /usr/sbin/rpcbind -w -f -d
> rpcbind: PMAPPROC_DUMP
> 
> rpcbind: RPCB_UNSET request for (536875000, 1, ) :
> rpcbind: RPCB_UNSET: succeeded
> rpcbind: RPCB_SET request for (536875000, 1, udp, 0.0.0.0.223.168) :
> rpcbind: RPCB_SET: succeeded
> rpcbind: RPCB_GETADDR req for (100000, 2, tcp) from 127.0.0.1.3.98:
> mergeaddr: contact uaddr = 127.0.0.1.0.111
> addrmerge(caller, 0.0.0.0.0.111, 127.0.0.1.0.111, tcp
> addrmerge: hint 127.0.0.1.0.111
> addrmerge: returning 127.0.0.1.0.111
> mergeaddr: uaddr = 0.0.0.0.0.111, merged uaddr = 127.0.0.1.0.111
> rpcbind: getaddr: 127.0.0.1.0.111
> rpcbind: PMAPPROC_DUMP
> 
> rpcbind: RPCB_GETADDR req for (536875000, 1, udp) from 10.0.0.1.3.105:
> mergeaddr: contact uaddr = 10.0.0.2.0.111
> addrmerge(caller, 0.0.0.0.223.168, 10.0.0.2.0.111, udp
> addrmerge: hint 10.0.0.2.0.111
> addrmerge: returning 10.0.0.2.223.168
> mergeaddr: uaddr = 0.0.0.0.223.168, merged uaddr = 10.0.0.2.223.168
> rpcbind: getaddr: 10.0.0.2.223.168
> rpcbind: RPCBPROC_BCAST
> 
> rpcbind: rpcb_indirect callit req for (536875000, 1, 1, udp) from 10.0.0.1.3.105 :
> rpcbind: found at uaddr 0.0.0.0.223.168
> 
> addrmerge(caller, 0.0.0.0.223.168, NULL, udp
> addrmerge: hint 127.0.0.1.0.111
> addrmerge: returning 127.0.0.1.223.168
> addrmerge(caller, 0.0.0.0.223.168, NULL, udp
> addrmerge: hint 10.0.0.1.3.105
> addrmerge: returning 192.168.122.43.223.168
> rpcbind: merged uaddr 192.168.122.43.223.168
> 
> rpcbind: RPCB_UNSET request for (536875000, 1, ) :
> rpcbind: Suppression RPC_UNSET(map_unset)
> rpcbind: rbl->rpcb_map.r_owner=superuser
> rpcbind: owner=superuser
> rpcbind: RPCB_UNSET: succeeded
> 
> Obviously, if I compile rpcbind with --enable-rmtcalls and run it, both tests work:
> 
> $ ./autogen.sh && ./configure --enable-debug --enable-warmstarts --enable-rmtcalls --with-rpcuser=rpc --with-nss-modules="files usrfiles"
> $ make -j`nproc`
> # ./rpcbind -w -d -f
> 
> # rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
> ...
> rpc_test 1 TINFO: using libtirpc: yes
> tirpc_rpcb_rmtcall 10.0.0.2 536875000
> rpc_test 1 TPASS: tirpc_rpcb_rmtcall 10.0.0.2 536875000 passed as expected
> 
> # rpc_test.sh -s rpc_svc_1 -c rpc_pmap_rmtcall
> ...
> rpc_pmap_rmtcall 10.0.0.2 536875000
> rpc_test 1 TPASS: rpc_pmap_rmtcall 10.0.0.2 536875000 passed as expected
> 
> 
> And the rpcbind outpt contains also:
> 
> rpcbind: rpcbproc_callit_com:  original XID 683f1705, new XID f68e200
> rpcbind: my_svc_run:  polled on forwarding fd 7, netid udp - calling handle_reply
> 
> Also, wouldn't it be worth mention --enable-rmtcalls in functions' man pages?
> (Or have I overlooked that in man?)
> 
> Thanks for any hint.
> 
> Kind regards,
> Petr
> 
> [1] https://github.com/linux-test-project/ltp/tree/master/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall.c
> [2] https://github.com/linux-test-project/ltp/tree/master/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c
> [3] https://git.linux-nfs.org/?p=steved/rpcbind.git;a=commitdiff;h=2e9c289246c647e25649914bdb0d9400c66f486e
> 
> Full strace on rpcbind compiled without --enable-rmtcalls (the default, thus
> how it's shipped to the new distros):
> 
> # rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
> 
> execve("/opt/ltp/testcases/bin/tirpc_rpcb_rmtcall", ["tirpc_rpcb_rmtcall", "10.0.0.2", "536875000"], 0x7ffee8701b10 /* 228 vars */) = 0
> ...
> openat(AT_FDCWD, "/etc/services", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 5
> ...
> openat(AT_FDCWD, "/usr/etc/services", O_RDONLY|O_CLOEXEC) = 5
> fstat(5, {st_mode=S_IFREG|0644, st_size=868338, ...}) = 0
> read(5, "#\n# Network services, Internet s"..., 4096) = 4096
> read(5, "[Jon_Postel]\ndaytime            "..., 4096) = 4096
> read(5, "gs          44/udp       # MPM F"..., 4096) = 4096
> read(5, "emote Job Service \nnetrjs-2     "..., 4096) = 4096
> read(5, "Jon_Postel]\nhostname           1"..., 4096) = 4096
> close(5)                                = 0
> socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP) = 5
> getsockname(5, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
> getsockopt(5, SOL_SOCKET, SO_TYPE, [2], [4]) = 0
> openat(AT_FDCWD, "/etc/bindresvport.blacklist", O_RDONLY) = 6
> fstat(6, {st_mode=S_IFREG|0644, st_size=415, ...}) = 0
> read(6, "#\n# This file contains a list of"..., 4096) = 415
> read(6, "", 4096)                       = 0
> close(6)                                = 0
> getsockname(5, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
> getpid()                                = 28530
> bind(5, {sa_family=AF_INET, sin_port=htons(722), sin_addr=inet_addr("0.0.0.0")}, 16) = 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> getsockname(5, {sa_family=AF_INET, sin_port=htons(722), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
> getsockopt(5, SOL_SOCKET, SO_TYPE, [2], [4]) = 0
> gettimeofday({tv_sec=1748867467, tv_usec=890549}, NULL) = 0
> getpid()                                = 28530
> setsockopt(5, SOL_IP, IP_RECVERR, [1], 4) = 0
> ioctl(5, FIONBIO, [1])                  = 0
> ...
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
> sendto(5, "h0`M\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\4\0\0\0\3\0\0\0\0\0\0\0\0"..., 88, 0, {sa_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("10.0.0.2")}, 16) = 88
> poll([{fd=5, events=POLLIN}], 1, 15000) = 1 ([{fd=5, revents=POLLIN}])
> recvfrom(5, "h0`M\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\02010.0"..., 8800, 0, NULL, NULL) = 44
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
> close(5)                                = 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP) = 5
> getsockname(5, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
> getsockopt(5, SOL_SOCKET, SO_TYPE, [2], [4]) = 0
> getsockname(5, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
> getpid()                                = 28530
> bind(5, {sa_family=AF_INET, sin_port=htons(722), sin_addr=inet_addr("0.0.0.0")}, 16) = 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> getsockname(5, {sa_family=AF_INET, sin_port=htons(722), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
> getsockopt(5, SOL_SOCKET, SO_TYPE, [2], [4]) = 0
> gettimeofday({tv_sec=1748867467, tv_usec=892984}, NULL) = 0
> getpid()                                = 28530
> setsockopt(5, SOL_IP, IP_RECVERR, [1], 4) = 0
> ioctl(5, FIONBIO, [1])                  = 0
> ...
> sendto(5, "h0V\302\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\4\0\0\0\5\0\0\0\0\0\0\0\0"..., 60, 0, {sa_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("10.0.0.2")}, 16) = 60
> poll([{fd=5, events=POLLIN}], 1, 1000)  = 0 (Timeout)
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
> close(5)                                = 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> fstat(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
> write(1, "1\n", 2)                      = 2
> exit_group(1)                           = ?
> +++ exited with 1 +++
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
