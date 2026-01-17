Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4F3C98312
	for <ltp@archiver.kernel.org>; Sat, 17 Jan 2026 08:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768637793; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=6rNy/2KKSEsu6EprSG9YAzL1hQs9v+2m8OxQIZb8NPg=;
 b=SBxdQKLH+p72kStX4NSGlhF8iLt0eUXPla9IrL4Qk2R4pQUPK/6qMGs6YrfQ//qlaqbBC
 r9CGCRuSawqsQ9tC15jn2AKIljpRbJp7Aozp9ZPKL4Pp+lTABLR7anH+BpH2ORQvIElBLG0
 ejm21IIRlId9DakR080lZJriyI1RnZ4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A13D33CACA1
	for <ltp@archiver.kernel.org>; Sat, 17 Jan 2026 09:16:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FA1A3C2C22
 for <ltp@lists.linux.it>; Sat, 17 Jan 2026 09:16:08 +0100 (CET)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CAA8060081D
 for <ltp@lists.linux.it>; Sat, 17 Jan 2026 09:16:07 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=+DyAm22NE/Ps6x896+tEuEEfZt9kA7J78beks28/xlc=;
 b=B1hqUdpVSGxx/sTpjR/HFV3Vwlv4VIov1oK0nFK10aZM4OqC8Z/oTOVED/F5iUjsjJyS6ZwGc
 6JqOVLfAV3Y3bpw11SkSwFGPn4d2MVUuCkw659YsKDdsZr35p+UT985GOguuCLgvPPpAZTMjQAw
 uxqkeVnt+8c9kfxKmDiQl1A=
Received: from mail.maildlp.com (unknown [172.19.163.163])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dtTwm6zv3zKm57;
 Sat, 17 Jan 2026 16:12:40 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
 by mail.maildlp.com (Postfix) with ESMTPS id 094DC40565;
 Sat, 17 Jan 2026 16:16:03 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (7.185.36.143) by
 dggpemf500015.china.huawei.com (7.185.36.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 17 Jan 2026 16:16:02 +0800
Received: from dggpemf500015.china.huawei.com ([7.185.36.143]) by
 dggpemf500015.china.huawei.com ([7.185.36.143]) with mapi id 15.02.1544.011;
 Sat, 17 Jan 2026 16:16:02 +0800
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v2] rpc: create valid fd to pass libtirpc validation
Thread-Index: AQHcg2KKsp0GmVN7WEy47qDqaoDbWrVPgqiAgAFhd5A=
Date: Sat, 17 Jan 2026 08:16:02 +0000
Message-ID: <549901d2f1344eb6b4500a6559febc78@huawei.com>
References: <20260112015047.2184003-1-liujian56@huawei.com>
 <20260113122557.GA318506@pevik>
In-Reply-To: <20260113122557.GA318506@pevik>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.179.244]
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] rpc: create valid fd to pass libtirpc
 validation
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
From: "liujian \(CE\) via ltp" <ltp@lists.linux.it>
Reply-To: "liujian \(CE\)" <liujian56@huawei.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 Steve Dickson <SteveD@redhat.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



> -----Original Message-----
> From: Petr Vorel [mailto:pvorel@suse.cz]
> Sent: Tuesday, January 13, 2026 8:26 PM
> To: liujian (CE) <liujian56@huawei.com>
> Cc: ltp@lists.linux.it; andrea.cervesato@suse.com; linux-nfs@vger.kernel.org;
> Steve Dickson <SteveD@redhat.com>
> Subject: Re: [LTP] [PATCH v2] rpc: create valid fd to pass libtirpc validation
> 
> Hi all,
> 
> [ Cc Steve and linux-nfs ]
> 
> > The testcase(rpc_svc_destroy, rpc_svcfd_create, rpc_xprt_register,
> > rpc_xprt_unregister) was failing due to an invalid fd, which caused
> > libtirpc's internal validation to reject the operation.
> > This change ensures a valid socket fd is created and can pass the
> > validation checks in libtirpc.
> 
> + I would also like to know more details about the failure (libtirpc
> + version, or
> do you still use Sun RPC from old glibc, distro, arch, ...).
> 
tested this on Debian 12 and Debian 10.
I observed that the latest libtirpc (1.3.7) code has the same logic.

svcfd_create
----svc_fd_create(fd, sendsize, recvsize);
--------...
--------getsockname(fd, (struct sockaddr *)(void *)&ss, &slen) < 0)
--------...
--------getpeername(fd, (struct sockaddr *)(void *)&ss, &slen)
--------...

