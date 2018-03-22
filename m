From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 22 Mar 2018 18:34:30 +0100
Subject: [LTP] [PATCH] cve: new regression test-case for CVE-2018-5803
In-Reply-To: <a26d2a06-429a-b0dd-995a-c01dbb7a4718@oracle.com>
References: <1520872613-30423-1-git-send-email-alexey.kodanev@oracle.com>
 <20180320140051.mxh5mqndc4gp72og@dell5510>
 <a26d2a06-429a-b0dd-995a-c01dbb7a4718@oracle.com>
Message-ID: <20180322173430.frvxkggp5a7wbs6b@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Do you think we should include linux headers for consistency?
Yes, although both SOL_SCTP and SOL_UDPLITE are defined the same for all architectures and
probably never change, I'd include the header.

Actually SOL_UDPLITE is already defined in include/lapi/socket.h.
This file was added as wrapper for values <sys/socket.h> in aac9d1f0e by Xiao Yang,
I included sys/socket.h in that lapi file in 3fd5746a8
Later you added in 0bc572423 constants from linux/socket.h.
I don't know what is a best practise, but I'd include both files in include/lapi/socket.h
(they don't conflict) (or don't include neither of them):
#ifdef HAVE_SYS_SOCKET_H
# include <sys/socket.h>
#endif

#ifdef HAVE_LINUX_SOCKET_H
# include <linux/socket.h>
#endif

> >> +
> >>  #ifndef SOL_UDPLITE
> >>  # define SOL_UDPLITE		136 /* UDP-Lite (RFC 3828) */
> >>  #endif
As I wrote, this is already defined in include/lapi/socket.h.

> >> diff --git a/runtest/cve b/runtest/cve
> >> index 0c385c6..826bb0b 100644
> ...
> >> +	fcntl(cfd, F_SETFL, O_NONBLOCK);
> >> +	connect(cfd, (struct sockaddr *)&rmt, sizeof(rmt));
> > Minor nit: you can use SAFE_CONNECT().


> No, it should fail in the kernels with the fix, on the second test-case when
> we get over-sized INIT chunk, I think ENOMEM returns in that case.
Oh sorry, understand.

Kind regards,
Petr
