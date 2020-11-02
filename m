From: Li Wang <liwang@redhat.com>
Date: Mon, 2 Nov 2020 14:53:12 +0800
Subject: [LTP] [PATCH v2] madvise06: Increase reliability and diagnostic
 info
In-Reply-To: <CAEemH2cevcmS1Cq-t0667CwQmxWL=6YNdBzvKNem2YV1E5EVSg@mail.gmail.com>
References: <CAEemH2d8+5qLLKWsuf5WJeLHdv2VfPZiyM9-oW=WyH4m==h=8g@mail.gmail.com>
 <20201027132334.1027-1-rpalethorpe@suse.com>
 <CAEemH2cevcmS1Cq-t0667CwQmxWL=6YNdBzvKNem2YV1E5EVSg@mail.gmail.com>
Message-ID: <CAEemH2f2-ByWBtrwukF_B8q_yGMj4Km6VN15viT7cAeisa8w0w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cc LTP ML.

On Mon, Nov 2, 2020 at 2:50 PM Li Wang <liwang@redhat.com> wrote:

>
>
> On Tue, Oct 27, 2020 at 9:24 PM Richard Palethorpe <rpalethorpe@suse.com>
> wrote:
>
>> When memcg.limit_in_bytes is set to PASS_THRESHOLD it's unlikely
>> swapcached will increase by more than PASS_THRESHOLD unless processes
>> in other memcgs are also increasing it. Additionally MADV_WILLNEED
>> must remove pages from memory as it adds more so that the first page
>> may not be in memory by the time the last page is faulted if the
>> amount exceeds the memory limit (which it does because CHUNK_SZ >
>> PASS_THRESSHOLD). Worse if pages are faulted in a non-linear way, or
>> the process must access some other pages, then there is no guarantee
>> which parts of the range will be resident in memory. This results in
>> spurious test failures.
>>
>> To solve this we can set PASS_THRESHOLD to 1/4 of CHUNK_SZ and
>> memcg.limit_in_bytes to 1/2 of CHUNK_SZ (MEM_LIMIT), then mark
>> MEM_LIMIT bytes as needed. That way the amount in the SwapCache will
>> easily be more than the threshold. Secondly we can run madvise again
>> on PASS_THRESHOLD bytes and check that dirtying all of these does not
>> result in too many page faults. We also run the second test on every
>> occasion to ensure the test code itself is still valid. If the
>> original bug is present then both tests fail.
>>
>> Finally this prints more diagnostic information to help with debugging
>> the test.
>>
>> While debugging the test a kernel bug was found in 5.9 which effects
>> CGroupV1 when use_hierarchy=0. This is unlikely to effect many users,
>> but a fix is pending and will be referenced in the test when
>> available. It is recommended that you set use_hierarchy=1.
>>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> Reviewed-by: Li Wang <liwang@redhat.com>
>> ---
>>
>
> Applied the patch V2, thanks!
>
> --
> Regards,
> Li Wang
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201102/6b67adeb/attachment-0001.htm>
