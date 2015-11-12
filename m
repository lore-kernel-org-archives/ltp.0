From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 12 Nov 2015 11:32:06 +0800
Subject: [LTP] [PATCH v2] commands/mkswap: Added new testcase to test
	mkswap(8).
In-Reply-To: <BLU436-SMTP34950324B1CC2CC1FCF1F3CF130@phx.gbl>
References: <563C94F5.9040803@oracle.com>
 <1447056173-8979-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <BLU436-SMTP34950324B1CC2CC1FCF1F3CF130@phx.gbl>
Message-ID: <56440836.2080504@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 2015/11/11 12:50, Lei Li wrote:
>> +mkswap_test "" "" "$TST_DEVICE"
>> +mkswap_test "" "" "$TST_DEVICE" "$((DEVICE_SIZE-10000))"
>> +mkswap_test "-f" "" "$TST_DEVICE" "$((DEVICE_SIZE+10000))"
>> +mkswap_test "-c" "" "$TST_DEVICE"
>> +mkswap_test "-p" "2048" "$TST_DEVICE"
>> +mkswap_test "-L" "testswap" "$TST_DEVICE"
>> +mkswap_test "-v1" "" "$TST_DEVICE"
>> +mkswap_test "-U" "ffffffff-ffff-ffff-ffff-ffffffffffff" "$TST_DEVICE"
> 
> Hi again :-)
>     This testcase changes UUID of a block device and will never
> restore it. Swapon error occurs when there are two "ffffffff-
> ffff-ffff-ffff-ffffffffffff" UUID in the system, for example, run this
> testcase to test a block device firstly and then, test a loop device.
> 

Indeed, just like you mentioned, it need to be fixed, thanks!

Best Regards,
Guangwen Feng

> Maybe you should restore the UUID of the block device in cleanup().
> 
> Thanks
