From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 May 2020 17:09:40 +0200
Subject: [LTP] [PATCH v2 3/3] syscalls/prctl: Use TST_ASSERT_FILE_INT/STR
In-Reply-To: <1588240704-14747-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200429120609.GA668@yuki.lan>
 <1588240704-14747-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1588240704-14747-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200506150940.GD11352@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static char proc_sup[20] = "Yes";

I've changed the proc_sup to a pointer, there is no point in having
this as an array when we can just change the pointer instead of
strcpy().

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
