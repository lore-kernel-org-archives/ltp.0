From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 6 Apr 2021 16:58:15 +0200
Subject: [LTP] cve-2015-3290
In-Reply-To: <CAEQtK3eWPsFFqBmQ9RpiOaWo5QhUSy_=-PNQCjNDJNiTOZNqKg@mail.gmail.com>
References: <CAEQtK3eWPsFFqBmQ9RpiOaWo5QhUSy_=-PNQCjNDJNiTOZNqKg@mail.gmail.com>
Message-ID: <YGx3B4uw9LtHW5I8@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I am running kernel ltp test cases on android x86 platform,
> and cve-2015-3290 test case is failing only for 32bit and passed for 64bit.
> 
> I can see here, test case itself is broken with SIGBUS error and not giving
> any result
> 
> *pid: 5316, tid: 5324, name: cve-2015-3290  >>> cve-2015-3290 <<<04-03
> 07:59:29.741  5327  5327 F DEBUG   : uid: 004-03 07:59:29.741  5327  5327 F
> DEBUG   : signal 7 (SIGBUS), code 128 (SI_KERNEL), fault addr 0x004-03
> 07:59:29.742  5327  5327 F DEBUG   :     eax 00000007  ebx 652457bc  ecx
> 00000000  edx 0000002304-03 07:59:29.742  5327  5327 F DEBUG   :     edi
> 00000007  esi e7ac41c804-03 07:59:29.742  5327  5327 F DEBUG   :     ebp
> 00000800  esp e7ac4110  eip 6523a800*
> 
> I think assembly code is causing wrong memory address or some memory
> alignment is not proper and so we are getting SIGBUS error.

The testcase is supposed to corrupt return state from NMI in case that
the CVE is present on the system. So triggering SIGBUS may be one of the
end results if that happens. The test seems to trigger SEGFAULT for me,
which is caught as a test failure when the test is compiled with -m32.

Which means that either the CVE has been reintroduced or the test is
buggy, hard to say which one without further analysis.

-- 
Cyril Hrubis
chrubis@suse.cz
