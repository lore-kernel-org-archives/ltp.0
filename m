From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 11 Apr 2016 19:23:05 +0200
Subject: [LTP] Pre-release LTP build
Message-ID: <20160411172305.GC3466@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've tried to build LTP source for several distributions and as I
expected the support for compiler atomic operations is missing in old
compilers. Particulary gcc-4.1 on x86 (32bit RHEL5) and gcc-3.4 (SLES9)
and older which were released in 2007 and 2006.

The questions is: do we care enough to provide fallback inline assembler?

I would be inclined to say that we don't. So does anybody out there
still uses LTP with a compiler old enough that it does not support
atomic builtins?

-- 
Cyril Hrubis
chrubis@suse.cz
