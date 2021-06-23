From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 Jun 2021 18:06:44 +0200
Subject: [LTP] [PATCH] fix rpc_suite/rpc:add check returned value
In-Reply-To: <52e4b3cba7d74f17b64816acaf50be01@inspur.com>
References: <52e4b3cba7d74f17b64816acaf50be01@inspur.com>
Message-ID: <YNNcFHTRmBtviT+Y@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Dong,

> Hi Petr
> I think this is just a simple test of some APIs, but some test cases are not standardized and cause errors like "Segmentation fault" during testing. I think it is necessary to fix these errors or delete these tests.

Sure this fix can get in. I saw issues with some tests on openSUSE, but that's a
separate problem (I was not able to find the problem thus report it.

> Kind regards,
> Dong

> > +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c
> > @@ -46,6 +46,11 @@ int main(void)

> >  	//First of all, create a server
> >  	svcr = svcfd_create(fd, 0, 0);
> > +
> > +	//check returned value
> > +	if ((SVCXPRT *) svcr == NULL) {
IMHO casting is not required, right? Just
	if (svcr == NULL) {

Kind regards,
Petr
