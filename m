From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Aug 2016 13:34:51 +0200
Subject: [LTP] [PATCH] tst_test: Propagate SIGINT to test process
In-Reply-To: <321891608.1353493.1470404076410.JavaMail.zimbra@redhat.com>
References: <20160804144508.GA8001@rei.lan>
 <321891608.1353493.1470404076410.JavaMail.zimbra@redhat.com>
Message-ID: <20160816113451.GA25092@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This still gives me a warning:
>   tst_test.c: In function ???sigint_handler???:
>   tst_test.c:732:3: warning: ignoring return value of ???write???, declared with attribute warn_unused_result [-Wunused-result]
>    (void)write(2, SIGINT_MSG, sizeof(SIGINT_MSG) - 1);
>    ^
> We could use fprintf(stderr):
>   fprintf(stderr, "%s\n", SIGINT_MSG);

Ping.

What do you think about this?

Should we ignore the warning for the time being or add the dummy if ()
to silence it?

-- 
Cyril Hrubis
chrubis@suse.cz
