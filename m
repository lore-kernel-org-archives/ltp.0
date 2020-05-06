From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 May 2020 17:08:27 +0200
Subject: [LTP] [PATCH v2 2/3] lib: Add TST_ASSERT_FILE_INT and
 TST_ASSERT_FILE_STR
In-Reply-To: <1588240704-14747-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200429120609.GA668@yuki.lan>
 <1588240704-14747-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1588240704-14747-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200506150827.GC11352@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +void tst_assert_file_int(const char *file, const int lineno, const char *path, const char *prefix, int val)
> +{
> +	int sys_val;
> +	char fmt[1024];
> +
> +	sprintf(fmt, "%s%%d", prefix);

I've changed this sprintf() to snprintf() and the same for the file_str
function and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
