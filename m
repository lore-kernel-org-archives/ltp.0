From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Feb 2021 11:16:22 +0100
Subject: [LTP] [PATCH 1/1] configure: Improve error message on missing
 pkg-config
In-Reply-To: <YCugPYQxkf61gxiK@pevik>
References: <20210215110419.2964-1-pvorel@suse.cz>
 <YCugPYQxkf61gxiK@pevik>
Message-ID: <YC4+dlPsqvmYaAks@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +m4_ifndef([PKG_PREREQ],
> > +	[m4_fatal([must install pkg-config or pkgconfig and pkg.m4 macro (usual dependency)])])
> Maybe mention also INSTALL file (feedback from
> https://github.com/linux-test-project/ltp/issues/787):
> 
> 	[m4_fatal([must install pkg-config or pkgconfig and pkg.m4 macro (usual dependency), see INSTALL for all dependencies])])

Maybe just shorten it to "..., see INSTALL"

Other than that no complaints, anything that prints reasonable message
is much better than the cryptic error we produce without this patch.

So Acked-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
