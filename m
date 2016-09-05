From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 5 Sep 2016 07:07:35 -0400 (EDT)
Subject: [LTP] Which LTP tag should be used for kernel 4.4 test
In-Reply-To: <CAE6rn=Prc-_D22_hLuuMED9XqDLaNEKAytGbAVGG+0EONyZAfg@mail.gmail.com>
References: <CAE6rn=Prc-_D22_hLuuMED9XqDLaNEKAytGbAVGG+0EONyZAfg@mail.gmail.com>
Message-ID: <469851347.1788700.1473073655715.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "张旭" <zhang.vax@gmail.com>
> To: ltp@lists.linux.it
> Sent: Friday, 2 September, 2016 11:47:22 AM
> Subject: [LTP] Which LTP tag should be used for kernel 4.4 test
> 
> Hi,
> 
> I want to use LTP for testing a kernel based version 4.4. Need I download
> some tag or latest LTP tag(20160510) for kernel 4.4 test?

Hi,

you can use latest tagged release or latest git tree. LTP aims
to skip tests not applicable to currently running kernel/config/hw/arch/etc.
by making various checks in setup phase of testcases and terminating with
TCONF ret code if conditions are not met.

Regards,
Jan
