Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WXE2r-0000Qb-Da
	for ltp-list@lists.sourceforge.net; Mon, 07 Apr 2014 18:13:21 +0000
Date: Mon, 7 Apr 2014 20:12:36 +0200
From: chrubis@suse.cz
Message-ID: <20140407181236.GA8332@rei>
References: <1387812348-23017-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1387812348-23017-2-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1387812348-23017-2-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH 2/3] rpc01: moved common functions to a lib
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/network/rpc/basic_tests/rpc01/Makefile b/testcases/network/rpc/basic_tests/rpc01/Makefile
> index 732d816..68ea85e 100644
> --- a/testcases/network/rpc/basic_tests/rpc01/Makefile
> +++ b/testcases/network/rpc/basic_tests/rpc01/Makefile
> @@ -28,7 +28,15 @@ include $(top_srcdir)/include/mk/env_pre.mk
>  CPPFLAGS		+= -Wno-error
>  
>  INSTALL_TARGETS		:= rpc01
> -
>  SUBDIRS			:= datafiles
>  
> +LIBSRCS			:= $(abs_srcdir)/librpc01.c
> +INTERNAL_LIB		:= librpc01.a
> +LDFLAGS			+= -L$(abs_srcdir)
> +LDLIBS			+= -lrpc01
> +
> +MAKE_TARGETS		:= rpc1 rpc_server
> +$(MAKE_TARGETS): $(INTERNAL_LIB)
> +
>  include $(top_srcdir)/include/mk/generic_trunk_target.mk
> +include $(top_srcdir)/include/mk/lib.mk

There is a problem with this change. Including both trunk target and lib
makes the install phase to install the MAKE_TARGETS both to
/testcases/bin and /usr/lib{,64}/ (because each of them installs
MAKE_TARGETS to INSTALL_DIR).

Given that there may be other problems with this setup I would rather
move the library to a subdirectory with it's own Makefile. What do you
think? 

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
