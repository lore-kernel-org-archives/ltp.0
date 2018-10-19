From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 19 Oct 2018 13:32:44 +0200
Subject: [LTP] [PATCH] ipc/msgstress*: Update test name in output
In-Reply-To: <1539925270-12034-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1539925270-12034-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20181019113244.GB31934@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> msgctl[08-11] have been renamed as msgstress[01-04] in
> commit 3e882e3e4c2d, so fix the wrong name in output.

Maybe we should just change these messages into "Test ran successfully!"
	instead. But I do not have strong opinion on this.

-- 
Cyril Hrubis
chrubis@suse.cz
