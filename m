From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 5 Aug 2020 17:20:06 +0200
Subject: [LTP] [PATCH 0/3] testcases/kernel/syscalls: Adding new
 testcases for existing tests
In-Reply-To: <20200804144045.18875-1-Filip.Bozuta@syrmia.com>
References: <20200804144045.18875-1-Filip.Bozuta@syrmia.com>
Message-ID: <20200805152006.GB631@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
First of all these patches should use tst_get_bad_addr() in the test
setup in order to get the bad address pointer.

-- 
Cyril Hrubis
chrubis@suse.cz
