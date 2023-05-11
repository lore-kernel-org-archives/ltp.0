Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313B4C7EE26
	for <ltp@archiver.kernel.org>; Thu, 11 May 2023 13:15:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1227D3CD5F6
	for <ltp@archiver.kernel.org>; Thu, 11 May 2023 15:15:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95A073CA0CC
 for <ltp@lists.linux.it>; Thu, 11 May 2023 15:15:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4AEEC1400339
 for <ltp@lists.linux.it>; Thu, 11 May 2023 15:15:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683810941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h7GdN215yNA43SzrNgI0qnS3dew63bkmnn0zBwKGt4M=;
 b=fUFyJIlY9GAVnYY6cuWM5XlBOnPtxpz8BcDrc7Aiw1w2vdMIHXkuIDWiRrDCe7wZ2EY27G
 wJfHS9D6aAfYKP2pXknmJM/FS23eJqwWfOttsXc/wsecOjtLohGR0ahn8uvebdPLeoGrWz
 D1TA4DyD8MnOMRoAFCkItgeXPcGZ6AE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-Wm-YeEYtMN6-l_LTWusAnw-1; Thu, 11 May 2023 09:15:38 -0400
X-MC-Unique: Wm-YeEYtMN6-l_LTWusAnw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-621189941cdso8487406d6.1
 for <ltp@lists.linux.it>; Thu, 11 May 2023 06:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683810937; x=1686402937;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h7GdN215yNA43SzrNgI0qnS3dew63bkmnn0zBwKGt4M=;
 b=lWtqn1QM6hl+d+w9qHl/SNjd80jpQcT55zKNtBZgXYTIKRm0b75WWaxtb/IcCNJai5
 42KdhR+2Du4A6XxtrdBhleuELyES5lKNNM/jzw46EZRxY8wtZ20IJgXCGF05fmJ6+Coo
 izDuz4l4ptLW4ixF2WkOZrNaTkDenuctHWFtZXH6K6muA3r9H1dR6kYT1LzKw+ZiRTrj
 dm4ymcLli58qyA8bx127u4KKsv+Gwmh7VxXm+YfTWnGiGwTKMN7RFlvLhD/K2otlVYT+
 jzfMnSlvC34PSKVdKsmSCEWtLQJ78+h/6C/UDKetc+1dqMKKaUpjwSheCrMT/1CUzLbD
 eSDg==
X-Gm-Message-State: AC+VfDzWpciFAOu0p81vD32C4lZx8msWCf2AgeHL4PbX/x7FhSpbi+9X
 58BuojuRWVOXc7Dioc6kEfeZZ2AOWVQUJgLVTlwupbxFMQCj7d8xfUJsY4Thba4Fu0v3vXKQ0ER
 zEklIuhF5758=
X-Received: by 2002:a05:6214:4017:b0:61b:6b8e:16e0 with SMTP id
 kd23-20020a056214401700b0061b6b8e16e0mr27925084qvb.1.1683810937688; 
 Thu, 11 May 2023 06:15:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7QrDuh1/3VnUeK77k+XBHREIqjDJBgvF7m/Cgt+2BZot4AWIC4wi4ZCroOdjQoYSYMlcYXjA==
X-Received: by 2002:a05:6214:4017:b0:61b:6b8e:16e0 with SMTP id
 kd23-20020a056214401700b0061b6b8e16e0mr27925049qvb.1.1683810937318; 
 Thu, 11 May 2023 06:15:37 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.154.41])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a05620a13a700b00758c1bd6d9esm969296qki.133.2023.05.11.06.15.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 May 2023 06:15:36 -0700 (PDT)
Message-ID: <76403fb4-87f2-88cb-ab0c-ba63feacbeee@redhat.com>
Date: Thu, 11 May 2023 09:15:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Petr Vorel <pvorel@suse.cz>
References: <20230504101619.GA3801922@pevik>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20230504101619.GA3801922@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP: tirpc_rpcb_rmtcall is failing
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
Cc: linux-nfs@vger.kernel.org, ltp@lists.linux.it,
 libtirpc-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Petr,

