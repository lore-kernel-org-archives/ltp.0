From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 19 Aug 2020 08:37:36 -0400 (EDT)
Subject: [LTP] [PATCH v2] clock_settime03: change to use CLOCK_REALTIME
In-Reply-To: <20200819083843.26435-1-liwang@redhat.com>
References: <20200819083843.26435-1-liwang@redhat.com>
Message-ID: <1494399286.9212519.1597840656586.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> CLOCK_REALTIME_ALARM requires an RTC with alarm support, which may not be
> present on a system. In that case, the kernel will return EOPNOTSUPP, which
> is defined as ENOTSUP in userspace.
> 
> Here use CLOCK_REALTIME instead of the CLOCK_REALTIME_ALARM because we do
> NOT need suspend the SUT during test.
> 
> For issue #712:
>   https://github.com/linux-test-project/ltp/issues/712
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Viresh Kumar<viresh.kumar@linaro.org>
> Cc: Cyril Hrubis <chrubis@suse.cz>
> Cc: Jan Stancek <jstancek@redhat.com>
> Tested-by: Li Wang <liwang@redhat.com>

Acked-by: Jan Stancek <jstancek@redhat.com>

