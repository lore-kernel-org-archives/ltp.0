From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 13 Jun 2019 10:57:35 -0400 (EDT)
Subject: [LTP] [PATCH v3 3/3] syscalls/ioctl_ns0[156]: align stack and
 wait for child
In-Reply-To: <20190613141714.GC29926@rei.lan>
References: <adca7c08dbf20805da9b99a7fa03d498de70235d.1560410182.git.jstancek@redhat.com>
 <1b6ddab9cd8e3620da9e37b1132e911280c22e32.1560410182.git.jstancek@redhat.com>
 <CAEemH2frt_zGSdSRL3d_J+km74p8ruQTNF6bVhEpaiTdMLCC6A@mail.gmail.com>
 <1320546599.27920597.1560420988025.JavaMail.zimbra@redhat.com>
 <20190613141714.GC29926@rei.lan>
Message-ID: <1211798607.28016198.1560437855198.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> > > We need free(child_stack) in the cleanup function.
> > 
> > Can you elaborate?
> 
> If I remember correctly at some point we decided to clean up after tests
> properly so that we don't upset various debugging tools, i.e. coverity,
> valgrind, etc. and I think that you were part of that discussion.

I recall I started with that position (free all), and I thought you
turned me around after this many years :-).

Do we have anything about this in style guide? I only found brief mention 
in "don't call cleanup from setup" section, which isn't even possible with newlib.

...
You don't need to clean up the following:                                                                                                                                                                          
                                                                                                                                                                                                                   
 * +malloc(3)+'ed memory.                                                                                                                                                                                          
 * Read-only file descriptors in persistent paths (i.e. not                                                                                                                                                        
   temporary directories).  

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
