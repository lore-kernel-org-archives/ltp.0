From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Nov 2020 11:31:23 +0100
Subject: [LTP] [PATCH v2 1/2] syscalls/ptrace02: Add another EPERM error
 test
In-Reply-To: <20201112102725.GB11365@yuki.lan>
References: <20201111150926.GA21539@yuki.lan>
 <1605163724-20306-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20201112102725.GB11365@yuki.lan>
Message-ID: <20201112103123.GC11365@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Pushed, thanks.

I've pushed a follow up patch that adds an explicit test for return value.

Please be strict in checking the return values in your testcases from
now on.

-- 
Cyril Hrubis
chrubis@suse.cz
