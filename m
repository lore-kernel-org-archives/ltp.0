From: James Dong =?unknown-8bit?b?6JGj5LiW5rGf?= <dongshijiang@inspur.com>
Date: Thu, 24 Jun 2021 01:02:37 +0000
Subject: [LTP] [PATCH] fix rpc_suite/rpc:add check returned value
Message-ID: <92ed4ea616c14205b30f14f0caf26c95@inspur.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr

My test environment is centos8.2, kernel version is 4.18 (CentOS-8.2.2004-x86_64-dvd1.iso)
For example:
	svcr = svcfd_create(fd, 0, 0);
	//Then call destroy macro
	svc_destroy(svcr);

If "svcfd_create" fails, that is, the return value is NULL and then call "svc_destroy" will report an error "Segmentation fault"

Kind regards,
Dong

-----????-----
???: Petr Vorel [mailto:pvorel@suse.cz] 
????: 2021?6?24? 0:07
???: James Dong (???) <dongshijiang@inspur.com>
??: ltp@lists.linux.it; Alexey Kodanev <aleksei.kodanev@bell-sw.com>; Steve Dickson <SteveD@redhat.com>; libtirpc-devel@lists.sourceforge.net; linux-nfs@vger.kernel.org
??: Re: [LTP] [PATCH] fix rpc_suite/rpc:add check returned value

Hi Dong,

> Hi Petr
> I think this is just a simple test of some APIs, but some test cases are not standardized and cause errors like "Segmentation fault" during testing. I think it is necessary to fix these errors or delete these tests.

Sure this fix can get in. I saw issues with some tests on openSUSE, but that's a separate problem (I was not able to find the problem thus report it.

> Kind regards,
> Dong

> > +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_c
> > +++ reatedestroy_svc_destroy/rpc_svc_destroy.c
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
