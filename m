From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 13 Jun 2019 16:17:14 +0200
Subject: [LTP] [PATCH v3 3/3] syscalls/ioctl_ns0[156]: align stack and
 wait for child
In-Reply-To: <1320546599.27920597.1560420988025.JavaMail.zimbra@redhat.com>
References: <adca7c08dbf20805da9b99a7fa03d498de70235d.1560410182.git.jstancek@redhat.com>
 <1b6ddab9cd8e3620da9e37b1132e911280c22e32.1560410182.git.jstancek@redhat.com>
 <CAEemH2frt_zGSdSRL3d_J+km74p8ruQTNF6bVhEpaiTdMLCC6A@mail.gmail.com>
 <1320546599.27920597.1560420988025.JavaMail.zimbra@redhat.com>
Message-ID: <20190613141714.GC29926@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > We need free(child_stack) in the cleanup function.
> 
> Can you elaborate?

If I remember correctly at some point we decided to clean up after tests
properly so that we don't upset various debugging tools, i.e. coverity,
valgrind, etc. and I think that you were part of that discussion.

-- 
Cyril Hrubis
chrubis@suse.cz
