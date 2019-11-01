From: Li Wang <liwang@redhat.com>
Date: Fri, 1 Nov 2019 14:13:55 +0800
Subject: [LTP] [PATCH] hugetlb: Initialize orig_shmmax and orig_shmmni
 value
In-Reply-To: <CAEemH2dOwoE2YMXn-+Ugb=-3=V5b-Q-X0KU+xDdRogWF-5ViWQ@mail.gmail.com>
References: <20191031064451.14966-1-tesheng@andestech.com>
 <CAEemH2dOwoE2YMXn-+Ugb=-3=V5b-Q-X0KU+xDdRogWF-5ViWQ@mail.gmail.com>
Message-ID: <CAEemH2cxrKbYF2k6__MQmpfsbWQ6Xez+xcFSwReP_wjxNi-gCw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Oct 31, 2019 at 4:17 PM Li Wang <liwang@redhat.com> wrote:

>
>
> On Thu, Oct 31, 2019 at 2:45 PM Eric Lin <tesheng@andestech.com> wrote:
>
>> When doing save_nr_hugepages() in setup() and there
>> is no Huge page support in system, it will call
>> cleanup() and write wrong orig_shmmax and orig_shmmni
>> value back to file.
>>
>> To fix it, we initialize the orig_shmmax and
>> orig_shmmni to -1 and check it in cleanup().
>>
>> Signed-off-by: Eric Lin <tesheng@andestech.com>
>
> Reviewed-by: Li Wang <liwang@redhat.com>
>

Pushed.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191101/3ce2e419/attachment.htm>
