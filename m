From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Mar 2019 15:36:48 +0100
Subject: [LTP] [PATCH] syscalls/fstat05.c: fix test logic error
In-Reply-To: <20190221140221.42163-1-liwei391@huawei.com>
References: <20190221140221.42163-1-liwei391@huawei.com>
Message-ID: <20190313143648.GA6171@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
It would be better to pass the result from tst_get_bad_addr() to the
fstat function rather than trying to guess unused address space based on
the end of the program data segment. Can you send updated patch?

Also sorry for the long delay.

-- 
Cyril Hrubis
chrubis@suse.cz
