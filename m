From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Jun 2017 10:49:52 +0200
Subject: [LTP] LTP Ipv6_lib failures
In-Reply-To: <CACUy5SN4anXf9wE+wCTjSHK5O6EXtTCTfL96tvJJHtcOS3KSBA@mail.gmail.com>
References: <CACUy5SN4anXf9wE+wCTjSHK5O6EXtTCTfL96tvJJHtcOS3KSBA@mail.gmail.com>
Message-ID: <20170626084952.whrq5i6s3hdm3w4n@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ankit,

> Hi All,

> I am executing the LTP(20160126) tests for one of my board, and in it
> Ipv6_lib is failing. below is the tests results and logs.

> Test Start Time: Thu Jun 22 18:22:27 2017
> -----------------------------------------
> Testcase                       Result     Exit Value
> --------                       ------     ----------
> in6_01                         PASS       0
> in6_02                         FAIL       4
> getaddrinfo_01                 FAIL       1
> asapi_01                       FAIL       2
> asapi_02                       FAIL       2
> asapi_03                       FAIL       2

> -----------------------------------------------
> Total Tests: 6
> Total Skipped Tests: 0
> Total Failures: 5
> Kernel Version: 4.1.29-4.1-1.0.x-imx-dms-ba16+g8eaed11
> Machine Architecture: armv7l
> Hostname: Development-board


> In this* getaddrinfo_01* is passing after I make entry of my host name in
> /etc/hosts file, but rest 4 tests are still failing. I did not find any
> failure reason in LTP bugs list.

> Please see the attachment for individual tests execution logs and let me
> know if something else is required from my side?

> Thanks & Regards,
> Ankit Gupta

Could you try it with latest release 20170516 and (optionally) with current master?
Do you use buildroot, yocto, something else or compile manually?


Kind regards,
Petr
