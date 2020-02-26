From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 26 Feb 2020 14:56:17 +0100
Subject: [LTP] [PATCH v3] syscalls/pipe13: Add regression test for pipe
 to wake up all readers
In-Reply-To: <1582686383-23299-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200225102850.GA5077@rei.lan>
 <1582686383-23299-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200226135616.GC24080@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've added a few more fixes/assertions and pushed, thanks.

* Changed the code to run the test for a few different number of
  children

* Added check for return value from the read() in the child

* Added SAFE_CLOSE(fds[0]) into the parent
  - this fixes failures with large enough -i parameter where the test
    would run out of file descriptors

-- 
Cyril Hrubis
chrubis@suse.cz
