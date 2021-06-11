From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Jun 2021 16:00:21 +0200
Subject: [LTP] [PATCH v2 06/10] setitimer02: Skipped EFAULT tests for
 libc variant.
In-Reply-To: <20210609173601.29352-6-vinay.m.engg@gmail.com>
References: <YL/Wf51Y6V5lRnkM@pevik>
 <20210609173601.29352-1-vinay.m.engg@gmail.com>
 <20210609173601.29352-6-vinay.m.engg@gmail.com>
Message-ID: <YMNsdfm7VW2dW9Hw@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Here as well, no need for the variant if the test checks only the EFAULT
error. We can simply switch to the syscall variant instead.

-- 
Cyril Hrubis
chrubis@suse.cz
