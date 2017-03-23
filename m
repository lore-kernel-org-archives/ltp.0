From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Mar 2017 11:59:58 +0100
Subject: [LTP] [PATCH 1/1] open_posix_testsuite: Fix cross compilation
 of tools
In-Reply-To: <20170322195449.19552-1-pvorel@suse.cz>
References: <20170322195449.19552-1-pvorel@suse.cz>
Message-ID: <20170323105957.GC351@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> by including config-openposix.mk which contains cross compilation setup.
> 
> This fixes #144.
> 
> Reported-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
>  testcases/open_posix_testsuite/tools/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/testcases/open_posix_testsuite/tools/Makefile b/testcases/open_posix_testsuite/tools/Makefile
> index 9a9f0481d..8500d4259 100644
> --- a/testcases/open_posix_testsuite/tools/Makefile
> +++ b/testcases/open_posix_testsuite/tools/Makefile
> @@ -4,6 +4,8 @@
>  # Ngie Cooper, June 2010
>  #
>  
> +include ../../../include/mk/config-openposix.mk

I've added hypen before the include, so that the open_posix_testsuite
compilation works without executing the top-level configure as well and
pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
