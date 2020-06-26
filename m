From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 Jun 2020 11:04:59 +0200
Subject: [LTP] [PATCH V4 2/2] syscalls/clock_gettime: Add test to check
 bug during successive readings
In-Reply-To: <20200626085327.GB2631@yuki.lan>
References: <0fb91044431a04c2787bfa121a7e5f969664fc8b.1591948595.git.viresh.kumar@linaro.org>
 <a92d6492218673113f1b4b45733adad48b805bb3.1593147069.git.viresh.kumar@linaro.org>
 <20200626085327.GB2631@yuki.lan>
Message-ID: <20200626090459.GC2631@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Applied, thanks a lot.

With a minor change, indentifiers starting with underscore(s) are
reserved for libc and kernel headers, we shall not use them, hence I
renamed the _vdso_gettime() to do_vdso_gettime().

-- 
Cyril Hrubis
chrubis@suse.cz
