Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Ogx8i-0006LR-7X
	for ltp-list@lists.sourceforge.net; Thu, 05 Aug 2010 09:53:28 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id C48638726A
	for <ltp-list@lists.sourceforge.net>;
	Thu,  5 Aug 2010 11:53:15 +0200 (CEST)
Date: Thu, 5 Aug 2010 12:09:54 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100805100954.GB11402@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
Subject: [LTP] just another make-3.80 bug
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
When trying to build ltp from tarball (ltp-full-20100630.bz2) using
make-3.80 for some reason automake rules kicks in so you need either
comment out some rules from include/mk/automake.mk or compile autotools
by hand (there is no recent automake on system with make-3.80).

# cat /etc/SuSE-release 
SUSE Linux Enterprise Server 10 (x86_64)
VERSION = 10
PATCHLEVEL = 2

# make -v
GNU Make 3.80
Copyright (C) 2002  Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

# tar xjf ltp-full-20100630.bz2 
# cd ltp-full-20100630/
# ./configure
...

# make
make -C testcases/realtime autotools
make[1]: Entering directory `/root/ltp-full-20100630/testcases/realtime'
autoheader
make[1]: autoheader: Command not found
make[1]: *** [autoheader] Error 127
make[1]: Leaving directory `/root/ltp-full-20100630/testcases/realtime'
make: *** [testcases/realtime/configure] Error 2

-- 
Cyril Hrubis
chrubis@suse.cz

--fdj2RfSjLxBAspz7
Content-Type: text/x-log; charset=us-ascii
Content-Disposition: attachment; filename="make.log"

GNU Make 3.80
Copyright (C) 2002  Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
Reading makefiles...
Reading makefile `Makefile'...
Reading makefile `/root/ltp-full-20100630/include/mk/env_pre.mk' (search path) (no ~ expansion)...
Reading makefile `/root/ltp-full-20100630/include/mk/functions.mk' (search path) (no ~ expansion)...
Got a SIGCHLD; 1 unreaped children.
Got a SIGCHLD; 1 unreaped children.
Got a SIGCHLD; 1 unreaped children.
Reading makefile `/root/ltp-full-20100630/include/mk/config.mk' (search path) (no ~ expansion)...
Reading makefile `/root/ltp-full-20100630/include/mk/automake.mk' (search path) (no ~ expansion)...
Got a SIGCHLD; 1 unreaped children.
Updating makefiles....
 Considering target file `/root/ltp-full-20100630/include/mk/automake.mk'.
  Looking for an implicit rule for `/root/ltp-full-20100630/include/mk/automake.mk'.
  Trying pattern rule with stem `automake.mk'.
  Trying implicit prerequisite `/root/ltp-full-20100630/include/mk/automake.mk,v'.
  Trying pattern rule with stem `automake.mk'.
  Trying implicit prerequisite `/root/ltp-full-20100630/include/mk/RCS/automake.mk,v'.
  Trying pattern rule with stem `automake.mk'.
  Trying implicit prerequisite `/root/ltp-full-20100630/include/mk/RCS/automake.mk'.
  Trying pattern rule with stem `automake.mk'.
  Trying implicit prerequisite `/root/ltp-full-20100630/include/mk/s.automake.mk'.
  Trying pattern rule with stem `automake.mk'.
  Trying implicit prerequisite `/root/ltp-full-20100630/include/mk/SCCS/s.automake.mk'.
  No implicit rule found for `/root/ltp-full-20100630/include/mk/automake.mk'.
  Finished prerequisites of target file `/root/ltp-full-20100630/include/mk/automake.mk'.
 No need to remake target `/root/ltp-full-20100630/include/mk/automake.mk'.
 Considering target file `/root/ltp-full-20100630/include/mk/config.mk'.
  Finished prerequisites of target file `/root/ltp-full-20100630/include/mk/config.mk'.
 No need to remake target `/root/ltp-full-20100630/include/mk/config.mk'.
 Considering target file `/root/ltp-full-20100630/include/mk/functions.mk'.
  Looking for an implicit rule for `/root/ltp-full-20100630/include/mk/functions.mk'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `/root/ltp-full-20100630/include/mk/functions.mk,v'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `/root/ltp-full-20100630/include/mk/RCS/functions.mk,v'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `/root/ltp-full-20100630/include/mk/RCS/functions.mk'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `/root/ltp-full-20100630/include/mk/s.functions.mk'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `/root/ltp-full-20100630/include/mk/SCCS/s.functions.mk'.
  No implicit rule found for `/root/ltp-full-20100630/include/mk/functions.mk'.
  Finished prerequisites of target file `/root/ltp-full-20100630/include/mk/functions.mk'.
 No need to remake target `/root/ltp-full-20100630/include/mk/functions.mk'.
 Considering target file `/root/ltp-full-20100630/include/mk/env_pre.mk'.
  Looking for an implicit rule for `/root/ltp-full-20100630/include/mk/env_pre.mk'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `/root/ltp-full-20100630/include/mk/env_pre.mk,v'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `/root/ltp-full-20100630/include/mk/RCS/env_pre.mk,v'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `/root/ltp-full-20100630/include/mk/RCS/env_pre.mk'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `/root/ltp-full-20100630/include/mk/s.env_pre.mk'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `/root/ltp-full-20100630/include/mk/SCCS/s.env_pre.mk'.
  No implicit rule found for `/root/ltp-full-20100630/include/mk/env_pre.mk'.
  Finished prerequisites of target file `/root/ltp-full-20100630/include/mk/env_pre.mk'.
 No need to remake target `/root/ltp-full-20100630/include/mk/env_pre.mk'.
 Considering target file `Makefile'.
  Looking for an implicit rule for `Makefile'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `Makefile,v'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `RCS/Makefile,v'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `RCS/Makefile'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `s.Makefile'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `SCCS/s.Makefile'.
  No implicit rule found for `Makefile'.
  Finished prerequisites of target file `Makefile'.
 No need to remake target `Makefile'.
Updating goal targets....
Considering target file `testcases/realtime/configure'.
 File `testcases/realtime/configure' does not exist.
 Finished prerequisites of target file `testcases/realtime/configure'.
