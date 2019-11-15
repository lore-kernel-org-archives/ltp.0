From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 15 Nov 2019 17:35:17 +0100
Subject: [LTP] [PATCH v5 2/2] syscalls/prctl09: New timer sample test
 for PR_SET_TIMERSLACK
In-Reply-To: <1573214419-15435-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20191107130543.GD22352@rei.lan>
 <1573214419-15435-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1573214419-15435-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20191115163517.GB25964@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> It also moves test setup function before timer setup function,
> so we can get this set value.

Can we please change the library code in a separate patch with
appropripate description of the change?

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
