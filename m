From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 25 Jul 2017 10:17:08 +0200
Subject: [LTP] LTP Test cases Details
In-Reply-To: <CAJ_4j46KaZHDx7NTBV8TqeB6GPBn-opMiQrKEuiMoUMBhz4e0A@mail.gmail.com>
References: <CAJ_4j46KaZHDx7NTBV8TqeB6GPBn-opMiQrKEuiMoUMBhz4e0A@mail.gmail.com>
Message-ID: <87k22x9bi3.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hello Khushboo,

khushbu sharma writes:

> Hi,
>     I am looking for some testing tool to test security of my Linux system.
> In the source code of LTP i can see security related test cases in
> "ltp/testcases/kernel/security/" directory.
> Before using LTP testcases to test security of my system, I want to get
> some details regarding these testcases e.g. what kind of security features
> are these TC testing.
>
> Unfortunately i cannot find any kind of documentation online which have
> details for LTP testcases.
>
> Can anyone from this list share with me some documents or link having
> details of LTP test cases?
>
> Thanks
> Khushboo Sharma

Some of the testcases in kernel/security (e.g. tomoyo) have a README
file, the others might have comments in the code. Generally the tests in
kernel/security test security features while the tests in testcases/cve
test for specific vulnerabilities which have been given CVE number. Each
CVE should be documented in the test code.

--
Thank you,
Richard.
