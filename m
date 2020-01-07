From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Jan 2020 13:26:04 +0100
Subject: [LTP] [PATCH 1/2] syscalls/capget01: Cleanup & convert to new
 library
In-Reply-To: <20200107120224.GA26408@rei.lan>
References: <1576049159-14014-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200107120224.GA26408@rei.lan>
Message-ID: <20200107122604.GC26408@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Also btw, we do not cover the case with pid == 0 now, which should
return the capabilities for the calling thread. I guess that we can run
the capget01 verify function twice, once for pid == getpid() and once
for pid == 0.

-- 
Cyril Hrubis
chrubis@suse.cz
