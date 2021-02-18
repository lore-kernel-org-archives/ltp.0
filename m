From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Feb 2021 15:36:07 +0100
Subject: [LTP] [PATCH 1/1] configure: Improve error message on missing
 pkg-config
In-Reply-To: <YC5xtPp6kHTR7XDl@pevik>
References: <20210215110419.2964-1-pvorel@suse.cz> <YCugPYQxkf61gxiK@pevik>
 <YC4+dlPsqvmYaAks@yuki.lan> <YC5xtPp6kHTR7XDl@pevik>
Message-ID: <YC57VyRUUfuTORUt@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > > 	[m4_fatal([must install pkg-config or pkgconfig and pkg.m4 macro (usual dependency), see INSTALL for all dependencies])])

> > Maybe just shorten it to "..., see INSTALL"
> Good point, merged with this change.
> Thanks for your review!

It looks it broke Centos 7, looking into it.

Kind regards,
Petr
