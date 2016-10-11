From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 11 Oct 2016 10:41:29 +0200
Subject: [LTP] [PATCH v2 3/3] writev01: rewrite and drop partially valid
 iovec tests
In-Reply-To: <57FC9729.7000107@redhat.com>
References: <81176684cd5c6bf764a070b79783f03f0037658a.1475827191.git.jstancek@redhat.com>
 <d6b408e9dcb22db9c362377a2d35876fdb6d7096.1475827191.git.jstancek@redhat.com>
 <20161010160346.GG1684@rei> <57FC9729.7000107@redhat.com>
Message-ID: <20161011084128.GA14295@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> How about:
> 
> static void test_writev(unsigned int i)
> {
>         struct testcase_t *tcase = &testcases[i];
>         int ret;
> 
>         TEST(writev(*(tcase->pfd), *(tcase->piovec), tcase->iovcnt));
> 
>         ret = (TEST_RETURN == tcase->exp_ret);
>         if (TEST_RETURN < 0 || tcase->exp_ret < 0) {
>                 ret &= (TEST_ERRNO == tcase->exp_errno);
>                 tst_res((ret ? TPASS : TFAIL),
>                         "%s, expected: %d (%s), got: %ld (%s)", tcase->desc,
>                         tcase->exp_ret, tst_strerrno(tcase->exp_errno),
>                         TEST_RETURN, tst_strerrno(TEST_ERRNO));
>         } else {
>                 tst_res((ret ? TPASS : TFAIL),
>                         "%s, expected: %d, got: %ld", tcase->desc,
>                         tcase->exp_ret, TEST_RETURN);
>         }
> }

Looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
