From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 23 Mar 2017 14:05:15 +0100
Subject: [LTP] [PATCH 1/1] rpc: Add missing header
In-Reply-To: <20170323113530.GD351@rei.lan>
References: <20170322202820.15989-1-pvorel@suse.cz>
 <20170323113530.GD351@rei.lan>
Message-ID: <20170323130515.hgxdgqs6absurzjf@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Cyril!

> > This fixes: implicit declaration of function ???pmap_unset???.

> Hmm, the man 3 rpc only states that <rpc/rpc.h> needs to be included,
> what distro this fails on?

Various distros. Tested on these:
* Debian testing/unstable (with recent updates)
$ lsb_release -a
Distributor ID:	Debian
Description:	Debian GNU/Linux 9.0 (stretch)
Release:	9.0
Codename:	stretch

$ gcc --version
gcc (Debian 6.3.0-8) 6.3.0 20170221

* Debian stretch cross compilation to sparc64
$ sparc64-linux-gnu-gcc --version
sparc64-linux-gnu-gcc (Debian 6.3.0-9) 6.3.0 20170316

* openSUSE Tumbleweed (with recent updates)
$ lsb_release -a
LSB Version:	n/a
Distributor ID:	openSUSE
Description:	openSUSE Tumbleweed
Release:	20170311
Codename:	n/a

$ gcc --version
gcc (SUSE Linux) 6.3.1 20170202 [gcc-6-branch revision 245119]

Error is:
rpc_server.c: In function ‘main’:
rpc_server.c:78:2: warning: implicit declaration of function ‘pmap_unset’ [-Wimplicit-function-declaration]
  pmap_unset(program, version);

But maybe I'm wrong, doing some mistake.

Kind regards,
Petr
