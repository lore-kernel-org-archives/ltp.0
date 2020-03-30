From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 Mar 2020 14:52:49 +0200
Subject: [LTP] [PATCH v3 1/3] security/dirtyc0w: Fix bug caused by
 default umask
In-Reply-To: <f78cb609-b4f1-2f89-a641-09a97c2d0a03@163.com>
References: <1585553269-119544-1-git-send-email-zou_wei@huawei.com>
 <1585553269-119544-2-git-send-email-zou_wei@huawei.com>
 <20200330091835.GA9845@yuki.lan> <20200330092046.GB9845@yuki.lan>
 <f78cb609-b4f1-2f89-a641-09a97c2d0a03@163.com>
Message-ID: <20200330125249.GA26711@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Just one question when reviewing this patch set.
> 
> I saw the umask set(e.g. set umask to 0 or 0022) is used by a lot of tests.
> 
> Is it necessary for metadata project to introduce .needs_umask?

I do no think so.

-- 
Cyril Hrubis
chrubis@suse.cz
