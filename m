From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 3 Aug 2018 16:00:01 +0200
Subject: [LTP] [PATCH v2] syscalls/prctl03.c: New test for prctl() with
 PR_{SET, GET}_CHILD_SUBREAPER
In-Reply-To: <1532662463-9404-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180725125655.GA23890@rei>
 <1532662463-9404-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180803140001.GA32243@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

TST_RETURN -> TST_RET
TST_ERRNO -> TST_ERR

And the grandchild does only exit(0) since we do not use the exit value.

-- 
Cyril Hrubis
chrubis@suse.cz
