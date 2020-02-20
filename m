From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Feb 2020 15:39:06 +0100
Subject: [LTP] [PATCH] syscalls/ptrace: Merge ptrace01 and ptrace02
In-Reply-To: <20200108135949.15048-1-jcronenberg@suse.de>
References: <20200108135949.15048-1-jcronenberg@suse.de>
Message-ID: <20200220143906.GB29116@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor adjustements, thanks.

* Removed the runtest entry for ptrace02
* Removed the .gitignore entry for ptrace02
* Fixed the status handling at the end of the test

We should adjust our expectations based on which ptrace() call we did,
e.g. for PTRACE_CONT the child killed by sigkill is still a failure.
Also you have to call WIF*() first and only then you can get the
exit/term signal value.

-- 
Cyril Hrubis
chrubis@suse.cz
