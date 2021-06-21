From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 21 Jun 2021 09:59:09 +0200
Subject: [LTP] [PATCH] fix rpc_suite/rpc:add check returned value
In-Reply-To: <20210617070806.174220-1-dongshijiang@inspur.com>
References: <20210617070806.174220-1-dongshijiang@inspur.com>
Message-ID: <YNBGza7f7dOawiaF@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

[Cc libtirpc ML and Steve]

> "Segmentation fault (core dumped)" due to the failure of svcfd_create during the rpc test, so you need to check the return value of the "svcfd_create" function

I'm not sure what is the value of TI-RPC tests. IMHO really messy code does
not in the end cover much of libtirpc functionality. That's why I'm thinking
to propose deleting whole testcases/network/rpc/rpc-tirpc/. libtirpc is being
used in nfs-utils, thus it'd deserve to have some testing, but IMHO this
should be libtirpc.

I'm not planning to dive into the technology to understand it enough be
able to written the tests from scratch and I'm not aware of anybody else
planning it.

> Signed-off-by: dongshijiang <dongshijiang@inspur.com>
> ---
>  .../rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c      | 5 +++++
>  .../rpc_createdestroy_svc_destroy/rpc_svc_destroy_stress.c   | 5 +++++
>  .../rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c       | 5 +++++
>  .../rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c   | 5 +++++
>  4 files changed, 20 insertions(+)

> diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c
> index 60b96cec3..3557c0068 100644
> --- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c
> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c
> @@ -46,6 +46,11 @@ int main(void)

>  	//First of all, create a server
>  	svcr = svcfd_create(fd, 0, 0);
> +
> +	//check returned value
> +	if ((SVCXPRT *) svcr == NULL) {
> +		return test_status;
> +	}

>  	//Then call destroy macro
>  	svc_destroy(svcr);
> diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy_stress.c
> index ecd145393..5a4331f4d 100644
> --- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy_stress.c
> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy_stress.c
> @@ -55,6 +55,11 @@ int main(int argn, char *argc[])
>  	//First of all, create a server
>  	for (i = 0; i < nbCall; i++) {
>  		svcr = svcfd_create(fd, 0, 0);
> +
> +		//check returned value
> +		if ((SVCXPRT *) svcr == NULL)
> +			continue;
> +		svcr = NULL;
man svc_destroy(3) states that it deallocates private data structures, including
xprt itself.

Kind regards,
Petr

>  		//Then call destroy macro
>  		svc_destroy(svcr);
> diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c
> index da3b93022..de4df15f1 100644
> --- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c
> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c
> @@ -48,6 +48,11 @@ int main(void)

>  	//create a server
>  	svcr = svcfd_create(fd, 1024, 1024);
> +
> +	//check returned value
> +	if ((SVCXPRT *) svcr == NULL) {
> +		return test_status;
> +	}

>  	//call routine
>  	xprt_register(svcr);
> diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c
> index d0b7a20d4..fbaec25ad 100644
> --- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c
> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c
> @@ -52,6 +52,11 @@ int main(int argn, char *argc[])

>  	//create a server
>  	svcr = svcfd_create(fd, 1024, 1024);
> +
> +	//check returned value
> +	if ((SVCXPRT *) svcr == NULL) {
> +		return test_status;
> +	}

>  	xprt_register(svcr);
>  	//call routine
