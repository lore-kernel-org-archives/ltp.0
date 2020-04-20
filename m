From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 20 Apr 2020 15:01:40 +0200
Subject: [LTP] [PATCH v2 02/10] syscalls/ioctl:add common c file for
 loop ioctl
In-Reply-To: <48142e6b-8169-2934-e8b2-f71927cd62b0@cn.fujitsu.com>
References: <20200409075506.GA2828@yuki.lan>
 <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1586429086-22975-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200417151050.GA2491@yuki.lan>
 <8dd0a496-c46f-55d2-2393-5566eff618ff@cn.fujitsu.com>
 <48142e6b-8169-2934-e8b2-f71927cd62b0@cn.fujitsu.com>
Message-ID: <20200420130140.GB11604@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +void tst_assert_file_str(const char *file, const int lineno, const char 
> *path, const char *buf, const char *val)
> +{
> +       char sys_val[1024];
> +
> +       SAFE_FILE_LINES_SCANF(path, buf, sys_val);

We should call the file_lines_scanf() here and pass the filename and
lineno that this functions takes as parameter instead.

Also I'm not sure that it's a good idea to pass the fmt to this
function. I guess that it would be better to pass a prefix string such
as "foo=" and to append the "%s" in this function. That way we could
also encode the buffer length to the fmt string as well, in that case we
would append "%1024s".

> +       if (!strcmp(val, sys_val)) {
> +               tst_res_(file, lineno, TPASS, "%s %s field = %s", path, 
> buf, sys_val);
> +               return;
> +       }
> +
> +       tst_res_(file, lineno, TFAIL, "%s %s field != %s got %s", path, 
> buf, val, sys_val);
> +}



-- 
Cyril Hrubis
chrubis@suse.cz
