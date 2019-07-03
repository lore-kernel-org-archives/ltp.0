From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Jul 2019 16:19:18 +0200
Subject: [LTP] [PATCH v1 1/2] syscalls/lstat{01,03} rewrote testcase
In-Reply-To: <20190611104747.14689-1-camann@suse.com>
References: <20190611104747.14689-1-camann@suse.com>
Message-ID: <20190703141918.GB17665@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor change, thanks.

I've made the stat_buf local variable and also memset() it to 0 before
the test (mostly because of -i paramter).

-- 
Cyril Hrubis
chrubis@suse.cz
