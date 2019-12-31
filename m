From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 31 Dec 2019 15:05:30 +0800
Subject: [LTP] [PATCH RFC] sync_file_range02: remove the toplimit of
 write back
In-Reply-To: <CAEemH2dyHSS20Lf9neVfY6voN-EO60_MQdXjb0Xjy9VsDfbZwA@mail.gmail.com>
References: <20191218082826.25083-1-liwang@redhat.com>
 <2104821569.17247635.1576661091375.JavaMail.zimbra@redhat.com>
 <CAFA6WYN1ssqCzCqvT=9=DLjZdQz8OnH7+YBi8VGo7XLRdNLyvg@mail.gmail.com>
 <CAEemH2eRhmozt5OiT6z-YBjJUBNaGZgQVQRh40hNpKcq2d4-aw@mail.gmail.com>
 <CAFA6WYOBbH8UbwrK1f3ZQjGuqHJqGZxhQ-N0w1mpBHz0bnPG1w@mail.gmail.com>
 <CAEemH2eXvZB9uCuZFsc2uMAt5k2F_gfgXCqch58juMsJn4Gr4w@mail.gmail.com>
 <CAEemH2coGZGjFLhHzeR4JJYWpERGypjRdXRQ2dO0f1=Drh2KOg@mail.gmail.com>
 <23f8d05b-efff-56ba-b5d8-f99046e5619c@cn.fujitsu.com>
 <CAEemH2dyHSS20Lf9neVfY6voN-EO60_MQdXjb0Xjy9VsDfbZwA@mail.gmail.com>
Message-ID: <d3baf4e5-66cb-6288-6742-0f7d1dc89090@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



Hi Li
> Hi Yang,
> 
> Yang Xu <xuyang2018.jy@cn.fujitsu.com 
> <mailto:xuyang2018.jy@cn.fujitsu.com>> wrote:
> 
>     ...
> 
>>
>>     I have tried this for many different systems, and it doesn't hit
>>     the failure at least one time. So if no more comments, I would
>>     merge the patch as below in the next step.
> 
>     I have a question.we must call sync()? I think syncfs is more accurate.
> 
> 
> Here we use sync() is to make fs metadata/cache being written back 
> before testing because there is no obtainable?file descriptor 'fd' for 
> the ext4 deferred?IO (e.g. initialize the journal and inode tables).
I see. For other test cases using tst_dev_bytes_written api such as 
fdatasync03.c,  we also need to call sync() to make this written value 
more accurate.  What do you think about it?

Best Regards
Yang Xu
> 
> -- 
> Regards,
> Li Wang