The above is some code flow of `svcfd_create()` in libtirpc, where both 
`getsockname()` and `getpeername()` require the file descriptor (fd) to be 
a valid and connected socket.
Additionally, in glibc, there are no similar operations in `svcfd_create()`, 
so there is no issue for this test case.

> Because while we have some problems with some of these tests, I'm not
> sure if connecting to 127.0.0.1 is a valid approach. And if it is, should it be
> used in more tests? Also rpc_svc_destroy_stress.c and
> rpc_svcfd_create_limits.c use svcfd_create().
> 
For a UDP socket, connect() does not trigger any message transmission and
should have no other side effects. What do you all think?
However, there are no `rpc_svcfd_create_limits` or `rpc_svc_destroy_stress` 
tests in `runtest/net.rpc_tests`?

> Below are few minor implementation details. First, maybe add a common
> header, with code in the function which would be used? But it can be done
> later (RPC test code is really awful, more duplicity will not make it worse).
> 
> > Signed-off-by: Liu Jian <liujian56@huawei.com>
> > ---
> > v2: Fix a compilation error on Alpine.
> >  .../rpc_svc_destroy.c                         | 27 +++++++++++++++++++
> >  .../rpc_svcfd_create.c                        | 26 ++++++++++++++++++
> >  .../rpc_xprt_register.c                       | 25 +++++++++++++++++
> >  .../rpc_xprt_unregister.c                     | 25 +++++++++++++++++
> >  4 files changed, 103 insertions(+)
> 
> > diff --git
> > a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_created
> > estroy_svc_destroy/rpc_svc_destroy.c
> > b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_created
> > estroy_svc_destroy/rpc_svc_destroy.c
> > index 22e560843..b9240ccba 100644
> > ---
> > a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_created
> > estroy_svc_destroy/rpc_svc_destroy.c
> > +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_cre
> > +++ atedestroy_svc_destroy/rpc_svc_destroy.c
> > @@ -30,6 +30,12 @@
> >  #include <time.h>
> >  #include <rpc/rpc.h>
> 
> > +#include <unistd.h>
> > +#include <sys/socket.h>
> > +#include <netinet/in.h>
> > +#include <arpa/inet.h>
> > +#include <string.h>
> > +
> >  //Standard define
> >  #define PROCNUM 1
> >  #define VERSNUM 1
> > @@ -43,6 +49,27 @@ int main(void)
> >  	int test_status = 1;	//Default test result set to FAILED
> >  	int fd = 0;
> >  	SVCXPRT *svcr = NULL;
> > +	struct sockaddr_in server_addr;
> > +
> > +	fd = socket(AF_INET, SOCK_DGRAM, 0);
> > +	if (fd < 0) {
> > +		printf("socket creation failed");
> Maybe fprintf(stderr, ...) or perror()?
> 
> > +		return test_status;
> > +	}
> > +
> > +	memset(&server_addr, 0, sizeof(server_addr));
> 
> Maybe just:
> struct sockaddr_in server_addr = {0};
> instead of memset() ?
> 
> > +	server_addr.sin_family = AF_INET;
> > +	server_addr.sin_port = htons(9001);
> > +	if (inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr) <= 0) {
> > +		printf("inet_pton failed");
> > +		close(fd);
> > +		return test_status;
> > +	}
> > +	if (connect(fd, (struct sockaddr *)&server_addr, sizeof(server_addr))
> < 0) {
> > +		printf("connect failed");
> > +		close(fd);
> Funny that all testsuites don't close fd, but not closing single fd is not that
> problematic.
> 
> Kind regards,
> Petr
> 
> > +		return test_status;
> > +	}
> 
> >  	//First of all, create a server
> >  	svcr = svcfd_create(fd, 0, 0);
> > diff --git
> > a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_created
> > estroy_svcfd_create/rpc_svcfd_create.c
> > b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_created
> > estroy_svcfd_create/rpc_svcfd_create.c
> > index f0d89ba48..ea4418961 100644
> > ---
> > a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_created
> > estroy_svcfd_create/rpc_svcfd_create.c
> > +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_cre
> > +++ atedestroy_svcfd_create/rpc_svcfd_create.c
> > @@ -29,6 +29,11 @@
> >  #include <stdlib.h>
> >  #include <time.h>
> >  #include <rpc/rpc.h>
> > +#include <unistd.h>
> > +#include <sys/socket.h>
> > +#include <netinet/in.h>
> > +#include <arpa/inet.h>
> > +#include <string.h>
> 
> >  //Standard define
> >  #define PROCNUM 1
> > @@ -43,6 +48,27 @@ int main(void)
> >  	int test_status = 1;	//Default test result set to FAILED
> >  	int fd = 0;
> >  	SVCXPRT *svcr = NULL;
> > +	struct sockaddr_in server_addr;
> > +
> > +	fd = socket(AF_INET, SOCK_DGRAM, 0);
> > +	if (fd < 0) {
> > +		printf("socket creation failed");
> > +		return test_status;
> > +	}
> > +
> > +	memset(&server_addr, 0, sizeof(server_addr));
> > +	server_addr.sin_family = AF_INET;
> > +	server_addr.sin_port = htons(9001);
> > +	if (inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr) <= 0) {
> > +		printf("inet_pton failed");
> > +		close(fd);
> > +		return test_status;
> > +	}
> > +	if (connect(fd, (struct sockaddr *)&server_addr, sizeof(server_addr))
> < 0) {
> > +		printf("connect failed");
> > +		close(fd);
> > +		return test_status;
> > +	}
> 
> >  	//create a server
> >  	svcr = svcfd_create(fd, 0, 0);
> > diff --git
> > a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunre
> > g_xprt_register/rpc_xprt_register.c
> > b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunre
> > g_xprt_register/rpc_xprt_register.c
> > index b10a1ce5e..a40dad7fe 100644
> > ---
> > a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunre
> > g_xprt_register/rpc_xprt_register.c
> > +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_reg
> > +++ unreg_xprt_register/rpc_xprt_register.c
> > @@ -31,6 +31,10 @@
> >  #include <rpc/rpc.h>
> >  #include <sys/types.h>
> >  #include <sys/socket.h>
> > +#include <unistd.h>
> > +#include <netinet/in.h>
> > +#include <arpa/inet.h>
> > +#include <string.h>
> 
> >  //Standard define
> >  #define PROCNUM 1
> > @@ -45,6 +49,27 @@ int main(void)
> >  	int test_status = 1;	//Default test result set to FAILED
> >  	SVCXPRT *svcr = NULL;
> >  	int fd = 0;
> > +	struct sockaddr_in server_addr;
> > +
> > +	fd = socket(AF_INET, SOCK_DGRAM, 0);
> > +	if (fd < 0) {
> > +		printf("socket creation failed");
> > +		return test_status;
> > +	}
> > +
> > +	memset(&server_addr, 0, sizeof(server_addr));
> > +	server_addr.sin_family = AF_INET;
> > +	server_addr.sin_port = htons(9001);
> > +	if (inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr) <= 0) {
> > +		printf("inet_pton failed");
> > +		close(fd);
> > +		return test_status;
> > +	}
> > +	if (connect(fd, (struct sockaddr *)&server_addr, sizeof(server_addr))
> < 0) {
> > +		printf("connect failed");
> > +		close(fd);
> > +		return test_status;
> > +	}
> 
> >  	//create a server
> >  	svcr = svcfd_create(fd, 1024, 1024); diff --git
> > a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunre
> > g_xprt_unregister/rpc_xprt_unregister.c
> > b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunre
> > g_xprt_unregister/rpc_xprt_unregister.c
> > index 3b6130eaa..5ac51de41 100644
> > ---
> > a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunre
> > g_xprt_unregister/rpc_xprt_unregister.c
> > +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_reg
> > +++ unreg_xprt_unregister/rpc_xprt_unregister.c
> > @@ -31,6 +31,10 @@
> >  #include <rpc/rpc.h>
> >  #include <sys/types.h>
> >  #include <sys/socket.h>
> > +#include <unistd.h>
> > +#include <netinet/in.h>
> > +#include <arpa/inet.h>
> > +#include <string.h>
> 
> >  //Standard define
> >  #define PROCNUM 1
> > @@ -49,6 +53,27 @@ int main(int argn, char *argc[])
> >  	int test_status = 1;	//Default test result set to FAILED
> >  	SVCXPRT *svcr = NULL;
> >  	int fd = 0;
> > +	struct sockaddr_in server_addr;
> > +
> > +	fd = socket(AF_INET, SOCK_DGRAM, 0);
> > +	if (fd < 0) {
> > +		printf("socket creation failed");
> > +		return test_status;
> > +	}
> > +
> > +	memset(&server_addr, 0, sizeof(server_addr));
> > +	server_addr.sin_family = AF_INET;
> > +	server_addr.sin_port = htons(9001);
> > +	if (inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr) <= 0) {
> > +		printf("inet_pton failed");
> > +		close(fd);
> > +		return test_status;
> > +	}
> > +	if (connect(fd, (struct sockaddr *)&server_addr, sizeof(server_addr))
> < 0) {
> > +		printf("connect failed");
> > +		close(fd);
> > +		return test_status;
> > +	}
> 
> >  	//create a server
> >  	svcr = svcfd_create(fd, 1024, 1024);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
