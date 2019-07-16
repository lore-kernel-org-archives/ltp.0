From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Jul 2019 16:17:39 +0200
Subject: [LTP] [PATCH] syscalls/acct02.c: Read threshold from
 /proc/sys/kernel/acct
In-Reply-To: <02b9f80d-05ec-e837-5770-c12f73f6bb0f@163.com>
References: <1563203796-22102-1-git-send-email-ice_yangxiao@163.com>
 <20190715160010.GA30303@rei.lan>
 <02b9f80d-05ec-e837-5770-c12f73f6bb0f@163.com>
Message-ID: <20190716141739.GA17060@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Good catch, I missed the sysctl API since I haven't realized that the
> > proc handlers are all stuffed in a different file in kernel/sysctl.c.
> >
> > What about we as well temporarily lower the value if needed while the
> > test is running?
> Hi Cyril,
> 
> When free space is not enough, test can change the threshold by itself
> or remind user to modify the threshold by sysctl API manually.
> 
> Which one do you prefer?

Ideally the test should modify the threshold.

-- 
Cyril Hrubis
chrubis@suse.cz
