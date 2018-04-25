From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 25 Apr 2018 09:42:35 -0400 (EDT)
Subject: [LTP] LTP Release preparations
In-Reply-To: <20180425132319.GA24333@rei>
References: <20180412113532.GA5963@rei> <20180419141749.GA13045@rei>
 <20180424133931.GA18016@rei>
 <547086855.15481908.1524604124480.JavaMail.zimbra@redhat.com>
 <20180425132319.GA24333@rei>
Message-ID: <327336229.15630466.1524663755614.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > I started testing and so far ran into problem with building
> > cve-2017-16939.c
> > on RHEL7.2:
> > 
> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W
> > -Wold-style-definition -D_GNU_SOURCE -D_FORTIFY_SOURCE=2 -I../../include
> > -I../../include -I../../include/old/   -L../../lib  cve-2017-16939.c
> > -lltp -o cve-2017-16939
> > In file included from /usr/include/linux/xfrm.h:4:0,
> >                  from cve-2017-16939.c:33:
> > /usr/include/linux/in6.h:30:8: error: redefinition of ???struct in6_addr???
> >  struct in6_addr {
> >         ^
> > In file included from cve-2017-16939.c:31:0:
> > /usr/include/netinet/in.h:197:8: note: originally defined here
> >  struct in6_addr
> >         ^
> > In file included from /usr/include/linux/xfrm.h:4:0,
> >                  from cve-2017-16939.c:33:
> > /usr/include/linux/in6.h:41:8: error: redefinition of ???struct
> > sockaddr_in6???
> >  struct sockaddr_in6 {
> >         ^
> > In file included from cve-2017-16939.c:29:0:
> > /usr/include/sys/socket.h:91:17: note: originally defined here
> >  typedef union { __SOCKADDR_ALLTYPES
> >                  ^
> > In file included from /usr/include/linux/xfrm.h:4:0,
> >                  from cve-2017-16939.c:33:
> > /usr/include/linux/in6.h:49:8: error: redefinition of ???struct
> > ipv6_mreq???
> >  struct ipv6_mreq {
> >         ^
> > In file included from cve-2017-16939.c:31:0:
> > /usr/include/netinet/in.h:274:8: note: originally defined here
> >  struct ipv6_mreq
> >         ^
> > make: *** [cve-2017-16939] Error 1
> 
> This seems to be very strange problem with mixing linux and libc
> headers. I've tried to remove the netinet/in.h header from the test and
> build it on different distros, buy that seemed to actually cause more
> problems than when it's included.
> 
> And actually I haven't been able to reproduce the build problem failure
> the original code, but I build-test only small mumber of RHEL and Fedora
> builds here.
> 
> I guess that the easiest solution here may be to declare the three XFRM
> macros somewhere in lapi header and include it here instead fo the
> linux/xfrm.h.

That worked for me, though I missed only 2 defines:
XFRMNLGRP_NONE
XFRM_MSG_GETPOLICY

Are you missing three after you drop linux/xfrm.h?

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