Must remake target `testcases/realtime/configure'.
make -C testcases/realtime autotools
Putting child 0x00539f90 (testcases/realtime/configure) PID 18838 on the chain.
Live child 0x00539f90 (testcases/realtime/configure) PID 18838 
GNU Make 3.80
Copyright (C) 2002  Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
Reading makefiles...
Reading makefile `Makefile'...
Reading makefile `../../include/mk/env_pre.mk' (search path) (no ~ expansion)...
Reading makefile `../../include/mk/functions.mk' (search path) (no ~ expansion)...
Got a SIGCHLD; 1 unreaped children.
Got a SIGCHLD; 1 unreaped children.
Got a SIGCHLD; 2 unreaped children.
Reading makefile `../../include/mk/generic_trunk_target.mk' (search path) (no ~ expansion)...
Reading makefile `../../include/mk/env_post.mk' (search path) (no ~ expansion)...
Reading makefile `../../include/mk/functions.mk' (search path) (no ~ expansion)...
Reading makefile `../../include/mk/generic_trunk_target.inc' (search path) (no ~ expansion)...
Reading makefile `../../include/mk/functions.mk' (search path) (no ~ expansion)...
Updating makefiles....
 Considering target file `../../include/mk/functions.mk'.
  Looking for an implicit rule for `../../include/mk/functions.mk'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `../../include/mk/functions.mk.o'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `../../include/mk/functions.mk.c'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `../../include/mk/functions.mk.cc'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `../../include/mk/functions.mk.C'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `../../include/mk/functions.mk.cpp'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `../../include/mk/functions.mk.p'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `../../include/mk/functions.mk.f'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `../../include/mk/functions.mk.F'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `../../include/mk/functions.mk.r'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `../../include/mk/functions.mk.s'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `../../include/mk/functions.mk.S'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `../../include/mk/functions.mk.mod'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `../../include/mk/functions.mk.sh'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `../../include/mk/functions.mk,v'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `../../include/mk/RCS/functions.mk,v'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `../../include/mk/RCS/functions.mk'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `../../include/mk/s.functions.mk'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `../../include/mk/SCCS/s.functions.mk'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `../../include/mk/functions.mk.o'.
  Looking for a rule with intermediate file `../../include/mk/functions.mk.o'.
   Avoiding implicit rule recursion.
   Trying pattern rule with stem `functions.mk'.
   Trying implicit prerequisite `../../include/mk/functions.mk.c'.
   Trying pattern rule with stem `functions.mk'.
   Trying implicit prerequisite `../../include/mk/functions.mk.cc'.
   Trying pattern rule with stem `functions.mk'.
   Trying implicit prerequisite `../../include/mk/functions.mk.C'.
   Trying pattern rule with stem `functions.mk'.
   Trying implicit prerequisite `../../include/mk/functions.mk.cpp'.
   Trying pattern rule with stem `functions.mk'.
   Trying implicit prerequisite `../../include/mk/functions.mk.p'.
   Trying pattern rule with stem `functions.mk'.
   Trying implicit prerequisite `../../include/mk/functions.mk.f'.
   Trying pattern rule with stem `functions.mk'.
   Trying implicit prerequisite `../../include/mk/functions.mk.F'.
   Trying pattern rule with stem `functions.mk'.
   Trying implicit prerequisite `../../include/mk/functions.mk.r'.
   Trying pattern rule with stem `functions.mk'.
   Trying implicit prerequisite `../../include/mk/functions.mk.s'.
   Trying pattern rule with stem `functions.mk'.
   Trying implicit prerequisite `../../include/mk/functions.mk.S'.
   Trying pattern rule with stem `functions.mk'.
   Trying implicit prerequisite `../../include/mk/functions.mk.mod'.
   Trying pattern rule with stem `functions.mk.o'.
   Trying implicit prerequisite `../../include/mk/functions.mk.o,v'.
   Trying pattern rule with stem `functions.mk.o'.
   Trying implicit prerequisite `../../include/mk/RCS/functions.mk.o,v'.
   Trying pattern rule with stem `functions.mk.o'.
   Trying implicit prerequisite `../../include/mk/RCS/functions.mk.o'.
   Trying pattern rule with stem `functions.mk.o'.
   Trying implicit prerequisite `../../include/mk/s.functions.mk.o'.
   Trying pattern rule with stem `functions.mk.o'.
   Trying implicit prerequisite `../../include/mk/SCCS/s.functions.mk.o'.
   Trying pattern rule with stem `functions.mk'.
   Trying implicit prerequisite `../../include/mk/functions.mk.c'.
   Looking for a rule with intermediate file `../../include/mk/functions.mk.c'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `functions.mk'.
    Trying implicit prerequisite `../../include/mk/functions.mk.y'.
    Trying pattern rule with stem `functions.mk'.
    Trying implicit prerequisite `../../include/mk/functions.mk.l'.
    Trying pattern rule with stem `functions.mk'.
    Trying implicit prerequisite `../../include/mk/functions.mk.w'.
    Trying pattern rule with stem `functions.mk'.
    Trying implicit prerequisite `../../include/mk/functions.mk.w'.
    Trying pattern rule with stem `functions.mk.c'.
    Trying implicit prerequisite `../../include/mk/functions.mk.c,v'.
    Trying pattern rule with stem `functions.mk.c'.
    Trying implicit prerequisite `../../include/mk/RCS/functions.mk.c,v'.
    Trying pattern rule with stem `functions.mk.c'.
    Trying implicit prerequisite `../../include/mk/RCS/functions.mk.c'.
    Trying pattern rule with stem `functions.mk.c'.
    Trying implicit prerequisite `../../include/mk/s.functions.mk.c'.
    Trying pattern rule with stem `functions.mk.c'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.functions.mk.c'.
    Trying pattern rule with stem `functions.mk'.
    Trying implicit prerequisite `../../include/mk/functions.mk.y'.
    Looking for a rule with intermediate file `../../include/mk/functions.mk.y'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `functions.mk.y'.
     Trying implicit prerequisite `../../include/mk/functions.mk.y,v'.
     Trying pattern rule with stem `functions.mk.y'.
     Trying implicit prerequisite `../../include/mk/RCS/functions.mk.y,v'.
     Trying pattern rule with stem `functions.mk.y'.
     Trying implicit prerequisite `../../include/mk/RCS/functions.mk.y'.
     Trying pattern rule with stem `functions.mk.y'.
     Trying implicit prerequisite `../../include/mk/s.functions.mk.y'.
     Trying pattern rule with stem `functions.mk.y'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.functions.mk.y'.
    Trying pattern rule with stem `functions.mk'.
    Trying implicit prerequisite `../../include/mk/functions.mk.l'.
    Looking for a rule with intermediate file `../../include/mk/functions.mk.l'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `functions.mk.l'.
     Trying implicit prerequisite `../../include/mk/functions.mk.l,v'.
     Trying pattern rule with stem `functions.mk.l'.
     Trying implicit prerequisite `../../include/mk/RCS/functions.mk.l,v'.
     Trying pattern rule with stem `functions.mk.l'.
     Trying implicit prerequisite `../../include/mk/RCS/functions.mk.l'.
     Trying pattern rule with stem `functions.mk.l'.
     Trying implicit prerequisite `../../include/mk/s.functions.mk.l'.
     Trying pattern rule with stem `functions.mk.l'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.functions.mk.l'.
    Trying pattern rule with stem `functions.mk'.
    Trying implicit prerequisite `../../include/mk/functions.mk.w'.
    Looking for a rule with intermediate file `../../include/mk/functions.mk.w'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `functions.mk.w'.
     Trying implicit prerequisite `../../include/mk/functions.mk.w,v'.
     Trying pattern rule with stem `functions.mk.w'.
     Trying implicit prerequisite `../../include/mk/RCS/functions.mk.w,v'.
     Trying pattern rule with stem `functions.mk.w'.
     Trying implicit prerequisite `../../include/mk/RCS/functions.mk.w'.
     Trying pattern rule with stem `functions.mk.w'.
     Trying implicit prerequisite `../../include/mk/s.functions.mk.w'.
     Trying pattern rule with stem `functions.mk.w'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.functions.mk.w'.
    Trying pattern rule with stem `functions.mk'.
    Rejecting impossible implicit prerequisite `../../include/mk/functions.mk.w'.
   Trying pattern rule with stem `functions.mk'.
   Trying implicit prerequisite `../../include/mk/functions.mk.cc'.
   Looking for a rule with intermediate file `../../include/mk/functions.mk.cc'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `functions.mk.cc'.
    Trying implicit prerequisite `../../include/mk/functions.mk.cc,v'.
    Trying pattern rule with stem `functions.mk.cc'.
    Trying implicit prerequisite `../../include/mk/RCS/functions.mk.cc,v'.
    Trying pattern rule with stem `functions.mk.cc'.
    Trying implicit prerequisite `../../include/mk/RCS/functions.mk.cc'.
    Trying pattern rule with stem `functions.mk.cc'.
    Trying implicit prerequisite `../../include/mk/s.functions.mk.cc'.
    Trying pattern rule with stem `functions.mk.cc'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.functions.mk.cc'.
   Trying pattern rule with stem `functions.mk'.
   Trying implicit prerequisite `../../include/mk/functions.mk.C'.
   Looking for a rule with intermediate file `../../include/mk/functions.mk.C'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `functions.mk.C'.
    Trying implicit prerequisite `../../include/mk/functions.mk.C,v'.
    Trying pattern rule with stem `functions.mk.C'.
    Trying implicit prerequisite `../../include/mk/RCS/functions.mk.C,v'.
    Trying pattern rule with stem `functions.mk.C'.
    Trying implicit prerequisite `../../include/mk/RCS/functions.mk.C'.
    Trying pattern rule with stem `functions.mk.C'.
    Trying implicit prerequisite `../../include/mk/s.functions.mk.C'.
    Trying pattern rule with stem `functions.mk.C'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.functions.mk.C'.
   Trying pattern rule with stem `functions.mk'.
   Trying implicit prerequisite `../../include/mk/functions.mk.cpp'.
   Looking for a rule with intermediate file `../../include/mk/functions.mk.cpp'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `functions.mk.cpp'.
    Trying implicit prerequisite `../../include/mk/functions.mk.cpp,v'.
    Trying pattern rule with stem `functions.mk.cpp'.
    Trying implicit prerequisite `../../include/mk/RCS/functions.mk.cpp,v'.
    Trying pattern rule with stem `functions.mk.cpp'.
    Trying implicit prerequisite `../../include/mk/RCS/functions.mk.cpp'.
    Trying pattern rule with stem `functions.mk.cpp'.
    Trying implicit prerequisite `../../include/mk/s.functions.mk.cpp'.
    Trying pattern rule with stem `functions.mk.cpp'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.functions.mk.cpp'.
   Trying pattern rule with stem `functions.mk'.
   Trying implicit prerequisite `../../include/mk/functions.mk.p'.
   Looking for a rule with intermediate file `../../include/mk/functions.mk.p'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `functions.mk'.
    Trying implicit prerequisite `../../include/mk/functions.mk.web'.
    Trying pattern rule with stem `functions.mk.p'.
    Trying implicit prerequisite `../../include/mk/functions.mk.p,v'.
    Trying pattern rule with stem `functions.mk.p'.
    Trying implicit prerequisite `../../include/mk/RCS/functions.mk.p,v'.
    Trying pattern rule with stem `functions.mk.p'.
    Trying implicit prerequisite `../../include/mk/RCS/functions.mk.p'.
    Trying pattern rule with stem `functions.mk.p'.
    Trying implicit prerequisite `../../include/mk/s.functions.mk.p'.
    Trying pattern rule with stem `functions.mk.p'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.functions.mk.p'.
    Trying pattern rule with stem `functions.mk'.
    Trying implicit prerequisite `../../include/mk/functions.mk.web'.
    Looking for a rule with intermediate file `../../include/mk/functions.mk.web'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `functions.mk.web'.
     Trying implicit prerequisite `../../include/mk/functions.mk.web,v'.
     Trying pattern rule with stem `functions.mk.web'.
     Trying implicit prerequisite `../../include/mk/RCS/functions.mk.web,v'.
     Trying pattern rule with stem `functions.mk.web'.
     Trying implicit prerequisite `../../include/mk/RCS/functions.mk.web'.
     Trying pattern rule with stem `functions.mk.web'.
     Trying implicit prerequisite `../../include/mk/s.functions.mk.web'.
     Trying pattern rule with stem `functions.mk.web'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.functions.mk.web'.
   Trying pattern rule with stem `functions.mk'.
   Trying implicit prerequisite `../../include/mk/functions.mk.f'.
   Looking for a rule with intermediate file `../../include/mk/functions.mk.f'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `functions.mk'.
    Trying implicit prerequisite `../../include/mk/functions.mk.F'.
    Trying pattern rule with stem `functions.mk'.
    Trying implicit prerequisite `../../include/mk/functions.mk.r'.
    Trying pattern rule with stem `functions.mk.f'.
    Trying implicit prerequisite `../../include/mk/functions.mk.f,v'.
    Trying pattern rule with stem `functions.mk.f'.
    Trying implicit prerequisite `../../include/mk/RCS/functions.mk.f,v'.
    Trying pattern rule with stem `functions.mk.f'.
    Trying implicit prerequisite `../../include/mk/RCS/functions.mk.f'.
    Trying pattern rule with stem `functions.mk.f'.
    Trying implicit prerequisite `../../include/mk/s.functions.mk.f'.
    Trying pattern rule with stem `functions.mk.f'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.functions.mk.f'.
    Trying pattern rule with stem `functions.mk'.
    Trying implicit prerequisite `../../include/mk/functions.mk.F'.
    Looking for a rule with intermediate file `../../include/mk/functions.mk.F'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `functions.mk.F'.
     Trying implicit prerequisite `../../include/mk/functions.mk.F,v'.
     Trying pattern rule with stem `functions.mk.F'.
     Trying implicit prerequisite `../../include/mk/RCS/functions.mk.F,v'.
     Trying pattern rule with stem `functions.mk.F'.
     Trying implicit prerequisite `../../include/mk/RCS/functions.mk.F'.
     Trying pattern rule with stem `functions.mk.F'.
     Trying implicit prerequisite `../../include/mk/s.functions.mk.F'.
     Trying pattern rule with stem `functions.mk.F'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.functions.mk.F'.
    Trying pattern rule with stem `functions.mk'.
    Trying implicit prerequisite `../../include/mk/functions.mk.r'.
    Looking for a rule with intermediate file `../../include/mk/functions.mk.r'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `functions.mk'.
     Rejecting impossible implicit prerequisite `../../include/mk/functions.mk.l'.
     Trying pattern rule with stem `functions.mk.r'.
     Trying implicit prerequisite `../../include/mk/functions.mk.r,v'.
     Trying pattern rule with stem `functions.mk.r'.
     Trying implicit prerequisite `../../include/mk/RCS/functions.mk.r,v'.
     Trying pattern rule with stem `functions.mk.r'.
     Trying implicit prerequisite `../../include/mk/RCS/functions.mk.r'.
     Trying pattern rule with stem `functions.mk.r'.
     Trying implicit prerequisite `../../include/mk/s.functions.mk.r'.
     Trying pattern rule with stem `functions.mk.r'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.functions.mk.r'.
   Trying pattern rule with stem `functions.mk'.
   Rejecting impossible implicit prerequisite `../../include/mk/functions.mk.F'.
   Trying pattern rule with stem `functions.mk'.
   Rejecting impossible implicit prerequisite `../../include/mk/functions.mk.r'.
   Trying pattern rule with stem `functions.mk'.
   Trying implicit prerequisite `../../include/mk/functions.mk.s'.
   Looking for a rule with intermediate file `../../include/mk/functions.mk.s'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `functions.mk'.
    Trying implicit prerequisite `../../include/mk/functions.mk.S'.
    Trying pattern rule with stem `functions.mk.s'.
    Trying implicit prerequisite `../../include/mk/functions.mk.s,v'.
    Trying pattern rule with stem `functions.mk.s'.
    Trying implicit prerequisite `../../include/mk/RCS/functions.mk.s,v'.
    Trying pattern rule with stem `functions.mk.s'.
    Trying implicit prerequisite `../../include/mk/RCS/functions.mk.s'.
    Trying pattern rule with stem `functions.mk.s'.
    Trying implicit prerequisite `../../include/mk/s.functions.mk.s'.
    Trying pattern rule with stem `functions.mk.s'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.functions.mk.s'.
    Trying pattern rule with stem `functions.mk'.
    Trying implicit prerequisite `../../include/mk/functions.mk.S'.
    Looking for a rule with intermediate file `../../include/mk/functions.mk.S'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `functions.mk.S'.
     Trying implicit prerequisite `../../include/mk/functions.mk.S,v'.
     Trying pattern rule with stem `functions.mk.S'.
     Trying implicit prerequisite `../../include/mk/RCS/functions.mk.S,v'.
     Trying pattern rule with stem `functions.mk.S'.
     Trying implicit prerequisite `../../include/mk/RCS/functions.mk.S'.
     Trying pattern rule with stem `functions.mk.S'.
     Trying implicit prerequisite `../../include/mk/s.functions.mk.S'.
     Trying pattern rule with stem `functions.mk.S'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.functions.mk.S'.
   Trying pattern rule with stem `functions.mk'.
   Rejecting impossible implicit prerequisite `../../include/mk/functions.mk.S'.
   Trying pattern rule with stem `functions.mk'.
   Trying implicit prerequisite `../../include/mk/functions.mk.mod'.
   Looking for a rule with intermediate file `../../include/mk/functions.mk.mod'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `functions.mk.mod'.
    Trying implicit prerequisite `../../include/mk/functions.mk.mod,v'.
    Trying pattern rule with stem `functions.mk.mod'.
    Trying implicit prerequisite `../../include/mk/RCS/functions.mk.mod,v'.
    Trying pattern rule with stem `functions.mk.mod'.
    Trying implicit prerequisite `../../include/mk/RCS/functions.mk.mod'.
    Trying pattern rule with stem `functions.mk.mod'.
    Trying implicit prerequisite `../../include/mk/s.functions.mk.mod'.
    Trying pattern rule with stem `functions.mk.mod'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.functions.mk.mod'.
  Trying pattern rule with stem `functions.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/functions.mk.c'.
  Trying pattern rule with stem `functions.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/functions.mk.cc'.
  Trying pattern rule with stem `functions.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/functions.mk.C'.
  Trying pattern rule with stem `functions.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/functions.mk.cpp'.
  Trying pattern rule with stem `functions.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/functions.mk.p'.
  Trying pattern rule with stem `functions.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/functions.mk.f'.
  Trying pattern rule with stem `functions.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/functions.mk.F'.
  Trying pattern rule with stem `functions.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/functions.mk.r'.
  Trying pattern rule with stem `functions.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/functions.mk.s'.
  Trying pattern rule with stem `functions.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/functions.mk.S'.
  Trying pattern rule with stem `functions.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/functions.mk.mod'.
  Trying pattern rule with stem `functions.mk'.
  Trying implicit prerequisite `../../include/mk/functions.mk.sh'.
  Looking for a rule with intermediate file `../../include/mk/functions.mk.sh'.
   Avoiding implicit rule recursion.
   Trying pattern rule with stem `functions.mk.sh'.
   Trying implicit prerequisite `../../include/mk/functions.mk.sh,v'.
   Trying pattern rule with stem `functions.mk.sh'.
   Trying implicit prerequisite `../../include/mk/RCS/functions.mk.sh,v'.
   Trying pattern rule with stem `functions.mk.sh'.
   Trying implicit prerequisite `../../include/mk/RCS/functions.mk.sh'.
   Trying pattern rule with stem `functions.mk.sh'.
   Trying implicit prerequisite `../../include/mk/s.functions.mk.sh'.
   Trying pattern rule with stem `functions.mk.sh'.
   Trying implicit prerequisite `../../include/mk/SCCS/s.functions.mk.sh'.
  No implicit rule found for `../../include/mk/functions.mk'.
  Finished prerequisites of target file `../../include/mk/functions.mk'.
 No need to remake target `../../include/mk/functions.mk'.
 Considering target file `../../include/mk/generic_trunk_target.inc'.
  Looking for an implicit rule for `../../include/mk/generic_trunk_target.inc'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.o'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.c'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.cc'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.C'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.cpp'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.p'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.f'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.F'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.r'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.s'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.S'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.mod'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.sh'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc,v'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc,v'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.inc'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.inc'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.o'.
  Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.inc.o'.
   Avoiding implicit rule recursion.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.c'.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.cc'.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.C'.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.cpp'.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.p'.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.f'.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.F'.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.r'.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.s'.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.S'.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.mod'.
   Trying pattern rule with stem `generic_trunk_target.inc.o'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.o,v'.
   Trying pattern rule with stem `generic_trunk_target.inc.o'.
   Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.o,v'.
   Trying pattern rule with stem `generic_trunk_target.inc.o'.
   Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.o'.
   Trying pattern rule with stem `generic_trunk_target.inc.o'.
   Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.inc.o'.
   Trying pattern rule with stem `generic_trunk_target.inc.o'.
   Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.inc.o'.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.c'.
   Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.inc.c'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `generic_trunk_target.inc'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.y'.
    Trying pattern rule with stem `generic_trunk_target.inc'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.l'.
    Trying pattern rule with stem `generic_trunk_target.inc'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.w'.
    Trying pattern rule with stem `generic_trunk_target.inc'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.w'.
    Trying pattern rule with stem `generic_trunk_target.inc.c'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.c,v'.
    Trying pattern rule with stem `generic_trunk_target.inc.c'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.c,v'.
    Trying pattern rule with stem `generic_trunk_target.inc.c'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.c'.
    Trying pattern rule with stem `generic_trunk_target.inc.c'.
    Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.inc.c'.
    Trying pattern rule with stem `generic_trunk_target.inc.c'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.inc.c'.
    Trying pattern rule with stem `generic_trunk_target.inc'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.y'.
    Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.inc.y'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `generic_trunk_target.inc.y'.
     Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.y,v'.
     Trying pattern rule with stem `generic_trunk_target.inc.y'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.y,v'.
     Trying pattern rule with stem `generic_trunk_target.inc.y'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.y'.
     Trying pattern rule with stem `generic_trunk_target.inc.y'.
     Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.inc.y'.
     Trying pattern rule with stem `generic_trunk_target.inc.y'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.inc.y'.
    Trying pattern rule with stem `generic_trunk_target.inc'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.l'.
    Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.inc.l'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `generic_trunk_target.inc.l'.
     Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.l,v'.
     Trying pattern rule with stem `generic_trunk_target.inc.l'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.l,v'.
     Trying pattern rule with stem `generic_trunk_target.inc.l'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.l'.
     Trying pattern rule with stem `generic_trunk_target.inc.l'.
     Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.inc.l'.
     Trying pattern rule with stem `generic_trunk_target.inc.l'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.inc.l'.
    Trying pattern rule with stem `generic_trunk_target.inc'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.w'.
    Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.inc.w'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `generic_trunk_target.inc.w'.
     Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.w,v'.
     Trying pattern rule with stem `generic_trunk_target.inc.w'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.w,v'.
     Trying pattern rule with stem `generic_trunk_target.inc.w'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.w'.
     Trying pattern rule with stem `generic_trunk_target.inc.w'.
     Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.inc.w'.
     Trying pattern rule with stem `generic_trunk_target.inc.w'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.inc.w'.
    Trying pattern rule with stem `generic_trunk_target.inc'.
    Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.inc.w'.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.cc'.
   Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.inc.cc'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `generic_trunk_target.inc.cc'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.cc,v'.
    Trying pattern rule with stem `generic_trunk_target.inc.cc'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.cc,v'.
    Trying pattern rule with stem `generic_trunk_target.inc.cc'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.cc'.
    Trying pattern rule with stem `generic_trunk_target.inc.cc'.
    Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.inc.cc'.
    Trying pattern rule with stem `generic_trunk_target.inc.cc'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.inc.cc'.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.C'.
   Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.inc.C'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `generic_trunk_target.inc.C'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.C,v'.
    Trying pattern rule with stem `generic_trunk_target.inc.C'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.C,v'.
    Trying pattern rule with stem `generic_trunk_target.inc.C'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.C'.
    Trying pattern rule with stem `generic_trunk_target.inc.C'.
    Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.inc.C'.
    Trying pattern rule with stem `generic_trunk_target.inc.C'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.inc.C'.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.cpp'.
   Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.inc.cpp'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `generic_trunk_target.inc.cpp'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.cpp,v'.
    Trying pattern rule with stem `generic_trunk_target.inc.cpp'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.cpp,v'.
    Trying pattern rule with stem `generic_trunk_target.inc.cpp'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.cpp'.
    Trying pattern rule with stem `generic_trunk_target.inc.cpp'.
    Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.inc.cpp'.
    Trying pattern rule with stem `generic_trunk_target.inc.cpp'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.inc.cpp'.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.p'.
   Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.inc.p'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `generic_trunk_target.inc'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.web'.
    Trying pattern rule with stem `generic_trunk_target.inc.p'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.p,v'.
    Trying pattern rule with stem `generic_trunk_target.inc.p'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.p,v'.
    Trying pattern rule with stem `generic_trunk_target.inc.p'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.p'.
    Trying pattern rule with stem `generic_trunk_target.inc.p'.
    Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.inc.p'.
    Trying pattern rule with stem `generic_trunk_target.inc.p'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.inc.p'.
    Trying pattern rule with stem `generic_trunk_target.inc'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.web'.
    Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.inc.web'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `generic_trunk_target.inc.web'.
     Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.web,v'.
     Trying pattern rule with stem `generic_trunk_target.inc.web'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.web,v'.
     Trying pattern rule with stem `generic_trunk_target.inc.web'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.web'.
     Trying pattern rule with stem `generic_trunk_target.inc.web'.
     Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.inc.web'.
     Trying pattern rule with stem `generic_trunk_target.inc.web'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.inc.web'.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.f'.
   Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.inc.f'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `generic_trunk_target.inc'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.F'.
    Trying pattern rule with stem `generic_trunk_target.inc'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.r'.
    Trying pattern rule with stem `generic_trunk_target.inc.f'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.f,v'.
    Trying pattern rule with stem `generic_trunk_target.inc.f'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.f,v'.
    Trying pattern rule with stem `generic_trunk_target.inc.f'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.f'.
    Trying pattern rule with stem `generic_trunk_target.inc.f'.
    Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.inc.f'.
    Trying pattern rule with stem `generic_trunk_target.inc.f'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.inc.f'.
    Trying pattern rule with stem `generic_trunk_target.inc'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.F'.
    Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.inc.F'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `generic_trunk_target.inc.F'.
     Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.F,v'.
     Trying pattern rule with stem `generic_trunk_target.inc.F'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.F,v'.
     Trying pattern rule with stem `generic_trunk_target.inc.F'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.F'.
     Trying pattern rule with stem `generic_trunk_target.inc.F'.
     Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.inc.F'.
     Trying pattern rule with stem `generic_trunk_target.inc.F'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.inc.F'.
    Trying pattern rule with stem `generic_trunk_target.inc'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.r'.
    Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.inc.r'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `generic_trunk_target.inc'.
     Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.inc.l'.
     Trying pattern rule with stem `generic_trunk_target.inc.r'.
     Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.r,v'.
     Trying pattern rule with stem `generic_trunk_target.inc.r'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.r,v'.
     Trying pattern rule with stem `generic_trunk_target.inc.r'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.r'.
     Trying pattern rule with stem `generic_trunk_target.inc.r'.
     Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.inc.r'.
     Trying pattern rule with stem `generic_trunk_target.inc.r'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.inc.r'.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.inc.F'.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.inc.r'.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.s'.
   Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.inc.s'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `generic_trunk_target.inc'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.S'.
    Trying pattern rule with stem `generic_trunk_target.inc.s'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.s,v'.
    Trying pattern rule with stem `generic_trunk_target.inc.s'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.s,v'.
    Trying pattern rule with stem `generic_trunk_target.inc.s'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.s'.
    Trying pattern rule with stem `generic_trunk_target.inc.s'.
    Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.inc.s'.
    Trying pattern rule with stem `generic_trunk_target.inc.s'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.inc.s'.
    Trying pattern rule with stem `generic_trunk_target.inc'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.S'.
    Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.inc.S'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `generic_trunk_target.inc.S'.
     Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.S,v'.
     Trying pattern rule with stem `generic_trunk_target.inc.S'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.S,v'.
     Trying pattern rule with stem `generic_trunk_target.inc.S'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.S'.
     Trying pattern rule with stem `generic_trunk_target.inc.S'.
     Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.inc.S'.
     Trying pattern rule with stem `generic_trunk_target.inc.S'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.inc.S'.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.inc.S'.
   Trying pattern rule with stem `generic_trunk_target.inc'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.mod'.
   Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.inc.mod'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `generic_trunk_target.inc.mod'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.mod,v'.
    Trying pattern rule with stem `generic_trunk_target.inc.mod'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.mod,v'.
    Trying pattern rule with stem `generic_trunk_target.inc.mod'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.mod'.
    Trying pattern rule with stem `generic_trunk_target.inc.mod'.
    Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.inc.mod'.
    Trying pattern rule with stem `generic_trunk_target.inc.mod'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.inc.mod'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.inc.c'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.inc.cc'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.inc.C'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.inc.cpp'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.inc.p'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.inc.f'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.inc.F'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.inc.r'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.inc.s'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.inc.S'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.inc.mod'.
  Trying pattern rule with stem `generic_trunk_target.inc'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.sh'.
  Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.inc.sh'.
   Avoiding implicit rule recursion.
   Trying pattern rule with stem `generic_trunk_target.inc.sh'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.inc.sh,v'.
   Trying pattern rule with stem `generic_trunk_target.inc.sh'.
   Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.sh,v'.
   Trying pattern rule with stem `generic_trunk_target.inc.sh'.
   Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.inc.sh'.
   Trying pattern rule with stem `generic_trunk_target.inc.sh'.
   Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.inc.sh'.
   Trying pattern rule with stem `generic_trunk_target.inc.sh'.
   Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.inc.sh'.
  No implicit rule found for `../../include/mk/generic_trunk_target.inc'.
  Finished prerequisites of target file `../../include/mk/generic_trunk_target.inc'.
 No need to remake target `../../include/mk/generic_trunk_target.inc'.
 Pruning file `../../include/mk/functions.mk'.
 Considering target file `../../include/mk/env_post.mk'.
  Looking for an implicit rule for `../../include/mk/env_post.mk'.
  Trying pattern rule with stem `env_post.mk'.
  Trying implicit prerequisite `../../include/mk/env_post.mk.o'.
  Trying pattern rule with stem `env_post.mk'.
  Trying implicit prerequisite `../../include/mk/env_post.mk.c'.
  Trying pattern rule with stem `env_post.mk'.
  Trying implicit prerequisite `../../include/mk/env_post.mk.cc'.
  Trying pattern rule with stem `env_post.mk'.
  Trying implicit prerequisite `../../include/mk/env_post.mk.C'.
  Trying pattern rule with stem `env_post.mk'.
  Trying implicit prerequisite `../../include/mk/env_post.mk.cpp'.
  Trying pattern rule with stem `env_post.mk'.
  Trying implicit prerequisite `../../include/mk/env_post.mk.p'.
  Trying pattern rule with stem `env_post.mk'.
  Trying implicit prerequisite `../../include/mk/env_post.mk.f'.
  Trying pattern rule with stem `env_post.mk'.
  Trying implicit prerequisite `../../include/mk/env_post.mk.F'.
  Trying pattern rule with stem `env_post.mk'.
  Trying implicit prerequisite `../../include/mk/env_post.mk.r'.
  Trying pattern rule with stem `env_post.mk'.
  Trying implicit prerequisite `../../include/mk/env_post.mk.s'.
  Trying pattern rule with stem `env_post.mk'.
  Trying implicit prerequisite `../../include/mk/env_post.mk.S'.
  Trying pattern rule with stem `env_post.mk'.
  Trying implicit prerequisite `../../include/mk/env_post.mk.mod'.
  Trying pattern rule with stem `env_post.mk'.
  Trying implicit prerequisite `../../include/mk/env_post.mk.sh'.
  Trying pattern rule with stem `env_post.mk'.
  Trying implicit prerequisite `../../include/mk/env_post.mk,v'.
  Trying pattern rule with stem `env_post.mk'.
  Trying implicit prerequisite `../../include/mk/RCS/env_post.mk,v'.
  Trying pattern rule with stem `env_post.mk'.
  Trying implicit prerequisite `../../include/mk/RCS/env_post.mk'.
  Trying pattern rule with stem `env_post.mk'.
  Trying implicit prerequisite `../../include/mk/s.env_post.mk'.
  Trying pattern rule with stem `env_post.mk'.
  Trying implicit prerequisite `../../include/mk/SCCS/s.env_post.mk'.
  Trying pattern rule with stem `env_post.mk'.
  Trying implicit prerequisite `../../include/mk/env_post.mk.o'.
  Looking for a rule with intermediate file `../../include/mk/env_post.mk.o'.
   Avoiding implicit rule recursion.
   Trying pattern rule with stem `env_post.mk'.
   Trying implicit prerequisite `../../include/mk/env_post.mk.c'.
   Trying pattern rule with stem `env_post.mk'.
   Trying implicit prerequisite `../../include/mk/env_post.mk.cc'.
   Trying pattern rule with stem `env_post.mk'.
   Trying implicit prerequisite `../../include/mk/env_post.mk.C'.
   Trying pattern rule with stem `env_post.mk'.
   Trying implicit prerequisite `../../include/mk/env_post.mk.cpp'.
   Trying pattern rule with stem `env_post.mk'.
   Trying implicit prerequisite `../../include/mk/env_post.mk.p'.
   Trying pattern rule with stem `env_post.mk'.
   Trying implicit prerequisite `../../include/mk/env_post.mk.f'.
   Trying pattern rule with stem `env_post.mk'.
   Trying implicit prerequisite `../../include/mk/env_post.mk.F'.
   Trying pattern rule with stem `env_post.mk'.
   Trying implicit prerequisite `../../include/mk/env_post.mk.r'.
   Trying pattern rule with stem `env_post.mk'.
   Trying implicit prerequisite `../../include/mk/env_post.mk.s'.
   Trying pattern rule with stem `env_post.mk'.
   Trying implicit prerequisite `../../include/mk/env_post.mk.S'.
   Trying pattern rule with stem `env_post.mk'.
   Trying implicit prerequisite `../../include/mk/env_post.mk.mod'.
   Trying pattern rule with stem `env_post.mk.o'.
   Trying implicit prerequisite `../../include/mk/env_post.mk.o,v'.
   Trying pattern rule with stem `env_post.mk.o'.
   Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.o,v'.
   Trying pattern rule with stem `env_post.mk.o'.
   Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.o'.
   Trying pattern rule with stem `env_post.mk.o'.
   Trying implicit prerequisite `../../include/mk/s.env_post.mk.o'.
   Trying pattern rule with stem `env_post.mk.o'.
   Trying implicit prerequisite `../../include/mk/SCCS/s.env_post.mk.o'.
   Trying pattern rule with stem `env_post.mk'.
   Trying implicit prerequisite `../../include/mk/env_post.mk.c'.
   Looking for a rule with intermediate file `../../include/mk/env_post.mk.c'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `env_post.mk'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.y'.
    Trying pattern rule with stem `env_post.mk'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.l'.
    Trying pattern rule with stem `env_post.mk'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.w'.
    Trying pattern rule with stem `env_post.mk'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.w'.
    Trying pattern rule with stem `env_post.mk.c'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.c,v'.
    Trying pattern rule with stem `env_post.mk.c'.
    Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.c,v'.
    Trying pattern rule with stem `env_post.mk.c'.
    Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.c'.
    Trying pattern rule with stem `env_post.mk.c'.
    Trying implicit prerequisite `../../include/mk/s.env_post.mk.c'.
    Trying pattern rule with stem `env_post.mk.c'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.env_post.mk.c'.
    Trying pattern rule with stem `env_post.mk'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.y'.
    Looking for a rule with intermediate file `../../include/mk/env_post.mk.y'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `env_post.mk.y'.
     Trying implicit prerequisite `../../include/mk/env_post.mk.y,v'.
     Trying pattern rule with stem `env_post.mk.y'.
     Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.y,v'.
     Trying pattern rule with stem `env_post.mk.y'.
     Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.y'.
     Trying pattern rule with stem `env_post.mk.y'.
     Trying implicit prerequisite `../../include/mk/s.env_post.mk.y'.
     Trying pattern rule with stem `env_post.mk.y'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.env_post.mk.y'.
    Trying pattern rule with stem `env_post.mk'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.l'.
    Looking for a rule with intermediate file `../../include/mk/env_post.mk.l'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `env_post.mk.l'.
     Trying implicit prerequisite `../../include/mk/env_post.mk.l,v'.
     Trying pattern rule with stem `env_post.mk.l'.
     Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.l,v'.
     Trying pattern rule with stem `env_post.mk.l'.
     Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.l'.
     Trying pattern rule with stem `env_post.mk.l'.
     Trying implicit prerequisite `../../include/mk/s.env_post.mk.l'.
     Trying pattern rule with stem `env_post.mk.l'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.env_post.mk.l'.
    Trying pattern rule with stem `env_post.mk'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.w'.
    Looking for a rule with intermediate file `../../include/mk/env_post.mk.w'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `env_post.mk.w'.
     Trying implicit prerequisite `../../include/mk/env_post.mk.w,v'.
     Trying pattern rule with stem `env_post.mk.w'.
     Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.w,v'.
     Trying pattern rule with stem `env_post.mk.w'.
     Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.w'.
     Trying pattern rule with stem `env_post.mk.w'.
     Trying implicit prerequisite `../../include/mk/s.env_post.mk.w'.
     Trying pattern rule with stem `env_post.mk.w'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.env_post.mk.w'.
    Trying pattern rule with stem `env_post.mk'.
    Rejecting impossible implicit prerequisite `../../include/mk/env_post.mk.w'.
   Trying pattern rule with stem `env_post.mk'.
   Trying implicit prerequisite `../../include/mk/env_post.mk.cc'.
   Looking for a rule with intermediate file `../../include/mk/env_post.mk.cc'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `env_post.mk.cc'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.cc,v'.
    Trying pattern rule with stem `env_post.mk.cc'.
    Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.cc,v'.
    Trying pattern rule with stem `env_post.mk.cc'.
    Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.cc'.
    Trying pattern rule with stem `env_post.mk.cc'.
    Trying implicit prerequisite `../../include/mk/s.env_post.mk.cc'.
    Trying pattern rule with stem `env_post.mk.cc'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.env_post.mk.cc'.
   Trying pattern rule with stem `env_post.mk'.
   Trying implicit prerequisite `../../include/mk/env_post.mk.C'.
   Looking for a rule with intermediate file `../../include/mk/env_post.mk.C'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `env_post.mk.C'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.C,v'.
    Trying pattern rule with stem `env_post.mk.C'.
    Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.C,v'.
    Trying pattern rule with stem `env_post.mk.C'.
    Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.C'.
    Trying pattern rule with stem `env_post.mk.C'.
    Trying implicit prerequisite `../../include/mk/s.env_post.mk.C'.
    Trying pattern rule with stem `env_post.mk.C'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.env_post.mk.C'.
   Trying pattern rule with stem `env_post.mk'.
   Trying implicit prerequisite `../../include/mk/env_post.mk.cpp'.
   Looking for a rule with intermediate file `../../include/mk/env_post.mk.cpp'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `env_post.mk.cpp'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.cpp,v'.
    Trying pattern rule with stem `env_post.mk.cpp'.
    Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.cpp,v'.
    Trying pattern rule with stem `env_post.mk.cpp'.
    Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.cpp'.
    Trying pattern rule with stem `env_post.mk.cpp'.
    Trying implicit prerequisite `../../include/mk/s.env_post.mk.cpp'.
    Trying pattern rule with stem `env_post.mk.cpp'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.env_post.mk.cpp'.
   Trying pattern rule with stem `env_post.mk'.
   Trying implicit prerequisite `../../include/mk/env_post.mk.p'.
   Looking for a rule with intermediate file `../../include/mk/env_post.mk.p'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `env_post.mk'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.web'.
    Trying pattern rule with stem `env_post.mk.p'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.p,v'.
    Trying pattern rule with stem `env_post.mk.p'.
    Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.p,v'.
    Trying pattern rule with stem `env_post.mk.p'.
    Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.p'.
    Trying pattern rule with stem `env_post.mk.p'.
    Trying implicit prerequisite `../../include/mk/s.env_post.mk.p'.
    Trying pattern rule with stem `env_post.mk.p'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.env_post.mk.p'.
    Trying pattern rule with stem `env_post.mk'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.web'.
    Looking for a rule with intermediate file `../../include/mk/env_post.mk.web'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `env_post.mk.web'.
     Trying implicit prerequisite `../../include/mk/env_post.mk.web,v'.
     Trying pattern rule with stem `env_post.mk.web'.
     Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.web,v'.
     Trying pattern rule with stem `env_post.mk.web'.
     Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.web'.
     Trying pattern rule with stem `env_post.mk.web'.
     Trying implicit prerequisite `../../include/mk/s.env_post.mk.web'.
     Trying pattern rule with stem `env_post.mk.web'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.env_post.mk.web'.
   Trying pattern rule with stem `env_post.mk'.
   Trying implicit prerequisite `../../include/mk/env_post.mk.f'.
   Looking for a rule with intermediate file `../../include/mk/env_post.mk.f'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `env_post.mk'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.F'.
    Trying pattern rule with stem `env_post.mk'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.r'.
    Trying pattern rule with stem `env_post.mk.f'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.f,v'.
    Trying pattern rule with stem `env_post.mk.f'.
    Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.f,v'.
    Trying pattern rule with stem `env_post.mk.f'.
    Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.f'.
    Trying pattern rule with stem `env_post.mk.f'.
    Trying implicit prerequisite `../../include/mk/s.env_post.mk.f'.
    Trying pattern rule with stem `env_post.mk.f'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.env_post.mk.f'.
    Trying pattern rule with stem `env_post.mk'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.F'.
    Looking for a rule with intermediate file `../../include/mk/env_post.mk.F'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `env_post.mk.F'.
     Trying implicit prerequisite `../../include/mk/env_post.mk.F,v'.
     Trying pattern rule with stem `env_post.mk.F'.
     Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.F,v'.
     Trying pattern rule with stem `env_post.mk.F'.
     Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.F'.
     Trying pattern rule with stem `env_post.mk.F'.
     Trying implicit prerequisite `../../include/mk/s.env_post.mk.F'.
     Trying pattern rule with stem `env_post.mk.F'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.env_post.mk.F'.
    Trying pattern rule with stem `env_post.mk'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.r'.
    Looking for a rule with intermediate file `../../include/mk/env_post.mk.r'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `env_post.mk'.
     Rejecting impossible implicit prerequisite `../../include/mk/env_post.mk.l'.
     Trying pattern rule with stem `env_post.mk.r'.
     Trying implicit prerequisite `../../include/mk/env_post.mk.r,v'.
     Trying pattern rule with stem `env_post.mk.r'.
     Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.r,v'.
     Trying pattern rule with stem `env_post.mk.r'.
     Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.r'.
     Trying pattern rule with stem `env_post.mk.r'.
     Trying implicit prerequisite `../../include/mk/s.env_post.mk.r'.
     Trying pattern rule with stem `env_post.mk.r'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.env_post.mk.r'.
   Trying pattern rule with stem `env_post.mk'.
   Rejecting impossible implicit prerequisite `../../include/mk/env_post.mk.F'.
   Trying pattern rule with stem `env_post.mk'.
   Rejecting impossible implicit prerequisite `../../include/mk/env_post.mk.r'.
   Trying pattern rule with stem `env_post.mk'.
   Trying implicit prerequisite `../../include/mk/env_post.mk.s'.
   Looking for a rule with intermediate file `../../include/mk/env_post.mk.s'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `env_post.mk'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.S'.
    Trying pattern rule with stem `env_post.mk.s'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.s,v'.
    Trying pattern rule with stem `env_post.mk.s'.
    Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.s,v'.
    Trying pattern rule with stem `env_post.mk.s'.
    Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.s'.
    Trying pattern rule with stem `env_post.mk.s'.
    Trying implicit prerequisite `../../include/mk/s.env_post.mk.s'.
    Trying pattern rule with stem `env_post.mk.s'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.env_post.mk.s'.
    Trying pattern rule with stem `env_post.mk'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.S'.
    Looking for a rule with intermediate file `../../include/mk/env_post.mk.S'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `env_post.mk.S'.
     Trying implicit prerequisite `../../include/mk/env_post.mk.S,v'.
     Trying pattern rule with stem `env_post.mk.S'.
     Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.S,v'.
     Trying pattern rule with stem `env_post.mk.S'.
     Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.S'.
     Trying pattern rule with stem `env_post.mk.S'.
     Trying implicit prerequisite `../../include/mk/s.env_post.mk.S'.
     Trying pattern rule with stem `env_post.mk.S'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.env_post.mk.S'.
   Trying pattern rule with stem `env_post.mk'.
   Rejecting impossible implicit prerequisite `../../include/mk/env_post.mk.S'.
   Trying pattern rule with stem `env_post.mk'.
   Trying implicit prerequisite `../../include/mk/env_post.mk.mod'.
   Looking for a rule with intermediate file `../../include/mk/env_post.mk.mod'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `env_post.mk.mod'.
    Trying implicit prerequisite `../../include/mk/env_post.mk.mod,v'.
    Trying pattern rule with stem `env_post.mk.mod'.
    Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.mod,v'.
    Trying pattern rule with stem `env_post.mk.mod'.
    Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.mod'.
    Trying pattern rule with stem `env_post.mk.mod'.
    Trying implicit prerequisite `../../include/mk/s.env_post.mk.mod'.
    Trying pattern rule with stem `env_post.mk.mod'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.env_post.mk.mod'.
  Trying pattern rule with stem `env_post.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_post.mk.c'.
  Trying pattern rule with stem `env_post.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_post.mk.cc'.
  Trying pattern rule with stem `env_post.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_post.mk.C'.
  Trying pattern rule with stem `env_post.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_post.mk.cpp'.
  Trying pattern rule with stem `env_post.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_post.mk.p'.
  Trying pattern rule with stem `env_post.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_post.mk.f'.
  Trying pattern rule with stem `env_post.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_post.mk.F'.
  Trying pattern rule with stem `env_post.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_post.mk.r'.
  Trying pattern rule with stem `env_post.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_post.mk.s'.
  Trying pattern rule with stem `env_post.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_post.mk.S'.
  Trying pattern rule with stem `env_post.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_post.mk.mod'.
  Trying pattern rule with stem `env_post.mk'.
  Trying implicit prerequisite `../../include/mk/env_post.mk.sh'.
  Looking for a rule with intermediate file `../../include/mk/env_post.mk.sh'.
   Avoiding implicit rule recursion.
   Trying pattern rule with stem `env_post.mk.sh'.
   Trying implicit prerequisite `../../include/mk/env_post.mk.sh,v'.
   Trying pattern rule with stem `env_post.mk.sh'.
   Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.sh,v'.
   Trying pattern rule with stem `env_post.mk.sh'.
   Trying implicit prerequisite `../../include/mk/RCS/env_post.mk.sh'.
   Trying pattern rule with stem `env_post.mk.sh'.
   Trying implicit prerequisite `../../include/mk/s.env_post.mk.sh'.
   Trying pattern rule with stem `env_post.mk.sh'.
   Trying implicit prerequisite `../../include/mk/SCCS/s.env_post.mk.sh'.
  No implicit rule found for `../../include/mk/env_post.mk'.
  Finished prerequisites of target file `../../include/mk/env_post.mk'.
 No need to remake target `../../include/mk/env_post.mk'.
 Considering target file `../../include/mk/generic_trunk_target.mk'.
  Looking for an implicit rule for `../../include/mk/generic_trunk_target.mk'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.o'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.c'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.cc'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.C'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.cpp'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.p'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.f'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.F'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.r'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.s'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.S'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.mod'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.sh'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk,v'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk,v'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.mk'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.mk'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.o'.
  Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.mk.o'.
   Avoiding implicit rule recursion.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.c'.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.cc'.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.C'.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.cpp'.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.p'.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.f'.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.F'.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.r'.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.s'.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.S'.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.mod'.
   Trying pattern rule with stem `generic_trunk_target.mk.o'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.o,v'.
   Trying pattern rule with stem `generic_trunk_target.mk.o'.
   Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.o,v'.
   Trying pattern rule with stem `generic_trunk_target.mk.o'.
   Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.o'.
   Trying pattern rule with stem `generic_trunk_target.mk.o'.
   Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.mk.o'.
   Trying pattern rule with stem `generic_trunk_target.mk.o'.
   Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.mk.o'.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.c'.
   Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.mk.c'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `generic_trunk_target.mk'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.y'.
    Trying pattern rule with stem `generic_trunk_target.mk'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.l'.
    Trying pattern rule with stem `generic_trunk_target.mk'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.w'.
    Trying pattern rule with stem `generic_trunk_target.mk'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.w'.
    Trying pattern rule with stem `generic_trunk_target.mk.c'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.c,v'.
    Trying pattern rule with stem `generic_trunk_target.mk.c'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.c,v'.
    Trying pattern rule with stem `generic_trunk_target.mk.c'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.c'.
    Trying pattern rule with stem `generic_trunk_target.mk.c'.
    Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.mk.c'.
    Trying pattern rule with stem `generic_trunk_target.mk.c'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.mk.c'.
    Trying pattern rule with stem `generic_trunk_target.mk'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.y'.
    Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.mk.y'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `generic_trunk_target.mk.y'.
     Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.y,v'.
     Trying pattern rule with stem `generic_trunk_target.mk.y'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.y,v'.
     Trying pattern rule with stem `generic_trunk_target.mk.y'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.y'.
     Trying pattern rule with stem `generic_trunk_target.mk.y'.
     Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.mk.y'.
     Trying pattern rule with stem `generic_trunk_target.mk.y'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.mk.y'.
    Trying pattern rule with stem `generic_trunk_target.mk'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.l'.
    Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.mk.l'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `generic_trunk_target.mk.l'.
     Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.l,v'.
     Trying pattern rule with stem `generic_trunk_target.mk.l'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.l,v'.
     Trying pattern rule with stem `generic_trunk_target.mk.l'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.l'.
     Trying pattern rule with stem `generic_trunk_target.mk.l'.
     Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.mk.l'.
     Trying pattern rule with stem `generic_trunk_target.mk.l'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.mk.l'.
    Trying pattern rule with stem `generic_trunk_target.mk'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.w'.
    Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.mk.w'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `generic_trunk_target.mk.w'.
     Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.w,v'.
     Trying pattern rule with stem `generic_trunk_target.mk.w'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.w,v'.
     Trying pattern rule with stem `generic_trunk_target.mk.w'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.w'.
     Trying pattern rule with stem `generic_trunk_target.mk.w'.
     Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.mk.w'.
     Trying pattern rule with stem `generic_trunk_target.mk.w'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.mk.w'.
    Trying pattern rule with stem `generic_trunk_target.mk'.
    Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.mk.w'.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.cc'.
   Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.mk.cc'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `generic_trunk_target.mk.cc'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.cc,v'.
    Trying pattern rule with stem `generic_trunk_target.mk.cc'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.cc,v'.
    Trying pattern rule with stem `generic_trunk_target.mk.cc'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.cc'.
    Trying pattern rule with stem `generic_trunk_target.mk.cc'.
    Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.mk.cc'.
    Trying pattern rule with stem `generic_trunk_target.mk.cc'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.mk.cc'.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.C'.
   Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.mk.C'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `generic_trunk_target.mk.C'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.C,v'.
    Trying pattern rule with stem `generic_trunk_target.mk.C'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.C,v'.
    Trying pattern rule with stem `generic_trunk_target.mk.C'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.C'.
    Trying pattern rule with stem `generic_trunk_target.mk.C'.
    Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.mk.C'.
    Trying pattern rule with stem `generic_trunk_target.mk.C'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.mk.C'.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.cpp'.
   Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.mk.cpp'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `generic_trunk_target.mk.cpp'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.cpp,v'.
    Trying pattern rule with stem `generic_trunk_target.mk.cpp'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.cpp,v'.
    Trying pattern rule with stem `generic_trunk_target.mk.cpp'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.cpp'.
    Trying pattern rule with stem `generic_trunk_target.mk.cpp'.
    Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.mk.cpp'.
    Trying pattern rule with stem `generic_trunk_target.mk.cpp'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.mk.cpp'.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.p'.
   Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.mk.p'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `generic_trunk_target.mk'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.web'.
    Trying pattern rule with stem `generic_trunk_target.mk.p'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.p,v'.
    Trying pattern rule with stem `generic_trunk_target.mk.p'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.p,v'.
    Trying pattern rule with stem `generic_trunk_target.mk.p'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.p'.
    Trying pattern rule with stem `generic_trunk_target.mk.p'.
    Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.mk.p'.
    Trying pattern rule with stem `generic_trunk_target.mk.p'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.mk.p'.
    Trying pattern rule with stem `generic_trunk_target.mk'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.web'.
    Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.mk.web'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `generic_trunk_target.mk.web'.
     Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.web,v'.
     Trying pattern rule with stem `generic_trunk_target.mk.web'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.web,v'.
     Trying pattern rule with stem `generic_trunk_target.mk.web'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.web'.
     Trying pattern rule with stem `generic_trunk_target.mk.web'.
     Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.mk.web'.
     Trying pattern rule with stem `generic_trunk_target.mk.web'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.mk.web'.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.f'.
   Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.mk.f'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `generic_trunk_target.mk'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.F'.
    Trying pattern rule with stem `generic_trunk_target.mk'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.r'.
    Trying pattern rule with stem `generic_trunk_target.mk.f'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.f,v'.
    Trying pattern rule with stem `generic_trunk_target.mk.f'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.f,v'.
    Trying pattern rule with stem `generic_trunk_target.mk.f'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.f'.
    Trying pattern rule with stem `generic_trunk_target.mk.f'.
    Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.mk.f'.
    Trying pattern rule with stem `generic_trunk_target.mk.f'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.mk.f'.
    Trying pattern rule with stem `generic_trunk_target.mk'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.F'.
    Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.mk.F'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `generic_trunk_target.mk.F'.
     Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.F,v'.
     Trying pattern rule with stem `generic_trunk_target.mk.F'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.F,v'.
     Trying pattern rule with stem `generic_trunk_target.mk.F'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.F'.
     Trying pattern rule with stem `generic_trunk_target.mk.F'.
     Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.mk.F'.
     Trying pattern rule with stem `generic_trunk_target.mk.F'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.mk.F'.
    Trying pattern rule with stem `generic_trunk_target.mk'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.r'.
    Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.mk.r'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `generic_trunk_target.mk'.
     Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.mk.l'.
     Trying pattern rule with stem `generic_trunk_target.mk.r'.
     Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.r,v'.
     Trying pattern rule with stem `generic_trunk_target.mk.r'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.r,v'.
     Trying pattern rule with stem `generic_trunk_target.mk.r'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.r'.
     Trying pattern rule with stem `generic_trunk_target.mk.r'.
     Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.mk.r'.
     Trying pattern rule with stem `generic_trunk_target.mk.r'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.mk.r'.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.mk.F'.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.mk.r'.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.s'.
   Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.mk.s'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `generic_trunk_target.mk'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.S'.
    Trying pattern rule with stem `generic_trunk_target.mk.s'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.s,v'.
    Trying pattern rule with stem `generic_trunk_target.mk.s'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.s,v'.
    Trying pattern rule with stem `generic_trunk_target.mk.s'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.s'.
    Trying pattern rule with stem `generic_trunk_target.mk.s'.
    Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.mk.s'.
    Trying pattern rule with stem `generic_trunk_target.mk.s'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.mk.s'.
    Trying pattern rule with stem `generic_trunk_target.mk'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.S'.
    Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.mk.S'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `generic_trunk_target.mk.S'.
     Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.S,v'.
     Trying pattern rule with stem `generic_trunk_target.mk.S'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.S,v'.
     Trying pattern rule with stem `generic_trunk_target.mk.S'.
     Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.S'.
     Trying pattern rule with stem `generic_trunk_target.mk.S'.
     Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.mk.S'.
     Trying pattern rule with stem `generic_trunk_target.mk.S'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.mk.S'.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.mk.S'.
   Trying pattern rule with stem `generic_trunk_target.mk'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.mod'.
   Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.mk.mod'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `generic_trunk_target.mk.mod'.
    Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.mod,v'.
    Trying pattern rule with stem `generic_trunk_target.mk.mod'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.mod,v'.
    Trying pattern rule with stem `generic_trunk_target.mk.mod'.
    Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.mod'.
    Trying pattern rule with stem `generic_trunk_target.mk.mod'.
    Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.mk.mod'.
    Trying pattern rule with stem `generic_trunk_target.mk.mod'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.mk.mod'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.mk.c'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.mk.cc'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.mk.C'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.mk.cpp'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.mk.p'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.mk.f'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.mk.F'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.mk.r'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.mk.s'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.mk.S'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/generic_trunk_target.mk.mod'.
  Trying pattern rule with stem `generic_trunk_target.mk'.
  Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.sh'.
  Looking for a rule with intermediate file `../../include/mk/generic_trunk_target.mk.sh'.
   Avoiding implicit rule recursion.
   Trying pattern rule with stem `generic_trunk_target.mk.sh'.
   Trying implicit prerequisite `../../include/mk/generic_trunk_target.mk.sh,v'.
   Trying pattern rule with stem `generic_trunk_target.mk.sh'.
   Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.sh,v'.
   Trying pattern rule with stem `generic_trunk_target.mk.sh'.
   Trying implicit prerequisite `../../include/mk/RCS/generic_trunk_target.mk.sh'.
   Trying pattern rule with stem `generic_trunk_target.mk.sh'.
   Trying implicit prerequisite `../../include/mk/s.generic_trunk_target.mk.sh'.
   Trying pattern rule with stem `generic_trunk_target.mk.sh'.
   Trying implicit prerequisite `../../include/mk/SCCS/s.generic_trunk_target.mk.sh'.
  No implicit rule found for `../../include/mk/generic_trunk_target.mk'.
  Finished prerequisites of target file `../../include/mk/generic_trunk_target.mk'.
 No need to remake target `../../include/mk/generic_trunk_target.mk'.
 Pruning file `../../include/mk/functions.mk'.
 Considering target file `../../include/mk/env_pre.mk'.
  Looking for an implicit rule for `../../include/mk/env_pre.mk'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `../../include/mk/env_pre.mk.o'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `../../include/mk/env_pre.mk.c'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `../../include/mk/env_pre.mk.cc'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `../../include/mk/env_pre.mk.C'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `../../include/mk/env_pre.mk.cpp'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `../../include/mk/env_pre.mk.p'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `../../include/mk/env_pre.mk.f'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `../../include/mk/env_pre.mk.F'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `../../include/mk/env_pre.mk.r'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `../../include/mk/env_pre.mk.s'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `../../include/mk/env_pre.mk.S'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `../../include/mk/env_pre.mk.mod'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `../../include/mk/env_pre.mk.sh'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `../../include/mk/env_pre.mk,v'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk,v'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `../../include/mk/s.env_pre.mk'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `../../include/mk/SCCS/s.env_pre.mk'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `../../include/mk/env_pre.mk.o'.
  Looking for a rule with intermediate file `../../include/mk/env_pre.mk.o'.
   Avoiding implicit rule recursion.
   Trying pattern rule with stem `env_pre.mk'.
   Trying implicit prerequisite `../../include/mk/env_pre.mk.c'.
   Trying pattern rule with stem `env_pre.mk'.
   Trying implicit prerequisite `../../include/mk/env_pre.mk.cc'.
   Trying pattern rule with stem `env_pre.mk'.
   Trying implicit prerequisite `../../include/mk/env_pre.mk.C'.
   Trying pattern rule with stem `env_pre.mk'.
   Trying implicit prerequisite `../../include/mk/env_pre.mk.cpp'.
   Trying pattern rule with stem `env_pre.mk'.
   Trying implicit prerequisite `../../include/mk/env_pre.mk.p'.
   Trying pattern rule with stem `env_pre.mk'.
   Trying implicit prerequisite `../../include/mk/env_pre.mk.f'.
   Trying pattern rule with stem `env_pre.mk'.
   Trying implicit prerequisite `../../include/mk/env_pre.mk.F'.
   Trying pattern rule with stem `env_pre.mk'.
   Trying implicit prerequisite `../../include/mk/env_pre.mk.r'.
   Trying pattern rule with stem `env_pre.mk'.
   Trying implicit prerequisite `../../include/mk/env_pre.mk.s'.
   Trying pattern rule with stem `env_pre.mk'.
   Trying implicit prerequisite `../../include/mk/env_pre.mk.S'.
   Trying pattern rule with stem `env_pre.mk'.
   Trying implicit prerequisite `../../include/mk/env_pre.mk.mod'.
   Trying pattern rule with stem `env_pre.mk.o'.
   Trying implicit prerequisite `../../include/mk/env_pre.mk.o,v'.
   Trying pattern rule with stem `env_pre.mk.o'.
   Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.o,v'.
   Trying pattern rule with stem `env_pre.mk.o'.
   Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.o'.
   Trying pattern rule with stem `env_pre.mk.o'.
   Trying implicit prerequisite `../../include/mk/s.env_pre.mk.o'.
   Trying pattern rule with stem `env_pre.mk.o'.
   Trying implicit prerequisite `../../include/mk/SCCS/s.env_pre.mk.o'.
   Trying pattern rule with stem `env_pre.mk'.
   Trying implicit prerequisite `../../include/mk/env_pre.mk.c'.
   Looking for a rule with intermediate file `../../include/mk/env_pre.mk.c'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `env_pre.mk'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.y'.
    Trying pattern rule with stem `env_pre.mk'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.l'.
    Trying pattern rule with stem `env_pre.mk'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.w'.
    Trying pattern rule with stem `env_pre.mk'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.w'.
    Trying pattern rule with stem `env_pre.mk.c'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.c,v'.
    Trying pattern rule with stem `env_pre.mk.c'.
    Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.c,v'.
    Trying pattern rule with stem `env_pre.mk.c'.
    Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.c'.
    Trying pattern rule with stem `env_pre.mk.c'.
    Trying implicit prerequisite `../../include/mk/s.env_pre.mk.c'.
    Trying pattern rule with stem `env_pre.mk.c'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.env_pre.mk.c'.
    Trying pattern rule with stem `env_pre.mk'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.y'.
    Looking for a rule with intermediate file `../../include/mk/env_pre.mk.y'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `env_pre.mk.y'.
     Trying implicit prerequisite `../../include/mk/env_pre.mk.y,v'.
     Trying pattern rule with stem `env_pre.mk.y'.
     Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.y,v'.
     Trying pattern rule with stem `env_pre.mk.y'.
     Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.y'.
     Trying pattern rule with stem `env_pre.mk.y'.
     Trying implicit prerequisite `../../include/mk/s.env_pre.mk.y'.
     Trying pattern rule with stem `env_pre.mk.y'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.env_pre.mk.y'.
    Trying pattern rule with stem `env_pre.mk'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.l'.
    Looking for a rule with intermediate file `../../include/mk/env_pre.mk.l'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `env_pre.mk.l'.
     Trying implicit prerequisite `../../include/mk/env_pre.mk.l,v'.
     Trying pattern rule with stem `env_pre.mk.l'.
     Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.l,v'.
     Trying pattern rule with stem `env_pre.mk.l'.
     Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.l'.
     Trying pattern rule with stem `env_pre.mk.l'.
     Trying implicit prerequisite `../../include/mk/s.env_pre.mk.l'.
     Trying pattern rule with stem `env_pre.mk.l'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.env_pre.mk.l'.
    Trying pattern rule with stem `env_pre.mk'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.w'.
    Looking for a rule with intermediate file `../../include/mk/env_pre.mk.w'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `env_pre.mk.w'.
     Trying implicit prerequisite `../../include/mk/env_pre.mk.w,v'.
     Trying pattern rule with stem `env_pre.mk.w'.
     Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.w,v'.
     Trying pattern rule with stem `env_pre.mk.w'.
     Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.w'.
     Trying pattern rule with stem `env_pre.mk.w'.
     Trying implicit prerequisite `../../include/mk/s.env_pre.mk.w'.
     Trying pattern rule with stem `env_pre.mk.w'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.env_pre.mk.w'.
    Trying pattern rule with stem `env_pre.mk'.
    Rejecting impossible implicit prerequisite `../../include/mk/env_pre.mk.w'.
   Trying pattern rule with stem `env_pre.mk'.
   Trying implicit prerequisite `../../include/mk/env_pre.mk.cc'.
   Looking for a rule with intermediate file `../../include/mk/env_pre.mk.cc'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `env_pre.mk.cc'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.cc,v'.
    Trying pattern rule with stem `env_pre.mk.cc'.
    Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.cc,v'.
    Trying pattern rule with stem `env_pre.mk.cc'.
    Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.cc'.
    Trying pattern rule with stem `env_pre.mk.cc'.
    Trying implicit prerequisite `../../include/mk/s.env_pre.mk.cc'.
    Trying pattern rule with stem `env_pre.mk.cc'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.env_pre.mk.cc'.
   Trying pattern rule with stem `env_pre.mk'.
   Trying implicit prerequisite `../../include/mk/env_pre.mk.C'.
   Looking for a rule with intermediate file `../../include/mk/env_pre.mk.C'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `env_pre.mk.C'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.C,v'.
    Trying pattern rule with stem `env_pre.mk.C'.
    Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.C,v'.
    Trying pattern rule with stem `env_pre.mk.C'.
    Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.C'.
    Trying pattern rule with stem `env_pre.mk.C'.
    Trying implicit prerequisite `../../include/mk/s.env_pre.mk.C'.
    Trying pattern rule with stem `env_pre.mk.C'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.env_pre.mk.C'.
   Trying pattern rule with stem `env_pre.mk'.
   Trying implicit prerequisite `../../include/mk/env_pre.mk.cpp'.
   Looking for a rule with intermediate file `../../include/mk/env_pre.mk.cpp'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `env_pre.mk.cpp'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.cpp,v'.
    Trying pattern rule with stem `env_pre.mk.cpp'.
    Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.cpp,v'.
    Trying pattern rule with stem `env_pre.mk.cpp'.
    Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.cpp'.
    Trying pattern rule with stem `env_pre.mk.cpp'.
    Trying implicit prerequisite `../../include/mk/s.env_pre.mk.cpp'.
    Trying pattern rule with stem `env_pre.mk.cpp'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.env_pre.mk.cpp'.
   Trying pattern rule with stem `env_pre.mk'.
   Trying implicit prerequisite `../../include/mk/env_pre.mk.p'.
   Looking for a rule with intermediate file `../../include/mk/env_pre.mk.p'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `env_pre.mk'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.web'.
    Trying pattern rule with stem `env_pre.mk.p'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.p,v'.
    Trying pattern rule with stem `env_pre.mk.p'.
    Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.p,v'.
    Trying pattern rule with stem `env_pre.mk.p'.
    Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.p'.
    Trying pattern rule with stem `env_pre.mk.p'.
    Trying implicit prerequisite `../../include/mk/s.env_pre.mk.p'.
    Trying pattern rule with stem `env_pre.mk.p'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.env_pre.mk.p'.
    Trying pattern rule with stem `env_pre.mk'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.web'.
    Looking for a rule with intermediate file `../../include/mk/env_pre.mk.web'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `env_pre.mk.web'.
     Trying implicit prerequisite `../../include/mk/env_pre.mk.web,v'.
     Trying pattern rule with stem `env_pre.mk.web'.
     Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.web,v'.
     Trying pattern rule with stem `env_pre.mk.web'.
     Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.web'.
     Trying pattern rule with stem `env_pre.mk.web'.
     Trying implicit prerequisite `../../include/mk/s.env_pre.mk.web'.
     Trying pattern rule with stem `env_pre.mk.web'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.env_pre.mk.web'.
   Trying pattern rule with stem `env_pre.mk'.
   Trying implicit prerequisite `../../include/mk/env_pre.mk.f'.
   Looking for a rule with intermediate file `../../include/mk/env_pre.mk.f'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `env_pre.mk'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.F'.
    Trying pattern rule with stem `env_pre.mk'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.r'.
    Trying pattern rule with stem `env_pre.mk.f'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.f,v'.
    Trying pattern rule with stem `env_pre.mk.f'.
    Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.f,v'.
    Trying pattern rule with stem `env_pre.mk.f'.
    Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.f'.
    Trying pattern rule with stem `env_pre.mk.f'.
    Trying implicit prerequisite `../../include/mk/s.env_pre.mk.f'.
    Trying pattern rule with stem `env_pre.mk.f'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.env_pre.mk.f'.
    Trying pattern rule with stem `env_pre.mk'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.F'.
    Looking for a rule with intermediate file `../../include/mk/env_pre.mk.F'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `env_pre.mk.F'.
     Trying implicit prerequisite `../../include/mk/env_pre.mk.F,v'.
     Trying pattern rule with stem `env_pre.mk.F'.
     Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.F,v'.
     Trying pattern rule with stem `env_pre.mk.F'.
     Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.F'.
     Trying pattern rule with stem `env_pre.mk.F'.
     Trying implicit prerequisite `../../include/mk/s.env_pre.mk.F'.
     Trying pattern rule with stem `env_pre.mk.F'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.env_pre.mk.F'.
    Trying pattern rule with stem `env_pre.mk'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.r'.
    Looking for a rule with intermediate file `../../include/mk/env_pre.mk.r'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `env_pre.mk'.
     Rejecting impossible implicit prerequisite `../../include/mk/env_pre.mk.l'.
     Trying pattern rule with stem `env_pre.mk.r'.
     Trying implicit prerequisite `../../include/mk/env_pre.mk.r,v'.
     Trying pattern rule with stem `env_pre.mk.r'.
     Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.r,v'.
     Trying pattern rule with stem `env_pre.mk.r'.
     Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.r'.
     Trying pattern rule with stem `env_pre.mk.r'.
     Trying implicit prerequisite `../../include/mk/s.env_pre.mk.r'.
     Trying pattern rule with stem `env_pre.mk.r'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.env_pre.mk.r'.
   Trying pattern rule with stem `env_pre.mk'.
   Rejecting impossible implicit prerequisite `../../include/mk/env_pre.mk.F'.
   Trying pattern rule with stem `env_pre.mk'.
   Rejecting impossible implicit prerequisite `../../include/mk/env_pre.mk.r'.
   Trying pattern rule with stem `env_pre.mk'.
   Trying implicit prerequisite `../../include/mk/env_pre.mk.s'.
   Looking for a rule with intermediate file `../../include/mk/env_pre.mk.s'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `env_pre.mk'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.S'.
    Trying pattern rule with stem `env_pre.mk.s'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.s,v'.
    Trying pattern rule with stem `env_pre.mk.s'.
    Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.s,v'.
    Trying pattern rule with stem `env_pre.mk.s'.
    Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.s'.
    Trying pattern rule with stem `env_pre.mk.s'.
    Trying implicit prerequisite `../../include/mk/s.env_pre.mk.s'.
    Trying pattern rule with stem `env_pre.mk.s'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.env_pre.mk.s'.
    Trying pattern rule with stem `env_pre.mk'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.S'.
    Looking for a rule with intermediate file `../../include/mk/env_pre.mk.S'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `env_pre.mk.S'.
     Trying implicit prerequisite `../../include/mk/env_pre.mk.S,v'.
     Trying pattern rule with stem `env_pre.mk.S'.
     Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.S,v'.
     Trying pattern rule with stem `env_pre.mk.S'.
     Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.S'.
     Trying pattern rule with stem `env_pre.mk.S'.
     Trying implicit prerequisite `../../include/mk/s.env_pre.mk.S'.
     Trying pattern rule with stem `env_pre.mk.S'.
     Trying implicit prerequisite `../../include/mk/SCCS/s.env_pre.mk.S'.
   Trying pattern rule with stem `env_pre.mk'.
   Rejecting impossible implicit prerequisite `../../include/mk/env_pre.mk.S'.
   Trying pattern rule with stem `env_pre.mk'.
   Trying implicit prerequisite `../../include/mk/env_pre.mk.mod'.
   Looking for a rule with intermediate file `../../include/mk/env_pre.mk.mod'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `env_pre.mk.mod'.
    Trying implicit prerequisite `../../include/mk/env_pre.mk.mod,v'.
    Trying pattern rule with stem `env_pre.mk.mod'.
    Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.mod,v'.
    Trying pattern rule with stem `env_pre.mk.mod'.
    Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.mod'.
    Trying pattern rule with stem `env_pre.mk.mod'.
    Trying implicit prerequisite `../../include/mk/s.env_pre.mk.mod'.
    Trying pattern rule with stem `env_pre.mk.mod'.
    Trying implicit prerequisite `../../include/mk/SCCS/s.env_pre.mk.mod'.
  Trying pattern rule with stem `env_pre.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_pre.mk.c'.
  Trying pattern rule with stem `env_pre.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_pre.mk.cc'.
  Trying pattern rule with stem `env_pre.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_pre.mk.C'.
  Trying pattern rule with stem `env_pre.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_pre.mk.cpp'.
  Trying pattern rule with stem `env_pre.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_pre.mk.p'.
  Trying pattern rule with stem `env_pre.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_pre.mk.f'.
  Trying pattern rule with stem `env_pre.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_pre.mk.F'.
  Trying pattern rule with stem `env_pre.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_pre.mk.r'.
  Trying pattern rule with stem `env_pre.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_pre.mk.s'.
  Trying pattern rule with stem `env_pre.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_pre.mk.S'.
  Trying pattern rule with stem `env_pre.mk'.
  Rejecting impossible implicit prerequisite `../../include/mk/env_pre.mk.mod'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `../../include/mk/env_pre.mk.sh'.
  Looking for a rule with intermediate file `../../include/mk/env_pre.mk.sh'.
   Avoiding implicit rule recursion.
   Trying pattern rule with stem `env_pre.mk.sh'.
   Trying implicit prerequisite `../../include/mk/env_pre.mk.sh,v'.
   Trying pattern rule with stem `env_pre.mk.sh'.
   Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.sh,v'.
   Trying pattern rule with stem `env_pre.mk.sh'.
   Trying implicit prerequisite `../../include/mk/RCS/env_pre.mk.sh'.
   Trying pattern rule with stem `env_pre.mk.sh'.
   Trying implicit prerequisite `../../include/mk/s.env_pre.mk.sh'.
   Trying pattern rule with stem `env_pre.mk.sh'.
   Trying implicit prerequisite `../../include/mk/SCCS/s.env_pre.mk.sh'.
  No implicit rule found for `../../include/mk/env_pre.mk'.
  Finished prerequisites of target file `../../include/mk/env_pre.mk'.
 No need to remake target `../../include/mk/env_pre.mk'.
 Considering target file `Makefile'.
  Looking for an implicit rule for `Makefile'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `Makefile.o'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `Makefile.c'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `Makefile.cc'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `Makefile.C'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `Makefile.cpp'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `Makefile.p'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `Makefile.f'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `Makefile.F'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `Makefile.r'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `Makefile.s'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `Makefile.S'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `Makefile.mod'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `Makefile.sh'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `Makefile,v'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `RCS/Makefile,v'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `RCS/Makefile'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `s.Makefile'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `SCCS/s.Makefile'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `Makefile.o'.
  Looking for a rule with intermediate file `Makefile.o'.
   Avoiding implicit rule recursion.
   Trying pattern rule with stem `Makefile'.
   Trying implicit prerequisite `Makefile.c'.
   Trying pattern rule with stem `Makefile'.
   Trying implicit prerequisite `Makefile.cc'.
   Trying pattern rule with stem `Makefile'.
   Trying implicit prerequisite `Makefile.C'.
   Trying pattern rule with stem `Makefile'.
   Trying implicit prerequisite `Makefile.cpp'.
   Trying pattern rule with stem `Makefile'.
   Trying implicit prerequisite `Makefile.p'.
   Trying pattern rule with stem `Makefile'.
   Trying implicit prerequisite `Makefile.f'.
   Trying pattern rule with stem `Makefile'.
   Trying implicit prerequisite `Makefile.F'.
   Trying pattern rule with stem `Makefile'.
   Trying implicit prerequisite `Makefile.r'.
   Trying pattern rule with stem `Makefile'.
   Trying implicit prerequisite `Makefile.s'.
   Trying pattern rule with stem `Makefile'.
   Trying implicit prerequisite `Makefile.S'.
   Trying pattern rule with stem `Makefile'.
   Trying implicit prerequisite `Makefile.mod'.
   Trying pattern rule with stem `Makefile.o'.
   Trying implicit prerequisite `Makefile.o,v'.
   Trying pattern rule with stem `Makefile.o'.
   Trying implicit prerequisite `RCS/Makefile.o,v'.
   Trying pattern rule with stem `Makefile.o'.
   Trying implicit prerequisite `RCS/Makefile.o'.
   Trying pattern rule with stem `Makefile.o'.
   Trying implicit prerequisite `s.Makefile.o'.
   Trying pattern rule with stem `Makefile.o'.
   Trying implicit prerequisite `SCCS/s.Makefile.o'.
   Trying pattern rule with stem `Makefile'.
   Trying implicit prerequisite `Makefile.c'.
   Looking for a rule with intermediate file `Makefile.c'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `Makefile'.
    Trying implicit prerequisite `Makefile.y'.
    Trying pattern rule with stem `Makefile'.
    Trying implicit prerequisite `Makefile.l'.
    Trying pattern rule with stem `Makefile'.
    Trying implicit prerequisite `Makefile.w'.
    Trying pattern rule with stem `Makefile'.
    Trying implicit prerequisite `Makefile.w'.
    Trying pattern rule with stem `Makefile.c'.
    Trying implicit prerequisite `Makefile.c,v'.
    Trying pattern rule with stem `Makefile.c'.
    Trying implicit prerequisite `RCS/Makefile.c,v'.
    Trying pattern rule with stem `Makefile.c'.
    Trying implicit prerequisite `RCS/Makefile.c'.
    Trying pattern rule with stem `Makefile.c'.
    Trying implicit prerequisite `s.Makefile.c'.
    Trying pattern rule with stem `Makefile.c'.
    Trying implicit prerequisite `SCCS/s.Makefile.c'.
    Trying pattern rule with stem `Makefile'.
    Trying implicit prerequisite `Makefile.y'.
    Looking for a rule with intermediate file `Makefile.y'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `Makefile.y'.
     Trying implicit prerequisite `Makefile.y,v'.
     Trying pattern rule with stem `Makefile.y'.
     Trying implicit prerequisite `RCS/Makefile.y,v'.
     Trying pattern rule with stem `Makefile.y'.
     Trying implicit prerequisite `RCS/Makefile.y'.
     Trying pattern rule with stem `Makefile.y'.
     Trying implicit prerequisite `s.Makefile.y'.
     Trying pattern rule with stem `Makefile.y'.
     Trying implicit prerequisite `SCCS/s.Makefile.y'.
    Trying pattern rule with stem `Makefile'.
    Trying implicit prerequisite `Makefile.l'.
    Looking for a rule with intermediate file `Makefile.l'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `Makefile.l'.
     Trying implicit prerequisite `Makefile.l,v'.
     Trying pattern rule with stem `Makefile.l'.
     Trying implicit prerequisite `RCS/Makefile.l,v'.
     Trying pattern rule with stem `Makefile.l'.
     Trying implicit prerequisite `RCS/Makefile.l'.
     Trying pattern rule with stem `Makefile.l'.
     Trying implicit prerequisite `s.Makefile.l'.
     Trying pattern rule with stem `Makefile.l'.
     Trying implicit prerequisite `SCCS/s.Makefile.l'.
    Trying pattern rule with stem `Makefile'.
    Trying implicit prerequisite `Makefile.w'.
    Looking for a rule with intermediate file `Makefile.w'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `Makefile.w'.
     Trying implicit prerequisite `Makefile.w,v'.
     Trying pattern rule with stem `Makefile.w'.
     Trying implicit prerequisite `RCS/Makefile.w,v'.
     Trying pattern rule with stem `Makefile.w'.
     Trying implicit prerequisite `RCS/Makefile.w'.
     Trying pattern rule with stem `Makefile.w'.
     Trying implicit prerequisite `s.Makefile.w'.
     Trying pattern rule with stem `Makefile.w'.
     Trying implicit prerequisite `SCCS/s.Makefile.w'.
    Trying pattern rule with stem `Makefile'.
    Rejecting impossible implicit prerequisite `Makefile.w'.
   Trying pattern rule with stem `Makefile'.
   Trying implicit prerequisite `Makefile.cc'.
   Looking for a rule with intermediate file `Makefile.cc'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `Makefile.cc'.
    Trying implicit prerequisite `Makefile.cc,v'.
    Trying pattern rule with stem `Makefile.cc'.
    Trying implicit prerequisite `RCS/Makefile.cc,v'.
    Trying pattern rule with stem `Makefile.cc'.
    Trying implicit prerequisite `RCS/Makefile.cc'.
    Trying pattern rule with stem `Makefile.cc'.
    Trying implicit prerequisite `s.Makefile.cc'.
    Trying pattern rule with stem `Makefile.cc'.
    Trying implicit prerequisite `SCCS/s.Makefile.cc'.
   Trying pattern rule with stem `Makefile'.
   Trying implicit prerequisite `Makefile.C'.
   Looking for a rule with intermediate file `Makefile.C'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `Makefile.C'.
    Trying implicit prerequisite `Makefile.C,v'.
    Trying pattern rule with stem `Makefile.C'.
    Trying implicit prerequisite `RCS/Makefile.C,v'.
    Trying pattern rule with stem `Makefile.C'.
    Trying implicit prerequisite `RCS/Makefile.C'.
    Trying pattern rule with stem `Makefile.C'.
    Trying implicit prerequisite `s.Makefile.C'.
    Trying pattern rule with stem `Makefile.C'.
    Trying implicit prerequisite `SCCS/s.Makefile.C'.
   Trying pattern rule with stem `Makefile'.
   Trying implicit prerequisite `Makefile.cpp'.
   Looking for a rule with intermediate file `Makefile.cpp'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `Makefile.cpp'.
    Trying implicit prerequisite `Makefile.cpp,v'.
    Trying pattern rule with stem `Makefile.cpp'.
    Trying implicit prerequisite `RCS/Makefile.cpp,v'.
    Trying pattern rule with stem `Makefile.cpp'.
    Trying implicit prerequisite `RCS/Makefile.cpp'.
    Trying pattern rule with stem `Makefile.cpp'.
    Trying implicit prerequisite `s.Makefile.cpp'.
    Trying pattern rule with stem `Makefile.cpp'.
    Trying implicit prerequisite `SCCS/s.Makefile.cpp'.
   Trying pattern rule with stem `Makefile'.
   Trying implicit prerequisite `Makefile.p'.
   Looking for a rule with intermediate file `Makefile.p'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `Makefile'.
    Trying implicit prerequisite `Makefile.web'.
    Trying pattern rule with stem `Makefile.p'.
    Trying implicit prerequisite `Makefile.p,v'.
    Trying pattern rule with stem `Makefile.p'.
    Trying implicit prerequisite `RCS/Makefile.p,v'.
    Trying pattern rule with stem `Makefile.p'.
    Trying implicit prerequisite `RCS/Makefile.p'.
    Trying pattern rule with stem `Makefile.p'.
    Trying implicit prerequisite `s.Makefile.p'.
    Trying pattern rule with stem `Makefile.p'.
    Trying implicit prerequisite `SCCS/s.Makefile.p'.
    Trying pattern rule with stem `Makefile'.
    Trying implicit prerequisite `Makefile.web'.
    Looking for a rule with intermediate file `Makefile.web'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `Makefile.web'.
     Trying implicit prerequisite `Makefile.web,v'.
     Trying pattern rule with stem `Makefile.web'.
     Trying implicit prerequisite `RCS/Makefile.web,v'.
     Trying pattern rule with stem `Makefile.web'.
     Trying implicit prerequisite `RCS/Makefile.web'.
     Trying pattern rule with stem `Makefile.web'.
     Trying implicit prerequisite `s.Makefile.web'.
     Trying pattern rule with stem `Makefile.web'.
     Trying implicit prerequisite `SCCS/s.Makefile.web'.
   Trying pattern rule with stem `Makefile'.
   Trying implicit prerequisite `Makefile.f'.
   Looking for a rule with intermediate file `Makefile.f'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `Makefile'.
    Trying implicit prerequisite `Makefile.F'.
    Trying pattern rule with stem `Makefile'.
    Trying implicit prerequisite `Makefile.r'.
    Trying pattern rule with stem `Makefile.f'.
    Trying implicit prerequisite `Makefile.f,v'.
    Trying pattern rule with stem `Makefile.f'.
    Trying implicit prerequisite `RCS/Makefile.f,v'.
    Trying pattern rule with stem `Makefile.f'.
    Trying implicit prerequisite `RCS/Makefile.f'.
    Trying pattern rule with stem `Makefile.f'.
    Trying implicit prerequisite `s.Makefile.f'.
    Trying pattern rule with stem `Makefile.f'.
    Trying implicit prerequisite `SCCS/s.Makefile.f'.
    Trying pattern rule with stem `Makefile'.
    Trying implicit prerequisite `Makefile.F'.
    Looking for a rule with intermediate file `Makefile.F'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `Makefile.F'.
     Trying implicit prerequisite `Makefile.F,v'.
     Trying pattern rule with stem `Makefile.F'.
     Trying implicit prerequisite `RCS/Makefile.F,v'.
     Trying pattern rule with stem `Makefile.F'.
     Trying implicit prerequisite `RCS/Makefile.F'.
     Trying pattern rule with stem `Makefile.F'.
     Trying implicit prerequisite `s.Makefile.F'.
     Trying pattern rule with stem `Makefile.F'.
     Trying implicit prerequisite `SCCS/s.Makefile.F'.
    Trying pattern rule with stem `Makefile'.
    Trying implicit prerequisite `Makefile.r'.
    Looking for a rule with intermediate file `Makefile.r'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `Makefile'.
     Rejecting impossible implicit prerequisite `Makefile.l'.
     Trying pattern rule with stem `Makefile.r'.
     Trying implicit prerequisite `Makefile.r,v'.
     Trying pattern rule with stem `Makefile.r'.
     Trying implicit prerequisite `RCS/Makefile.r,v'.
     Trying pattern rule with stem `Makefile.r'.
     Trying implicit prerequisite `RCS/Makefile.r'.
     Trying pattern rule with stem `Makefile.r'.
     Trying implicit prerequisite `s.Makefile.r'.
     Trying pattern rule with stem `Makefile.r'.
     Trying implicit prerequisite `SCCS/s.Makefile.r'.
   Trying pattern rule with stem `Makefile'.
   Rejecting impossible implicit prerequisite `Makefile.F'.
   Trying pattern rule with stem `Makefile'.
   Rejecting impossible implicit prerequisite `Makefile.r'.
   Trying pattern rule with stem `Makefile'.
   Trying implicit prerequisite `Makefile.s'.
   Looking for a rule with intermediate file `Makefile.s'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `Makefile'.
    Trying implicit prerequisite `Makefile.S'.
    Trying pattern rule with stem `Makefile.s'.
    Trying implicit prerequisite `Makefile.s,v'.
    Trying pattern rule with stem `Makefile.s'.
    Trying implicit prerequisite `RCS/Makefile.s,v'.
    Trying pattern rule with stem `Makefile.s'.
    Trying implicit prerequisite `RCS/Makefile.s'.
    Trying pattern rule with stem `Makefile.s'.
    Trying implicit prerequisite `s.Makefile.s'.
    Trying pattern rule with stem `Makefile.s'.
    Trying implicit prerequisite `SCCS/s.Makefile.s'.
    Trying pattern rule with stem `Makefile'.
    Trying implicit prerequisite `Makefile.S'.
    Looking for a rule with intermediate file `Makefile.S'.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Avoiding implicit rule recursion.
     Trying pattern rule with stem `Makefile.S'.
     Trying implicit prerequisite `Makefile.S,v'.
     Trying pattern rule with stem `Makefile.S'.
     Trying implicit prerequisite `RCS/Makefile.S,v'.
     Trying pattern rule with stem `Makefile.S'.
     Trying implicit prerequisite `RCS/Makefile.S'.
     Trying pattern rule with stem `Makefile.S'.
     Trying implicit prerequisite `s.Makefile.S'.
     Trying pattern rule with stem `Makefile.S'.
     Trying implicit prerequisite `SCCS/s.Makefile.S'.
   Trying pattern rule with stem `Makefile'.
   Rejecting impossible implicit prerequisite `Makefile.S'.
   Trying pattern rule with stem `Makefile'.
   Trying implicit prerequisite `Makefile.mod'.
   Looking for a rule with intermediate file `Makefile.mod'.
    Avoiding implicit rule recursion.
    Avoiding implicit rule recursion.
    Trying pattern rule with stem `Makefile.mod'.
    Trying implicit prerequisite `Makefile.mod,v'.
    Trying pattern rule with stem `Makefile.mod'.
    Trying implicit prerequisite `RCS/Makefile.mod,v'.
    Trying pattern rule with stem `Makefile.mod'.
    Trying implicit prerequisite `RCS/Makefile.mod'.
    Trying pattern rule with stem `Makefile.mod'.
    Trying implicit prerequisite `s.Makefile.mod'.
    Trying pattern rule with stem `Makefile.mod'.
    Trying implicit prerequisite `SCCS/s.Makefile.mod'.
  Trying pattern rule with stem `Makefile'.
  Rejecting impossible implicit prerequisite `Makefile.c'.
  Trying pattern rule with stem `Makefile'.
  Rejecting impossible implicit prerequisite `Makefile.cc'.
  Trying pattern rule with stem `Makefile'.
  Rejecting impossible implicit prerequisite `Makefile.C'.
  Trying pattern rule with stem `Makefile'.
  Rejecting impossible implicit prerequisite `Makefile.cpp'.
  Trying pattern rule with stem `Makefile'.
  Rejecting impossible implicit prerequisite `Makefile.p'.
  Trying pattern rule with stem `Makefile'.
  Rejecting impossible implicit prerequisite `Makefile.f'.
  Trying pattern rule with stem `Makefile'.
  Rejecting impossible implicit prerequisite `Makefile.F'.
  Trying pattern rule with stem `Makefile'.
  Rejecting impossible implicit prerequisite `Makefile.r'.
  Trying pattern rule with stem `Makefile'.
  Rejecting impossible implicit prerequisite `Makefile.s'.
  Trying pattern rule with stem `Makefile'.
  Rejecting impossible implicit prerequisite `Makefile.S'.
  Trying pattern rule with stem `Makefile'.
  Rejecting impossible implicit prerequisite `Makefile.mod'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `Makefile.sh'.
  Looking for a rule with intermediate file `Makefile.sh'.
   Avoiding implicit rule recursion.
   Trying pattern rule with stem `Makefile.sh'.
   Trying implicit prerequisite `Makefile.sh,v'.
   Trying pattern rule with stem `Makefile.sh'.
   Trying implicit prerequisite `RCS/Makefile.sh,v'.
   Trying pattern rule with stem `Makefile.sh'.
   Trying implicit prerequisite `RCS/Makefile.sh'.
   Trying pattern rule with stem `Makefile.sh'.
   Trying implicit prerequisite `s.Makefile.sh'.
   Trying pattern rule with stem `Makefile.sh'.
   Trying implicit prerequisite `SCCS/s.Makefile.sh'.
  No implicit rule found for `Makefile'.
  Finished prerequisites of target file `Makefile'.
 No need to remake target `Makefile'.
