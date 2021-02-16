From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 16 Feb 2021 11:36:45 +0100
Subject: [LTP] [PATCH 1/1] configure: Improve error message on missing
 pkg-config
In-Reply-To: <20210215110419.2964-1-pvorel@suse.cz>
References: <20210215110419.2964-1-pvorel@suse.cz>
Message-ID: <YCugPYQxkf61gxiK@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> +++ b/configure.ac
> @@ -30,6 +30,9 @@ AC_DEFUN([AC_PROG_STRIP], [AC_CHECK_TOOL(STRIP, strip, :)])
>  AC_PROG_STRIP
>  AC_PROG_YACC

> +m4_ifndef([PKG_PREREQ],
> +	[m4_fatal([must install pkg-config or pkgconfig and pkg.m4 macro (usual dependency)])])
Maybe mention also INSTALL file (feedback from
https://github.com/linux-test-project/ltp/issues/787):

	[m4_fatal([must install pkg-config or pkgconfig and pkg.m4 macro (usual dependency), see INSTALL for all dependencies])])

Kind regards,
Petr
