From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 3 Jan 2020 18:03:26 +0800
Subject: [LTP] [PATCH COMMITTED] tst_device: do sync() before reading
 test block device stat file
In-Reply-To: <90c16f7d-0850-3011-947a-eb42229d7169@cn.fujitsu.com>
References: <20200102015236.7400-1-liwang@redhat.com>
 <b2b1b91e-4813-a281-6f56-0924d21bb103@cn.fujitsu.com>
 <CAEemH2cPJnbNeLRNmHPoGDjh5y_i6YicYPOyM7Vu+AM9t09Kyg@mail.gmail.com>
 <94af8423-337a-8e96-8ab2-b818afb43a76@cn.fujitsu.com>
 <CAEemH2cCN7LwBEiitzU+=B=8YwR4pUX9Hg1rm-t7Ygc_HvSbHQ@mail.gmail.com>
 <90c16f7d-0850-3011-947a-eb42229d7169@cn.fujitsu.com>
Message-ID: <ee66d24f-f00c-e456-dde0-ad98de68ce4f@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



Hi Li
> 
> 
> on 2020/01/03 15:25, Li Wang wrote:
>>
>>
>> On Thu, Jan 2, 2020 at 2:46 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com 
>> <mailto:xuyang2018.jy@cn.fujitsu.com>> wrote:
>>
>>
>>
>> ??? on 2020/01/02 14:31, Li Wang wrote:
>> ???? >
>> ???? >
>> ???? > On Thu, Jan 2, 2020 at 10:10 AM Yang Xu
>> ??? <xuyang2018.jy@cn.fujitsu.com <mailto:xuyang2018.jy@cn.fujitsu.com>
>> ???? > <mailto:xuyang2018.jy@cn.fujitsu.com
>> ??? <mailto:xuyang2018.jy@cn.fujitsu.com>>> wrote:
>> ???? >
>> ???? >
>> ???? >
>> ???? >? ? ?Hi Li
>> ???? >? ? ? > To avoid FS deferred IO metadata/cache interferes test
>> ??? result, so we
>> ???? >? ? ? > do sync simply before the tst_dev_bytes_written invocation.
>> ???? >? ? ? >
>> ???? >? ? ?Looks good, acked. Also, I think we can mention it in
>> ???? >? ? ?doc/test-writing-guidelines.txt when using this api.
>> ???? >
>> ???? >
>> ???? > Ok, I will append one line as:
>> ???? > --- a/doc/test-writing-guidelines.txt
>> ???? > +++ b/doc/test-writing-guidelines.txt
>> ???? > @@ -1072,7 +1072,9 @@ unsigned long tst_dev_bytes_written(const
>> ??? char *dev);
>> ???? >      
>> ?------------------------------------------------------------------------------- 
>>
>> ???? >
>> ???? >? ?This function reads test block device stat file
>> ???? > (/sys/block/<device>/stat) and
>> ???? > -returns the bytes written since the last invocation of this
>> ??? function.
>> ???? > +returns the bytes written since the last invocation of this
>> ??? function.
>> ???? > To avoid
>> ???? > +FS deferred IO metadata/cache interferes the test result, we
>> ??? suggest
>> ???? > doing sync()
>> ???? > +before the tst_dev_bytes_written first invocation.
>> ??? OK.
>>
>> ??? I also meet another problem when using this api on old kernel.
>>
>> ??? tst_device.c:395: CONF: Test device stat file: /sys/block/loop0/stat
>> ??? broken
>>
>> ??? /sys/block/loop0/stat is all 0 and case reports TCONF. on new kernel,
>> ??? this value is normal. This is a block layer or loop device driver
>> ??? modifition several yeas ago?
>>
>>
>> It sounds like a kernel issue, can you tell which kernel version you 
>> did test?
>>
> I test this on 3.10.0-1101.el7.x86_64. It also reports TCONF on old 
> fedora such as fedora 20,21. I guess loop driver modification(I am 
> verifying ...) causes it.
Before kernel commit b5dd2f6047ca[1] (block: loop: improve performance 
via blk-mq), this /sys/block/loop0/stat value is all 0 for loop device 
because loop device uses its own make requestion function but not blk 
end request (so these value can not be counted). After onversion of loop 
to blk-mq, this value is normal. This patch was merged into upstream 
kernel since v4.0.  When using tst_dev_bytes_written api(using loop 
device as block device) on older kernel, this /sys/block/loop0/stat 
value is all 0 and we should mention user to export $LTP_DEV to test. 
Also, we can do it in other patch.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/block/loop.c?id=b5dd2f6047ca108001328aac0e8588edd15f1778

ps:I don't know block device(bio,request) or loop driver very much. If I 
was wrong, please feel free to correct me.

Best Regards
Yang Xu
>>
>> ??? ps:I know ltp used LOOP_SET_FD to make loop device simulate other
>> ??? filesystems. I am trying to find a generic way about this api.
>>
>> ??? Best Regards
>> ??? Yang Xu
>> ???? >
>> ???? > --
>> ???? > Regards,
>> ???? > Li Wang
>>
>>
>>
>>
>> -- 
>> Regards,
>> Li Wang
> 
> 
> 


