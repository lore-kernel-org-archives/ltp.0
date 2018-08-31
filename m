From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 31 Aug 2018 10:41:50 +0200
Subject: [LTP] [PATCH ltp] syscalls/bind03: Add version compare
 according to behaviour difference.
In-Reply-To: <20180831132453.6461-1-junchi.chen@intel.com>
References: <20180831132453.6461-1-junchi.chen@intel.com>
Message-ID: <20180831084149.GA16417@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> ISSUE:
>   The case is designed to test the behaviour diverse caused by kernel
>   commit 0fb44559ffd6. And it failed for the new behaviour.
> 
> ACTION:
>   Add a version compare to split part of the test.

This is actually a not-yet fixed kernel bug as the correct errno to be
reported in this case is EADDRINUSE at least that is what I understand
after reading POSIX.

See:

https://patchwork.ozlabs.org/patch/782692/

-- 
Cyril Hrubis
chrubis@suse.cz
