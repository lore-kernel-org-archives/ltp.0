From: Weichao Guo <guoweichao@oppo.com>
Date: Tue, 9 Mar 2021 10:23:35 +0800
Subject: [LTP] [f2fs] 02eb84b96b: ltp.swapon03.fail
In-Reply-To: <87h7llhnfe.fsf@suse.de>
References: <20210308072510.GA902@xsang-OptiPlex-9020> <87h7llhnfe.fsf@suse.de>
Message-ID: <c75229cc-e325-1c8b-0afa-fd236db8319c@oppo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

On 2021/3/8 19:53, Richard Palethorpe wrote:
> Hello,
>
>> kern  :err   : [  187.461914] F2FS-fs (sda1): Swapfile does not align to section
>> commit 02eb84b96bc1b382dd138bf60724edbefe77b025
>> Author: huangjianan@oppo.com <huangjianan@oppo.com>
>> Date:   Mon Mar 1 12:58:44 2021 +0800
>>      f2fs: check if swapfile is section-alligned
>>      If the swapfile isn't created by pin and fallocate, it can't be
>>      guaranteed section-aligned, so it may be selected by f2fs gc. When
>>      gc_pin_file_threshold is reached, the address of swapfile may change,
>>      but won't be synchronized to swap_extent, so swap will write to wrong
>>      address, which will cause data corruption.
>>      Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>>      Signed-off-by: Guo Weichao <guoweichao@oppo.com>
>>      Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>      Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> The test uses fallocate to preallocate the swap file and writes zeros to
> it. I'm not sure what pin refers to?

'pin' refers to pinned file feature in F2FS, the LBA(Logical Block 
Address) of a file is fixed after pinned. Without this operation before 
fallocate, the LBA may not align with section(F2FS GC unit), some LBA of 
the file may be changed by F2FS GC in some extreme cases.

For this test case, how about pin the swap file before fallocate for 
F2FS as following:

ioctl(fd, F2FS_IOC_SET_PIN_FILE, true);


BR,

Weichao