On 5/4/23 6:16 AM, Petr Vorel wrote:
> Hi Steve,
> 
> tirpc_rpcb_rmtcall is failing. I was able to reproduce it on
> * openSUSE Tumbleweed with libtirpc 1.3.3
> * Debian stable  11 (bullseye) with libtirpc 1.3.1-1
> 
> OTOH SLE 15-SP4 with libtirpc 1.2.6 is working.
> 
> PATH="/opt/ltp/testcases/bin:$PATH" rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
> rpc_test 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
> rpc_test 1 TINFO: add local addr 10.0.0.2/24
> rpc_test 1 TINFO: add local addr fd00:1:1:1::2/64
> rpc_test 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
> rpc_test 1 TINFO: add remote addr 10.0.0.1/24
> rpc_test 1 TINFO: add remote addr fd00:1:1:1::1/64
> rpc_test 1 TINFO: Network config (local -- remote):
> rpc_test 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
> rpc_test 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
> rpc_test 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
> rpc_test 1 TINFO: timeout per run is 0h 5m 0s
> rpc_test 1 TINFO: check registered RPC with rpcinfo
> rpc_test 1 TINFO: registered RPC:
>     program vers proto   port  service
>      100000    4   tcp    111  portmapper
>      100000    3   tcp    111  portmapper
>      100000    2   tcp    111  portmapper
>      100000    4   udp    111  portmapper
>      100000    3   udp    111  portmapper
>      100000    2   udp    111  portmapper
>      100005    1   udp  20048  mountd
>      100005    1   tcp  20048  mountd
>      100005    2   udp  20048  mountd
>      100005    2   tcp  20048  mountd
>      100005    3   udp  20048  mountd
>      100005    3   tcp  20048  mountd
>      100024    1   udp  37966  status
>      100024    1   tcp  43643  status
>      100003    3   tcp   2049  nfs
>      100003    4   tcp   2049  nfs
>      100227    3   tcp   2049  nfs_acl
>      100021    1   udp  59603  nlockmgr
>      100021    3   udp  59603  nlockmgr
>      100021    4   udp  59603  nlockmgr
>      100021    1   tcp  39145  nlockmgr
>      100021    3   tcp  39145  nlockmgr
>      100021    4   tcp  39145  nlockmgr
> rpc_test 1 TINFO: using libtirpc: yes
> rpc_test 1 TFAIL: tirpc_rpcb_rmtcall 10.0.0.2 536875000 failed unexpectedly
> 1
> 
> The problem is in tirpc_rpcb_rmtcall.c [1], which calls rpcb_rmtcall(), which
> returns 1 (I suppose RPC_CANTENCODEARGS - can't encode arguments - enum
> clnt_stat from tirpc/rpc/clnt_stat.h):
> 
> 	cs = rpcb_rmtcall(nconf, argc[1], progNum, VERSNUM, PROCNUM,
> 			  (xdrproc_t) xdr_int, (char *)&var_snd,
> 			  (xdrproc_t) xdr_int, (char *)&var_rec, tv, &svcaddr);
> 
> 	test_status = (cs == RPC_SUCCESS) ? 0 : 1;
> 
> 	//This last printf gives the result status to the tests suite
> 	//normally should be 0: test has passed or 1: test has failed
> 	printf("%d\n", test_status);
> 
> 	return test_status;
> 
> Any idea what could be wrong with these very old tests?
No... No idea... but I'm unable to reproduce it. It appears
you are using different repo that the one I found on
github [1]. But...

Looking code, RPC_CANTENCODEARGS is returned when
there is an xdr problem which might means a
memory problem??

With that said... commits 21718bbb^..fa153d63 did
make a lot of changes in the locking and cache
management.

steved.

[1] https://github.com/linux-test-project/ltp
> 
> Kind regards,
> Petr
> 
> [1] https://github.com/linux-test-project/ltp/blob/12765c115f11026c090ab0ee5dd79b38d95ef31f/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c#L91-L93
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
