From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 18 Aug 2020 15:37:21 +0200
Subject: [LTP] [PATCH v3 1/2] syscalls/clock_nanosleep: add a test case
 for bad timespec address
In-Reply-To: <20200817102232.5902-2-Filip.Bozuta@syrmia.com>
References: <20200817102232.5902-1-Filip.Bozuta@syrmia.com>
 <20200817102232.5902-2-Filip.Bozuta@syrmia.com>
Message-ID: <20200818133721.GB27964@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've moved the comment about covered errors to the top of the source
code (just after copyrights) so that we are consistent with the rest of
the testcases and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
