From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Jul 2020 17:45:58 +0200
Subject: [LTP] [PATCH v2 2/2] syscalls/msgstress: scale number of
 processes accodingly to available RAM
In-Reply-To: <20200618094139.24579-2-xuyang_jy_0410@163.com>
References: <20200618094139.24579-1-xuyang_jy_0410@163.com>
 <20200618094139.24579-2-xuyang_jy_0410@163.com>
Message-ID: <20200722154558.GB2714@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
The main problem with this patch is that it's doing too much.

The conversion to the new library should be ideally done in a separate
patch, then we should start working on getting the limits right.

For the limits I would really like to introduce a library function that
would return how many processes test can run before the system runs out
of memory then we can build on the top of that and create a library
function to return now many message queues we can run. As it is the code
is still copy&pasted between the testcases.

So please can we do things in smaller, well defined, steps?

-- 
Cyril Hrubis
chrubis@suse.cz
