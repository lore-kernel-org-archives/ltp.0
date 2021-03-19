From: Li Wang <liwang@redhat.com>
Date: Fri, 19 Mar 2021 12:56:59 +0800
Subject: [LTP] [PATCH v2 2/2] doc: Add Maintainer Patch Review Checklist
In-Reply-To: <CAEemH2fUGFY6YH=m4SfGpJ_nbYWJmUK1_-mLK8n74zM_WNFLng@mail.gmail.com>
References: <20210318181641.2062-1-pvorel@suse.cz>
 <20210318181641.2062-3-pvorel@suse.cz>
 <CAEemH2fUGFY6YH=m4SfGpJ_nbYWJmUK1_-mLK8n74zM_WNFLng@mail.gmail.com>
Message-ID: <CAEemH2dRU-3Q-qjE+t_O6Zh8MKDg4C+1vPAnUR+Js9_fHvFykA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Li Wang <liwang@redhat.com> wrote:


> +Commit messages should have
>> +
>> +* Author's `Signed-off-by` tag
>> +* Committer's `Reviewed-by` or `Signed-off-by` tag
>>
>
> Or adding `Acked-by:` also acceptable?
>
> I'm not sure what's the difference between Acked-by and Reviewed-by,
> but personally feel the Acked-by has more confidence in the reviewing.
>
> In my mind,
>
> `Acked-by` means:
> code review OK, compiled OK, executed OK, has confidence it OK for all
> arches
>
> `Reviewed-by` means:
> code review OK, compiled and executed OK just locally or optional, still room
> for improvement/discussion
>

Plz ignore my rough understanding, I find a precise description at kernel
process/submitting-patches.rst.

https://github.com/torvalds/linux/blob/master/Documentation/process/submitting-patches.rst#when-to-use-acked-by-cc-and-co-developed-by

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210319/933026c4/attachment.htm>
