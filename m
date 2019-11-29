From: Li Wang <liwang@redhat.com>
Date: Fri, 29 Nov 2019 11:43:33 +0800
Subject: [LTP] [COMMITTED PATCH] mmap1: include lapi/abisize.h header
 file
In-Reply-To: <16eba1ee-8b23-13c5-f496-3758c2b29fc8@163.com>
References: <20191128082945.6495-1-liwang@redhat.com>
 <1766813779.14211710.1574930105928.JavaMail.zimbra@redhat.com>
 <CAEemH2cW+XUARCzyreQQgJnd1HSV506JEn4rt=oGyezXRtLKFw@mail.gmail.com>
 <16eba1ee-8b23-13c5-f496-3758c2b29fc8@163.com>
Message-ID: <CAEemH2fhobsR2ethyGe2uOMk=j7KHfttn2hN3YsCv8YX7k9NNg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Nov 29, 2019 at 11:35 AM Xiao Yang <ice_yangxiao@163.com> wrote:

> ...
>
>
>> This sounds familiar:
>>   74d9fe32fda9 ("mtest06/mmap1: add missing lapi/abisize.h include")
>>
>
> Ah, sorry I was blind for missing this commit. Seems I just git pull&push
> my patch.
>
> Hi Li,
>
> Perhaps, you should git revert the duplicated patch. :-)
>
Ok sure, but it doesn't matter for including twice I guess. :)

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191129/c7aad147/attachment.htm>
