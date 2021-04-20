From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Apr 2021 16:48:51 +0200
Subject: [LTP] [PATCH v2] syscalls/wait02.c: Convert to new API
In-Reply-To: <20210419094431.2418-1-gaozh.jy@fujitsu.com>
References: <20210419094431.2418-1-gaozh.jy@fujitsu.com>
Message-ID: <YH7p00c276VxJPYg@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor changes to the tst_res() messages, thanks.

...
> +	tst_res(TFAIL, "wait(&status) got wrong exit status 0x%x", status);

We do have a tst_strstatus() that formats the wait status into a
readable string, so I've changed this meessage to make use of it.

I've also removed the &status part for the messages, since it does not
add any useful information.

-- 
Cyril Hrubis
chrubis@suse.cz
