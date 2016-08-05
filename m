From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 5 Aug 2016 10:30:34 +0200
Subject: [LTP] [PATCH V3 2/6] tst_test: make reap_children() part of the
 test API
In-Reply-To: <20160804161323.GC3367@rei.lan>
References: <1470320195-22145-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470320195-22145-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160804161323.GC3367@rei.lan>
Message-ID: <20160805083033.GA12117@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> And it's nearly the same in case of tst_brk(TCONF, ...) but the exit
> value will be 0 and the TCONF is instead stored in the result structure
> in the shared memory.

Scratch that, the tst_brk(TCONF, ...) behaves exactly the same as
tst_brk(TBRO, ...). I.e. propagates via return value. Sorry for being
confusing.

-- 
Cyril Hrubis
chrubis@suse.cz
