From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 1 Mar 2019 15:48:31 +0100
Subject: [LTP] [PATCH DRAFT] syscalls/stime: convert to new lib,
 use direct syscall
In-Reply-To: <20190202015923.189057-1-smuckle@google.com>
References: <20190202015923.189057-1-smuckle@google.com>
Message-ID: <20190301144831.GA16823@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I set about cleaning up the stime tests but later realized I don't
> have a platform that has the stime syscall so I cannot test this
> patch fully. If someone else has such a platform (looks like 32-bit
> x86 has it) and wants to take the patch over, feel free :) .

I've taken over and finished the patchset, thanks.

Also btw, you can test these testcases on x86_64 if you compile LTP with
-m32 flag with:

CFLAGS=-m32 LDFLAGS=-m32 ./configure

-- 
Cyril Hrubis
chrubis@suse.cz
