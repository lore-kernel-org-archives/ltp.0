From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 13 Jun 2019 17:14:19 +0200
Subject: [LTP] [PATCH v3 3/3] syscalls/ioctl_ns0[156]: align stack and
 wait for child
In-Reply-To: <1211798607.28016198.1560437855198.JavaMail.zimbra@redhat.com>
References: <adca7c08dbf20805da9b99a7fa03d498de70235d.1560410182.git.jstancek@redhat.com>
 <1b6ddab9cd8e3620da9e37b1132e911280c22e32.1560410182.git.jstancek@redhat.com>
 <CAEemH2frt_zGSdSRL3d_J+km74p8ruQTNF6bVhEpaiTdMLCC6A@mail.gmail.com>
 <1320546599.27920597.1560420988025.JavaMail.zimbra@redhat.com>
 <20190613141714.GC29926@rei.lan>
 <1211798607.28016198.1560437855198.JavaMail.zimbra@redhat.com>
Message-ID: <20190613151419.GE29926@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > If I remember correctly at some point we decided to clean up after tests
> > properly so that we don't upset various debugging tools, i.e. coverity,
> > valgrind, etc. and I think that you were part of that discussion.
> 
> I recall I started with that position (free all), and I thought you
> turned me around after this many years :-).

Well I didn't care that much, but I guess that I lean slightly to free
the memory :-).

> Do we have anything about this in style guide? I only found brief mention 
> in "don't call cleanup from setup" section, which isn't even possible with newlib.

I don't think so. I guess that we should write something down, once we
decide what is the prefered option.

> ...
> You don't need to clean up the following:                                                                                                                                                                          
>                                                                                                                                                                                                                    
>  * +malloc(3)+'ed memory.                                                                                                                                                                                          
>  * Read-only file descriptors in persistent paths (i.e. not                                                                                                                                                        
>    temporary directories).  

Looks like this is terribly outdated, at least I tend to tell people to
close all filedescriptors to make things simpler.

-- 
Cyril Hrubis
chrubis@suse.cz
