From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 24 Mar 2017 10:21:18 +0100
Subject: [LTP] [PATCH] Fix sbrk02 failure on ia32 architecture
In-Reply-To: <b0668bef-6906-8c74-bbed-a2374d16a9c7@linux.vnet.ibm.com>
References: <b0668bef-6906-8c74-bbed-a2374d16a9c7@linux.vnet.ibm.com>
Message-ID: <20170324092118.GA9961@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> sbrk02 is failing on ia32 architecture, where as this test passed in 
> other arch's.
> 
> when we check the sbrk02 with below increment value #define INC 
> 16*1024*1024 the error
>   condition "(void *) -1" met but the errno show the success. below 
> output will
>   show fail condition.

This is most likely this glibc bug:

https://sourceware.org/bugzilla/show_bug.cgi?id=18592

Fixed by this patch:
https://sourceware.org/git/gitweb.cgi?p=glibc.git;a=patch;h=c13e07830800dd95ca7684b3c473394c77059c97

-- 
Cyril Hrubis
chrubis@suse.cz
