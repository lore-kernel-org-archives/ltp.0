From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Jun 2021 15:43:20 +0200
Subject: [LTP] [PATCH v2 02/10] getitimer02: Skipped EFAULT tests for
 libc variant.
In-Reply-To: <20210609173601.29352-2-vinay.m.engg@gmail.com>
References: <YL/Wf51Y6V5lRnkM@pevik>
 <20210609173601.29352-1-vinay.m.engg@gmail.com>
 <20210609173601.29352-2-vinay.m.engg@gmail.com>
Message-ID: <YMNoeLR3J9Ah1eAZ@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
What is the point of adding test variants when the test does only EFAULT
test that ends up being skipped on the libc variant?

Can't we simply just switch to the syscall here instead?

-- 
Cyril Hrubis
chrubis@suse.cz
