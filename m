From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jan 2021 17:18:35 +0100
Subject: [LTP] [PATCH 4/5] syscalls/ipc: semctl05: Convert to new API
 and cleanup
In-Reply-To: <1609918063-15810-4-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1609918063-15810-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <1609918063-15810-4-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <YBBA2+QObcpo73bc@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor changes, thanks.

- Reformated the test description for docparser

- Got rid of the XLC compiler workaround

- Removed .needs_root

-- 
Cyril Hrubis
chrubis@suse.cz
