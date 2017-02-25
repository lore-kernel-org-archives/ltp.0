From: Yisheng Xie <xieyisheng1@huawei.com>
Date: Sat, 25 Feb 2017 10:28:15 +0800
Subject: [LTP] Is MADV_HWPOISON supposed to work only on faulted-in
	pages?
In-Reply-To: <20170223032342.GA18740@hori1.linux.bs1.fc.nec.co.jp>
References: <6a445beb-119c-9a9a-0277-07866afe4924@redhat.com>
 <20170220050016.GA15533@hori1.linux.bs1.fc.nec.co.jp>
 <20170223032342.GA18740@hori1.linux.bs1.fc.nec.co.jp>
Message-ID: <1ba376aa-5e7c-915f-35d1-2d4eef0cad88@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

hi Naoya,

On 2017/2/23 11:23, Naoya Horiguchi wrote:
> On Mon, Feb 20, 2017 at 05:00:17AM +0000, Horiguchi Naoya(堀口 直也) wrote:
>> On Tue, Feb 14, 2017 at 04:41:29PM +0100, Jan Stancek wrote:
>>> Hi,
>>>
>>> code below (and LTP madvise07 [1]) doesn't produce SIGBUS,
>>> unless I touch/prefault page before call to madvise().
>>>
>>> Is this expected behavior?
>>
>> Thank you for reporting.
>>
>> madvise(MADV_HWPOISON) triggers page fault when called on the address
>> over which no page is faulted-in, so I think that SIGBUS should be
>> called in such case.
>>
>> But it seems that memory error handler considers such a page as "reserved
>> kernel page" and recovery action fails (see below.)
>>
>>   [  383.371372] Injecting memory failure for page 0x1f10 at 0x7efcdc569000
>>   [  383.375678] Memory failure: 0x1f10: reserved kernel page still referenced by 1 users
>>   [  383.377570] Memory failure: 0x1f10: recovery action for reserved kernel page: Failed
>>
>> I'm not sure how/when this behavior was introduced, so I try to understand.
> 
> I found that this is a zero page, which is not recoverable for memory
> error now.
> 
>> IMO, the test code below looks valid to me, so no need to change.
> 
> I think that what the testcase effectively does is to test whether memory
> handling on zero pages works or not.
> And the testcase's failure seems acceptable, because it's simply not-implemented yet.
> Maybe recovering from error on zero page is possible (because there's no data
> loss for memory error,) but I'm not sure that code might be simple enough and/or
> it's worth doing ...
I question about it,  if a memory error happened on zero page, it will
cause all of data read from zero page is error, I mean no-zero, right?
And can we just use re-initial it with zero data maybe by memset ?

Thanks
Yisheng Xie.


