From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Feb 2021 14:55:00 +0100
Subject: [LTP] [PATCH 1/1] configure: Improve error message on missing
 pkg-config
In-Reply-To: <YC4+dlPsqvmYaAks@yuki.lan>
References: <20210215110419.2964-1-pvorel@suse.cz> <YCugPYQxkf61gxiK@pevik>
 <YC4+dlPsqvmYaAks@yuki.lan>
Message-ID: <YC5xtPp6kHTR7XDl@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > 	[m4_fatal([must install pkg-config or pkgconfig and pkg.m4 macro (usual dependency), see INSTALL for all dependencies])])

> Maybe just shorten it to "..., see INSTALL"
Good point, merged with this change.
Thanks for your review!

Petr

> Other than that no complaints, anything that prints reasonable message
> is much better than the cryptic error we produce without this patch.

> So Acked-by: Cyril Hrubis <chrubis@suse.cz>
