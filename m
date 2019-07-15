From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 Jul 2019 13:19:51 +0200
Subject: [LTP] [PATCH 2/2] syscalls/acct02: Fix failures with nearly
 full FS
In-Reply-To: <5D2C35B6.6080606@cn.fujitsu.com>
References: <20190712141530.22195-1-chrubis@suse.cz>
 <20190712141530.22195-3-chrubis@suse.cz>
 <5D2C35B6.6080606@cn.fujitsu.com>
Message-ID: <20190715111950.GA12926@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I met the same problem on last week when I ran acct02 on nearly full
> FS.  Since kernel/acct.c has defined the RESUME(4) and SUSPEND(2)
> macro, 4.1 is enough.  And I think we can leave a simple comment in
> here for why the limit is 4.1(even though the commit message has the
> reason).

I guess that short comment would help there, if it's OK I will add it
before I push the patch.

-- 
Cyril Hrubis
chrubis@suse.cz
