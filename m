From: Akshay Mhaske <amhaske01@gmail.com>
Date: Sun, 4 Apr 2021 17:28:51 +0530
Subject: [LTP] cve-2015-3290
Message-ID: <CAEQtK3eWPsFFqBmQ9RpiOaWo5QhUSy_=-PNQCjNDJNiTOZNqKg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi ,

I am running kernel ltp test cases on android x86 platform,
and cve-2015-3290 test case is failing only for 32bit and passed for 64bit.

I can see here, test case itself is broken with SIGBUS error and not giving
any result






*pid: 5316, tid: 5324, name: cve-2015-3290  >>> cve-2015-3290 <<<04-03
07:59:29.741  5327  5327 F DEBUG   : uid: 004-03 07:59:29.741  5327  5327 F
DEBUG   : signal 7 (SIGBUS), code 128 (SI_KERNEL), fault addr 0x004-03
07:59:29.742  5327  5327 F DEBUG   :     eax 00000007  ebx 652457bc  ecx
00000000  edx 0000002304-03 07:59:29.742  5327  5327 F DEBUG   :     edi
00000007  esi e7ac41c804-03 07:59:29.742  5327  5327 F DEBUG   :     ebp
00000800  esp e7ac4110  eip 6523a800*

I think assembly code is causing wrong memory address or some memory
alignment is not proper and so we are getting SIGBUS error.

Can you please help me on this.

Thanks & Regards,
Akshay Mhaske
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210404/ee85abef/attachment.htm>
