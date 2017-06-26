From: ankit gupta <ankitrtk@gmail.com>
Date: Mon, 26 Jun 2017 14:27:05 +0530
Subject: [LTP] LTP Ipv6_lib failures
In-Reply-To: <20170626084952.whrq5i6s3hdm3w4n@dell5510>
References: <CACUy5SN4anXf9wE+wCTjSHK5O6EXtTCTfL96tvJJHtcOS3KSBA@mail.gmail.com>
 <20170626084952.whrq5i6s3hdm3w4n@dell5510>
Message-ID: <CACUy5SPm3hZrx+1-+w5UFNvkKpF341cSfpjTUqy+LdtkNWaa1A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

I couldn't try it with latest version.

I used Yocto poky Distro version 1.8.1 to build my image.

Is there some issue with LTP(20160126) version for ipv6_lib testsuite?


Thanks & Regards,
Ankit


On Mon, Jun 26, 2017 at 2:19 PM, Petr Vorel <pvorel@suse.cz> wrote:

> Hi Ankit,
>
> > Hi All,
>
> > I am executing the LTP(20160126) tests for one of my board, and in it
> > Ipv6_lib is failing. below is the tests results and logs.
>
> > Test Start Time: Thu Jun 22 18:22:27 2017
> > -----------------------------------------
> > Testcase                       Result     Exit Value
> > --------                       ------     ----------
> > in6_01                         PASS       0
> > in6_02                         FAIL       4
> > getaddrinfo_01                 FAIL       1
> > asapi_01                       FAIL       2
> > asapi_02                       FAIL       2
> > asapi_03                       FAIL       2
>
> > -----------------------------------------------
> > Total Tests: 6
> > Total Skipped Tests: 0
> > Total Failures: 5
> > Kernel Version: 4.1.29-4.1-1.0.x-imx-dms-ba16+g8eaed11
> > Machine Architecture: armv7l
> > Hostname: Development-board
>
>
> > In this* getaddrinfo_01* is passing after I make entry of my host name in
> > /etc/hosts file, but rest 4 tests are still failing. I did not find any
> > failure reason in LTP bugs list.
>
> > Please see the attachment for individual tests execution logs and let me
> > know if something else is required from my side?
>
> > Thanks & Regards,
> > Ankit Gupta
>
> Could you try it with latest release 20170516 and (optionally) with
> current master?
> Do you use buildroot, yocto, something else or compile manually?
>
>
> Kind regards,
> Petr
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170626/6ea838e7/attachment.html>
