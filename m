From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 2 Mar 2016 14:19:45 +0100
Subject: [LTP] [PATCH] run-posix-option-group-test: replace CWD qith PWD
In-Reply-To: <1456736680-8968-1-git-send-email-vgupta@synopsys.com>
References: <1456736680-8968-1-git-send-email-vgupta@synopsys.com>
Message-ID: <20160302131944.GC24147@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This is because $CDW env variable is not provided by Busybox shell.
> 
> I understand PWD is not same as CWD, but should suffice here !

Actually this looks like a typo to me. Since there is no $CWD in bash
either (there is one in csh though).

I'm getting this with bash:

basename: missing operand
Try 'basename --help' for more information.

So I've pushed the patch with a bit different changelog.

-- 
Cyril Hrubis
chrubis@suse.cz
