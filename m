From: Laura Abbott <labbott@redhat.com>
Date: Tue, 19 Nov 2019 07:50:56 -0500
Subject: [LTP] =?utf-8?b?4p2MIEZBSUw6IFN0YWJsZSBxdWV1ZTogcXVldWUtNS4z?=
In-Reply-To: <20191119124428.GC1975017@kroah.com>
References: <cki.042792963E.5VOWULC1Q9@redhat.com>
 <8e0fa6de-b6b1-23ac-9e77-d425c8d1ba22@redhat.com>
 <c326c35e-453e-2dae-391c-5324803e6112@redhat.com>
 <20191119124428.GC1975017@kroah.com>
Message-ID: <236c4f8d-a54e-daa6-0896-eca236e23e58@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/19/19 7:44 AM, Greg KH wrote:
> On Tue, Nov 19, 2019 at 07:37:09AM -0500, Laura Abbott wrote:
>> On 11/18/19 7:07 PM, Rachel Sibley wrote:
>>>
>>> On 11/18/19 10:00 AM, CKI Project wrote:
>>>> Hello,
>>>>
>>>> We ran automated tests on a patchset that was proposed for merging into this
>>>> kernel tree. The patches were applied to:
>>>>
>>>>          Kernel repo:https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
>>>>               Commit: 116a395b7061 - Linux 5.3.11
>>>>
>>>> The results of these automated tests are provided below.
>>>>
>>>>       Overall result: FAILED (see details below)
>>>>                Merge: OK
>>>>              Compile: OK
>>>>                Tests: FAILED
>>>>
>>>> All kernel binaries, config files, and logs are available for download here:
>>>>
>>>>     https://artifacts.cki-project.org/pipelines/293063
>>>>
>>>> One or more kernel tests failed:
>>>>
>>>>       aarch64:
>>>>        ? LTP lite
>>>
>>> I see a panic when installing the LTP dependencies
>>>
>>> [  690.625060] Call trace:
>>> [  690.627495]  bfq_find_set_group+0x8c/0xf0
>>> [  690.631491]  bfq_bic_update_cgroup+0xbc/0x218
>>> [  690.635834]  bfq_init_rq+0xac/0x808
>>> [  690.639309]  bfq_insert_request.isra.0+0xe0/0x200
>>> [  690.643999]  bfq_insert_requests+0x68/0x88
>>> [  690.648085]  blk_mq_sched_insert_requests+0x84/0x140
>>> [  690.653036]  blk_mq_flush_plug_list+0x170/0x2b0
>>> [  690.657555]  blk_flush_plug_list+0xec/0x100
>>> [  690.661725]  blk_mq_make_request+0x200/0x5e8
>>> [  690.665982]  generic_make_request+0x94/0x270
>>> [  690.670239]  submit_bio+0x34/0x168
>>> [  690.673712]  xfs_submit_ioend.isra.0+0x9c/0x180 [xfs]
>>> [  690.678798]  xfs_do_writepage+0x234/0x458 [xfs]
>>> [  690.683318]  write_cache_pages+0x1a4/0x3f8
>>> [  690.687442]  xfs_vm_writepages+0x84/0xb8 [xfs]
>>> [  690.691874]  do_writepages+0x3c/0xe0
>>> [  690.695438]  __writeback_single_inode+0x48/0x440
>>> [  690.700042]  writeback_sb_inodes+0x1ec/0x4b0
>>> [  690.704298]  __writeback_inodes_wb+0x50/0xe8
>>> [  690.708555]  wb_writeback+0x264/0x388
>>> [  690.712204]  wb_do_writeback+0x300/0x358
>>> [  690.716113]  wb_workfn+0x80/0x1e0
>>> [  690.719418]  process_one_work+0x1bc/0x3e8
>>> [  690.723414]  worker_thread+0x54/0x440
>>> [  690.727064]  kthread+0x104/0x130
>>> [  690.730281]  ret_from_fork+0x10/0x18
>>> [  690.733847] Code: eb00007f 54000220 b4000040 f8568022 (f9401c42)
>>> [  690.739928] ---[ end trace d3fd392f569e86d3 ]---
>>>
>>> https://artifacts.cki-project.org/pipelines/293063/logs/aarch64_host_2_console.log
>>>
>>
>> This looks like that same issue
>> https://bugzilla.redhat.com/show_bug.cgi?id=1767539
>>
>> I don't think the BFQ fix has been sent to stable yet, or at least
>> it was not in 5.3.11
> 
> Any specific git commit id I should be picking up for this?
> 
> thanks,
> 
> greg k-h
> 

Should be 478de3380c1c ("block, bfq: deschedule empty bfq_queues
not referred by any process") .

Thanks,
Laura

