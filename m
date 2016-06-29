From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 29 Jun 2016 16:47:11 +0300
Subject: [LTP] [PATCH] network/busy_poll: make test results more stable
In-Reply-To: <35755633.671473.1467198066896.JavaMail.zimbra@redhat.com>
References: <1467045057-19618-1-git-send-email-alexey.kodanev@oracle.com>
 <35755633.671473.1467198066896.JavaMail.zimbra@redhat.com>
Message-ID: <5773D15F.9060606@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 06/29/2016 02:01 PM, Jan Stancek wrote:
> ...
> With patch:
> busy_poll01 1 TINFO : set low latency busy poll to 50
> busy_poll01 1 TINFO : run tcp_fastopen with 'localhost', port '30109'
> busy_poll01 1 TINFO : time spent is '3874' ms
> busy_poll01 1 TINFO : set low latency busy poll to 0
> busy_poll01 1 TINFO : run tcp_fastopen with 'localhost', port '10440'
> busy_poll01 1 TINFO : time spent is '12561' ms
> busy_poll01 1 TPASS : busy poll increased performance by '70' %
>
> real    0m19.006s
> user    0m0.749s
> sys     0m16.408s

Thank you for verifying it,  patch applied.

Best regards,
Alexey
