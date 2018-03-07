From: Li Wang <liwan@redhat.com>
Date: Wed, 7 Mar 2018 17:13:41 +0800
Subject: [LTP] [PATCH] times03: don't assume process initial [us]time is
	0
In-Reply-To: <8385516ec732e57976aeef8789480c6bf0199bcb.1520411634.git.jstancek@redhat.com>
References: <8385516ec732e57976aeef8789480c6bf0199bcb.1520411634.git.jstancek@redhat.com>
Message-ID: <CAEemH2fXEVWyQTLmOGHVVXidNNfzz=7mKZEE04F5-KgcuZwkhA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Wed, Mar 7, 2018 at 4:34 PM, Jan Stancek <jstancek@redhat.com> wrote:

> times() runs immediately after fork(), but syscall alone
> seems to be enough for some systems to already account ticks.
>
> For example on arm64 with 4.14:
>   tst_test.c:980: INFO: Timeout per run is 0h 05m 00s
>   times03.c:102: PASS: buf1.tms_utime = 0
>   times03.c:105: FAIL: buf1.tms_stime = 1
>   ...
>
> This patch drops the initial zero check for [us]time.
>

​Acked-by: Li Wang <liwang@redhat.com>​



-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180307/976413e1/attachment.html>
