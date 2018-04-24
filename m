From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 24 Apr 2018 17:08:44 -0400 (EDT)
Subject: [LTP] LTP Release preparations
In-Reply-To: <20180424133931.GA18016@rei>
References: <20180412113532.GA5963@rei> <20180419141749.GA13045@rei>
 <20180424133931.GA18016@rei>
Message-ID: <547086855.15481908.1524604124480.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > I suppose that we should get in the fix for the read_all testcase along
> > with the exponential back off.
> > 
> > Also I would like to get in the needs_rofs patchset.
> > 
> > There is also patch for converting our python code to be python3
> > compatible that is worth looking into.
> 
> That has been done.
> 
> I've also send a patch for long-standing problem with perf_event_open02
> testcase that would be a good candidate for the release.
> 
> Peter how is it with the IMA testsuite, should we merge the patchset and
> call it incremental improvement over the previous code?
> 
> Anything else to be merged?
> 
> I would like to go for freezing the git at the end of the week and
> start with a pre-release testing next week. Is that OK with everyone?

I started testing and so far ran into problem with building cve-2017-16939.c
on RHEL7.2:

gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -D_GNU_SOURCE -D_FORTIFY_SOURCE=2 -I../../include -I../../include -I../../include/old/   -L../../lib  cve-2017-16939.c   -lltp -o cve-2017-16939
In file included from /usr/include/linux/xfrm.h:4:0,
                 from cve-2017-16939.c:33:
/usr/include/linux/in6.h:30:8: error: redefinition of ‘struct in6_addr’
 struct in6_addr {
        ^
In file included from cve-2017-16939.c:31:0:
/usr/include/netinet/in.h:197:8: note: originally defined here
 struct in6_addr
        ^
In file included from /usr/include/linux/xfrm.h:4:0,
                 from cve-2017-16939.c:33:
/usr/include/linux/in6.h:41:8: error: redefinition of ‘struct sockaddr_in6’
 struct sockaddr_in6 {
        ^
In file included from cve-2017-16939.c:29:0:
/usr/include/sys/socket.h:91:17: note: originally defined here
 typedef union { __SOCKADDR_ALLTYPES
                 ^
In file included from /usr/include/linux/xfrm.h:4:0,
                 from cve-2017-16939.c:33:
/usr/include/linux/in6.h:49:8: error: redefinition of ‘struct ipv6_mreq’
 struct ipv6_mreq {
        ^
In file included from cve-2017-16939.c:31:0:
/usr/include/netinet/in.h:274:8: note: originally defined here
 struct ipv6_mreq
        ^
make: *** [cve-2017-16939] Error 1


> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
