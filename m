From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 29 Jun 2016 07:01:06 -0400 (EDT)
Subject: [LTP] [PATCH] network/busy_poll: make test results more stable
In-Reply-To: <1467045057-19618-1-git-send-email-alexey.kodanev@oracle.com>
References: <1467045057-19618-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <35755633.671473.1467198066896.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Alexey Kodanev" <alexey.kodanev@oracle.com>
> To: ltp@lists.linux.it
> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>
> Sent: Monday, 27 June, 2016 6:30:57 PM
> Subject: [LTP] [PATCH] network/busy_poll: make test results more stable
> 
> Changing tcp network load from 'connect/request/response/close'
> to 'request/response'. Results will be more stable as we aren't
> closing/establishing tcp connection after 3 requests from client.
> 
> There're other tests that do such stress testing so such test-case
> won't be removed.
> 
> It'll also decrease test time by several times.
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>

ACK.

As advertised my KVM guest running 4.5.0 shows more significant
difference between busy poll 0/50:

Without patch:
busy_poll01 1 TINFO : set low latency busy poll to 50
busy_poll01 1 TINFO : run tcp_fastopen with 'localhost', port '37532'
busy_poll01 1 TINFO : time spent is '25039' ms
busy_poll01 1 TINFO : set low latency busy poll to 0
busy_poll01 1 TINFO : run tcp_fastopen with 'localhost', port '61133'
busy_poll01 1 TINFO : time spent is '35203' ms
busy_poll01 1 TPASS : busy poll increased performance by '29' %

real    1m2.866s
user    0m1.542s
sys     1m5.937s

With patch:
busy_poll01 1 TINFO : set low latency busy poll to 50
busy_poll01 1 TINFO : run tcp_fastopen with 'localhost', port '30109'
busy_poll01 1 TINFO : time spent is '3874' ms
busy_poll01 1 TINFO : set low latency busy poll to 0
busy_poll01 1 TINFO : run tcp_fastopen with 'localhost', port '10440'
busy_poll01 1 TINFO : time spent is '12561' ms
busy_poll01 1 TPASS : busy poll increased performance by '70' %

real    0m19.006s
user    0m0.749s
sys     0m16.408s
