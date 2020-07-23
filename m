From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 23 Jul 2020 17:41:23 +0800
Subject: [LTP] [PATCH v2 1/2] syscalls/ioctl_loop06: Using
 LOOP_CONFIGURE to test invalid block size
In-Reply-To: <20200722125946.GA22573@yuki.lan>
References: <20200708140034.GD7276@yuki.lan>
 <1594363189-20972-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200722094502.GB2319@yuki.lan>
 <13f6db1e-f1b6-1465-b34d-ae418ead2558@cn.fujitsu.com>
 <20200722125946.GA22573@yuki.lan>
Message-ID: <66653092-9167-5bb0-3000-7f9662e2cfdc@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

HI Cyril


> Hi!
>>> Do we really need to close and open the dev_fd repeatedly and also we
>>> don't have to attach the device in the test setup?
>> YES, we don't need to attach the device in the setup because
>> LOOP_SET_BLOCK_SIZE checks works well(return ENXIO if supports, return
>> EINVAL if not supports) when not attaching device.
>>
>> But for close and open the dev_fd repeatedly, I think it is necessary
>> because when we detach device firstly without closing dev fd, it will
>> report the warnging as below:
>>
>> tst_device.c:89: INFO: Found free device 0 '/dev/loop0'
>> ioctl_loop06.c:69: INFO: Using LOOP_SET_BLOCK_SIZE with arg < 512
>> ioctl_loop06.c:60: PASS: Set block size failed as expected: EINVAL (22)
>> ioctl_loop06.c:69: INFO: Using LOOP_SET_BLOCK_SIZE with arg > PAGE_SIZE
>> ioctl_loop06.c:60: PASS: Set block size failed as expected: EINVAL (22)
>> ioctl_loop06.c:69: INFO: Using LOOP_SET_BLOCK_SIZE with arg != power_of_2
>> ioctl_loop06.c:60: PASS: Set block size failed as expected: EINVAL (22)
>> ioctl_loop06.c:69: INFO: Using LOOP_CONFIGURE with block_size < 512
>> tst_device.c:223: WARN: ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO for
>> too long
>> ioctl_loop06.c:62: FAIL: Set block size failed expected EINVAL got:
>> EBUSY (16)
>>
>> That is why I close dev_fd firstly and then detach device in cleanup
>> function.
> 
> Ah, right, the tst_detach_device() opens the dev_path so the function
> fails to destroy it because the device is opened twice at that point.
> 
> I guess that proper solution would be to add a tst_detach_device_by_fd()
> and change the library so that tst_detach_device() opens the dev_path
> and calls tst_detach_device_by_fd() internally.
Should I send a v3 patch or you directly use the new api for this patch?
> 


