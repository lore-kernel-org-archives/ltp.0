Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7hj-0007Qg-K0
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:14:35 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7hi-00089S-Lg
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:14:35 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5NF9wA6025764
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 11:09:58 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5NFEYXu251862
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 11:14:34 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5NFEXWp020879
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 11:14:34 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <d51f89b0906220045y60889b4ap2f8402f2d28622af@mail.gmail.com>
References: <20090526.194251.189710754.caiqian@cclom.cn>
	<d51f89b0905261006x59d2147agb5c5d29d16309b4a@mail.gmail.com>
	<20090531.165827.260097760.caiqian@cclom.cn>
	<20090601.230148.104050591.caiqian@cclom.cn>
	<d51f89b0906220045y60889b4ap2f8402f2d28622af@mail.gmail.com>
Date: Tue, 23 Jun 2009 20:20:49 +0530
Message-Id: <1245768649.4860.94.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Regarding ht_enable test case failure
Reply-To: subrata@linux.vnet.ibm.com
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
To: rohit verma <rohit.170309@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Mon, 2009-06-22 at 13:15 +0530, rohit verma wrote: 
> Hi Subrata/CAI,
> 
> Pls find attached patch for ht_enabled and ht_affinity.
> I am not having a 16-CPU machine at my end to test ht_interrupt test code.
> 
> 
> Regards,
> Rohit
> 

Thanks.

Regards--
Subrata

> On Mon, Jun 1, 2009 at 8:31 PM, CAI Qian<caiqian@cclom.cn> wrote:
> > From: CAI Qian <caiqian@cclom.cn>
> > Subject: Re: [LTP] Fw: Regarding ht_enable test case failure
> > Date: Sun, 31 May 2009 16:58:27 +0800 (CST)
> >
> >> OK. The compilation error was probably due to my incomplete build last
> >> time. Sorry about that.
> >>
> >> smt_smp_interrupt.sh is no working for 2 CPU system.
> >>
> >> # cat /proc/interrupts
> >>            CPU0       CPU1
> >>   0:    1821938    1845925    IO-APIC-edge  timer
> >>   1:          2          1    IO-APIC-edge  i8042
> >>   4:        176        259    IO-APIC-edge  serial
> >>   6:          2          3    IO-APIC-edge  floppy
> >>   8:          2          1    IO-APIC-edge  rtc
> >>   9:          0          0   IO-APIC-level  acpi
> >>  12:          4          1    IO-APIC-edge  i8042
> >>  82:      52431       2322   IO-APIC-level  uhci_hcd:usb3, ahci
> >>  90:          0          0   IO-APIC-level  uhci_hcd:usb4
> >>  98:          0          0   IO-APIC-level  uhci_hcd:usb5
> >> 106:         53         52   IO-APIC-level  HDA Intel
> >> 114:        242      25683         PCI-MSI  eth0
> >> 201:          0          0   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2
> >> NMI:          0          0
> >> LOC:    3667704    3667763
> >> ERR:          0
> >> MIS:          0
> >>
> >> # ./smt_smp_interrupt.sh
> >> smt_smp_interrupt    0  INFO  :  Begin: SMT/SMP Interrupt
> >> smt_smp_interrupt    0  INFO  :  smp_affinity is 00000002
> >> smt_smp_interrupt    1  CONF  :  /proc/irq/114/smp_affinity:Not set
> >> smt_smp_interrupt    0  INFO  :  End: SMT/SMP Interrupt
> >>
> >> I am not having a 16-CPU machine at the moment, so I'll test on it later
> >> when had a chance.
> >>
> >
> > I have finally had a chance to test it on the 16-CPU machine, but
> > smt_smp_interrupt.sh test failed,
> >
> > # ./smt_smp_interrupt.sh
> > smt_smp_interrupt    0  INFO  :  Begin: SMT/SMP Interrupt
> > cat: /proc/irq/154: Is a directory
> > cat: 162: No such file or directory
> > cat: 170: No such file or directory
> > cat: 178: No such file or directory
> > cat: 186: No such file or directory
> > cat: 194: No such file or directory
> > cat: 202/smp_affinity: No such file or directory
> > smt_smp_interrupt    0  INFO  :  smp_affinity is
> > ./smt_smp_interrupt.sh: line 86: [: 31: unary operator expected
> > smt_smp_interrupt    0  INFO  :  Begin: HyperThreading Interrupt
> > smt_smp_interrupt    1  CONF  :  HT is not enabled or not supported.
> > smt_smp_interrupt    0  INFO  :  End: HyperThreading Interrupt
> > smt_smp_interrupt    0  INFO  :  End: SMT/SMP Interrupt
> >
> >
> > This probably due to multiple eth0 entries in /proc/interrupts.
> >
> > # cat /proc/interrupts
> >           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7       CPU8       CPU9       CPU10      CPU11      CPU12      CPU13      CPU14
> >  CPU15
> >  0:   29973184          0      82092          0          0          0          0          0          0          0          0          0          0          0          0
> >    0    IO-APIC-edge  timer
> >  4:          0          0          0         10        388          0        219          0          0          0          0          0          0          0          0
> >    0    IO-APIC-edge  serial
> >  8:          0          0          3          0          0          0          0          0          0          0          0          0          0          0          0
> >    0    IO-APIC-edge  rtc
> >  9:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0
> >    0   IO-APIC-level  acpi
> >  82:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0
> >    0   IO-APIC-level  ehci_hcd:usb1
> >  90:          0          0          0          0          0          0          0          0          0          0          0          0         49          0          0
> >    0   IO-APIC-level  ehci_hcd:usb2, uhci_hcd:usb5, uhci_hcd:usb7
> >  98:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0
> >    0   IO-APIC-level  uhci_hcd:usb3
> > 106:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0
> >    0   IO-APIC-level  uhci_hcd:usb4
> > 114:          0          0         43          0          0          0          0          0          0          0          0          0          0          0          0
> >    0   IO-APIC-level  uhci_hcd:usb6
> > 154:         91          0          0          0          0          0          0          0          0          0          0          0      45761          0     117042
> >  1105       PCI-MSI-X  eth0
> > 162:         28          0          0          0        230          0        451          0          0          0        562          0        298          0        159
> >    0       PCI-MSI-X  eth0
> > 170:         24          0          0          0        458          0        460          0          0          1       1497          0        193          0        467
> >    0       PCI-MSI-X  eth0
> > 177:          0         22          0         27      38596       1422       4017          0       4063          0          0          0       2367          0          0
> >    0   IO-APIC-level  ioc0
> > 178:         22          0          0          0       8039          0       1054          0          0          0          0         16       1850         20       9302
> >    0       PCI-MSI-X  eth0
> > 186:         38          0          0          0        530          0       1100          0          0          0         40          0        163          0        176
> >    0       PCI-MSI-X  eth0
> > 194:         23          0          0          0       3163          0       3521          0          0         16          0         20       6674          0        448
> >    0       PCI-MSI-X  eth0
> > 202:         49          0          0          0        637          0       1305          0          0          6        120          0        733          4       1087
> >    0       PCI-MSI-X  eth0
> > NMI:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0
> >    0
> > LOC:   30053985   30053999   30054001   30053998   30053997   30053995   30053993   30053991   30053716   30053990   30053974   30053914   30053953   30053870   30053986   30053818
> > ERR:          0
> > MIS:          0
> >
> > Other tests look good though.
> >
> > CAI Qian
> >


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
