From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Jan 2020 14:06:25 +0100
Subject: [LTP] [PATCH v2] syscalls/add_key01: test the length of payload
In-Reply-To: <1579670796-21233-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200121151342.GD6337@rei>
 <1579670796-21233-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200123130625.GB6762@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've removed the save buffers from the test setup, since I do not think
that we should use them for the syscall availability check, added the
.needs_root flag and pushed. Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