Updating goal targets....
Considering target file `autotools'.
 File `autotools' does not exist.
  Considering target file `aclocal'.
   File `aclocal' does not exist.
   Finished prerequisites of target file `aclocal'.
  Must remake target `aclocal'.
  Successfully remade target file `aclocal'.
  Considering target file `autoconf'.
   File `autoconf' does not exist.
    Considering target file `configure'.
      Considering target file `configure.in'.
       Looking for an implicit rule for `configure.in'.
       Trying pattern rule with stem `configure.in'.
       Trying implicit prerequisite `configure.in.o'.
       Trying pattern rule with stem `configure.in'.
       Trying implicit prerequisite `configure.in.c'.
       Trying pattern rule with stem `configure.in'.
       Trying implicit prerequisite `configure.in.cc'.
       Trying pattern rule with stem `configure.in'.
       Trying implicit prerequisite `configure.in.C'.
       Trying pattern rule with stem `configure.in'.
       Trying implicit prerequisite `configure.in.cpp'.
       Trying pattern rule with stem `configure.in'.
       Trying implicit prerequisite `configure.in.p'.
       Trying pattern rule with stem `configure.in'.
       Trying implicit prerequisite `configure.in.f'.
       Trying pattern rule with stem `configure.in'.
       Trying implicit prerequisite `configure.in.F'.
       Trying pattern rule with stem `configure.in'.
       Trying implicit prerequisite `configure.in.r'.
       Trying pattern rule with stem `configure.in'.
       Trying implicit prerequisite `configure.in.s'.
       Trying pattern rule with stem `configure.in'.
       Trying implicit prerequisite `configure.in.S'.
       Trying pattern rule with stem `configure.in'.
       Trying implicit prerequisite `configure.in.mod'.
       Trying pattern rule with stem `configure.in'.
       Trying implicit prerequisite `configure.in.sh'.
       Trying pattern rule with stem `configure.in'.
       Trying implicit prerequisite `configure.in,v'.
       Trying pattern rule with stem `configure.in'.
       Trying implicit prerequisite `RCS/configure.in,v'.
       Trying pattern rule with stem `configure.in'.
       Trying implicit prerequisite `RCS/configure.in'.
       Trying pattern rule with stem `configure.in'.
       Trying implicit prerequisite `s.configure.in'.
       Trying pattern rule with stem `configure.in'.
       Trying implicit prerequisite `SCCS/s.configure.in'.
       Trying pattern rule with stem `configure.in'.
       Trying implicit prerequisite `configure.in.o'.
       Looking for a rule with intermediate file `configure.in.o'.
        Avoiding implicit rule recursion.
        Trying pattern rule with stem `configure.in'.
        Trying implicit prerequisite `configure.in.c'.
        Trying pattern rule with stem `configure.in'.
        Trying implicit prerequisite `configure.in.cc'.
        Trying pattern rule with stem `configure.in'.
        Trying implicit prerequisite `configure.in.C'.
        Trying pattern rule with stem `configure.in'.
        Trying implicit prerequisite `configure.in.cpp'.
        Trying pattern rule with stem `configure.in'.
        Trying implicit prerequisite `configure.in.p'.
        Trying pattern rule with stem `configure.in'.
        Trying implicit prerequisite `configure.in.f'.
        Trying pattern rule with stem `configure.in'.
        Trying implicit prerequisite `configure.in.F'.
        Trying pattern rule with stem `configure.in'.
        Trying implicit prerequisite `configure.in.r'.
        Trying pattern rule with stem `configure.in'.
        Trying implicit prerequisite `configure.in.s'.
        Trying pattern rule with stem `configure.in'.
        Trying implicit prerequisite `configure.in.S'.
        Trying pattern rule with stem `configure.in'.
        Trying implicit prerequisite `configure.in.mod'.
        Trying pattern rule with stem `configure.in.o'.
        Trying implicit prerequisite `configure.in.o,v'.
        Trying pattern rule with stem `configure.in.o'.
        Trying implicit prerequisite `RCS/configure.in.o,v'.
        Trying pattern rule with stem `configure.in.o'.
        Trying implicit prerequisite `RCS/configure.in.o'.
        Trying pattern rule with stem `configure.in.o'.
        Trying implicit prerequisite `s.configure.in.o'.
        Trying pattern rule with stem `configure.in.o'.
        Trying implicit prerequisite `SCCS/s.configure.in.o'.
        Trying pattern rule with stem `configure.in'.
        Trying implicit prerequisite `configure.in.c'.
        Looking for a rule with intermediate file `configure.in.c'.
         Avoiding implicit rule recursion.
         Avoiding implicit rule recursion.
         Trying pattern rule with stem `configure.in'.
         Trying implicit prerequisite `configure.in.y'.
         Trying pattern rule with stem `configure.in'.
         Trying implicit prerequisite `configure.in.l'.
         Trying pattern rule with stem `configure.in'.
         Trying implicit prerequisite `configure.in.w'.
         Trying pattern rule with stem `configure.in'.
         Trying implicit prerequisite `configure.in.w'.
         Trying pattern rule with stem `configure.in.c'.
         Trying implicit prerequisite `configure.in.c,v'.
         Trying pattern rule with stem `configure.in.c'.
         Trying implicit prerequisite `RCS/configure.in.c,v'.
         Trying pattern rule with stem `configure.in.c'.
         Trying implicit prerequisite `RCS/configure.in.c'.
         Trying pattern rule with stem `configure.in.c'.
         Trying implicit prerequisite `s.configure.in.c'.
         Trying pattern rule with stem `configure.in.c'.
         Trying implicit prerequisite `SCCS/s.configure.in.c'.
         Trying pattern rule with stem `configure.in'.
         Trying implicit prerequisite `configure.in.y'.
         Looking for a rule with intermediate file `configure.in.y'.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Trying pattern rule with stem `configure.in.y'.
          Trying implicit prerequisite `configure.in.y,v'.
          Trying pattern rule with stem `configure.in.y'.
          Trying implicit prerequisite `RCS/configure.in.y,v'.
          Trying pattern rule with stem `configure.in.y'.
          Trying implicit prerequisite `RCS/configure.in.y'.
          Trying pattern rule with stem `configure.in.y'.
          Trying implicit prerequisite `s.configure.in.y'.
          Trying pattern rule with stem `configure.in.y'.
          Trying implicit prerequisite `SCCS/s.configure.in.y'.
         Trying pattern rule with stem `configure.in'.
         Trying implicit prerequisite `configure.in.l'.
         Looking for a rule with intermediate file `configure.in.l'.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Trying pattern rule with stem `configure.in.l'.
          Trying implicit prerequisite `configure.in.l,v'.
          Trying pattern rule with stem `configure.in.l'.
          Trying implicit prerequisite `RCS/configure.in.l,v'.
          Trying pattern rule with stem `configure.in.l'.
          Trying implicit prerequisite `RCS/configure.in.l'.
          Trying pattern rule with stem `configure.in.l'.
          Trying implicit prerequisite `s.configure.in.l'.
          Trying pattern rule with stem `configure.in.l'.
          Trying implicit prerequisite `SCCS/s.configure.in.l'.
         Trying pattern rule with stem `configure.in'.
         Trying implicit prerequisite `configure.in.w'.
         Looking for a rule with intermediate file `configure.in.w'.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Trying pattern rule with stem `configure.in.w'.
          Trying implicit prerequisite `configure.in.w,v'.
          Trying pattern rule with stem `configure.in.w'.
          Trying implicit prerequisite `RCS/configure.in.w,v'.
          Trying pattern rule with stem `configure.in.w'.
          Trying implicit prerequisite `RCS/configure.in.w'.
          Trying pattern rule with stem `configure.in.w'.
          Trying implicit prerequisite `s.configure.in.w'.
          Trying pattern rule with stem `configure.in.w'.
          Trying implicit prerequisite `SCCS/s.configure.in.w'.
         Trying pattern rule with stem `configure.in'.
         Rejecting impossible implicit prerequisite `configure.in.w'.
        Trying pattern rule with stem `configure.in'.
        Trying implicit prerequisite `configure.in.cc'.
        Looking for a rule with intermediate file `configure.in.cc'.
         Avoiding implicit rule recursion.
         Avoiding implicit rule recursion.
         Trying pattern rule with stem `configure.in.cc'.
         Trying implicit prerequisite `configure.in.cc,v'.
         Trying pattern rule with stem `configure.in.cc'.
         Trying implicit prerequisite `RCS/configure.in.cc,v'.
         Trying pattern rule with stem `configure.in.cc'.
         Trying implicit prerequisite `RCS/configure.in.cc'.
         Trying pattern rule with stem `configure.in.cc'.
         Trying implicit prerequisite `s.configure.in.cc'.
         Trying pattern rule with stem `configure.in.cc'.
         Trying implicit prerequisite `SCCS/s.configure.in.cc'.
        Trying pattern rule with stem `configure.in'.
        Trying implicit prerequisite `configure.in.C'.
        Looking for a rule with intermediate file `configure.in.C'.
         Avoiding implicit rule recursion.
         Avoiding implicit rule recursion.
         Trying pattern rule with stem `configure.in.C'.
         Trying implicit prerequisite `configure.in.C,v'.
         Trying pattern rule with stem `configure.in.C'.
         Trying implicit prerequisite `RCS/configure.in.C,v'.
         Trying pattern rule with stem `configure.in.C'.
         Trying implicit prerequisite `RCS/configure.in.C'.
         Trying pattern rule with stem `configure.in.C'.
         Trying implicit prerequisite `s.configure.in.C'.
         Trying pattern rule with stem `configure.in.C'.
         Trying implicit prerequisite `SCCS/s.configure.in.C'.
        Trying pattern rule with stem `configure.in'.
        Trying implicit prerequisite `configure.in.cpp'.
        Looking for a rule with intermediate file `configure.in.cpp'.
         Avoiding implicit rule recursion.
         Avoiding implicit rule recursion.
         Trying pattern rule with stem `configure.in.cpp'.
         Trying implicit prerequisite `configure.in.cpp,v'.
         Trying pattern rule with stem `configure.in.cpp'.
         Trying implicit prerequisite `RCS/configure.in.cpp,v'.
         Trying pattern rule with stem `configure.in.cpp'.
         Trying implicit prerequisite `RCS/configure.in.cpp'.
         Trying pattern rule with stem `configure.in.cpp'.
         Trying implicit prerequisite `s.configure.in.cpp'.
         Trying pattern rule with stem `configure.in.cpp'.
         Trying implicit prerequisite `SCCS/s.configure.in.cpp'.
        Trying pattern rule with stem `configure.in'.
        Trying implicit prerequisite `configure.in.p'.
        Looking for a rule with intermediate file `configure.in.p'.
         Avoiding implicit rule recursion.
         Avoiding implicit rule recursion.
         Trying pattern rule with stem `configure.in'.
         Trying implicit prerequisite `configure.in.web'.
         Trying pattern rule with stem `configure.in.p'.
         Trying implicit prerequisite `configure.in.p,v'.
         Trying pattern rule with stem `configure.in.p'.
         Trying implicit prerequisite `RCS/configure.in.p,v'.
         Trying pattern rule with stem `configure.in.p'.
         Trying implicit prerequisite `RCS/configure.in.p'.
         Trying pattern rule with stem `configure.in.p'.
         Trying implicit prerequisite `s.configure.in.p'.
         Trying pattern rule with stem `configure.in.p'.
         Trying implicit prerequisite `SCCS/s.configure.in.p'.
         Trying pattern rule with stem `configure.in'.
         Trying implicit prerequisite `configure.in.web'.
         Looking for a rule with intermediate file `configure.in.web'.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Trying pattern rule with stem `configure.in.web'.
          Trying implicit prerequisite `configure.in.web,v'.
          Trying pattern rule with stem `configure.in.web'.
          Trying implicit prerequisite `RCS/configure.in.web,v'.
          Trying pattern rule with stem `configure.in.web'.
          Trying implicit prerequisite `RCS/configure.in.web'.
          Trying pattern rule with stem `configure.in.web'.
          Trying implicit prerequisite `s.configure.in.web'.
          Trying pattern rule with stem `configure.in.web'.
          Trying implicit prerequisite `SCCS/s.configure.in.web'.
        Trying pattern rule with stem `configure.in'.
        Trying implicit prerequisite `configure.in.f'.
        Looking for a rule with intermediate file `configure.in.f'.
         Avoiding implicit rule recursion.
         Avoiding implicit rule recursion.
         Trying pattern rule with stem `configure.in'.
         Trying implicit prerequisite `configure.in.F'.
         Trying pattern rule with stem `configure.in'.
         Trying implicit prerequisite `configure.in.r'.
         Trying pattern rule with stem `configure.in.f'.
         Trying implicit prerequisite `configure.in.f,v'.
         Trying pattern rule with stem `configure.in.f'.
         Trying implicit prerequisite `RCS/configure.in.f,v'.
         Trying pattern rule with stem `configure.in.f'.
         Trying implicit prerequisite `RCS/configure.in.f'.
         Trying pattern rule with stem `configure.in.f'.
         Trying implicit prerequisite `s.configure.in.f'.
         Trying pattern rule with stem `configure.in.f'.
         Trying implicit prerequisite `SCCS/s.configure.in.f'.
         Trying pattern rule with stem `configure.in'.
         Trying implicit prerequisite `configure.in.F'.
         Looking for a rule with intermediate file `configure.in.F'.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Trying pattern rule with stem `configure.in.F'.
          Trying implicit prerequisite `configure.in.F,v'.
          Trying pattern rule with stem `configure.in.F'.
          Trying implicit prerequisite `RCS/configure.in.F,v'.
          Trying pattern rule with stem `configure.in.F'.
          Trying implicit prerequisite `RCS/configure.in.F'.
          Trying pattern rule with stem `configure.in.F'.
          Trying implicit prerequisite `s.configure.in.F'.
          Trying pattern rule with stem `configure.in.F'.
          Trying implicit prerequisite `SCCS/s.configure.in.F'.
         Trying pattern rule with stem `configure.in'.
         Trying implicit prerequisite `configure.in.r'.
         Looking for a rule with intermediate file `configure.in.r'.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Trying pattern rule with stem `configure.in'.
          Rejecting impossible implicit prerequisite `configure.in.l'.
          Trying pattern rule with stem `configure.in.r'.
          Trying implicit prerequisite `configure.in.r,v'.
          Trying pattern rule with stem `configure.in.r'.
          Trying implicit prerequisite `RCS/configure.in.r,v'.
          Trying pattern rule with stem `configure.in.r'.
          Trying implicit prerequisite `RCS/configure.in.r'.
          Trying pattern rule with stem `configure.in.r'.
          Trying implicit prerequisite `s.configure.in.r'.
          Trying pattern rule with stem `configure.in.r'.
          Trying implicit prerequisite `SCCS/s.configure.in.r'.
        Trying pattern rule with stem `configure.in'.
        Rejecting impossible implicit prerequisite `configure.in.F'.
        Trying pattern rule with stem `configure.in'.
        Rejecting impossible implicit prerequisite `configure.in.r'.
        Trying pattern rule with stem `configure.in'.
        Trying implicit prerequisite `configure.in.s'.
        Looking for a rule with intermediate file `configure.in.s'.
         Avoiding implicit rule recursion.
         Avoiding implicit rule recursion.
         Trying pattern rule with stem `configure.in'.
         Trying implicit prerequisite `configure.in.S'.
         Trying pattern rule with stem `configure.in.s'.
         Trying implicit prerequisite `configure.in.s,v'.
         Trying pattern rule with stem `configure.in.s'.
         Trying implicit prerequisite `RCS/configure.in.s,v'.
         Trying pattern rule with stem `configure.in.s'.
         Trying implicit prerequisite `RCS/configure.in.s'.
         Trying pattern rule with stem `configure.in.s'.
         Trying implicit prerequisite `s.configure.in.s'.
         Trying pattern rule with stem `configure.in.s'.
         Trying implicit prerequisite `SCCS/s.configure.in.s'.
         Trying pattern rule with stem `configure.in'.
         Trying implicit prerequisite `configure.in.S'.
         Looking for a rule with intermediate file `configure.in.S'.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Trying pattern rule with stem `configure.in.S'.
          Trying implicit prerequisite `configure.in.S,v'.
          Trying pattern rule with stem `configure.in.S'.
          Trying implicit prerequisite `RCS/configure.in.S,v'.
          Trying pattern rule with stem `configure.in.S'.
          Trying implicit prerequisite `RCS/configure.in.S'.
          Trying pattern rule with stem `configure.in.S'.
          Trying implicit prerequisite `s.configure.in.S'.
          Trying pattern rule with stem `configure.in.S'.
          Trying implicit prerequisite `SCCS/s.configure.in.S'.
        Trying pattern rule with stem `configure.in'.
        Rejecting impossible implicit prerequisite `configure.in.S'.
        Trying pattern rule with stem `configure.in'.
        Trying implicit prerequisite `configure.in.mod'.
        Looking for a rule with intermediate file `configure.in.mod'.
         Avoiding implicit rule recursion.
         Avoiding implicit rule recursion.
         Trying pattern rule with stem `configure.in.mod'.
         Trying implicit prerequisite `configure.in.mod,v'.
         Trying pattern rule with stem `configure.in.mod'.
         Trying implicit prerequisite `RCS/configure.in.mod,v'.
         Trying pattern rule with stem `configure.in.mod'.
         Trying implicit prerequisite `RCS/configure.in.mod'.
         Trying pattern rule with stem `configure.in.mod'.
         Trying implicit prerequisite `s.configure.in.mod'.
         Trying pattern rule with stem `configure.in.mod'.
         Trying implicit prerequisite `SCCS/s.configure.in.mod'.
       Trying pattern rule with stem `configure.in'.
       Rejecting impossible implicit prerequisite `configure.in.c'.
       Trying pattern rule with stem `configure.in'.
       Rejecting impossible implicit prerequisite `configure.in.cc'.
       Trying pattern rule with stem `configure.in'.
       Rejecting impossible implicit prerequisite `configure.in.C'.
       Trying pattern rule with stem `configure.in'.
       Rejecting impossible implicit prerequisite `configure.in.cpp'.
       Trying pattern rule with stem `configure.in'.
       Rejecting impossible implicit prerequisite `configure.in.p'.
       Trying pattern rule with stem `configure.in'.
       Rejecting impossible implicit prerequisite `configure.in.f'.
       Trying pattern rule with stem `configure.in'.
       Rejecting impossible implicit prerequisite `configure.in.F'.
       Trying pattern rule with stem `configure.in'.
       Rejecting impossible implicit prerequisite `configure.in.r'.
       Trying pattern rule with stem `configure.in'.
       Rejecting impossible implicit prerequisite `configure.in.s'.
       Trying pattern rule with stem `configure.in'.
       Rejecting impossible implicit prerequisite `configure.in.S'.
       Trying pattern rule with stem `configure.in'.
       Rejecting impossible implicit prerequisite `configure.in.mod'.
       Trying pattern rule with stem `configure.in'.
       Trying implicit prerequisite `configure.in.sh'.
       Looking for a rule with intermediate file `configure.in.sh'.
        Avoiding implicit rule recursion.
        Trying pattern rule with stem `configure.in.sh'.
        Trying implicit prerequisite `configure.in.sh,v'.
        Trying pattern rule with stem `configure.in.sh'.
        Trying implicit prerequisite `RCS/configure.in.sh,v'.
        Trying pattern rule with stem `configure.in.sh'.
        Trying implicit prerequisite `RCS/configure.in.sh'.
        Trying pattern rule with stem `configure.in.sh'.
        Trying implicit prerequisite `s.configure.in.sh'.
        Trying pattern rule with stem `configure.in.sh'.
        Trying implicit prerequisite `SCCS/s.configure.in.sh'.
       No implicit rule found for `configure.in'.
       Finished prerequisites of target file `configure.in'.
      No need to remake target `configure.in'.
      Considering target file `aclocal.m4'.
       Finished prerequisites of target file `aclocal.m4'.
      No need to remake target `aclocal.m4'.
     Finished prerequisites of target file `configure'.
     Prerequisite `configure.in' is older than target `configure'.
     Prerequisite `aclocal.m4' is older than target `configure'.
    No need to remake target `configure'.
   Finished prerequisites of target file `autoconf'.
  Must remake target `autoconf'.
  Successfully remade target file `autoconf'.
  Considering target file `autoheader'.
   File `autoheader' does not exist.
    Considering target file `include/realtime_config.h.in'.
      Pruning file `configure.in'.
      Considering target file `m4/check.m4'.
       Looking for an implicit rule for `m4/check.m4'.
       Trying pattern rule with stem `check.m4'.
       Trying implicit prerequisite `m4/check.m4.o'.
       Trying pattern rule with stem `check.m4'.
       Trying implicit prerequisite `m4/check.m4.c'.
       Trying pattern rule with stem `check.m4'.
       Trying implicit prerequisite `m4/check.m4.cc'.
       Trying pattern rule with stem `check.m4'.
       Trying implicit prerequisite `m4/check.m4.C'.
       Trying pattern rule with stem `check.m4'.
       Trying implicit prerequisite `m4/check.m4.cpp'.
       Trying pattern rule with stem `check.m4'.
       Trying implicit prerequisite `m4/check.m4.p'.
       Trying pattern rule with stem `check.m4'.
       Trying implicit prerequisite `m4/check.m4.f'.
       Trying pattern rule with stem `check.m4'.
       Trying implicit prerequisite `m4/check.m4.F'.
       Trying pattern rule with stem `check.m4'.
       Trying implicit prerequisite `m4/check.m4.r'.
       Trying pattern rule with stem `check.m4'.
       Trying implicit prerequisite `m4/check.m4.s'.
       Trying pattern rule with stem `check.m4'.
       Trying implicit prerequisite `m4/check.m4.S'.
       Trying pattern rule with stem `check.m4'.
       Trying implicit prerequisite `m4/check.m4.mod'.
       Trying pattern rule with stem `check.m4'.
       Trying implicit prerequisite `m4/check.m4.sh'.
       Trying pattern rule with stem `check.m4'.
       Trying implicit prerequisite `m4/check.m4,v'.
       Trying pattern rule with stem `check.m4'.
       Trying implicit prerequisite `m4/RCS/check.m4,v'.
       Trying pattern rule with stem `check.m4'.
       Trying implicit prerequisite `m4/RCS/check.m4'.
       Trying pattern rule with stem `check.m4'.
       Trying implicit prerequisite `m4/s.check.m4'.
       Trying pattern rule with stem `check.m4'.
       Trying implicit prerequisite `m4/SCCS/s.check.m4'.
       Trying pattern rule with stem `check.m4'.
       Trying implicit prerequisite `m4/check.m4.o'.
       Looking for a rule with intermediate file `m4/check.m4.o'.
        Avoiding implicit rule recursion.
        Trying pattern rule with stem `check.m4'.
        Trying implicit prerequisite `m4/check.m4.c'.
        Trying pattern rule with stem `check.m4'.
        Trying implicit prerequisite `m4/check.m4.cc'.
        Trying pattern rule with stem `check.m4'.
        Trying implicit prerequisite `m4/check.m4.C'.
        Trying pattern rule with stem `check.m4'.
        Trying implicit prerequisite `m4/check.m4.cpp'.
        Trying pattern rule with stem `check.m4'.
        Trying implicit prerequisite `m4/check.m4.p'.
        Trying pattern rule with stem `check.m4'.
        Trying implicit prerequisite `m4/check.m4.f'.
        Trying pattern rule with stem `check.m4'.
        Trying implicit prerequisite `m4/check.m4.F'.
        Trying pattern rule with stem `check.m4'.
        Trying implicit prerequisite `m4/check.m4.r'.
        Trying pattern rule with stem `check.m4'.
        Trying implicit prerequisite `m4/check.m4.s'.
        Trying pattern rule with stem `check.m4'.
        Trying implicit prerequisite `m4/check.m4.S'.
        Trying pattern rule with stem `check.m4'.
        Trying implicit prerequisite `m4/check.m4.mod'.
        Trying pattern rule with stem `check.m4.o'.
        Trying implicit prerequisite `m4/check.m4.o,v'.
        Trying pattern rule with stem `check.m4.o'.
        Trying implicit prerequisite `m4/RCS/check.m4.o,v'.
        Trying pattern rule with stem `check.m4.o'.
        Trying implicit prerequisite `m4/RCS/check.m4.o'.
        Trying pattern rule with stem `check.m4.o'.
        Trying implicit prerequisite `m4/s.check.m4.o'.
        Trying pattern rule with stem `check.m4.o'.
        Trying implicit prerequisite `m4/SCCS/s.check.m4.o'.
        Trying pattern rule with stem `check.m4'.
        Trying implicit prerequisite `m4/check.m4.c'.
        Looking for a rule with intermediate file `m4/check.m4.c'.
         Avoiding implicit rule recursion.
         Avoiding implicit rule recursion.
         Trying pattern rule with stem `check.m4'.
         Trying implicit prerequisite `m4/check.m4.y'.
         Trying pattern rule with stem `check.m4'.
         Trying implicit prerequisite `m4/check.m4.l'.
         Trying pattern rule with stem `check.m4'.
         Trying implicit prerequisite `m4/check.m4.w'.
         Trying pattern rule with stem `check.m4'.
         Trying implicit prerequisite `m4/check.m4.w'.
         Trying pattern rule with stem `check.m4.c'.
         Trying implicit prerequisite `m4/check.m4.c,v'.
         Trying pattern rule with stem `check.m4.c'.
         Trying implicit prerequisite `m4/RCS/check.m4.c,v'.
         Trying pattern rule with stem `check.m4.c'.
         Trying implicit prerequisite `m4/RCS/check.m4.c'.
         Trying pattern rule with stem `check.m4.c'.
         Trying implicit prerequisite `m4/s.check.m4.c'.
         Trying pattern rule with stem `check.m4.c'.
         Trying implicit prerequisite `m4/SCCS/s.check.m4.c'.
         Trying pattern rule with stem `check.m4'.
         Trying implicit prerequisite `m4/check.m4.y'.
         Looking for a rule with intermediate file `m4/check.m4.y'.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Trying pattern rule with stem `check.m4.y'.
          Trying implicit prerequisite `m4/check.m4.y,v'.
          Trying pattern rule with stem `check.m4.y'.
          Trying implicit prerequisite `m4/RCS/check.m4.y,v'.
          Trying pattern rule with stem `check.m4.y'.
          Trying implicit prerequisite `m4/RCS/check.m4.y'.
          Trying pattern rule with stem `check.m4.y'.
          Trying implicit prerequisite `m4/s.check.m4.y'.
          Trying pattern rule with stem `check.m4.y'.
          Trying implicit prerequisite `m4/SCCS/s.check.m4.y'.
         Trying pattern rule with stem `check.m4'.
         Trying implicit prerequisite `m4/check.m4.l'.
         Looking for a rule with intermediate file `m4/check.m4.l'.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Trying pattern rule with stem `check.m4.l'.
          Trying implicit prerequisite `m4/check.m4.l,v'.
          Trying pattern rule with stem `check.m4.l'.
          Trying implicit prerequisite `m4/RCS/check.m4.l,v'.
          Trying pattern rule with stem `check.m4.l'.
          Trying implicit prerequisite `m4/RCS/check.m4.l'.
          Trying pattern rule with stem `check.m4.l'.
          Trying implicit prerequisite `m4/s.check.m4.l'.
          Trying pattern rule with stem `check.m4.l'.
          Trying implicit prerequisite `m4/SCCS/s.check.m4.l'.
         Trying pattern rule with stem `check.m4'.
         Trying implicit prerequisite `m4/check.m4.w'.
         Looking for a rule with intermediate file `m4/check.m4.w'.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Trying pattern rule with stem `check.m4.w'.
          Trying implicit prerequisite `m4/check.m4.w,v'.
          Trying pattern rule with stem `check.m4.w'.
          Trying implicit prerequisite `m4/RCS/check.m4.w,v'.
          Trying pattern rule with stem `check.m4.w'.
          Trying implicit prerequisite `m4/RCS/check.m4.w'.
          Trying pattern rule with stem `check.m4.w'.
          Trying implicit prerequisite `m4/s.check.m4.w'.
          Trying pattern rule with stem `check.m4.w'.
          Trying implicit prerequisite `m4/SCCS/s.check.m4.w'.
         Trying pattern rule with stem `check.m4'.
         Rejecting impossible implicit prerequisite `m4/check.m4.w'.
        Trying pattern rule with stem `check.m4'.
        Trying implicit prerequisite `m4/check.m4.cc'.
        Looking for a rule with intermediate file `m4/check.m4.cc'.
         Avoiding implicit rule recursion.
         Avoiding implicit rule recursion.
         Trying pattern rule with stem `check.m4.cc'.
         Trying implicit prerequisite `m4/check.m4.cc,v'.
         Trying pattern rule with stem `check.m4.cc'.
         Trying implicit prerequisite `m4/RCS/check.m4.cc,v'.
         Trying pattern rule with stem `check.m4.cc'.
         Trying implicit prerequisite `m4/RCS/check.m4.cc'.
         Trying pattern rule with stem `check.m4.cc'.
         Trying implicit prerequisite `m4/s.check.m4.cc'.
         Trying pattern rule with stem `check.m4.cc'.
         Trying implicit prerequisite `m4/SCCS/s.check.m4.cc'.
        Trying pattern rule with stem `check.m4'.
        Trying implicit prerequisite `m4/check.m4.C'.
        Looking for a rule with intermediate file `m4/check.m4.C'.
         Avoiding implicit rule recursion.
         Avoiding implicit rule recursion.
         Trying pattern rule with stem `check.m4.C'.
         Trying implicit prerequisite `m4/check.m4.C,v'.
         Trying pattern rule with stem `check.m4.C'.
         Trying implicit prerequisite `m4/RCS/check.m4.C,v'.
         Trying pattern rule with stem `check.m4.C'.
         Trying implicit prerequisite `m4/RCS/check.m4.C'.
         Trying pattern rule with stem `check.m4.C'.
         Trying implicit prerequisite `m4/s.check.m4.C'.
         Trying pattern rule with stem `check.m4.C'.
         Trying implicit prerequisite `m4/SCCS/s.check.m4.C'.
        Trying pattern rule with stem `check.m4'.
        Trying implicit prerequisite `m4/check.m4.cpp'.
        Looking for a rule with intermediate file `m4/check.m4.cpp'.
         Avoiding implicit rule recursion.
         Avoiding implicit rule recursion.
         Trying pattern rule with stem `check.m4.cpp'.
         Trying implicit prerequisite `m4/check.m4.cpp,v'.
         Trying pattern rule with stem `check.m4.cpp'.
         Trying implicit prerequisite `m4/RCS/check.m4.cpp,v'.
         Trying pattern rule with stem `check.m4.cpp'.
         Trying implicit prerequisite `m4/RCS/check.m4.cpp'.
         Trying pattern rule with stem `check.m4.cpp'.
         Trying implicit prerequisite `m4/s.check.m4.cpp'.
         Trying pattern rule with stem `check.m4.cpp'.
         Trying implicit prerequisite `m4/SCCS/s.check.m4.cpp'.
        Trying pattern rule with stem `check.m4'.
        Trying implicit prerequisite `m4/check.m4.p'.
        Looking for a rule with intermediate file `m4/check.m4.p'.
         Avoiding implicit rule recursion.
         Avoiding implicit rule recursion.
         Trying pattern rule with stem `check.m4'.
         Trying implicit prerequisite `m4/check.m4.web'.
         Trying pattern rule with stem `check.m4.p'.
         Trying implicit prerequisite `m4/check.m4.p,v'.
         Trying pattern rule with stem `check.m4.p'.
         Trying implicit prerequisite `m4/RCS/check.m4.p,v'.
         Trying pattern rule with stem `check.m4.p'.
         Trying implicit prerequisite `m4/RCS/check.m4.p'.
         Trying pattern rule with stem `check.m4.p'.
         Trying implicit prerequisite `m4/s.check.m4.p'.
         Trying pattern rule with stem `check.m4.p'.
         Trying implicit prerequisite `m4/SCCS/s.check.m4.p'.
         Trying pattern rule with stem `check.m4'.
         Trying implicit prerequisite `m4/check.m4.web'.
         Looking for a rule with intermediate file `m4/check.m4.web'.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Trying pattern rule with stem `check.m4.web'.
          Trying implicit prerequisite `m4/check.m4.web,v'.
          Trying pattern rule with stem `check.m4.web'.
          Trying implicit prerequisite `m4/RCS/check.m4.web,v'.
          Trying pattern rule with stem `check.m4.web'.
          Trying implicit prerequisite `m4/RCS/check.m4.web'.
          Trying pattern rule with stem `check.m4.web'.
          Trying implicit prerequisite `m4/s.check.m4.web'.
          Trying pattern rule with stem `check.m4.web'.
          Trying implicit prerequisite `m4/SCCS/s.check.m4.web'.
        Trying pattern rule with stem `check.m4'.
        Trying implicit prerequisite `m4/check.m4.f'.
        Looking for a rule with intermediate file `m4/check.m4.f'.
         Avoiding implicit rule recursion.
         Avoiding implicit rule recursion.
         Trying pattern rule with stem `check.m4'.
         Trying implicit prerequisite `m4/check.m4.F'.
         Trying pattern rule with stem `check.m4'.
         Trying implicit prerequisite `m4/check.m4.r'.
         Trying pattern rule with stem `check.m4.f'.
         Trying implicit prerequisite `m4/check.m4.f,v'.
         Trying pattern rule with stem `check.m4.f'.
         Trying implicit prerequisite `m4/RCS/check.m4.f,v'.
         Trying pattern rule with stem `check.m4.f'.
         Trying implicit prerequisite `m4/RCS/check.m4.f'.
         Trying pattern rule with stem `check.m4.f'.
         Trying implicit prerequisite `m4/s.check.m4.f'.
         Trying pattern rule with stem `check.m4.f'.
         Trying implicit prerequisite `m4/SCCS/s.check.m4.f'.
         Trying pattern rule with stem `check.m4'.
         Trying implicit prerequisite `m4/check.m4.F'.
         Looking for a rule with intermediate file `m4/check.m4.F'.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Trying pattern rule with stem `check.m4.F'.
          Trying implicit prerequisite `m4/check.m4.F,v'.
          Trying pattern rule with stem `check.m4.F'.
          Trying implicit prerequisite `m4/RCS/check.m4.F,v'.
          Trying pattern rule with stem `check.m4.F'.
          Trying implicit prerequisite `m4/RCS/check.m4.F'.
          Trying pattern rule with stem `check.m4.F'.
          Trying implicit prerequisite `m4/s.check.m4.F'.
          Trying pattern rule with stem `check.m4.F'.
          Trying implicit prerequisite `m4/SCCS/s.check.m4.F'.
         Trying pattern rule with stem `check.m4'.
         Trying implicit prerequisite `m4/check.m4.r'.
         Looking for a rule with intermediate file `m4/check.m4.r'.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Trying pattern rule with stem `check.m4'.
          Rejecting impossible implicit prerequisite `m4/check.m4.l'.
          Trying pattern rule with stem `check.m4.r'.
          Trying implicit prerequisite `m4/check.m4.r,v'.
          Trying pattern rule with stem `check.m4.r'.
          Trying implicit prerequisite `m4/RCS/check.m4.r,v'.
          Trying pattern rule with stem `check.m4.r'.
          Trying implicit prerequisite `m4/RCS/check.m4.r'.
          Trying pattern rule with stem `check.m4.r'.
          Trying implicit prerequisite `m4/s.check.m4.r'.
          Trying pattern rule with stem `check.m4.r'.
          Trying implicit prerequisite `m4/SCCS/s.check.m4.r'.
        Trying pattern rule with stem `check.m4'.
        Rejecting impossible implicit prerequisite `m4/check.m4.F'.
        Trying pattern rule with stem `check.m4'.
        Rejecting impossible implicit prerequisite `m4/check.m4.r'.
        Trying pattern rule with stem `check.m4'.
        Trying implicit prerequisite `m4/check.m4.s'.
        Looking for a rule with intermediate file `m4/check.m4.s'.
         Avoiding implicit rule recursion.
         Avoiding implicit rule recursion.
         Trying pattern rule with stem `check.m4'.
         Trying implicit prerequisite `m4/check.m4.S'.
         Trying pattern rule with stem `check.m4.s'.
         Trying implicit prerequisite `m4/check.m4.s,v'.
         Trying pattern rule with stem `check.m4.s'.
         Trying implicit prerequisite `m4/RCS/check.m4.s,v'.
         Trying pattern rule with stem `check.m4.s'.
         Trying implicit prerequisite `m4/RCS/check.m4.s'.
         Trying pattern rule with stem `check.m4.s'.
         Trying implicit prerequisite `m4/s.check.m4.s'.
         Trying pattern rule with stem `check.m4.s'.
         Trying implicit prerequisite `m4/SCCS/s.check.m4.s'.
         Trying pattern rule with stem `check.m4'.
         Trying implicit prerequisite `m4/check.m4.S'.
         Looking for a rule with intermediate file `m4/check.m4.S'.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Avoiding implicit rule recursion.
          Trying pattern rule with stem `check.m4.S'.
          Trying implicit prerequisite `m4/check.m4.S,v'.
          Trying pattern rule with stem `check.m4.S'.
          Trying implicit prerequisite `m4/RCS/check.m4.S,v'.
          Trying pattern rule with stem `check.m4.S'.
          Trying implicit prerequisite `m4/RCS/check.m4.S'.
          Trying pattern rule with stem `check.m4.S'.
          Trying implicit prerequisite `m4/s.check.m4.S'.
          Trying pattern rule with stem `check.m4.S'.
          Trying implicit prerequisite `m4/SCCS/s.check.m4.S'.
        Trying pattern rule with stem `check.m4'.
        Rejecting impossible implicit prerequisite `m4/check.m4.S'.
        Trying pattern rule with stem `check.m4'.
        Trying implicit prerequisite `m4/check.m4.mod'.
        Looking for a rule with intermediate file `m4/check.m4.mod'.
         Avoiding implicit rule recursion.
         Avoiding implicit rule recursion.
         Trying pattern rule with stem `check.m4.mod'.
         Trying implicit prerequisite `m4/check.m4.mod,v'.
         Trying pattern rule with stem `check.m4.mod'.
         Trying implicit prerequisite `m4/RCS/check.m4.mod,v'.
         Trying pattern rule with stem `check.m4.mod'.
         Trying implicit prerequisite `m4/RCS/check.m4.mod'.
         Trying pattern rule with stem `check.m4.mod'.
         Trying implicit prerequisite `m4/s.check.m4.mod'.
         Trying pattern rule with stem `check.m4.mod'.
         Trying implicit prerequisite `m4/SCCS/s.check.m4.mod'.
       Trying pattern rule with stem `check.m4'.
       Rejecting impossible implicit prerequisite `m4/check.m4.c'.
       Trying pattern rule with stem `check.m4'.
       Rejecting impossible implicit prerequisite `m4/check.m4.cc'.
       Trying pattern rule with stem `check.m4'.
       Rejecting impossible implicit prerequisite `m4/check.m4.C'.
       Trying pattern rule with stem `check.m4'.
       Rejecting impossible implicit prerequisite `m4/check.m4.cpp'.
       Trying pattern rule with stem `check.m4'.
       Rejecting impossible implicit prerequisite `m4/check.m4.p'.
       Trying pattern rule with stem `check.m4'.
       Rejecting impossible implicit prerequisite `m4/check.m4.f'.
       Trying pattern rule with stem `check.m4'.
       Rejecting impossible implicit prerequisite `m4/check.m4.F'.
       Trying pattern rule with stem `check.m4'.
       Rejecting impossible implicit prerequisite `m4/check.m4.r'.
       Trying pattern rule with stem `check.m4'.
       Rejecting impossible implicit prerequisite `m4/check.m4.s'.
       Trying pattern rule with stem `check.m4'.
       Rejecting impossible implicit prerequisite `m4/check.m4.S'.
       Trying pattern rule with stem `check.m4'.
       Rejecting impossible implicit prerequisite `m4/check.m4.mod'.
       Trying pattern rule with stem `check.m4'.
       Trying implicit prerequisite `m4/check.m4.sh'.
       Looking for a rule with intermediate file `m4/check.m4.sh'.
        Avoiding implicit rule recursion.
        Trying pattern rule with stem `check.m4.sh'.
        Trying implicit prerequisite `m4/check.m4.sh,v'.
        Trying pattern rule with stem `check.m4.sh'.
        Trying implicit prerequisite `m4/RCS/check.m4.sh,v'.
        Trying pattern rule with stem `check.m4.sh'.
        Trying implicit prerequisite `m4/RCS/check.m4.sh'.
        Trying pattern rule with stem `check.m4.sh'.
        Trying implicit prerequisite `m4/s.check.m4.sh'.
        Trying pattern rule with stem `check.m4.sh'.
        Trying implicit prerequisite `m4/SCCS/s.check.m4.sh'.
       No implicit rule found for `m4/check.m4'.
       Finished prerequisites of target file `m4/check.m4'.
      No need to remake target `m4/check.m4'.
      Pruning file `aclocal.m4'.
     Finished prerequisites of target file `include/realtime_config.h.in'.
     Prerequisite `configure.in' is older than target `include/realtime_config.h.in'.
     Prerequisite `m4/check.m4' is older than target `include/realtime_config.h.in'.
     Prerequisite `aclocal.m4' is older than target `include/realtime_config.h.in'.
    No need to remake target `include/realtime_config.h.in'.
   Finished prerequisites of target file `autoheader'.
  Must remake target `autoheader'.
make[1]: Entering directory `/root/ltp-full-20100630/testcases/realtime'
autoheader
Got a SIGCHLD; 2 unreaped children.
Putting child 0x0054b880 (autoheader) PID 18854 on the chain.
Live child 0x0054b880 (autoheader) PID 18854 
Reaping losing child 0x0054b880 PID 18854 
Removing child 0x0054b880 PID 18854 from chain.
make[1]: Leaving directory `/root/ltp-full-20100630/testcases/realtime'
Got a SIGCHLD; 1 unreaped children.
Reaping losing child 0x00539f90 PID 18838 
Removing child 0x00539f90 PID 18838 from chain.

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--fdj2RfSjLxBAspz7--

