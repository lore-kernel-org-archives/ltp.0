From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Jul 2021 15:49:29 +0200
Subject: [LTP] [PATCH] syscalls/readv03: Convert to new API
In-Reply-To: <1626771497-20281-1-git-send-email-daisl.fnst@fujitsu.com>
References: <1626771497-20281-1-git-send-email-daisl.fnst@fujitsu.com>
Message-ID: <YPbUaYZTUaM44cFl@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Nice cleanup, pushed with minor change, thanks.

* I've changed the buf and rd_iovec to static.


Also it would probably be for the best if we implemented the EINVAL,
EFAULT, and EBADFD tests in the readv03.c and got rid of readv02.c as
well.

-- 
Cyril Hrubis
chrubis@suse.cz
