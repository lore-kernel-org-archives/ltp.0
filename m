From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 24 Jan 2017 19:15:55 +0300
Subject: [LTP] [PATCH] test_net.sh: add tst_wait_ipv6_dad()
In-Reply-To: <20170124153732.GA31989@rei.lan>
References: <1484139234-14043-1-git-send-email-alexey.kodanev@oracle.com>
 <20170124153732.GA31989@rei.lan>
Message-ID: <df591234-5e5f-4934-bf2b-1b8c6c946bfb@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 24.01.2017 18:37, Cyril Hrubis wrote:
>
> My only concern here is that sleeping for 1s is too much and will slow
> down things more than it should. How long this operation usually takes?
> Can we reduce the sleep to 0.1s here and print the TINFO only
> if [ $((i % 10)) -eq 0 ] ?
Hi Cyril,

1 sec minimum,  I guess it should be fine if I add a check whether
interfaces
already configured or not, as a result we shouldn't flush/configure/wait
on each
test or group of tests...

Thanks,
Alexey

