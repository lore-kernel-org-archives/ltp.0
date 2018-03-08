From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 8 Mar 2018 16:14:03 +0100
Subject: [LTP] [PATCH] Add tst_flush() library function
In-Reply-To: <20180308105704.7823-1-mmoese@suse.de>
References: <20180308105704.7823-1-mmoese@suse.de>
Message-ID: <20180308151359.GA1777@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've tried to apply this but found out that there is tst_flush() in the
old library and because of that the code does not even compile.

So we have to rename the tst_flush() in the old library to something as
tst_old_flush() and also remove it from the ltpapicmd.c since there are
no shell tests that call that command (ltpapicmd.c should hopefully die
some day soon). Should I do that or will you send another patch? :-)

Also we should make use of the tst_flush() in the safe_fork() so that we
finally flush the right stream in the new test library...

-- 
Cyril Hrubis
chrubis@suse.cz
