From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Wed, 25 Nov 2020 12:23:02 +0100
Subject: [LTP] kernel BUG at mm/highmem.c:417! invalid opcode: 0000 EIP:
 zero_user_segments
In-Reply-To: <20201125004632.GG4327@casper.infradead.org>
References: <CA+G9fYuKZGaHVvAv=ZwOL_p6UM3YhOHy0DcJRRM_DOLGYXg1Dw@mail.gmail.com>
 <20201124171628.dk6tle5lh3sx2jxg@linutronix.de>
 <20201125004632.GG4327@casper.infradead.org>
Message-ID: <20201125112302.zh6x3hq7wyzqoz66@linutronix.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020-11-25 00:46:32 [+0000], Matthew Wilcox wrote:
> 
> Thanks for debugging this!  I didn't realise start1 was allowed to be
> less than start2.  Try this ... (systemd is sabotaging my efforts to
> test an i386 kernel)

You are welcome.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
