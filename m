From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 13 Feb 2020 07:40:44 -0500 (EST)
Subject: [LTP] [PATCH v2 2/2] syscalls/kill11,
 abort01: lower MIN_RLIMIT_CORE size
In-Reply-To: <1581590121-4626-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1581590121-4626-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1581590121-4626-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1420373308.7517416.1581597644001.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From ulimit manpage, ulimit -c options used 512-bytes-block in posix mode
> and used 1024-bytes-block in common mode. Usually, this case used "ulimit
>  -c 1024" to test, but it will report TCONF in posix mode under unprivileged
>  user.
> Since these two cases only check correct signal, lower this size doesn't
> affect
> this result. This also can avoid github issue(640[1],83[2]).
> 
> [1]https://github.com/linux-test-project/ltp/issues/640
> [2]https://github.com/linux-test-project/ltp/issues/83
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

both look good to me, ack

