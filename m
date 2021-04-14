From: wangxin (CQ) <wangxin410@huawei.com>
Date: Wed, 14 Apr 2021 08:15:58 +0000
Subject: [LTP] =?utf-8?b?562U5aSNOiAgW1BBVENIXSBvcGVucG9zaXgvY29uZm9ybWFu?=
 =?utf-8?q?ce/interfaces=3A_Correct_typos?=
In-Reply-To: <CAEemH2ctSMR5OF=0TQX1eNmTE7PcdEdMbjoYXc3RxiBsyfzcuw@mail.gmail.com>
References: <1617765607-78263-1-git-send-email-wangxin410@huawei.com>
 <CAEemH2ctSMR5OF=0TQX1eNmTE7PcdEdMbjoYXc3RxiBsyfzcuw@mail.gmail.com>
Message-ID: <91a235700b494bdf9a9a7dd1901aa947@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Wang,

Thanks so much for your review!

I just re-checked the latest code and found that the code needed to be modified was not the same as the last time.
Therefore, do you want to incorporate the patch submitted last time?
If there is a conflict, I can modify the patch submitted last time.

--
Regards,
Wang Xin

???: Li Wang [mailto:liwang@redhat.com]
????: 2021?4?14? 14:58
???: wangxin (CQ) <wangxin410@huawei.com>
??: LTP List <ltp@lists.linux.it>
??: Re: [LTP] [PATCH] openposix/conformance/interfaces: Correct typos

Hi Xin,

Sorry for the late reply.

On Wed, Apr 7, 2021 at 11:03 AM Wang Xin <wangxin410@huawei.com<mailto:wangxin410@huawei.com>> wrote:
Types in the name of the temporary files: For example, in aio_cancel/8-1.c file,
pts_aio_cancel_1_1 -> pts_aio_cancel_8_1.
Others like this have been modified.

Good catch!

Since there are many changes before this patch, could you
rebase this patch on the latest main branch and resend?
(in order to get rid of the patch conflict :)

--
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210414/b702708b/attachment-0001.htm>
