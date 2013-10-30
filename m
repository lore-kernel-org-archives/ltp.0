Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VbMZc-0001bo-JA
	for ltp-list@lists.sourceforge.net; Wed, 30 Oct 2013 03:36:00 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VbMZa-0004Bm-O7
	for ltp-list@lists.sourceforge.net; Wed, 30 Oct 2013 03:36:00 +0000
Message-ID: <52707E88.1010403@cn.fujitsu.com>
Date: Wed, 30 Oct 2013 11:35:36 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1382949890.5455.40.camel@fedora19> <526F779B.2030205@oracle.com>
	<526F7A65.7010206@cn.fujitsu.com>
In-Reply-To: <526F7A65.7010206@cn.fujitsu.com>
Subject: Re: [LTP] tpci test trigger RHEL6.4GA crash!
Reply-To: gaowanlong@cn.fujitsu.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: alexey.kodanev@oracle.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On 10/29/2013 05:05 PM, Wanlong Gao wrote:
> On 10/29/2013 04:53 PM, alexey.kodanev@oracle.com wrote:
>> Hi!
>> On 10/28/2013 12:44 PM, Zeng Linggang wrote:
>>> Hi,
>>>
>>> When we execute the test of tpci in RHEL6.4GA, the system will crash:
>>>    - filesystem is broken
>>>    - network is off
>>> Some logs are as follows:
>>>
>>> [root@RHEL6U4GA-Intel64 ltp]# ata1.00: exception Emask 0x52 SAct 0x1 SErr 0xffffffff action 0xe frozen
>>> ata1: SError: { RecovData RecovCommon UnrecovData Persist Proto HostInt PHYInt CommWake 10B8B Display
>>> Seq TrStaTrns UnrecFIS DevExch }
>>> ata1.00: failed command: WRITE FPDMA QUEUED
>>> ata1.00: cmd 61/08:00:c8:fb:f3/00:00:39:00:00/40 tag 0 ncq 4096 out
>>>           res 40/00:18:48:eb:33/00:00:38:00:00/40 Emask 0x56 (ATA bus error)
>>> ata1.00: stauts: { DRDY }
>>> ata1.00 failed to resume link (SControl FFFFFFFF)
>>> ata1.00 failed to resume link (SControl FFFFFFFF)
>>> ata1.00 failed to resume link (SControl FFFFFFFF)
>>> Buffer I/O error on device sda13, logical block 4752991
>>> sd 0:0:0:0: rejecting I/O to offline device
>>> sd 0:0:0:0: rejecting I/O to offline device
>>> ...
>>> EXT4-fs error (device sda13): ext4_find_entry: reading directory #524297 offset 0
>>> EXT4-fs error (device sda13): ext4_find_entry: reading directory #524297 offset 0
>>> ...
>>>
>> Could you please find out which particular test case does it? it can be 
>> done manually the following way:
>> insmod ltp_pci.ko
>>
>> Get your ata bus and pci slot number, then write it to the file (the 
>> number is 16bit unsigned integer, the first 8 bits is a device number, 
>> the last is a bus number):
>>
>> echo "number" > /sys/devices/ltp_tcpi/bus_slot
>>
>> Then try test-cases one by one:
>> echo 1 > /sys/devices/ltp_tcpi/tcase
>> ...
>> echo 17 > /sys/devices/ltp_tcpi/tcase
>>
>> You can check the result of each test case by reading 
>> /sys/devices/ltp_tcpi/result file. 0 - PASS, 1 - FAIL.
> 
> PCI_RESOURCES, will cause kernel crash, could you please
> check it?

And PCI_EXP_CAP_CONFIG always FAIL here on RHEL or Fedora, the log is like:

[ 4668.373058] ltp_tpci: incorrect val read. PCIE driver/device not installed: '335609857'

Could you please investigate this?

Thanks,
Wanlong Gao

> 
> Thanks,
> Wanlong Gao
> 
>>
>> Thanks,
>> Alexey
>>
>> ------------------------------------------------------------------------------
>> Android is increasing in popularity, but the open development platform that
>> developers love is also attractive to malware creators. Download this white
>> paper to learn more about secure code signing practices that can help keep
>> Android apps secure.
>> http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>
> 
> 
> ------------------------------------------------------------------------------
> Android is increasing in popularity, but the open development platform that
> developers love is also attractive to malware creators. Download this white
> paper to learn more about secure code signing practices that can help keep
> Android apps secure.
> http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
