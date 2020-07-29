From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 29 Jul 2020 18:43:53 +0800
Subject: [LTP] [PATCH v3 1/2] syscalls/ioctl_loop06: Using
 LOOP_CONFIGURE to test invalid block size
In-Reply-To: <20200729100758.GA7152@yuki.lan>
References: <20200722125946.GA22573@yuki.lan>
 <1595556357-29932-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200729100758.GA7152@yuki.lan>
Message-ID: <a6b872b4-35e7-c326-1470-4372a02a92ad@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril
> Hi!
>>   static void verify_ioctl_loop(unsigned int n)
>> +{
>> +	if (tcases[n].ioctl_flag == LOOP_CONFIGURE)
>> +		TEST(ioctl(dev_fd, LOOP_CONFIGURE, &loopconfig));
>> +	else
>> +		TEST(ioctl(dev_fd, LOOP_SET_BLOCK_SIZE, *(tcases[n].setvalue)));
>> +
>> +	if (TST_RET == 0) {
>> +		tst_res(TFAIL, "Set block size succeed unexpectedly");
>> +		if (tcases[n].ioctl_flag == LOOP_CONFIGURE)
>> +			TST_RETRY_FUNC(ioctl(dev_fd, LOOP_CLR_FD, 0), TST_RETVAL_EQ0);
> 
> I guess that we can use the tst_detach_device_by_fd() here as well
> right?
> 
> If you agree with that change I will change this and push the patch.
Agree.
> 


