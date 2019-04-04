From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Apr 2019 10:20:18 +0800
Subject: [LTP] [PATCH] hugetlb/hugemmap01: dynamically change default
	hugepages
In-Reply-To: <CAAb+4C6Jf2iLCcAXiaYdoBv_YG=7s7K2vUw0mNyX0qXTS4SGpA@mail.gmail.com>
References: <20190403075935.8407-1-xiliang@redhat.com>
 <CAEemH2ea3S1zKsGK851MbnbQnwtxwg03i6Nf-uAwnvUE0yxY0A@mail.gmail.com>
 <CAAb+4C6Jf2iLCcAXiaYdoBv_YG=7s7K2vUw0mNyX0qXTS4SGpA@mail.gmail.com>
Message-ID: <CAEemH2fqAAhahkohQSbzr2Lq3KbH-S8n2j7ZUZ4-o5Loq0WqRA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

[Cc' LTP mailling list] To respect the ML:).

On Wed, Apr 3, 2019 at 11:12 PM Xiao Liang <xiliang@redhat.com> wrote:

>
>
> On Wed, Apr 3, 2019 at 8:19 PM Li Wang <liwang@redhat.com> wrote:
>
>> Hi Xiao,
>>
>> On Wed, Apr 3, 2019 at 7:56 PM Xiao Liang <xiliang@redhat.com> wrote:
>>
>>> When the system's Hugepagesize is large(eg. 512MiB), the test may
>>> break as cannot set nr_hugepages to default 128.
>>>
>>
>> Yes, that's true. But each of ltp/hugemmap test has a
>> parameter(hugemmap01 -s #nr_hpage#) to reset the nr_huagepges number before
>> testing. What we have done to avoid that is to customize the hugetlb
>> runtest file via a wrapper script.
>>
>  Yes, I tried '-s' option too, but runtest file does not specify it.
> Although default 128 works in most situations, I feel it is not very
> convenient for users to specify it or need double check it in each run in
> different platforms.
>
>>
>>> This patch checks the memory available and Hugepagesize registered
>>> to set a reasonable num.
>>>
>>
>> I have no objection on this way. But a better way maybe to achieve a new
>> function in the hugetlb library to reset nr_hugepages dynamically for the
>> whole hugepage tests.
>>
> Yes. I prefer this way than hard coding it with 128. I think we can add a
> new function into library as other cases use it too.
>

Ok, It'd be great if you can help to draft a new patch for this.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190404/6e414519/attachment.html>
