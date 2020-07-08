From: Li Wang <liwang@redhat.com>
Date: Wed, 8 Jul 2020 14:30:37 +0800
Subject: [LTP] [PATCH 1/1] numa01.sh: Handle computation error
In-Reply-To: <2c7f1334-0ff1-7530-90fa-7f3ce796a829@linux.ibm.com>
References: <20200701233133.122801-1-petr.vorel@gmail.com>
 <CAEemH2cHWqRQ+bkUCof8mrK7jfy-DsuA9wegmOT8D-h8F1Cu2g@mail.gmail.com>
 <2c7f1334-0ff1-7530-90fa-7f3ce796a829@linux.ibm.com>
Message-ID: <CAEemH2dKAuteO=UWm=M4D4LeW4KVcLdts_AwiLRyYsdur14ESA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jul 3, 2020 at 11:48 AM Harish <harish@linux.ibm.com> wrote:

> On 7/3/20 8:30 AM, Li Wang wrote:
>
> Hi Petr, Harish,
>
> Though the root cause is from the non-ordered node in a special machine, I
> still think this patch makes sense to numa01, because the function
> get_mem_cur() make code more readable.
>
> So I'm going to merge both this one and Harish's patch, after doing that,
> I will also follow Cyril's comment to remove test8(migrate_pages).
>
> Any objections? or comments?
>
> Makes sense to me.
>

I have pushed both patches, and remove the test8 too.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200708/9377025f/attachment-0001.htm>
