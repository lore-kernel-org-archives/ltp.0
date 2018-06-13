From: Li Wang <liwang@redhat.com>
Date: Wed, 13 Jun 2018 16:56:41 +0800
Subject: [LTP] [RFC PATCH 3/9] syscalls/ipc: Rewrite msgctl01 + merge
	msgctl06
In-Reply-To: <20180612154631.435-4-chrubis@suse.cz>
References: <20180612154631.435-1-chrubis@suse.cz>
 <20180612154631.435-4-chrubis@suse.cz>
Message-ID: <CAEemH2fmszUp0TMC24+kJuGYrBbwyrwe67B28AoWB16-MCj89A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> wrote:

> ​[...]
>
>
> -int main(int ac, char **av)
> -{
> -       int lc;
> +       if (TEST_RETURN != 0) {
> +               tst_res(TFAIL | TTERRNO, "msgctl() returned %li",
> TEST_RETURN);
> +               return;
> +       }
>
> -       tst_parse_opts(ac, av, NULL, NULL);
> +       tst_res(TPASS, "msgctl(IPC_STAT)");
>
> -       setup();                /* global setup */
> +       if (buf.msg_stime == 0)
> +               tst_res(TPASS, "msg_stime = 0");
> +       else
> +               tst_res(TFAIL, "msg_stime = %lu", (unsigned
> long)buf.msg_stime);
>
> -       /* The following loop checks looping state if -i option given */
> +       if (buf.msg_rtime == 0)
> +               tst_res(TPASS, "msg_rtime = 0");
> +       else
> +               tst_res(TFAIL, "msg_rtime = %lu", (unsigned
> long)buf.msg_rtime);
>
> -       for (lc = 0; TEST_LOOPING(lc); lc++) {
> -               /* reset tst_count in case we are looping */
> -               tst_count = 0;
> +       if (buf.msg_ctime == creat_time || buf.msg_ctime == creat_time +
> 1) {

​
​I'm thinking that whether 1 second is enough for system shaking. ​If this
program is running on an overload system, this maybe delay more than 1
second and test fails, is that a test defect?​

Maybe gives more flexible as:
    if (buf.msg_ctime <= creat_time && buf.msg_ctime >= creat_time - 3)


> +               tst_res(TPASS, "msg_ctime = %lu, expected %lu",
> +                       (unsigned long)buf.msg_ctime, (unsigned
> long)creat_time);
> +       } else {
> +               tst_res(TPASS, "msg_ctime = %lu, expected %lu",
>

​seems typo here?  TFAIL



> +                       (unsigned long)buf.msg_ctime, (unsigned
> long)creat_time);
> +       }


>
​Beside that, I got this follow errors occasionally:

​# ./msgctl01
tst_test.c:1015: INFO: Timeout per run is 0h 05m 00s
tst_safe_sysv_ipc.c:51: BROK: msgctl01.c:137: msgget(1627794347, 7b0)
failed: EEXIST​

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180613/0f181e3f/attachment.html>
