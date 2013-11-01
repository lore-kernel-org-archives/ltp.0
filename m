Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Vc5BI-0003wy-Fp
	for ltp-list@lists.sourceforge.net; Fri, 01 Nov 2013 03:13:52 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vc5BG-0004d9-PF
	for ltp-list@lists.sourceforge.net; Fri, 01 Nov 2013 03:13:52 +0000
Message-ID: <52731C57.5030704@cn.fujitsu.com>
Date: Fri, 01 Nov 2013 11:13:27 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1383132093-4920-1-git-send-email-alexey.kodanev@oracle.com>
	<5271B4A7.4060006@cn.fujitsu.com> <52721796.7010001@oracle.com>
In-Reply-To: <52721796.7010001@oracle.com>
Subject: Re: [LTP] [PATCH] device-drivers: pci: fix PCI_EXP_CAP_CONFIG
	test-case
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
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

On 10/31/2013 04:40 PM, alexey.kodanev@oracle.com wrote:
> Hi!
> On 10/31/2013 05:38 AM, Wanlong Gao wrote:
>> On 10/30/2013 07:21 PM, Alexey Kodanev wrote:
>>> There is another way to check that PCI Express config space of pci devices
>>> can be read successfully.
>>> Firstly, find out if a device has a PCI Express Capability: we should get
>>> a correct config address offset from the dev's structure (dev->pcie_cap).
>>> Using the offset, read a PCI Express header. Check if we can get the right
>>> PCI Express CAP ID from the header (it must match the PCI_CAP_ID_EXP macro).
>> This can PASS here, thank you.
>>
>> Why did the original method always FAIL?
> 
> The original code has wrong offset, should be reg = 0x100 at least (as it written in comment):
>> int reg = 100, len = 4; /*PCI-Exp enhanced config register 0x100, 4 implies dword access */
> 
> I don't know about that magic number 0x14011 in the original code. Comments said that we can find a constant value from that offset, but in truth, we can find any of the PCI_EXT_CAP_ID_* macors in the first 16 bits or none if device doesn't have Extended Configuration Space. It can be AER (ERR in the macro) and it could be any other ID (it depends on the device).
> 
> better find a particular offset using the kernel function, for example:
> pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR); /* it will find Advanced Error Reporting structure */
> 
> Then get the header (first 4 bytes). First 16 bits should be AER_ID, that it is to say 0x0001. From bit 16 to bit 19 - capability version (can be 1h or 2h). The other bits contain the offset to the next PCI Express Capability structure or zero if it is the last one. That kind of header will never equal to 0x14011, that's is why the original method will always fail even with the right offset.
> 

OK, got it, thank you for your explaination.

Wanlong Gao

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
